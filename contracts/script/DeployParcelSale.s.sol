// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/ParcelSale.sol";

contract DeployParcelSale is Script {
    function run() external {
        // Load environment variables
        address core = vm.envAddress("HYPERLAND_CORE_ADDRESS");
        address landToken = vm.envAddress("LAND_TOKEN_ADDRESS");
        address admin = vm.envAddress("ADMIN_ADDRESS");

        console.log("==============================================");
        console.log("Deploying ParcelSale Contract");
        console.log("==============================================");
        console.log("Network: Base Mainnet");
        console.log("HyperLandCore:", core);
        console.log("LAND Token:", landToken);
        console.log("Admin:", admin);
        console.log("");

        vm.startBroadcast();

        // Deploy ParcelSale
        ParcelSale sale = new ParcelSale(core, landToken, admin);

        vm.stopBroadcast();

        console.log("==============================================");
        console.log("Deployment Complete!");
        console.log("==============================================");
        console.log("ParcelSale:", address(sale));
        console.log("");
        console.log("CRITICAL NEXT STEPS:");
        console.log("1. Transfer HyperLandCore ownership to ParcelSale:");
        console.log("   cast send", core);
        console.log("   \"transferOwnership(address)\"", address(sale));
        console.log("   --rpc-url $RPC --private-key $PRIVATE_KEY");
        console.log("");
        console.log("2. Load all 1,205 parcels into ParcelSale");
        console.log("   (Use the load-parcels script)");
        console.log("");
        console.log("3. Update frontend with ParcelSale address:");
        console.log("   NEXT_PUBLIC_PARCEL_SALE_ADDRESS=", address(sale));
        console.log("");
    }
}
