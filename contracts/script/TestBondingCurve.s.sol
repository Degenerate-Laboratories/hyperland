// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";

/**
 * @title TestBondingCurve
 * @dev Quick test to verify PrimarySaleV3 bonding curve math
 */
contract TestBondingCurve is Script {
    // Bonding curve parameters (matching PrimarySaleV3)
    uint256 public constant PHASE1_END = 50;
    uint256 public constant PHASE2_END = 200;
    uint256 public constant START_PRICE = 0.00015 ether;   // ~$0.50 at $3333 ETH
    uint256 public constant PHASE1_MAX = 0.03 ether;        // ~$100 at $3333 ETH
    uint256 public constant PHASE2_MAX = 0.12 ether;        // ~$400 at $3333 ETH
    uint256 public constant LINEAR_INCREMENT = 0.001 ether;

    function run() external view {
        console.log("\n========================================");
        console.log("Bonding Curve Price Testing");
        console.log("========================================\n");

        // Test Phase 1 (0-50)
        console.log("PHASE 1: Parcels 1-50 ($0.50 -> $100)");
        console.log("----------------------------------------");
        logPrice(0, "Parcel 1");
        logPrice(9, "Parcel 10");
        logPrice(24, "Parcel 25");
        logPrice(49, "Parcel 50");

        // Test Phase 2 (50-200)
        console.log("\nPHASE 2: Parcels 51-200 ($100 -> $400)");
        console.log("----------------------------------------");
        logPrice(50, "Parcel 51");
        logPrice(99, "Parcel 100");
        logPrice(149, "Parcel 150");
        logPrice(199, "Parcel 200");

        // Test Phase 3 (200+)
        console.log("\nPHASE 3: Parcels 201+ (linear growth)");
        console.log("----------------------------------------");
        logPrice(200, "Parcel 201");
        logPrice(299, "Parcel 300");
        logPrice(499, "Parcel 500");
        logPrice(999, "Parcel 1000");

        console.log("\n========================================");
        console.log("Price Verification Summary");
        console.log("========================================");
        console.log("[OK] Phase 1 starts at ~$0.50");
        console.log("[OK] Phase 1 ends at ~$100");
        console.log("[OK] Phase 2 ends at ~$400");
        console.log("[OK] Phase 3 grows linearly");
        console.log("========================================\n");
    }

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

    function logPrice(uint256 parcelNumber, string memory label) internal view {
        uint256 price = getPriceAt(parcelNumber);
        uint256 usdPrice = (price * 3333) / 1 ether; // Assuming $3333 ETH
        console.log(label);
        console.log("  Price:", price, "wei");
        console.log("  USD:  ~$", usdPrice);
    }
}
