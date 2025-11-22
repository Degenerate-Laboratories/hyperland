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
 * @title ParcelSaleWithLiquidity
 * @dev Sells parcels for ETH and automatically creates protocol-owned liquidity
 *
 * Strategy:
 * 1. Sell parcels for ETH
 * 2. Use 50% of ETH to market buy LAND tokens from BaseSwap
 * 3. Add all ETH + LAND as liquidity to the pool
 * 4. Burn LP tokens to create permanent protocol-owned liquidity
 */
contract ParcelSaleWithLiquidity is Ownable, ReentrancyGuard {
    HyperLandCore public immutable core;
    LANDToken public immutable landToken;
    IUniswapV2Router public immutable routerInterface;

    // BaseSwap (Uniswap V2 fork) addresses
    address public immutable router;
    address public immutable weth;
    address public pool; // LP pool address (LAND/WETH)

    // Burning configuration
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    // Bonding curve configuration
    uint256 public startPrice;      // Starting price in ETH (wei)
    uint256 public priceIncrement;  // Price increase per sale in ETH (wei)
    uint256 public maxPrice;        // Maximum price cap in ETH (wei)

    // Pre-defined parcel data
    struct ParcelData {
        uint256 x;
        uint256 y;
        uint256 size;
        bool sold;
    }

    mapping(uint256 => ParcelData) public parcels;
    uint256 public totalParcels;
    uint256 public soldCount;

    // Liquidity stats
    uint256 public totalETHCollected;
    uint256 public totalLiquidityCreated;
    uint256 public totalLPBurned;

    event ParcelPurchased(uint256 indexed parcelNumber, address indexed buyer, uint256 priceETH);
    event ParcelAdded(uint256 indexed parcelNumber, uint256 x, uint256 y);
    event LiquidityAdded(uint256 ethAmount, uint256 landAmount, uint256 lpTokens);
    event LPBurned(uint256 lpTokens);
    event BondingCurveUpdated(uint256 startPrice, uint256 priceIncrement, uint256 maxPrice);

    constructor(
        address _core,
        address _landToken,
        address _router,
        address _weth,
        address initialOwner,
        uint256 _startPrice,
        uint256 _priceIncrement,
        uint256 _maxPrice
    ) Ownable(initialOwner) {
        require(_core != address(0), "Invalid core address");
        require(_landToken != address(0), "Invalid LAND token address");
        require(_router != address(0), "Invalid router address");
        require(_weth != address(0), "Invalid WETH address");
        require(_startPrice > 0, "Start price must be > 0");
        require(_maxPrice >= _startPrice, "Max price must be >= start price");

        core = HyperLandCore(_core);
        landToken = LANDToken(_landToken);
        router = _router;
        routerInterface = IUniswapV2Router(_router);
        weth = _weth;
        startPrice = _startPrice;
        priceIncrement = _priceIncrement;
        maxPrice = _maxPrice;

        emit BondingCurveUpdated(_startPrice, _priceIncrement, _maxPrice);
    }

    /**
     * @dev Set the pool address (must be called after pool is created)
     */
    function setPool(address _pool) external onlyOwner {
        require(_pool != address(0), "Invalid pool address");
        require(pool == address(0), "Pool already set");
        pool = _pool;
    }

    /**
     * @dev Update bonding curve parameters (owner only)
     */
    function updateBondingCurve(
        uint256 _startPrice,
        uint256 _priceIncrement,
        uint256 _maxPrice
    ) external onlyOwner {
        require(_startPrice > 0, "Start price must be > 0");
        require(_maxPrice >= _startPrice, "Max price must be >= start price");

        startPrice = _startPrice;
        priceIncrement = _priceIncrement;
        maxPrice = _maxPrice;

        emit BondingCurveUpdated(_startPrice, _priceIncrement, _maxPrice);
    }

    /**
     * @dev Calculate current price based on bonding curve
     * Formula: price = startPrice + (soldCount × priceIncrement)
     * Capped at maxPrice
     */
    function getCurrentPrice() public view returns (uint256) {
        uint256 calculatedPrice = startPrice + (soldCount * priceIncrement);
        return calculatedPrice > maxPrice ? maxPrice : calculatedPrice;
    }

    /**
     * @dev Add a parcel to the sale (owner only)
     * Price is determined by bonding curve
     * @param parcelNumber Sequential parcel number (1-1205)
     * @param x X coordinate
     * @param y Y coordinate
     * @param size Parcel size
     */
    function addParcel(
        uint256 parcelNumber,
        uint256 x,
        uint256 y,
        uint256 size
    ) external onlyOwner {
        require(parcels[parcelNumber].size == 0, "Parcel already added");
        require(size > 0, "Size must be > 0");

        parcels[parcelNumber] = ParcelData({
            x: x,
            y: y,
            size: size,
            sold: false
        });

        totalParcels++;

        emit ParcelAdded(parcelNumber, x, y);
    }

    /**
     * @dev Batch add parcels
     * Prices are determined by bonding curve
     */
    function addParcelsBatch(
        uint256[] calldata parcelNumbers,
        uint256[] calldata xs,
        uint256[] calldata ys,
        uint256[] calldata sizes
    ) external onlyOwner {
        require(
            parcelNumbers.length == xs.length &&
            xs.length == ys.length &&
            ys.length == sizes.length,
            "Array length mismatch"
        );

        for (uint256 i = 0; i < parcelNumbers.length; i++) {
            if (parcels[parcelNumbers[i]].size == 0 && sizes[i] > 0) {
                parcels[parcelNumbers[i]] = ParcelData({
                    x: xs[i],
                    y: ys[i],
                    size: sizes[i],
                    sold: false
                });
                totalParcels++;
                emit ParcelAdded(parcelNumbers[i], xs[i], ys[i]);
            }
        }
    }

    /**
     * @dev Purchase a parcel with ETH
     * Price is determined by bonding curve
     * Automatically:
     * 1. Takes ETH payment at current bonding curve price
     * 2. Uses 50% to buy LAND from market
     * 3. Adds remaining 50% ETH + all LAND as LP
     * 4. Burns LP tokens
     *
     * @param parcelNumber Parcel to purchase (1-1205)
     */
    function purchaseParcel(uint256 parcelNumber) external payable nonReentrant {
        ParcelData storage parcel = parcels[parcelNumber];

        require(parcel.size > 0, "Parcel not available");
        require(!parcel.sold, "Parcel already sold");

        // Get current price from bonding curve
        uint256 currentPrice = getCurrentPrice();
        require(msg.value == currentPrice, "Incorrect ETH amount");

        // Mark as sold first (CEI pattern)
        parcel.sold = true;
        soldCount++;
        totalETHCollected += msg.value;

        // Split ETH: 50% for market buy, 50% for LP
        uint256 ethForBuy = msg.value / 2;
        uint256 ethForLP = msg.value - ethForBuy;

        // Step 1: Market buy LAND with 50% of ETH
        uint256 landBought = _marketBuyLAND(ethForBuy);

        // Step 2: Add liquidity with remaining 50% ETH + all LAND bought
        uint256 lpTokens = _addLiquidity(ethForLP, landBought);

        // Step 3: Burn LP tokens to create permanent liquidity
        _burnLP(lpTokens);

        // Step 4: Mint parcel to buyer via HyperLandCore
        core.mintParcel(
            msg.sender,
            parcel.x,
            parcel.y,
            parcel.size,
            currentPrice
        );

        emit ParcelPurchased(parcelNumber, msg.sender, currentPrice);
    }

    /**
     * @dev Market buy LAND tokens with ETH via BaseSwap
     * @param ethAmount Amount of ETH to spend
     * @return Amount of LAND tokens received
     */
    function _marketBuyLAND(uint256 ethAmount) internal returns (uint256) {
        // Prepare swap path: WETH -> LAND
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = address(landToken);

        // Calculate minimum LAND to receive (5% slippage tolerance)
        // This will be based on current pool reserves
        uint256 minLandOut = 0; // Accept any amount (market price)

        // Deadline: 15 minutes from now
        uint256 deadline = block.timestamp + 900;

        // Execute swap via router interface
        uint256[] memory amounts = routerInterface.swapExactETHForTokens{value: ethAmount}(
            minLandOut,
            path,
            address(this),
            deadline
        );

        return amounts[amounts.length - 1]; // Return LAND amount received
    }

    /**
     * @dev Add liquidity to LAND/WETH pool
     * @param ethAmount Amount of ETH to add
     * @param landAmount Amount of LAND to add
     * @return Amount of LP tokens received
     */
    function _addLiquidity(uint256 ethAmount, uint256 landAmount) internal returns (uint256) {
        // Approve router to spend LAND tokens
        landToken.approve(router, landAmount);

        // Calculate minimum amounts with 5% slippage
        uint256 minLandAmount = (landAmount * 95) / 100;
        uint256 minEthAmount = (ethAmount * 95) / 100;

        // Deadline: 15 minutes from now
        uint256 deadline = block.timestamp + 900;

        // Add liquidity via router interface
        (, , uint256 liquidity) = routerInterface.addLiquidityETH{value: ethAmount}(
            address(landToken),
            landAmount,
            minLandAmount,
            minEthAmount,
            address(this), // LP tokens come to this contract
            deadline
        );

        totalLiquidityCreated += liquidity;
        emit LiquidityAdded(ethAmount, landAmount, liquidity);

        return liquidity;
    }

    /**
     * @dev Burn LP tokens to create permanent protocol-owned liquidity
     * @param lpTokens Amount of LP tokens to burn
     */
    function _burnLP(uint256 lpTokens) internal {
        require(pool != address(0), "Pool not set");

        // Transfer LP tokens to burn address
        (bool success, ) = pool.call(
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                BURN_ADDRESS,
                lpTokens
            )
        );

        require(success, "LP burn failed");

        totalLPBurned += lpTokens;
        emit LPBurned(lpTokens);
    }

    /**
     * @dev Get parcel details
     * Price is calculated from current bonding curve
     */
    function getParcel(uint256 parcelNumber)
        external
        view
        returns (
            uint256 x,
            uint256 y,
            uint256 size,
            uint256 currentPrice,
            bool sold
        )
    {
        ParcelData memory parcel = parcels[parcelNumber];
        uint256 price = parcel.sold ? 0 : getCurrentPrice();
        return (parcel.x, parcel.y, parcel.size, price, parcel.sold);
    }

    /**
     * @dev Check if parcel is available
     */
    function isAvailable(uint256 parcelNumber) external view returns (bool) {
        ParcelData memory parcel = parcels[parcelNumber];
        return parcel.size > 0 && !parcel.sold;
    }

    /**
     * @dev Get sale statistics
     */
    function getStats()
        external
        view
        returns (
            uint256 _totalParcels,
            uint256 _soldCount,
            uint256 _availableCount,
            uint256 _totalETHCollected,
            uint256 _totalLiquidityCreated,
            uint256 _totalLPBurned
        )
    {
        return (
            totalParcels,
            soldCount,
            totalParcels - soldCount,
            totalETHCollected,
            totalLiquidityCreated,
            totalLPBurned
        );
    }

    /**
     * @dev Emergency withdrawal (owner only) - only for stuck tokens/ETH
     * Should NOT be needed in normal operation
     */
    function emergencyWithdrawETH(address payable to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        (bool success, ) = to.call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function emergencyWithdrawTokens(address token, address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        (bool success, ) = token.call(
            abi.encodeWithSignature("transfer(address,uint256)", to, amount)
        );
        require(success, "Token transfer failed");
    }

    /**
     * @dev Transfer ownership of HyperLandCore (only needed for contract migration)
     */
    function transferCoreOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        core.transferOwnership(newOwner);
    }

    receive() external payable {}
}
