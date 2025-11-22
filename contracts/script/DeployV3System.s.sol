// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/HyperLandCore.sol";
import "../src/PrimarySaleV3.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";

/**
 * @title DeployV3System
 * @dev Deploy LandDeed + HyperLandCore + PrimarySaleV3 with correct ownership chain
 *
 * OWNERSHIP STRUCTURE:
 * - Deployer owns HyperLandCore
 * - Deployer owns PrimarySaleV3
 * - PrimarySaleV3 is authorized minter on HyperLandCore
 * - HyperLandCore owns LandDeed (NEW deployment)
 */
contract DeployV3System is Script {
    // Existing deployed contracts (reuse)
    address constant LAND_TOKEN = 0x919e6e2b36b6944F52605bC705Ff609AFcb7c797;
    address constant BASESWAP_ROUTER = 0x327Df1E6de05895d2ab08513aaDD9313Fe505d86;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant POOL = 0x035877E50562f11daC3D158a3485eBEc89A4B707;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Deploying V3 System with Correct Ownership");
        console.log("========================================\n");
        console.log("Network: Base Mainnet");
        console.log("Deployer:", deployer);
        console.log("\nExisting Contracts (Reusing):");
        console.log("LAND Token:", LAND_TOKEN);
        console.log("Router:", BASESWAP_ROUTER);
        console.log("WETH:", WETH);
        console.log("Pool:", POOL);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy NEW LandDeed (deployer owns it temporarily)
        console.log("\n[1/5] Deploying NEW LandDeed...");
        LandDeed landDeed = new LandDeed(deployer);
        console.log("LandDeed deployed:", address(landDeed));

        // 2. Deploy NEW HyperLandCore (deployer owns it)
        console.log("\n[2/5] Deploying NEW HyperLandCore...");
        HyperLandCore hyperLandCore = new HyperLandCore(
            LAND_TOKEN,
            address(landDeed),
            deployer, // deployer is treasury
            deployer  // deployer is owner
        );
        console.log("HyperLandCore deployed:", address(hyperLandCore));

        // 3. Transfer LandDeed ownership to HyperLandCore
        console.log("\n[3/5] Transferring LandDeed ownership...");
        landDeed.transferOwnership(address(hyperLandCore));
        console.log("LandDeed ownership -> HyperLandCore");

        // 4. Deploy PrimarySaleV3 (deployer owns it)
        console.log("\n[4/5] Deploying PrimarySaleV3...");
        PrimarySaleV3 primarySale = new PrimarySaleV3(
            address(hyperLandCore),
            LAND_TOKEN,
            BASESWAP_ROUTER,
            WETH,
            deployer
        );
        console.log("PrimarySaleV3 deployed:", address(primarySale));

        // 5. Configure pool and authorize minter
        console.log("\n[5/5] Configuring system...");
        primarySale.setPool(POOL);
        console.log("Pool configured");

        hyperLandCore.authorizeMinter(address(primarySale), true);
        console.log("PrimarySaleV3 authorized as minter");

        vm.stopBroadcast();

        console.log("\n========================================");
        console.log("Deployment Summary");
        console.log("========================================");
        console.log("LandDeed:", address(landDeed));
        console.log("HyperLandCore:", address(hyperLandCore));
        console.log("PrimarySaleV3:", address(primarySale));
        console.log("\nOwnership Chain:");
        console.log("- Deployer owns HyperLandCore");
        console.log("- Deployer owns PrimarySaleV3");
        console.log("- HyperLandCore owns LandDeed");
        console.log("- PrimarySaleV3 is authorized minter");

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
        console.log("Next Steps");
        console.log("========================================");
        console.log("1. Add parcels to PrimarySaleV3:");
        console.log("   primarySale.addParcelsBatch(xs, ys, sizes, assessedValues)");
        console.log("\n2. Update frontend .env.local:");
        console.log("   NEXT_PUBLIC_LAND_DEED_ADDRESS=", address(landDeed));
        console.log("   NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=", address(hyperLandCore));
        console.log("   NEXT_PUBLIC_PARCEL_SALE_ADDRESS=", address(primarySale));
        console.log("\n3. Users can purchase parcels:");
        console.log("   primarySale.purchaseNextParcel{value: currentPrice}()");
        console.log("\n4. Test the flow end-to-end");
        console.log("========================================\n");
    }
}
