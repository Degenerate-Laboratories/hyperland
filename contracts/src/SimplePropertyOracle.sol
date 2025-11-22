// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./interfaces/IPropertyOracle.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SimplePropertyOracle
 * @dev Simple implementation of IPropertyOracle for testing and demonstration
 *
 * This oracle stores property valuations set by an admin. In production,
 * this would be replaced with oracles that fetch data from:
 * - Chainlink Price Feeds
 * - External APIs (via Chainlink Functions)
 * - On-chain DEX prices
 * - Multiple aggregated sources
 */
contract SimplePropertyOracle is IPropertyOracle, Ownable {
    // Valuation data
    struct ValuationData {
        uint256 value;
        uint256 confidence;
        uint256 timestamp;
        bool exists;
    }

    mapping(uint256 => ValuationData) private valuations;
    string private _oracleName;
    string[] private _dataSources;

    event ValuationUpdated(uint256 indexed parcelId, uint256 value, uint256 confidence, uint256 timestamp);

    /**
     * @dev Constructor
     * @param name Oracle identifier
     * @param initialOwner Owner address
     */
    constructor(string memory name, address initialOwner) Ownable(initialOwner) {
        _oracleName = name;
        _dataSources = new string[](1);
        _dataSources[0] = "Admin-provided valuations";
    }

    /**
     * @dev Update valuation for a parcel (admin only)
     * @param parcelId Token ID
     * @param value Assessed value in LAND tokens
     * @param confidence Confidence score (0-100)
     */
    function setValuation(uint256 parcelId, uint256 value, uint256 confidence) external onlyOwner {
        require(value > 0, "Value must be > 0");
        require(confidence <= 100, "Confidence must be <= 100");

        valuations[parcelId] = ValuationData({
            value: value,
            confidence: confidence,
            timestamp: block.timestamp,
            exists: true
        });

        emit ValuationUpdated(parcelId, value, confidence, block.timestamp);
    }

    /**
     * @dev Remove valuation for a parcel (admin only)
     * @param parcelId Token ID
     */
    function removeValuation(uint256 parcelId) external onlyOwner {
        delete valuations[parcelId];
    }

    // ============================================
    // IPropertyOracle Implementation
    // ============================================

    /**
     * @inheritdoc IPropertyOracle
     */
    function getPropertyValue(uint256 parcelId)
        external
        view
        override
        returns (uint256 value, uint256 confidence)
    {
        ValuationData memory data = valuations[parcelId];
        require(data.exists, "No valuation for this parcel");

        return (data.value, data.confidence);
    }

    /**
     * @inheritdoc IPropertyOracle
     */
    function oracleName() external view override returns (string memory) {
        return _oracleName;
    }

    /**
     * @inheritdoc IPropertyOracle
     */
    function dataSources() external view override returns (string[] memory) {
        return _dataSources;
    }

    /**
     * @inheritdoc IPropertyOracle
     */
    function canValueParcel(uint256 parcelId) external view override returns (bool) {
        return valuations[parcelId].exists;
    }

    /**
     * @inheritdoc IPropertyOracle
     */
    function lastUpdated(uint256 parcelId) external view override returns (uint256) {
        require(valuations[parcelId].exists, "No valuation for this parcel");
        return valuations[parcelId].timestamp;
    }

    /**
     * @dev Update oracle name (admin only)
     * @param newName New name
     */
    function setOracleName(string memory newName) external onlyOwner {
        _oracleName = newName;
    }

    /**
     * @dev Add data source description (admin only)
     * @param source Data source description
     */
    function addDataSource(string memory source) external onlyOwner {
        _dataSources.push(source);
    }
}
