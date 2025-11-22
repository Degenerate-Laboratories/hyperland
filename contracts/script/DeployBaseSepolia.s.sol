// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";
import "../src/HyperLandCore.sol";

/**
 * @title DeployBaseSepolia
 * @dev Script to deploy the complete HyperLand system to Base Sepolia testnet
 *
 * Usage:
 * forge script script/DeployBaseSepolia.s.sol:DeployBaseSepolia --rpc-url base_sepolia --broadcast --verify
 *
 * Required environment variables:
 * - PRIVATE_KEY: Deployer private key
 * - ADMIN_ADDRESS: Address for contract admin
 * - TREASURY_ADDRESS: Address for treasury (receives fees)
 * - ETHERSCAN_API_KEY: API key for contract verification (optional)
 */
contract DeployBaseSepolia is Script {
    function run() external {
        // Get addresses from environment
        address admin = vm.envAddress("ADMIN_ADDRESS");
        address treasury = vm.envAddress("TREASURY_ADDRESS");
        require(admin != address(0), "ADMIN_ADDRESS not set");
        require(treasury != address(0), "TREASURY_ADDRESS not set");

        // Get deployer private key
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("===========================================");
        console.log("Deploying HyperLand to Base Sepolia...");
        console.log("===========================================");
        console.log("Deployer:", deployer);
        console.log("Admin:", admin);
        console.log("Treasury:", treasury);
        console.log("-------------------------------------------");

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy LAND Token
        console.log("\n1. Deploying LAND Token...");
        LANDToken land = new LANDToken(admin);
        console.log("   LAND Token deployed to:", address(land));
        console.log("   Total supply:", land.totalSupply() / 10**18, "LAND");
        console.log("   Admin balance:", land.balanceOf(admin) / 10**18, "LAND");

        // 2. Deploy LandDeed NFT
        console.log("\n2. Deploying LandDeed NFT...");
        LandDeed deed = new LandDeed(admin);
        console.log("   LandDeed deployed to:", address(deed));

        // 3. Deploy HyperLandCore
        console.log("\n3. Deploying HyperLandCore...");
        HyperLandCore core = new HyperLandCore(
            address(land),
            address(deed),
            treasury,
            admin
        );
        console.log("   HyperLandCore deployed to:", address(core));

        vm.stopBroadcast();

        console.log("\n===========================================");
        console.log("Deployment Complete!");
        console.log("===========================================");
        console.log("\nNext Steps:");
        console.log("1. Transfer LandDeed ownership to HyperLandCore:");
        console.log("   As admin, call: deed.transferOwnership(", vm.toString(address(core)), ")");
        console.log("\n2. Verify contracts on BaseScan:");
        console.log("   forge verify-contract", vm.toString(address(land)), "src/LANDToken.sol:LANDToken --chain base-sepolia");
        console.log("   forge verify-contract", vm.toString(address(deed)), "src/LandDeed.sol:LandDeed --chain base-sepolia");
        console.log("   forge verify-contract", vm.toString(address(core)), "src/HyperLandCore.sol:HyperLandCore --chain base-sepolia");

        // Save deployment info
        string memory deploymentInfo = string.concat(
            "# HyperLand Base Sepolia Deployment\n\n",
            "LAND_TOKEN_ADDRESS=", vm.toString(address(land)), "\n",
            "LAND_DEED_ADDRESS=", vm.toString(address(deed)), "\n",
            "HYPERLAND_CORE_ADDRESS=", vm.toString(address(core)), "\n",
            "ADMIN_ADDRESS=", vm.toString(admin), "\n",
            "TREASURY_ADDRESS=", vm.toString(treasury), "\n",
            "DEPLOYER_ADDRESS=", vm.toString(deployer), "\n",
            "DEPLOYMENT_BLOCK=", vm.toString(block.number), "\n",
            "DEPLOYMENT_TIMESTAMP=", vm.toString(block.timestamp), "\n",
            "\n# Configuration\n",
            "PROTOCOL_FEE_BP=2000 # 20%\n",
            "TAX_RATE_BP=500 # 5%\n",
            "TAX_CYCLE_SECONDS=604800 # 7 days\n",
            "LIEN_GRACE_CYCLES=3\n",
            "AUCTION_DURATION=604800 # 7 days\n"
        );

        string memory envPath = "deployments/base-sepolia.env";
        vm.writeFile(envPath, deploymentInfo);
        console.log("\n4. Deployment info saved to:", envPath);
    }
}
