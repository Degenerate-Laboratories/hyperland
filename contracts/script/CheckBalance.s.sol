// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/LANDToken.sol";

/**
 * @title CheckBalance
 * @dev Script to check LAND token balances
 *
 * Usage:
 * forge script script/CheckBalance.s.sol:CheckBalance --rpc-url base
 *
 * Required environment variables:
 * - LAND_TOKEN_ADDRESS: Deployed LAND token address
 * - ADMIN_ADDRESS: Admin address to check
 */
contract CheckBalance is Script {
    function run() external view {
        // Get addresses from environment
        address tokenAddress = vm.envAddress("LAND_TOKEN_ADDRESS");
        address adminAddress = vm.envAddress("ADMIN_ADDRESS");

        console.log("Checking LAND Token balances...");
        console.log("Token address:", tokenAddress);
        console.log("Admin address:", adminAddress);
        console.log("");

        // Get token contract
        LANDToken land = LANDToken(tokenAddress);

        // Check token info
        console.log("Token Info:");
        console.log("- Name:", land.name());
        console.log("- Symbol:", land.symbol());
        console.log("- Decimals:", land.decimals());
        console.log("- Total Supply:", land.totalSupply() / 10**18, "LAND");
        console.log("");

        // Check admin balance
        uint256 adminBalance = land.balanceOf(adminAddress);
        console.log("Admin Balance:", adminBalance / 10**18, "LAND");
        console.log("Percentage of supply:", (adminBalance * 100) / land.totalSupply(), "%");
    }
}
