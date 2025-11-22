// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/PrimarySaleV3.sol";

contract DeployPrimarySaleV3 is Script {
    // Base Mainnet addresses (existing deployed contracts)
    address constant HYPERLAND_CORE = 0xB22b072503a381A2Db8309A8dD46789366D55074;
    address constant LAND_TOKEN = 0x919e6e2b36b6944F52605bC705Ff609AFcb7c797;
    address constant BASESWAP_ROUTER = 0x327Df1E6de05895d2ab08513aaDD9313Fe505d86;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant POOL = 0x035877E50562f11daC3D158a3485eBEc89A4B707;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Deploying PrimarySale V3");
        console.log("========================================\n");
        console.log("Network: Base Mainnet");
        console.log("Deployer:", deployer);
        console.log("\nExisting Contracts:");
        console.log("HyperLandCore:", HYPERLAND_CORE);
        console.log("LAND Token:", LAND_TOKEN);
        console.log("Router:", BASESWAP_ROUTER);
        console.log("WETH:", WETH);
        console.log("Pool:", POOL);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy PrimarySaleV3
        PrimarySaleV3 primarySale = new PrimarySaleV3(
            HYPERLAND_CORE,
            LAND_TOKEN,
            BASESWAP_ROUTER,
            WETH,
            deployer
        );

        console.log("\n[SUCCESS] PrimarySale V3 deployed!");
        console.log("Address:", address(primarySale));

        // Set pool
        primarySale.setPool(POOL);
        console.log("[SUCCESS] Pool configured!");

        vm.stopBroadcast();

        console.log("\n========================================");
        console.log("Bonding Curve Preview");
        console.log("========================================");
        console.log("Parcel 1:    ", primarySale.getPriceAt(0), "wei (~$0.50)");
        console.log("Parcel 10:   ", primarySale.getPriceAt(9), "wei");
        console.log("Parcel 25:   ", primarySale.getPriceAt(24), "wei");
        console.log("Parcel 50:   ", primarySale.getPriceAt(49), "wei (~$100)");
        console.log("Parcel 100:  ", primarySale.getPriceAt(99), "wei");
        console.log("Parcel 200:  ", primarySale.getPriceAt(199), "wei (~$400)");
        console.log("Parcel 500:  ", primarySale.getPriceAt(499), "wei");

        console.log("\n========================================");
        console.log("CRITICAL NEXT STEPS");
        console.log("========================================");
        console.log("1. Authorize PrimarySale as minter on HyperLandCore:");
        console.log("   cast send", HYPERLAND_CORE);
        console.log("   \"authorizeMinter(address,bool)\"", address(primarySale), "true");
        console.log("   --rpc-url https://mainnet.base.org");
        console.log("   --private-key $PRIVATE_KEY");
        console.log("");
        console.log("2. Add parcels to PrimarySale:");
        console.log("   primarySale.addParcelsBatch(xs, ys, sizes, assessedValues)");
        console.log("");
        console.log("3. Update frontend:");
        console.log("   NEXT_PUBLIC_PRIMARY_SALE_ADDRESS=", address(primarySale));
        console.log("");
        console.log("4. Users can purchase:");
        console.log("   primarySale.purchaseNextParcel{value: currentPrice}()");
        console.log("\n========================================");
        console.log("V3 IMPROVEMENTS");
        console.log("========================================");
        console.log("[OK] Exponential bonding curve ($0.50 -> $100 -> $400)");
        console.log("[OK] Proper router interface (no low-level calls)");
        console.log("[OK] Protocol-owned liquidity on primary sale only");
        console.log("[OK] Works with existing HyperLandCore/LandDeed");
        console.log("[OK] Secondary sales via marketplace (no liquidity)");
        console.log("========================================\n");
    }
}
