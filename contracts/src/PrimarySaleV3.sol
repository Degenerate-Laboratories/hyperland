// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./HyperLandCore.sol";
import "./LANDToken.sol";

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

/**
 * @title PrimarySaleV3
 * @dev Primary sale contract with exponential bonding curve and protocol-owned liquidity
 *
 * KEY FEATURES:
 * - Only handles FIRST MINT (primary sale)
 * - Exponential bonding curve: $0.50 → $100 → $400
 * - Automatic liquidity: 50% ETH swap for LAND, 50% ETH + LAND → LP, burn LP
 * - Works with existing HyperLandCore for minting
 * - Secondary sales happen via HyperLandCore marketplace (no liquidity mechanism)
 */
contract PrimarySaleV3 is Ownable, ReentrancyGuard {

    // ============================================
    // IMMUTABLE REFERENCES
    // ============================================

    HyperLandCore public immutable hyperLandCore;
    LANDToken public immutable landToken;
    IUniswapV2Router public immutable router;
    address public immutable weth;
    address public immutable burnAddress = 0x000000000000000000000000000000000000dEaD;

    // ============================================
    // STATE VARIABLES
    // ============================================

    address public pool; // LAND/WETH LP pool
    uint256 public nextTokenId = 1;

    // Parcel configuration
    struct ParcelConfig {
        int256 x;
        int256 y;
        uint256 size;
        uint256 assessedValue; // In LAND tokens
        bool configured;
    }
    mapping(uint256 => ParcelConfig) public parcelConfigs;
    uint256 public totalParcelsConfigured;

    // Bonding curve parameters
    uint256 public constant PHASE1_END = 50;      // Parcels 1-50: $0.50 → $100
    uint256 public constant PHASE2_END = 200;     // Parcels 51-200: $100 → $400
    // After 200: slow linear growth

    uint256 public constant START_PRICE = 0.00015 ether;   // ~$0.50 at $3333 ETH
    uint256 public constant PHASE1_MAX = 0.03 ether;        // ~$100 at $3333 ETH
    uint256 public constant PHASE2_MAX = 0.12 ether;        // ~$400 at $3333 ETH
    uint256 public constant LINEAR_INCREMENT = 0.001 ether; // After phase 2

    // Stats
    uint256 public totalETHCollected;
    uint256 public totalLiquidityCreated;
    uint256 public totalLPBurned;

    // ============================================
    // EVENTS
    // ============================================

    event ParcelPurchased(
        uint256 indexed tokenId,
        address indexed buyer,
        int256 x,
        int256 y,
        uint256 priceETH,
        uint256 parcelNumber
    );
    event LiquidityAdded(uint256 ethAmount, uint256 landAmount, uint256 lpTokens);
    event LPBurned(uint256 lpTokens);
    event ParcelConfigured(uint256 indexed tokenId, int256 x, int256 y, uint256 size);

    // ============================================
    // CONSTRUCTOR
    // ============================================

    constructor(
        address _hyperLandCore,
        address _landToken,
        address _router,
        address _weth,
        address initialOwner
    ) Ownable(initialOwner) {
        require(_hyperLandCore != address(0), "Invalid core");
        require(_landToken != address(0), "Invalid LAND token");
        require(_router != address(0), "Invalid router");
        require(_weth != address(0), "Invalid WETH");

        hyperLandCore = HyperLandCore(_hyperLandCore);
        landToken = LANDToken(_landToken);
        router = IUniswapV2Router(_router);
        weth = _weth;
    }

    // ============================================
    // BONDING CURVE PRICING
    // ============================================

    /**
     * @dev Get current price based on number of parcels sold
     * Phase 1 (0-50): Quadratic growth $0.50 → $100
     * Phase 2 (50-200): Quadratic growth $100 → $400
     * Phase 3 (200+): Linear slow growth
     */
    function getCurrentPrice() public view returns (uint256) {
        uint256 sold = nextTokenId - 1;

        if (sold < PHASE1_END) {
            // Phase 1: Quadratic (exponential-like)
            // y = START + (MAX - START) * (x/50)^2
            uint256 ratio = (sold * 1e18) / PHASE1_END;
            uint256 priceRange = PHASE1_MAX - START_PRICE;
            uint256 quadraticFactor = (ratio * ratio) / 1e18;
            return START_PRICE + (priceRange * quadraticFactor) / 1e18;
        }
        else if (sold < PHASE2_END) {
            // Phase 2: Quadratic
            uint256 phase2Sold = sold - PHASE1_END;
            uint256 phase2Length = PHASE2_END - PHASE1_END;
            uint256 ratio = (phase2Sold * 1e18) / phase2Length;
            uint256 priceRange = PHASE2_MAX - PHASE1_MAX;
            uint256 quadraticFactor = (ratio * ratio) / 1e18;
            return PHASE1_MAX + (priceRange * quadraticFactor) / 1e18;
        }
        else {
            // Phase 3: Linear
            uint256 phase3Sold = sold - PHASE2_END;
            return PHASE2_MAX + (phase3Sold * LINEAR_INCREMENT);
        }
    }

    /**
     * @dev Get price at specific parcel number (for previewing)
     */
    function getPriceAt(uint256 parcelNumber) public pure returns (uint256) {
        if (parcelNumber < PHASE1_END) {
            uint256 ratio = (parcelNumber * 1e18) / PHASE1_END;
            uint256 priceRange = PHASE1_MAX - START_PRICE;
            uint256 quadraticFactor = (ratio * ratio) / 1e18;
            return START_PRICE + (priceRange * quadraticFactor) / 1e18;
        }
        else if (parcelNumber < PHASE2_END) {
            uint256 phase2Sold = parcelNumber - PHASE1_END;
            uint256 phase2Length = PHASE2_END - PHASE1_END;
            uint256 ratio = (phase2Sold * 1e18) / phase2Length;
            uint256 priceRange = PHASE2_MAX - PHASE1_MAX;
            uint256 quadraticFactor = (ratio * ratio) / 1e18;
            return PHASE1_MAX + (priceRange * quadraticFactor) / 1e18;
        }
        else {
            uint256 phase3Sold = parcelNumber - PHASE2_END;
            return PHASE2_MAX + (phase3Sold * LINEAR_INCREMENT);
        }
    }

    // ============================================
    // PARCEL CONFIGURATION
    // ============================================

    /**
     * @dev Add parcels to the sale (owner only)
     */
    function addParcelsBatch(
        int256[] calldata xs,
        int256[] calldata ys,
        uint256[] calldata sizes,
        uint256[] calldata assessedValues
    ) external onlyOwner {
        require(
            xs.length == ys.length &&
            ys.length == sizes.length &&
            sizes.length == assessedValues.length,
            "Array length mismatch"
        );

        for (uint256 i = 0; i < xs.length; i++) {
            uint256 tokenId = nextTokenId + totalParcelsConfigured;
            parcelConfigs[tokenId] = ParcelConfig({
                x: xs[i],
                y: ys[i],
                size: sizes[i],
                assessedValue: assessedValues[i],
                configured: true
            });
            totalParcelsConfigured++;
            emit ParcelConfigured(tokenId, xs[i], ys[i], sizes[i]);
        }
    }

    // ============================================
    // PRIMARY SALE
    // ============================================

    /**
     * @dev Purchase next available parcel (PRIMARY SALE ONLY)
     * - Mints NFT via HyperLandCore
     * - Creates protocol-owned liquidity (50% swap, 50% LP, burn)
     * - This is the ONLY time liquidity is created for this parcel
     * - Secondary sales go through HyperLandCore marketplace (no liquidity)
     */
    function purchaseNextParcel() external payable nonReentrant returns (uint256) {
        require(nextTokenId <= totalParcelsConfigured, "No parcels available");

        uint256 currentPrice = getCurrentPrice();
        require(msg.value >= currentPrice, "Insufficient ETH");

        uint256 tokenId = nextTokenId;
        ParcelConfig memory config = parcelConfigs[tokenId];
        require(config.configured, "Parcel not configured");

        // Increment before external calls (CEI pattern)
        nextTokenId++;
        totalETHCollected += msg.value;

        // Mint parcel via HyperLandCore (primary sale)
        hyperLandCore.mintParcel(
            msg.sender,
            config.x,
            config.y,
            config.size,
            config.assessedValue
        );

        // Create protocol-owned liquidity (only if pool is set)
        if (pool != address(0) && msg.value > 0) {
            _createLiquidity(msg.value);
        }

        emit ParcelPurchased(
            tokenId,
            msg.sender,
            config.x,
            config.y,
            currentPrice,
            tokenId
        );

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
        pool = _pool;
    }

    /**
     * @dev Create protocol-owned liquidity from sale proceeds
     * - 50% ETH swapped for LAND
     * - 50% ETH + LAND added as LP
     * - LP tokens burned to dead address
     */
    function _createLiquidity(uint256 ethAmount) internal {
        uint256 ethForSwap = ethAmount / 2;
        uint256 ethForLP = ethAmount - ethForSwap;

        // Step 1: Swap 50% ETH for LAND
        uint256 landBought = _swapETHForLAND(ethForSwap);

        // Step 2: Add liquidity with 50% ETH + LAND
        uint256 lpTokens = _addLiquidityETH(ethForLP, landBought);

        // Step 3: Burn LP tokens
        _burnLP(lpTokens);
    }

    function _swapETHForLAND(uint256 ethAmount) internal returns (uint256) {
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = address(landToken);

        uint256 deadline = block.timestamp + 900; // 15 minutes

        uint256[] memory amounts = router.swapExactETHForTokens{value: ethAmount}(
            0, // Accept any amount (market price)
            path,
            address(this),
            deadline
        );

        return amounts[amounts.length - 1];
    }

    function _addLiquidityETH(uint256 ethAmount, uint256 landAmount) internal returns (uint256) {
        // Approve router to spend LAND
        landToken.approve(address(router), landAmount);

        uint256 minLand = (landAmount * 95) / 100; // 5% slippage
        uint256 minETH = (ethAmount * 95) / 100;
        uint256 deadline = block.timestamp + 900;

        (, , uint256 liquidity) = router.addLiquidityETH{value: ethAmount}(
            address(landToken),
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
        // Transfer LP tokens to burn address
        (bool success, ) = pool.call(
            abi.encodeWithSignature("transfer(address,uint256)", burnAddress, lpTokens)
        );
        require(success, "LP burn failed");
        totalLPBurned += lpTokens;
        emit LPBurned(lpTokens);
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    function getStats() external view returns (
        uint256 _totalParcelsConfigured,
        uint256 _parcelsSold,
        uint256 _parcelsAvailable,
        uint256 _currentPrice,
        uint256 _totalETHCollected,
        uint256 _totalLiquidityCreated,
        uint256 _totalLPBurned
    ) {
        uint256 sold = nextTokenId - 1;
        return (
            totalParcelsConfigured,
            sold,
            totalParcelsConfigured - sold,
            getCurrentPrice(),
            totalETHCollected,
            totalLiquidityCreated,
            totalLPBurned
        );
    }

    function getParcelConfig(uint256 tokenId) external view returns (
        int256 x,
        int256 y,
        uint256 size,
        uint256 assessedValue,
        uint256 price,
        bool available
    ) {
        ParcelConfig memory config = parcelConfigs[tokenId];
        bool isAvailable = config.configured && tokenId >= nextTokenId;
        uint256 parcelPrice = isAvailable ? getPriceAt(tokenId - 1) : 0;

        return (
            config.x,
            config.y,
            config.size,
            config.assessedValue,
            parcelPrice,
            isAvailable
        );
    }

    // ============================================
    // EMERGENCY FUNCTIONS
    // ============================================

    function emergencyWithdrawETH(address payable to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        (bool success, ) = to.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function emergencyWithdrawTokens(address token, address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        (bool success, ) = token.call(
            abi.encodeWithSignature("transfer(address,uint256)", to, amount)
        );
        require(success, "Token transfer failed");
    }

    receive() external payable {}
}
