// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./HyperLandCore.sol";
import "./LANDToken.sol";

/**
 * @title ParcelSale
 * @dev Allows users to purchase parcels directly using LAND tokens
 * Acts as a bonding curve / initial sale mechanism
 */
contract ParcelSale is Ownable, ReentrancyGuard {
    HyperLandCore public immutable core;
    LANDToken public immutable landToken;

    // Pre-defined parcel data
    struct ParcelData {
        uint256 x;
        uint256 y;
        uint256 size;
        uint256 price; // Price in LAND tokens
        bool sold;
    }

    mapping(uint256 => ParcelData) public parcels;
    uint256 public totalParcels;
    uint256 public soldCount;

    event ParcelPurchased(uint256 indexed parcelNumber, address indexed buyer, uint256 price);
    event ParcelAdded(uint256 indexed parcelNumber, uint256 x, uint256 y, uint256 price);

    constructor(
        address _core,
        address _landToken,
        address initialOwner
    ) Ownable(initialOwner) {
        require(_core != address(0), "Invalid core address");
        require(_landToken != address(0), "Invalid LAND token address");

        core = HyperLandCore(_core);
        landToken = LANDToken(_landToken);
    }

    /**
     * @dev Add a parcel to the sale (owner only)
     * @param parcelNumber Sequential parcel number (1-1205)
     * @param x X coordinate
     * @param y Y coordinate
     * @param size Parcel size
     * @param price Price in LAND tokens (wei)
     */
    function addParcel(
        uint256 parcelNumber,
        uint256 x,
        uint256 y,
        uint256 size,
        uint256 price
    ) external onlyOwner {
        require(parcels[parcelNumber].price == 0, "Parcel already added");
        require(price > 0, "Price must be > 0");

        parcels[parcelNumber] = ParcelData({
            x: x,
            y: y,
            size: size,
            price: price,
            sold: false
        });

        totalParcels++;

        emit ParcelAdded(parcelNumber, x, y, price);
    }

    /**
     * @dev Batch add parcels
     */
    function addParcelsBatch(
        uint256[] calldata parcelNumbers,
        uint256[] calldata xs,
        uint256[] calldata ys,
        uint256[] calldata sizes,
        uint256[] calldata prices
    ) external onlyOwner {
        require(
            parcelNumbers.length == xs.length &&
            xs.length == ys.length &&
            ys.length == sizes.length &&
            sizes.length == prices.length,
            "Array length mismatch"
        );

        for (uint256 i = 0; i < parcelNumbers.length; i++) {
            if (parcels[parcelNumbers[i]].price == 0 && prices[i] > 0) {
                parcels[parcelNumbers[i]] = ParcelData({
                    x: xs[i],
                    y: ys[i],
                    size: sizes[i],
                    price: prices[i],
                    sold: false
                });
                totalParcels++;
                emit ParcelAdded(parcelNumbers[i], xs[i], ys[i], prices[i]);
            }
        }
    }

    /**
     * @dev Purchase a parcel
     * @param parcelNumber Parcel to purchase (1-1205)
     */
    function purchaseParcel(uint256 parcelNumber) external nonReentrant {
        ParcelData storage parcel = parcels[parcelNumber];

        require(parcel.price > 0, "Parcel not available");
        require(!parcel.sold, "Parcel already sold");

        // Mark as sold first (CEI pattern)
        parcel.sold = true;
        soldCount++;

        // Transfer LAND tokens from buyer to this contract
        require(
            landToken.transferFrom(msg.sender, address(this), parcel.price),
            "LAND transfer failed"
        );

        // Mint parcel to buyer via HyperLandCore
        core.mintParcel(
            msg.sender,
            parcel.x,
            parcel.y,
            parcel.size,
            parcel.price
        );

        emit ParcelPurchased(parcelNumber, msg.sender, parcel.price);
    }

    /**
     * @dev Get parcel details
     */
    function getParcel(uint256 parcelNumber)
        external
        view
        returns (
            uint256 x,
            uint256 y,
            uint256 size,
            uint256 price,
            bool sold
        )
    {
        ParcelData memory parcel = parcels[parcelNumber];
        return (parcel.x, parcel.y, parcel.size, parcel.price, parcel.sold);
    }

    /**
     * @dev Check if parcel is available
     */
    function isAvailable(uint256 parcelNumber) external view returns (bool) {
        ParcelData memory parcel = parcels[parcelNumber];
        return parcel.price > 0 && !parcel.sold;
    }

    /**
     * @dev Withdraw collected LAND tokens (owner only)
     */
    function withdrawLAND(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        require(landToken.transfer(to, amount), "Transfer failed");
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
            uint256 _availableCount
        )
    {
        return (totalParcels, soldCount, totalParcels - soldCount);
    }
}
