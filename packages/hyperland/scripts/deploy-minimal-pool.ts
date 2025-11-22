#!/usr/bin/env tsx
/**
 * Deploy Minimal Test Pool - $50 Budget
 *
 * Purpose: Create a small liquidity pool for initial testing
 * Budget: ~$50 (0.021 ETH)
 * Strategy: Minimal viable pool for $1-2 test trades
 */

import { parseEther, formatEther } from 'viem';
import dotenv from 'dotenv';
import { walletClient, publicClient } from '../src/clients/base-mainnet';

dotenv.config();

// BaseSwap (Uniswap V2 fork) on Base Mainnet
const ROUTER = '0x327Df1E6de05895d2ab08513aaDD9313Fe505d86'; // BaseSwap Router
const WETH = '0x4200000000000000000000000000000000000006'; // Base WETH

// Your deployed LAND token
const LAND_TOKEN = process.env.MAINNET_LAND_TOKEN as `0x${string}`;

// Pool Configuration for $20 budget ($25 wallet - $5 gas reserve)
const POOL_CONFIG = {
  // Split: $10 ETH + $10 worth of LAND
  ethAmount: parseEther('0.0042'), // ~$10 at $2,380/ETH
  landAmount: parseEther('10000'), // 10,000 LAND at $0.001 initial price

  // Pool settings
  slippage: 5000, // 50% slippage tolerance (high for minimal pool)
  deadline: Math.floor(Date.now() / 1000) + 1800, // 30 minutes
  stable: false, // Volatile pool (better for new tokens)
};

// Uniswap V2 Router ABI (minimal needed functions)
const ROUTER_ABI = [
  {
    inputs: [
      { name: 'token', type: 'address' },
      { name: 'amountTokenDesired', type: 'uint256' },
      { name: 'amountTokenMin', type: 'uint256' },
      { name: 'amountETHMin', type: 'uint256' },
      { name: 'to', type: 'address' },
      { name: 'deadline', type: 'uint256' },
    ],
    name: 'addLiquidityETH',
    outputs: [
      { name: 'amountToken', type: 'uint256' },
      { name: 'amountETH', type: 'uint256' },
      { name: 'liquidity', type: 'uint256' },
    ],
    stateMutability: 'payable',
    type: 'function',
  },
  {
    inputs: [],
    name: 'factory',
    outputs: [{ name: '', type: 'address' }],
    stateMutability: 'view',
    type: 'function',
  },
] as const;

// Uniswap V2 Factory ABI
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

