// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/PrimarySaleV3.sol";

/**
 * @title AddParcelsV3
 * @dev Add initial parcels to PrimarySaleV3 for testing
 */
contract AddParcelsV3 is Script {
    address payable constant PRIMARY_SALE = payable(0x9Fdd7A16295c2004E61FF28B98d323E130fd2240);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Adding Parcels to PrimarySaleV3");
        console.log("========================================\n");
        console.log("PrimarySale:", PRIMARY_SALE);
        console.log("Deployer:", deployer);

        // Prepare parcel data (10 parcels for testing)
        int256[] memory xs = new int256[](10);
        int256[] memory ys = new int256[](10);
        uint256[] memory sizes = new uint256[](10);
        uint256[] memory assessedValues = new uint256[](10);

        // Ring 0: parcels around origin (100, 100)
        xs[0] = 100;  ys[0] = 100;  sizes[0] = 1;  assessedValues[0] = 1000 ether;
        xs[1] = 101;  ys[1] = 100;  sizes[1] = 1;  assessedValues[1] = 1000 ether;
        xs[2] = 102;  ys[2] = 100;  sizes[2] = 1;  assessedValues[2] = 1000 ether;
        xs[3] = 100;  ys[3] = 101;  sizes[3] = 1;  assessedValues[3] = 1000 ether;
        xs[4] = 101;  ys[4] = 101;  sizes[4] = 1;  assessedValues[4] = 1000 ether;

        // Ring 1: next ring
        xs[5] = 102;  ys[5] = 101;  sizes[5] = 1;  assessedValues[5] = 1000 ether;
        xs[6] = 100;  ys[6] = 102;  sizes[6] = 1;  assessedValues[6] = 1000 ether;
        xs[7] = 101;  ys[7] = 102;  sizes[7] = 1;  assessedValues[7] = 1000 ether;
        xs[8] = 102;  ys[8] = 102;  sizes[8] = 1;  assessedValues[8] = 1000 ether;
        xs[9] = 103;  ys[9] = 100;  sizes[9] = 1;  assessedValues[9] = 1000 ether;

        vm.startBroadcast(deployerPrivateKey);

        PrimarySaleV3 primarySale = PrimarySaleV3(PRIMARY_SALE);

        console.log("\nAdding 10 parcels...");
        primarySale.addParcelsBatch(xs, ys, sizes, assessedValues);
        console.log("[OK] Parcels added successfully!");

        vm.stopBroadcast();

        // Check stats
        (
            uint256 totalConfigured,
            uint256 sold,
            uint256 available,
            uint256 currentPrice,
            ,
            ,
        ) = primarySale.getStats();

        console.log("\n========================================");
        console.log("PrimarySale Stats");
        console.log("========================================");
        console.log("Total Configured:", totalConfigured);
        console.log("Sold:", sold);
        console.log("Available:", available);
        console.log("Current Price:", currentPrice, "wei");
        console.log("Current Price USD:", (currentPrice * 3333) / 1 ether, "(assuming $3333 ETH)");

        console.log("\n========================================");
        console.log("Next Steps");
        console.log("========================================");
        console.log("1. Test purchase with:");
        console.log("   cast send", PRIMARY_SALE);
        console.log("   'purchaseNextParcel()' \\");
        console.log("   --value", currentPrice, "\\");
        console.log("   --rpc-url https://mainnet.base.org \\");
        console.log("   --private-key $PRIVATE_KEY");
        console.log("\n2. Or run the test purchase script");
        console.log("========================================\n");
    }
}
