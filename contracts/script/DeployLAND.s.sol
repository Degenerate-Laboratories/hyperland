// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/LANDToken.sol";

/**
 * @title DeployLAND
 * @dev Script to deploy LAND token to Base mainnet
 *
 * Usage:
 * forge script script/DeployLAND.s.sol:DeployLAND --rpc-url base --broadcast --verify
 *
 * Required environment variables:
 * - PRIVATE_KEY: Deployer private key
 * - ADMIN_ADDRESS: Address to receive initial token supply
 * - BASESCAN_API_KEY: API key for contract verification
 */
contract DeployLAND is Script {
    function run() external {
        // Get admin address from environment
        address admin = vm.envAddress("ADMIN_ADDRESS");
        require(admin != address(0), "ADMIN_ADDRESS not set");

        // Get deployer private key
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        console.log("Deploying LAND Token to Base mainnet...");
        console.log("Admin address:", admin);
        console.log("Deployer:", vm.addr(deployerPrivateKey));

        vm.startBroadcast(deployerPrivateKey);

        // Deploy LAND token
        LANDToken land = new LANDToken(admin);

        vm.stopBroadcast();

        console.log("LAND Token deployed to:", address(land));
        console.log("Total supply (21M tokens):", land.totalSupply() / 10**18);
        console.log("Admin balance:", land.balanceOf(admin) / 10**18);

        // Save deployment info
        string memory deploymentInfo = string.concat(
            "LAND_TOKEN_ADDRESS=", vm.toString(address(land)), "\n",
            "ADMIN_ADDRESS=", vm.toString(admin), "\n",
            "TOTAL_SUPPLY=21000000\n",
            "DEPLOYMENT_BLOCK=", vm.toString(block.number), "\n"
        );

        vm.writeFile("deployments/base-mainnet.env", deploymentInfo);
        console.log("\nDeployment info saved to deployments/base-mainnet.env");
    }
}
