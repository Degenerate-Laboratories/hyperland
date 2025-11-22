// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/ParcelSaleWithLiquidity.sol";
import "../src/HyperLandCore.sol";
import "../src/LANDToken.sol";

/**
 * @title DeployParcelSaleWithLiquidity
 * @dev Deploy the ParcelSale contract with automated liquidity creation
 */
contract DeployParcelSaleWithLiquidity is Script {
    // Base Mainnet addresses
    address constant BASESWAP_ROUTER = 0x327Df1E6de05895d2ab08513aaDD9313Fe505d86;
    address constant WETH = 0x4200000000000000000000000000000000000006;

    // Bonding curve parameters - targeting ~$1 per parcel
    uint256 constant START_PRICE = 0.0003 ether;      // First parcel: 0.0003 ETH (~$0.90)
    uint256 constant PRICE_INCREMENT = 0.00000003 ether;  // +0.00000003 ETH (30 gwei) per sale
    uint256 constant MAX_PRICE = 0.001 ether;          // Cap at 0.001 ETH (~$3)

    function run() external {
        // Load environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address hyperLandCore = vm.envAddress("HYPERLAND_CORE_ADDRESS");
        address landToken = vm.envAddress("LAND_TOKEN_ADDRESS");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("\n========================================");
        console.log("Deploying ParcelSaleWithLiquidity");
        console.log("========================================\n");
        console.log("Network: Base Mainnet");
        console.log("Deployer:", deployer);
        console.log("HyperLandCore:", hyperLandCore);
        console.log("LAND Token:", landToken);
        console.log("BaseSwap Router:", BASESWAP_ROUTER);
        console.log("WETH:", WETH);
        console.log("\nBonding Curve:");
        console.log("Start Price:", START_PRICE);
        console.log("Price Increment:", PRICE_INCREMENT);
        console.log("Max Price:", MAX_PRICE);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy ParcelSaleWithLiquidity
        ParcelSaleWithLiquidity parcelSale = new ParcelSaleWithLiquidity(
            hyperLandCore,
            landToken,
            BASESWAP_ROUTER,
            WETH,
            deployer, // Initial owner
            START_PRICE,
            PRICE_INCREMENT,
            MAX_PRICE
        );

        console.log("\n[SUCCESS] ParcelSaleWithLiquidity deployed!");
        console.log("Address:", address(parcelSale));

        // Get pool address from factory
        IUniswapV2Factory factory = IUniswapV2Factory(
            IUniswapV2RouterExtended(BASESWAP_ROUTER).factory()
        );
        address pool = factory.getPair(landToken, WETH);

        if (pool != address(0)) {
            // Set pool address
            parcelSale.setPool(pool);
            console.log("\n[SUCCESS] Pool address set!");
            console.log("Pool:", pool);
        } else {
            console.log("\n[WARNING] Pool not yet created");
            console.log("You must:");
            console.log("1. Create LAND/WETH pool first");
            console.log("2. Call setPool() on ParcelSale contract");
        }

        vm.stopBroadcast();

        console.log("\n========================================");
        console.log("Deployment Summary");
        console.log("========================================");
        console.log("ParcelSaleWithLiquidity:", address(parcelSale));
        console.log("Pool:", pool);
        console.log("\nBonding Curve Pricing:");
        console.log("Parcel 1: 0.001 ETH");
        console.log("Parcel 10: 0.0019 ETH");
        console.log("Parcel 50: 0.0059 ETH");
        console.log("Parcel 100+: 0.01 ETH (capped)");

        console.log("\nNOTE: ParcelSale contract must be set as owner of HyperLandCore");
        console.log("or HyperLandCore must be updated to allow ParcelSale to mint.");
        console.log("\nNext Steps:");
        console.log("1. Update HyperLandCore to allow ParcelSale to mint");
        console.log("2. Add parcels using addParcelsBatch() - no prices needed!");
        console.log("3. Users purchase parcels at bonding curve price");
        console.log("4. Contract auto-creates liquidity and burns LP");
        console.log("\nTo verify contract on BaseScan:");
        console.log("Use the ParcelSaleWithLiquidity address above");
    }
}

// Minimal interface for factory check
interface IUniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address);
}

interface IUniswapV2RouterExtended {
    function factory() external view returns (address);
}
