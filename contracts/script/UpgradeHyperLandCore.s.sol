// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/HyperLandCore.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";

/**
 * @title UpgradeHyperLandCore
 * @dev Deploy new HyperLandCore with authorized minter support
 * Then migrate state from old contract
 */
contract UpgradeHyperLandCore is Script {
    // Existing contracts
    address constant OLD_HYPERLAND_CORE = 0xB22b072503a381A2Db8309A8dD46789366D55074;
    address constant LAND_TOKEN = 0x919e6e2b36b6944F52605bC705Ff609AFcb7c797;
    address constant LAND_DEED = 0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf;

    // ParcelSale to authorize
    address constant PARCEL_SALE = 0xc5428954d2F75a6602fe10CDd4157B17f91A7598;

    function run() external {
        // Load environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address admin = vm.envAddress("ADMIN_ADDRESS");
        address treasury = vm.envAddress("ADMIN_ADDRESS"); // Use admin as treasury
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Upgrading HyperLandCore");
        console.log("========================================\n");
        console.log("Network: Base Mainnet");
        console.log("Deployer:", deployer);
        console.log("Old HyperLandCore:", OLD_HYPERLAND_CORE);
        console.log("LAND Token:", LAND_TOKEN);
        console.log("Land Deed:", LAND_DEED);
        console.log("ParcelSale to authorize:", PARCEL_SALE);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy new HyperLandCore
        HyperLandCore newCore = new HyperLandCore(
            LAND_TOKEN,
            LAND_DEED,
            admin,
            treasury
        );

        console.log("\n[SUCCESS] New HyperLandCore deployed!");
        console.log("Address:", address(newCore));

        // Authorize ParcelSale contract as minter
        newCore.authorizeMinter(PARCEL_SALE, true);
        console.log("\n[SUCCESS] ParcelSale authorized as minter");

        vm.stopBroadcast();

        console.log("\n========================================");
        console.log("Upgrade Summary");
        console.log("========================================");
        console.log("New HyperLandCore:", address(newCore));
        console.log("ParcelSale authorized:", PARCEL_SALE);
        console.log("\nMANUAL STEP REQUIRED:");
        console.log("Transfer LandDeed ownership from old to new HyperLandCore:");
        console.log("cast send", LAND_DEED);
        console.log("  'transferOwnership(address)'", address(newCore));
        console.log("  --rpc-url https://mainnet.base.org --private-key $OWNER_KEY");
        console.log("\nThen update frontend:");
        console.log("HYPERLAND_CORE_ADDRESS=", address(newCore));
    }
}
