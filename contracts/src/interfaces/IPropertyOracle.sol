// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title IPropertyOracle
 * @dev Interface for external property valuation oracles
 *
 * Oracles implementing this interface can provide property valuations
 * to the HyperLand ecosystem with confidence scores.
 */
interface IPropertyOracle {
    /**
     * @dev Get property valuation for a specific parcel
     * @param parcelId Token ID of the parcel
     * @return value Assessed value in LAND tokens
     * @return confidence Confidence score (0-100)
     */
    function getPropertyValue(uint256 parcelId)
        external
        view
        returns (uint256 value, uint256 confidence);

    /**
     * @dev Get the oracle's name/identifier
     * @return Oracle name
     */
    function oracleName() external view returns (string memory);

    /**
     * @dev Get the data sources used by this oracle
     * @return Array of data source descriptions
     */
    function dataSources() external view returns (string[] memory);

    /**
     * @dev Check if oracle can value a specific parcel
     * @param parcelId Token ID of the parcel
     * @return True if oracle has data for this parcel
     */
    function canValueParcel(uint256 parcelId) external view returns (bool);

    /**
     * @dev Get last update timestamp for a parcel's valuation
     * @param parcelId Token ID of the parcel
     * @return Unix timestamp of last update
     */
    function lastUpdated(uint256 parcelId) external view returns (uint256);
}
