#!/usr/bin/env tsx
/**
 * Test Liquidity Strategy
 *
 * Tests the complete flow:
 * 1. Sell parcel for ETH
 * 2. Market buy LAND with 50% of ETH
 * 3. Add liquidity with remaining 50% ETH + LAND
 * 4. Burn LP tokens to create protocol-owned liquidity
 */

import { parseEther, formatEther } from 'viem';
import dotenv from 'dotenv';
import { walletClient, publicClient } from '../packages/hyperland/src/clients/base-mainnet';

dotenv.config();

// Contract addresses
const PARCEL_SALE = process.env.MAINNET_PARCEL_SALE_LIQUIDITY as `0x${string}`;
const LAND_TOKEN = process.env.MAINNET_LAND_TOKEN as `0x${string}`;
const BASESWAP_ROUTER = '0x327Df1E6de05895d2ab08513aaDD9313Fe505d86' as const;
const WETH = '0x4200000000000000000000000000000000000006' as const;

// ABIs
const PARCEL_SALE_ABI = [
  {
    inputs: [{ name: 'parcelNumber', type: 'uint256' }],
    name: 'purchaseParcel',
    outputs: [],
    stateMutability: 'payable',
    type: 'function',
  },
  {
    inputs: [{ name: 'parcelNumber', type: 'uint256' }],
    name: 'getParcel',
    outputs: [
      { name: 'x', type: 'uint256' },
      { name: 'y', type: 'uint256' },
      { name: 'size', type: 'uint256' },
      { name: 'priceETH', type: 'uint256' },
      { name: 'sold', type: 'bool' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'getStats',
    outputs: [
      { name: '_totalParcels', type: 'uint256' },
      { name: '_soldCount', type: 'uint256' },
      { name: '_availableCount', type: 'uint256' },
      { name: '_totalETHCollected', type: 'uint256' },
      { name: '_totalLiquidityCreated', type: 'uint256' },
      { name: '_totalLPBurned', type: 'uint256' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
] as const;

const FACTORY_ABI = [
  {
    inputs: [
      { name: 'tokenA', type: 'address' },
      { name: 'tokenB', type: 'address' },
    ],
    name: 'getPair',
    outputs: [{ name: 'pair', type: 'address' }],
    stateMutability: 'view',
    type: 'function',
  },
] as const;

const PAIR_ABI = [
  {
    inputs: [],
    name: 'getReserves',
    outputs: [
      { name: 'reserve0', type: 'uint112' },
      { name: 'reserve1', type: 'uint112' },
      { name: 'blockTimestampLast', type: 'uint32' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'token0',
    outputs: [{ name: '', type: 'address' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'totalSupply',
    outputs: [{ name: '', type: 'uint256' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [{ name: 'account', type: 'address' }],
    name: 'balanceOf',
    outputs: [{ name: '', type: 'uint256' }],
    stateMutability: 'view',
    type: 'function',
  },
] as const;

const ROUTER_ABI = [
  {
    inputs: [],
    name: 'factory',
    outputs: [{ name: '', type: 'address' }],
    stateMutability: 'view',
    type: 'function',
  },
] as const;

async function main() {
  console.log('\n🧪 Testing Liquidity Strategy');
  console.log('==============================\n');

  const [account] = await walletClient.getAddresses();
  console.log(`📍 Wallet: ${account}`);

  // Get factory and pool
  const factoryAddress = await publicClient.readContract({
    address: BASESWAP_ROUTER,
    abi: ROUTER_ABI,
    functionName: 'factory',
  });

  const poolAddress = await publicClient.readContract({
    address: factoryAddress,
    abi: FACTORY_ABI,
    functionName: 'getPair',
    args: [LAND_TOKEN, WETH],
  });

  console.log(`🏭 Factory: ${factoryAddress}`);
  console.log(`💧 Pool: ${poolAddress}\n`);

  // Get current stats
  console.log('📊 Current Stats:');
  console.log('─────────────────');
  const stats = await publicClient.readContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getStats',
  });

  console.log(`Total Parcels: ${stats[0]}`);
  console.log(`Sold: ${stats[1]}`);
  console.log(`Available: ${stats[2]}`);
  console.log(`Total ETH Collected: ${formatEther(stats[3])} ETH`);
  console.log(`Total Liquidity Created: ${stats[4]} LP tokens`);
  console.log(`Total LP Burned: ${stats[5]} LP tokens\n`);

  // Get pool reserves BEFORE purchase
  console.log('💦 Pool Reserves (BEFORE):');
  console.log('─────────────────────────');
  const token0Before = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'token0',
  });

  const reservesBefore = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'getReserves',
  });

  const totalSupplyBefore = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'totalSupply',
  });

  const burnAddressBalance = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'balanceOf',
    args: ['0x000000000000000000000000000000000000dEaD'],
  });

  const isToken0LAND = token0Before.toLowerCase() === LAND_TOKEN.toLowerCase();
  const landReserveBefore = isToken0LAND ? reservesBefore[0] : reservesBefore[1];
  const wethReserveBefore = isToken0LAND ? reservesBefore[1] : reservesBefore[0];

  console.log(`LAND Reserve: ${formatEther(landReserveBefore)} LAND`);
  console.log(`WETH Reserve: ${formatEther(wethReserveBefore)} WETH`);
  console.log(`Total LP Supply: ${formatEther(totalSupplyBefore)} LP`);
  console.log(`LP Burned (Dead Address): ${formatEther(burnAddressBalance)} LP\n`);

  // Select a test parcel (parcel #1)
  const testParcelNumber = 1;
  const parcel = await publicClient.readContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getParcel',
    args: [BigInt(testParcelNumber)],
  });

  console.log('🏗️  Test Parcel:');
  console.log('──────────────');
  console.log(`Parcel #${testParcelNumber}`);
  console.log(`Coordinates: (${parcel[0]}, ${parcel[1]})`);
  console.log(`Size: ${parcel[2]}`);
  console.log(`Price: ${formatEther(parcel[3])} ETH`);
  console.log(`Sold: ${parcel[4]}\n`);

  if (parcel[4]) {
    console.log('⚠️  Parcel already sold, choose another one');
    return;
  }

  // Purchase parcel
  console.log('💳 Purchasing parcel...');
  console.log('───────────────────────');
  console.log(`Sending ${formatEther(parcel[3])} ETH...`);

  const purchaseTx = await walletClient.writeContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'purchaseParcel',
    args: [BigInt(testParcelNumber)],
    value: parcel[3],
  });

  console.log(`TX Hash: ${purchaseTx}`);
  console.log('⏳ Waiting for confirmation...\n');

  const receipt = await publicClient.waitForTransactionReceipt({
    hash: purchaseTx,
  });

  console.log('✅ Purchase Confirmed!');
  console.log(`Block: ${receipt.blockNumber}`);
  console.log(`Gas Used: ${receipt.gasUsed}\n`);

  // Get pool reserves AFTER purchase
  console.log('💦 Pool Reserves (AFTER):');
  console.log('────────────────────────');
  const reservesAfter = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'getReserves',
  });

  const totalSupplyAfter = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'totalSupply',
  });

  const burnAddressBalanceAfter = await publicClient.readContract({
    address: poolAddress,
    abi: PAIR_ABI,
    functionName: 'balanceOf',
    args: ['0x000000000000000000000000000000000000dEaD'],
  });

  const landReserveAfter = isToken0LAND ? reservesAfter[0] : reservesAfter[1];
  const wethReserveAfter = isToken0LAND ? reservesAfter[1] : reservesAfter[0];

  console.log(`LAND Reserve: ${formatEther(landReserveAfter)} LAND`);
  console.log(`WETH Reserve: ${formatEther(wethReserveAfter)} WETH`);
  console.log(`Total LP Supply: ${formatEther(totalSupplyAfter)} LP`);
  console.log(`LP Burned (Dead Address): ${formatEther(burnAddressBalanceAfter)} LP\n`);

  // Calculate changes
  console.log('📈 Changes:');
  console.log('───────────');
  const landAdded = landReserveAfter - landReserveBefore;
  const wethAdded = wethReserveAfter - wethReserveBefore;
  const lpBurned = burnAddressBalanceAfter - burnAddressBalance;

  console.log(`LAND Added: ${formatEther(landAdded)} LAND`);
  console.log(`WETH Added: ${formatEther(wethAdded)} WETH`);
  console.log(`LP Burned: ${formatEther(lpBurned)} LP\n`);

  // Verify strategy execution
  console.log('✓ Strategy Verification:');
  console.log('────────────────────────');
  const expectedWethAdded = parcel[3] / BigInt(2);
  const wethMatch = wethAdded >= (expectedWethAdded * BigInt(90)) / BigInt(100); // Allow 10% slippage

  console.log(`Expected ~${formatEther(expectedWethAdded)} WETH added: ${wethMatch ? '✅' : '❌'}`);
  console.log(`LAND bought and added: ${landAdded > 0 ? '✅' : '❌'}`);
  console.log(`LP tokens burned: ${lpBurned > 0 ? '✅' : '❌'}\n`);

  // Get final stats
  const finalStats = await publicClient.readContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getStats',
  });

  console.log('📊 Final Stats:');
  console.log('───────────────');
  console.log(`Total Parcels: ${finalStats[0]}`);
  console.log(`Sold: ${finalStats[1]}`);
  console.log(`Available: ${finalStats[2]}`);
  console.log(`Total ETH Collected: ${formatEther(finalStats[3])} ETH`);
  console.log(`Total Liquidity Created: ${formatEther(finalStats[4])} LP tokens`);
  console.log(`Total LP Burned: ${formatEther(finalStats[5])} LP tokens\n`);

  console.log('🔗 View Transaction:');
  console.log(`https://basescan.org/tx/${purchaseTx}\n`);

  console.log('✅ Test Complete!');
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('❌ Error:', error);
    process.exit(1);
  });
