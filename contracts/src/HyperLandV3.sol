// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

interface IUniswapV2Router {
    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external payable returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);
}

interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
}

/**
 * @title HyperLandV3
 * @dev Simplified all-in-one contract:
 * - ERC721 NFT for land parcels
 * - Non-linear bonding curve pricing
 * - Automatic liquidity creation & LP burning
 * - No complex ownership chains
 *
 * V3 IMPROVEMENTS:
 * - Single contract = no ownership issues
 * - Exponential bonding curve: $0.50 → $100 (fast) → $400 (slow)
 * - Built-in liquidity management
 * - Direct NFT minting (no external dependencies)
 */
contract HyperLandV3 is ERC721, Ownable, ReentrancyGuard {

    // ============================================
    // STATE VARIABLES
    // ============================================

    struct Parcel {
        int256 x;
        int256 y;
        uint256 size;
        bool exists;
    }

    // Token ID => Parcel data
    mapping(uint256 => Parcel) public parcels;
    uint256 public totalParcels;
    uint256 public nextTokenId = 1;

    // Bonding curve parameters
    uint256 public constant PHASE1_END = 50;      // First 50 parcels: $0.50 → $100
    uint256 public constant PHASE2_END = 200;     // Next 150 parcels: $100 → $400
    // After 200: slow linear growth

    uint256 public constant START_PRICE = 0.00015 ether;   // ~$0.50 at $3000 ETH
    uint256 public constant PHASE1_MAX = 0.033 ether;       // ~$100
    uint256 public constant PHASE2_MAX = 0.133 ether;       // ~$400
    uint256 public constant LINEAR_INCREMENT = 0.001 ether; // After phase 2

    // Liquidity management
    address public immutable LAND_TOKEN;
    address public immutable ROUTER;
    address public immutable WETH;
    address public pool;
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    // Stats
    uint256 public totalETHCollected;
    uint256 public totalLiquidityCreated;
    uint256 public totalLPBurned;

    // Events
    event ParcelMinted(uint256 indexed tokenId, address indexed owner, int256 x, int256 y, uint256 price);
    event LiquidityAdded(uint256 ethAmount, uint256 landAmount, uint256 lpTokens);
    event LPBurned(uint256 lpTokens);

    // ============================================
    // CONSTRUCTOR
    // ============================================

    constructor(
        address _landToken,
        address _router,
        address _weth,
        address initialOwner
    ) ERC721("HyperLand V3", "HLAND3") Ownable(initialOwner) {
        require(_landToken != address(0), "Invalid LAND token");
        require(_router != address(0), "Invalid router");
        require(_weth != address(0), "Invalid WETH");

        LAND_TOKEN = _landToken;
        ROUTER = _router;
        WETH = _weth;
    }

    // ============================================
    // BONDING CURVE PRICING
    // ============================================

    /**
     * @dev Non-linear bonding curve with 3 phases:
     * Phase 1 (0-50): Exponential $0.50 → $100
     * Phase 2 (50-200): Exponential $100 → $400
     * Phase 3 (200+): Linear slow growth
     */
    function getCurrentPrice() public view returns (uint256) {
        uint256 sold = nextTokenId - 1;

        if (sold < PHASE1_END) {
            // Exponential growth: 0-50 parcels
            // Formula: START_PRICE * (PHASE1_MAX/START_PRICE) ^ (sold/PHASE1_END)
            // Simplified: exponential interpolation
            uint256 ratio = (sold * 1e18) / PHASE1_END;
            uint256 priceRange = PHASE1_MAX - START_PRICE;
            uint256 exponentialFactor = (ratio * ratio) / 1e18; // x^2 for fast growth
            return START_PRICE + (priceRange * exponentialFactor) / 1e18;
        }
        else if (sold < PHASE2_END) {
            // Exponential growth: 50-200 parcels
            uint256 phase2Sold = sold - PHASE1_END;
            uint256 phase2Total = PHASE2_END - PHASE1_END;
            uint256 ratio = (phase2Sold * 1e18) / phase2Total;
            uint256 priceRange = PHASE2_MAX - PHASE1_MAX;
            uint256 exponentialFactor = (ratio * ratio) / 1e18; // x^2
            return PHASE1_MAX + (priceRange * exponentialFactor) / 1e18;
        }
        else {
            // Linear slow growth: 200+ parcels
            uint256 phase3Sold = sold - PHASE2_END;
            return PHASE2_MAX + (phase3Sold * LINEAR_INCREMENT);
        }
    }

    /**
     * @dev Preview price at specific parcel number
     */
    function getPriceAt(uint256 parcelNumber) public pure returns (uint256) {
        if (parcelNumber < PHASE1_END) {
            uint256 ratio = (parcelNumber * 1e18) / PHASE1_END;
            uint256 priceRange = PHASE1_MAX - START_PRICE;
            uint256 exponentialFactor = (ratio * ratio) / 1e18;
            return START_PRICE + (priceRange * exponentialFactor) / 1e18;
        }
        else if (parcelNumber < PHASE2_END) {
            uint256 phase2Sold = parcelNumber - PHASE1_END;
            uint256 phase2Total = PHASE2_END - PHASE1_END;
            uint256 ratio = (phase2Sold * 1e18) / phase2Total;
            uint256 priceRange = PHASE2_MAX - PHASE1_MAX;
            uint256 exponentialFactor = (ratio * ratio) / 1e18;
            return PHASE1_MAX + (priceRange * exponentialFactor) / 1e18;
        }
        else {
            uint256 phase3Sold = parcelNumber - PHASE2_END;
            return PHASE2_MAX + (phase3Sold * LINEAR_INCREMENT);
        }
    }

    // ============================================
    // PARCEL MANAGEMENT
    // ============================================

    /**
     * @dev Add parcels to the sale (owner only, before minting)
     */
    function addParcelsBatch(
        int256[] calldata xs,
        int256[] calldata ys,
        uint256[] calldata sizes
    ) external onlyOwner {
        require(xs.length == ys.length && ys.length == sizes.length, "Array length mismatch");

        for (uint256 i = 0; i < xs.length; i++) {
            uint256 tokenId = nextTokenId + totalParcels;
            parcels[tokenId] = Parcel({
                x: xs[i],
                y: ys[i],
                size: sizes[i],
                exists: true
            });
            totalParcels++;
        }
    }

    // ============================================
    // PURCHASE FLOW
    // ============================================

    /**
     * @dev Purchase the next available parcel
     * Automatically:
     * 1. Mints NFT to buyer
     * 2. Uses 50% ETH to buy LAND from pool
     * 3. Adds 50% ETH + LAND as liquidity
     * 4. Burns LP tokens
     */
    function purchaseNextParcel() external payable nonReentrant returns (uint256) {
        require(nextTokenId <= totalParcels, "No parcels available");

        uint256 currentPrice = getCurrentPrice();
        require(msg.value >= currentPrice, "Insufficient ETH");

        uint256 tokenId = nextTokenId;
        Parcel memory parcel = parcels[tokenId];
        require(parcel.exists, "Parcel not configured");

        // Mint NFT to buyer
        _safeMint(msg.sender, tokenId);
        nextTokenId++;

        totalETHCollected += msg.value;

        // Only create liquidity if pool is set
        if (pool != address(0)) {
            // Split ETH: 50% for market buy, 50% for LP
            uint256 ethForBuy = msg.value / 2;
            uint256 ethForLP = msg.value - ethForBuy;

            // Buy LAND from market
            uint256 landBought = _marketBuyLAND(ethForBuy);

            // Add liquidity
            uint256 lpTokens = _addLiquidity(ethForLP, landBought);

            // Burn LP tokens
            _burnLP(lpTokens);
        }

        emit ParcelMinted(tokenId, msg.sender, parcel.x, parcel.y, currentPrice);

        // Refund excess ETH
        if (msg.value > currentPrice) {
            (bool success, ) = msg.sender.call{value: msg.value - currentPrice}("");
            require(success, "Refund failed");
        }

        return tokenId;
    }

    // ============================================
    // LIQUIDITY MANAGEMENT
    // ============================================

    function setPool(address _pool) external onlyOwner {
        require(_pool != address(0), "Invalid pool");
        require(pool == address(0), "Pool already set");
        pool = _pool;
    }

    function _marketBuyLAND(uint256 ethAmount) internal returns (uint256) {
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = LAND_TOKEN;

        uint256 deadline = block.timestamp + 900;

        uint256[] memory amounts = IUniswapV2Router(ROUTER).swapExactETHForTokens{value: ethAmount}(
            0, // Accept any amount
            path,
            address(this),
            deadline
        );

        return amounts[amounts.length - 1];
    }

    function _addLiquidity(uint256 ethAmount, uint256 landAmount) internal returns (uint256) {
        IERC20(LAND_TOKEN).approve(ROUTER, landAmount);

        uint256 minLand = (landAmount * 95) / 100;
        uint256 minETH = (ethAmount * 95) / 100;
        uint256 deadline = block.timestamp + 900;

        (, , uint256 liquidity) = IUniswapV2Router(ROUTER).addLiquidityETH{value: ethAmount}(
            LAND_TOKEN,
            landAmount,
            minLand,
            minETH,
            address(this),
            deadline
        );

        totalLiquidityCreated += liquidity;
        emit LiquidityAdded(ethAmount, landAmount, liquidity);

        return liquidity;
    }

    function _burnLP(uint256 lpTokens) internal {
        IERC20(pool).transfer(BURN_ADDRESS, lpTokens);
        totalLPBurned += lpTokens;
        emit LPBurned(lpTokens);
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    function getParcel(uint256 tokenId) external view returns (
        int256 x,
        int256 y,
        uint256 size,
        uint256 currentPrice,
        address owner
    ) {
        Parcel memory p = parcels[tokenId];
        require(p.exists, "Parcel does not exist");

        address parcelOwner = _ownerOf(tokenId);
        uint256 price = parcelOwner == address(0) ? getCurrentPrice() : 0;

        return (p.x, p.y, p.size, price, parcelOwner);
    }

    function getStats() external view returns (
        uint256 _totalParcels,
        uint256 _soldCount,
        uint256 _availableCount,
        uint256 _currentPrice,
        uint256 _totalETHCollected,
        uint256 _totalLiquidityCreated,
        uint256 _totalLPBurned
    ) {
        uint256 sold = nextTokenId - 1;
        return (
            totalParcels,
            sold,
            totalParcels - sold,
            getCurrentPrice(),
            totalETHCollected,
            totalLiquidityCreated,
            totalLPBurned
        );
    }

    // ============================================
    // EMERGENCY & ADMIN
    // ============================================

    function emergencyWithdrawETH(address payable to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        (bool success, ) = to.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function emergencyWithdrawTokens(address token, address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        IERC20(token).transfer(to, amount);
    }

    receive() external payable {}
}
