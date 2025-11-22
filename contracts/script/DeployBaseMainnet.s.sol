// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";
import "../src/HyperLandCore.sol";

/**
 * @title DeployBaseMainnet
 * @dev Script to deploy the complete HyperLand V2 system to Base Mainnet
 *
 * Usage:
 * forge script script/DeployBaseMainnet.s.sol:DeployBaseMainnet --rpc-url base --broadcast --verify
 *
 * Required environment variables:
 * - PRIVATE_KEY: Deployer private key (EOA with ≥0.015 ETH)
 * - ADMIN_ADDRESS: Address for contract admin (Gnosis Safe recommended)
 * - TREASURY_ADDRESS: Address for treasury (receives protocol fees)
 * - BASESCAN_API_KEY: API key for contract verification
 *
 * IMPORTANT:
 * - This deploys with 15-minute cycles (for testing)
 * - MUST call setTaxCycleDuration(604800) to set 7-day cycles after deployment
 * - MUST transfer LandDeed ownership to HyperLandCore after deployment
 */
contract DeployBaseMainnet is Script {
    function run() external {
        // Get addresses from environment
        address admin = vm.envAddress("ADMIN_ADDRESS");
        address treasury = vm.envAddress("TREASURY_ADDRESS");
        require(admin != address(0), "ADMIN_ADDRESS not set");
        require(treasury != address(0), "TREASURY_ADDRESS not set");

        // Get deployer private key
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        // Check deployer balance
        uint256 balance = deployer.balance;
        require(balance >= 0.008 ether, "Insufficient ETH for deployment (need ~0.01 ETH)");

        console.log("===========================================");
        console.log("DEPLOYING HYPERLAND V2 TO BASE MAINNET");
        console.log("===========================================");
        console.log("Network: Base Mainnet (Chain ID: 8453)");
        console.log("Deployer:", deployer);
        console.log("Deployer Balance:", balance / 1e18, "ETH");
        console.log("Admin:", admin);
        console.log("Treasury:", treasury);
        console.log("-------------------------------------------");
        console.log("MAINNET DEPLOYMENT - VERIFY ALL ADDRESSES");
        console.log("-------------------------------------------");

        // Confirm addresses
        console.log("\nPlease verify:");
        console.log("1. Admin is a Gnosis Safe multi-sig? (Recommended)");
        console.log("2. Treasury address is correct and can receive ERC20?");
        console.log("3. You have >= 0.01 ETH for deployment?");
        console.log("\nPress Ctrl+C to cancel, or wait 10 seconds to continue...");

        // Safety delay (comment out for automated deployments)
        // vm.sleep(10000);

        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy LAND Token (21M supply to admin)
        console.log("\n[1/3] Deploying LAND Token...");
        LANDToken land = new LANDToken(admin);
        console.log("   LAND Token deployed to:", address(land));
        console.log("   Total supply:", land.totalSupply() / 10**18, "LAND");
        console.log("   Admin balance:", land.balanceOf(admin) / 10**18, "LAND");

        // 2. Deploy LandDeed NFT
        console.log("\n[2/3] Deploying LandDeed NFT...");
        LandDeed deed = new LandDeed(admin);
        console.log("   LandDeed deployed to:", address(deed));
        console.log("   Owner:", deed.owner());

        // 3. Deploy HyperLandCore
        console.log("\n[3/3] Deploying HyperLandCore...");
        HyperLandCore core = new HyperLandCore(
            address(land),
            address(deed),
            treasury,
            admin
        );
        console.log("   HyperLandCore deployed to:", address(core));
        console.log("   Owner:", core.owner());
        console.log("   Protocol Fee:", core.protocolFeeBP() / 100, "%");
        console.log("   Tax Rate:", core.taxRateBP() / 100, "%");
        console.log("   Tax Cycle:", core.taxCycleSeconds() / 60, "minutes (NEEDS UPDATE)");

        vm.stopBroadcast();

        console.log("\n===========================================");
        console.log("DEPLOYMENT COMPLETE!");
        console.log("===========================================");

        console.log("\nCONTRACT ADDRESSES:");
        console.log("   LAND Token:     ", address(land));
        console.log("   LandDeed:       ", address(deed));
        console.log("   HyperLandCore:  ", address(core));

        console.log("\nCRITICAL POST-DEPLOYMENT STEPS:");
        console.log("\n[1/4] Transfer LandDeed ownership to HyperLandCore:");
        console.log("   As admin, call:");
        console.log("   cast send", vm.toString(address(deed)));
        console.log("     'transferOwnership(address)'", vm.toString(address(core)));
        console.log("     --rpc-url https://mainnet.base.org --private-key $ADMIN_KEY");

        console.log("\n[2/4] Set production timing parameters:");
        console.log("   cast send", vm.toString(address(core)));
        console.log("     'setTaxCycleDuration(uint256)' 604800"); // 7 days
        console.log("     --rpc-url https://mainnet.base.org --private-key $ADMIN_KEY");
        console.log("   cast send", vm.toString(address(core)));
        console.log("     'setAuctionDuration(uint256)' 259200"); // 3 days
        console.log("     --rpc-url https://mainnet.base.org --private-key $ADMIN_KEY");

        console.log("\n[3/4] Verify contracts on BaseScan:");
        console.log("   forge verify-contract", vm.toString(address(land)));
        console.log("     src/LANDToken.sol:LANDToken");
        console.log("     --chain base --constructor-args $(cast abi-encode 'constructor(address)' ", vm.toString(admin), ")");
        console.log("\n   forge verify-contract", vm.toString(address(deed)));
        console.log("     src/LandDeed.sol:LandDeed");
        console.log("     --chain base --constructor-args $(cast abi-encode 'constructor(address)' ", vm.toString(admin), ")");
        console.log("\n   forge verify-contract", vm.toString(address(core)));
        console.log("     src/HyperLandCore.sol:HyperLandCore --chain base");
        console.log("     (Use BaseScan GUI for constructor args)");

        // Save deployment info
        string memory deploymentInfo = string.concat(
            "# ========================================\n",
            "# HyperLand V2 - Base Mainnet Deployment\n",
            "# ========================================\n",
            "# Deployed:", vm.toString(block.timestamp), "\n",
            "# Block:", vm.toString(block.number), "\n\n",
            "# Contract Addresses\n",
            "LAND_TOKEN_ADDRESS=", vm.toString(address(land)), "\n",
            "LAND_DEED_ADDRESS=", vm.toString(address(deed)), "\n",
            "HYPERLAND_CORE_ADDRESS=", vm.toString(address(core)), "\n\n",
            "# Admin & Treasury\n",
            "ADMIN_ADDRESS=", vm.toString(admin), "\n",
            "TREASURY_ADDRESS=", vm.toString(treasury), "\n",
            "DEPLOYER_ADDRESS=", vm.toString(deployer), "\n\n",
            "# Network\n",
            "CHAIN_ID=8453\n",
            "RPC_URL=https://mainnet.base.org\n\n",
            "# Current Configuration\n",
            "PROTOCOL_FEE_BP=2000 # 20%\n",
            "TAX_RATE_BP=500 # 5%\n",
            "TAX_CYCLE_SECONDS=900 # 15 minutes (UPDATE TO 604800 = 7 days)\n",
            "LIEN_GRACE_CYCLES=3\n",
            "AUCTION_DURATION=900 # 15 minutes (UPDATE TO 259200 = 3 days)\n\n",
            "# BaseScan Links\n",
            "LAND_TOKEN_BASESCAN=https://basescan.org/address/", vm.toString(address(land)), "\n",
            "LAND_DEED_BASESCAN=https://basescan.org/address/", vm.toString(address(deed)), "\n",
            "HYPERLAND_CORE_BASESCAN=https://basescan.org/address/", vm.toString(address(core)), "\n"
        );

        string memory envPath = "deployments/base-mainnet.env";
        vm.writeFile(envPath, deploymentInfo);
        console.log("\n[4/4] Deployment info saved to:", envPath);

        console.log("\n===========================================");
        console.log("WELCOME TO HYPERLAND ON BASE MAINNET!");
        console.log("===========================================\n");
    }
}
