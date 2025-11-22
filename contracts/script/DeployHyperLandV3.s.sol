// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/HyperLandV3.sol";

contract DeployHyperLandV3 is Script {
    // Base Mainnet addresses
    address constant LAND_TOKEN = 0x919e6e2b36b6944F52605bC705Ff609AFcb7c797;
    address constant BASESWAP_ROUTER = 0x327Df1E6de05895d2ab08513aaDD9313Fe505d86;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant POOL = 0x035877E50562f11daC3D158a3485eBEc89A4B707;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Deploying HyperLand V3");
        console.log("========================================\n");
        console.log("Network: Base Mainnet");
        console.log("Deployer:", deployer);
        console.log("LAND Token:", LAND_TOKEN);
        console.log("Router:", BASESWAP_ROUTER);
        console.log("WETH:", WETH);
        console.log("Pool:", POOL);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy HyperLandV3
        HyperLandV3 hyperland = new HyperLandV3(
            LAND_TOKEN,
            BASESWAP_ROUTER,
            WETH,
            deployer
        );

        console.log("\n[SUCCESS] HyperLand V3 deployed!");
        console.log("Address:", address(hyperland));

        // Set pool
        hyperland.setPool(POOL);
        console.log("\n[SUCCESS] Pool configured!");

        vm.stopBroadcast();

        console.log("\n========================================");
        console.log("Bonding Curve Preview");
        console.log("========================================");

        console.log("Parcel 1:    ", hyperland.getPriceAt(0), "wei (~$0.50)");
        console.log("Parcel 10:   ", hyperland.getPriceAt(9), "wei");
        console.log("Parcel 25:   ", hyperland.getPriceAt(24), "wei (~$25)");
        console.log("Parcel 50:   ", hyperland.getPriceAt(49), "wei (~$100)");
        console.log("Parcel 100:  ", hyperland.getPriceAt(99), "wei (~$200)");
        console.log("Parcel 200:  ", hyperland.getPriceAt(199), "wei (~$400)");
        console.log("Parcel 500:  ", hyperland.getPriceAt(499), "wei (~$700)");
        console.log("Parcel 1000: ", hyperland.getPriceAt(999), "wei (~$1200)");

        console.log("\n========================================");
        console.log("V3 IMPROVEMENTS");
        console.log("========================================");
        console.log("✅ Single contract - no ownership issues");
        console.log("✅ Direct NFT minting - no external calls");
        console.log("✅ Exponential bonding curve - fast growth");
        console.log("✅ Proper router interface - no call() bugs");
        console.log("✅ Simplified architecture - easier to maintain");

        console.log("\n========================================");
        console.log("Next Steps");
        console.log("========================================");
        console.log("1. Add parcels: hyperland.addParcelsBatch(xs, ys, sizes)");
        console.log("2. Users purchase: hyperland.purchaseNextParcel{value: price}()");
        console.log("3. NFT auto-minted + liquidity auto-created + LP auto-burned");
        console.log("\nContract: ", address(hyperland));
        console.log("========================================\n");
    }
}
