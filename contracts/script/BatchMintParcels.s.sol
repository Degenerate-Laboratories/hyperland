// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/HyperLandCore.sol";

/**
 * @title BatchMintParcels
 * @dev Script to batch mint parcels from CSV data
 *
 * Usage:
 * forge script script/BatchMintParcels.s.sol:BatchMintParcels --rpc-url base_sepolia --broadcast
 *
 * Required environment variables:
 * - PRIVATE_KEY: Admin private key
 * - HYPERLAND_CORE_ADDRESS: Address of deployed HyperLandCore
 * - BATCH_SIZE: Number of parcels to mint per transaction (default: 50)
 * - START_INDEX: Starting index in CSV (default: 0)
 * - END_INDEX: Ending index (default: 1205 for all parcels)
 */
contract BatchMintParcels is Script {
    struct ParcelData {
        string parcelId;
        uint256 x;
        uint256 y;
        uint256 ring; // 0=Esplanade, 1=MidCity, 2=Afanc, 3=Igopogo, 4=Kraken
        uint256 assessedValue;
    }

    // Ring data from CSV analysis
    // Ring 0 (Esplanade): Inner 0, Outer 2500
    // Ring 1 (MidCity): Inner 2500, Outer 3450
    // Ring 2 (Afanc): Inner 3450, Outer 5200
    // Ring 3 (Igopogo): Inner 5200, Outer 7675
    // Ring 4 (Kraken): Inner 7675, Outer 11690

    function run() external {
        // Get environment variables
        address coreAddress = vm.envAddress("HYPERLAND_CORE_ADDRESS");
        uint256 batchSize = vm.envOr("BATCH_SIZE", uint256(50));
        uint256 startIndex = vm.envOr("START_INDEX", uint256(0));
        uint256 endIndex = vm.envOr("END_INDEX", uint256(1205));
        address initialOwner = vm.envOr("INITIAL_OWNER", address(0));

        // If no initial owner specified, use treasury/admin
        if (initialOwner == address(0)) {
            initialOwner = vm.envAddress("TREASURY_ADDRESS");
        }

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        HyperLandCore core = HyperLandCore(coreAddress);

        console.log("===========================================");
        console.log("Batch Minting HyperLand Parcels");
        console.log("===========================================");
        console.log("Core Contract:", coreAddress);
        console.log("Initial Owner:", initialOwner);
        console.log("Batch Size:", batchSize);
        console.log("Range:", startIndex, "to", endIndex);
        console.log("Total Parcels:", endIndex - startIndex);
        console.log("-------------------------------------------");

        vm.startBroadcast(deployerPrivateKey);

        uint256 count = 0;
        for (uint256 i = startIndex; i < endIndex; i++) {
            // Calculate coordinates and ring from CSV data
            // This is a simplified example - you'll parse the actual CSV
            (uint256 x, uint256 y, uint256 ring, uint256 assessedValue) = getParcelData(i);

            // Mint parcel
            uint256 tokenId = core.mintParcel(
                initialOwner,
                x,
                y,
                100, // Standard size
                assessedValue
            );

            count++;

            if (count % 10 == 0) {
                console.log("Minted", count, "parcels... Latest token ID:", tokenId);
            }

            // Optional: Add delay every batch to avoid rate limits
            if (count % batchSize == 0) {
                console.log("Batch complete. Minted", count, "parcels total.");
            }
        }

        vm.stopBroadcast();

        console.log("\n===========================================");
        console.log("Minting Complete!");
        console.log("===========================================");
        console.log("Total Parcels Minted:", count);
        console.log("Final Token ID:", count);
    }

    /**
     * @dev Get parcel data for a given index
     * In production, this would read from the CSV file
     * For now, returns calculated/mock data
     */
    function getParcelData(uint256 index) internal pure returns (
        uint256 x,
        uint256 y,
        uint256 ring,
        uint256 assessedValue
    ) {
        // Simplified calculation - in production, read from CSV
        // Each ring has 241 parcels
        ring = index / 241; // 0-4 for 5 rings
        uint256 positionInRing = index % 241;

        // Calculate approximate coordinates based on ring
        // These are placeholder calculations
        if (ring == 0) {
            // Esplanade: radius ~1250
            x = uint256(int256(1250) * cos(positionInRing * 15)); // ~1.5 degrees per parcel
            y = uint256(int256(1250) * sin(positionInRing * 15));
            assessedValue = 1000 * 10**18; // Base value
        } else if (ring == 1) {
            // MidCity: radius ~2975
            x = uint256(int256(2975) * cos(positionInRing * 15));
            y = uint256(int256(2975) * sin(positionInRing * 15));
            assessedValue = 800 * 10**18;
        } else if (ring == 2) {
            // Afanc: radius ~4325
            x = uint256(int256(4325) * cos(positionInRing * 15));
            y = uint256(int256(4325) * sin(positionInRing * 15));
            assessedValue = 600 * 10**18;
        } else if (ring == 3) {
            // Igopogo: radius ~6437
            x = uint256(int256(6437) * cos(positionInRing * 15));
            y = uint256(int256(6437) * sin(positionInRing * 15));
            assessedValue = 400 * 10**18;
        } else {
            // Kraken: radius ~9682
            x = uint256(int256(9682) * cos(positionInRing * 15));
            y = uint256(int256(9682) * sin(positionInRing * 15));
            assessedValue = 200 * 10**18;
        }

        return (x, y, ring, assessedValue);
    }

    // Simple trig approximations for coordinate calculation
    function cos(uint256 degrees) internal pure returns (int256) {
        // Simplified - returns approximate values
        // In production, use actual CSV coordinates
        degrees = degrees % 360;
        if (degrees <= 90) return int256(1000 - (degrees * 11));
        else if (degrees <= 180) return -int256((degrees - 90) * 11);
        else if (degrees <= 270) return -int256(1000 - ((degrees - 180) * 11));
        else return int256((degrees - 270) * 11);
    }

    function sin(uint256 degrees) internal pure returns (int256) {
        return cos(degrees >= 90 ? degrees - 90 : degrees + 270);
    }
}