// ERC20 ABI for approvals
const ERC20_ABI = [
  {
    inputs: [
      { name: 'spender', type: 'address' },
      { name: 'amount', type: 'uint256' },
    ],
    name: 'approve',
    outputs: [{ name: '', type: 'bool' }],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      { name: 'owner', type: 'address' },
      { name: 'spender', type: 'address' },
    ],
    name: 'allowance',
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

async function main() {
  console.log('\n🚀 Deploying Minimal Test Pool');
  console.log('================================\n');

  // Get wallet address
  const [account] = await walletClient.getAddresses();
  console.log(`📍 Wallet: ${account}`);

  // Check ETH balance
  const ethBalance = await publicClient.getBalance({ address: account });
  console.log(`💰 ETH Balance: ${formatEther(ethBalance)} ETH`);

  if (ethBalance < POOL_CONFIG.ethAmount) {
    throw new Error('Insufficient ETH balance for pool creation');
  }

  // Check LAND token balance
  const landBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [account],
  });
  console.log(`🪙 LAND Balance: ${formatEther(landBalance)} LAND`);

  if (landBalance < POOL_CONFIG.landAmount) {
    throw new Error('Insufficient LAND balance for pool creation');
  }

  console.log('\n📊 Pool Configuration');
  console.log('──────────────────────');
  console.log(`ETH Amount: ${formatEther(POOL_CONFIG.ethAmount)} ETH (~$10)`);
  console.log(`LAND Amount: ${formatEther(POOL_CONFIG.landAmount)} LAND`);
  console.log(`Initial Price: $${(10 / 10000).toFixed(6)} per LAND`);
  console.log(`Pool Type: ${POOL_CONFIG.stable ? 'Stable' : 'Volatile'}`);
  console.log(`Slippage: ${POOL_CONFIG.slippage / 100}%`);

  // Step 1: Check if pool exists
  console.log('\n🔍 Checking for existing pool...');
  const factoryAddress = await publicClient.readContract({
    address: ROUTER,
    abi: ROUTER_ABI,
    functionName: 'factory',
  });

  const poolAddress = await publicClient.readContract({
    address: factoryAddress,
    abi: FACTORY_ABI,
    functionName: 'getPair',
    args: [LAND_TOKEN, WETH],
  });
  console.log(`Factory: ${factoryAddress}`);
  console.log(`Pool Address: ${poolAddress}`);

  // Step 2: Approve LAND tokens
  console.log('\n✅ Approving LAND tokens...');
  const allowance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'allowance',
    args: [account, ROUTER],
  });

  if (allowance < POOL_CONFIG.landAmount) {
    const approveTx = await walletClient.writeContract({
      address: LAND_TOKEN,
      abi: ERC20_ABI,
      functionName: 'approve',
      args: [ROUTER, POOL_CONFIG.landAmount],
    });
    console.log(`Approval TX: ${approveTx}`);
    await publicClient.waitForTransactionReceipt({ hash: approveTx });
    console.log('✅ Approval confirmed');
  } else {
    console.log('✅ Already approved');
  }

  // Step 3: Add liquidity
  console.log('\n💦 Adding liquidity to pool...');

  const minLandAmount = (POOL_CONFIG.landAmount * BigInt(10000 - POOL_CONFIG.slippage)) / BigInt(10000);
  const minEthAmount = (POOL_CONFIG.ethAmount * BigInt(10000 - POOL_CONFIG.slippage)) / BigInt(10000);

  const addLiquidityTx = await walletClient.writeContract({
    address: ROUTER,
    abi: ROUTER_ABI,
    functionName: 'addLiquidityETH',
    args: [
      LAND_TOKEN,
      POOL_CONFIG.landAmount,
      minLandAmount,
      minEthAmount,
      account,
      BigInt(POOL_CONFIG.deadline),
    ],
    value: POOL_CONFIG.ethAmount,
  });

  console.log(`TX Hash: ${addLiquidityTx}`);
  console.log('⏳ Waiting for confirmation...');

  const receipt = await publicClient.waitForTransactionReceipt({
    hash: addLiquidityTx
  });

  console.log('\n✅ Pool Created Successfully!');
  console.log('============================\n');
  console.log(`Pool Address: ${poolAddress}`);
  console.log(`TX Hash: ${addLiquidityTx}`);
  console.log(`Block: ${receipt.blockNumber}`);
  console.log(`Gas Used: ${receipt.gasUsed}`);

  console.log('\n📝 Next Steps:');
  console.log('1. Update frontend with pool address');
  console.log('2. Test small trades ($1-2)');
  console.log('3. Monitor slippage and price impact');
  console.log('4. Add more liquidity if needed');

  console.log('\n🔗 View on BaseScan:');
  console.log(`https://basescan.org/tx/${addLiquidityTx}`);
  console.log(`https://basescan.org/address/${poolAddress}`);

  // Save deployment info
  const deploymentInfo = {
    timestamp: new Date().toISOString(),
    network: 'base-mainnet',
    poolAddress,
    router: ROUTER,
    landToken: LAND_TOKEN,
    weth: WETH,
    initialLiquidity: {
      eth: formatEther(POOL_CONFIG.ethAmount),
      land: formatEther(POOL_CONFIG.landAmount),
      initialPrice: 10 / 10000,
    },
    transaction: addLiquidityTx,
    block: receipt.blockNumber.toString(),
  };

  console.log('\n💾 Deployment Info:');
  console.log(JSON.stringify(deploymentInfo, null, 2));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('❌ Error:', error);
    process.exit(1);
  });
