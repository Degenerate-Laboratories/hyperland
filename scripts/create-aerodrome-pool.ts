/**
 * Create Aerodrome Liquidity Pool for LAND/WETH
 *
 * This script creates the initial liquidity pool on Aerodrome Finance (Base)
 *
 * Usage:
 *   npx tsx scripts/create-aerodrome-pool.ts --amount 1000000 --eth 20
 *
 * Parameters:
 *   --amount: Amount of LAND tokens to add (default: 1,000,000)
 *   --eth: Amount of ETH to add (default: 20)
 *   --slippage: Slippage tolerance in percent (default: 5)
 */

import { ethers } from 'ethers';
import * as dotenv from 'dotenv';

dotenv.config({ path: '../contracts/.env' });

// Contract addresses on Base Mainnet
const LAND_TOKEN = '0x919e6e2b36b6944F52605bC705Ff609AFcb7c797';
const AERODROME_ROUTER = '0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43';
const AERODROME_FACTORY = '0x420DD381b31aEf6683db6B902084cB0FFECe40Da';
const WETH = '0x4200000000000000000000000000000000000006';

// ABIs
const ROUTER_ABI = [
  'function addLiquidityETH(address token, bool stable, uint256 amountTokenDesired, uint256 amountTokenMin, uint256 amountETHMin, address to, uint256 deadline) external payable returns (uint256 amountToken, uint256 amountETH, uint256 liquidity)',
];

const FACTORY_ABI = [
  'function getPair(address tokenA, address tokenB, bool stable) external view returns (address pair)',
];

const ERC20_ABI = [
  'function approve(address spender, uint256 amount) external returns (bool)',
  'function balanceOf(address account) external view returns (uint256)',
];

async function main() {
  // Parse arguments
  const args = process.argv.slice(2);
  const landAmount = getArg(args, '--amount', '1000000');
  const ethAmount = getArg(args, '--eth', '20');
  const slippage = parseFloat(getArg(args, '--slippage', '5'));

  console.log('\n🚀 Creating Aerodrome Liquidity Pool for LAND/WETH');
  console.log('================================================\n');

  // Setup provider and signer
  const provider = new ethers.JsonRpcProvider('https://mainnet.base.org');
  const privateKey = process.env.PRIVATE_KEY;

  if (!privateKey) {
    throw new Error('PRIVATE_KEY not found in environment');
  }

  const wallet = new ethers.Wallet(privateKey, provider);
  console.log(`📍 Deployer: ${wallet.address}`);

  // Convert amounts to wei
  const landAmountWei = ethers.parseEther(landAmount);
  const ethAmountWei = ethers.parseEther(ethAmount);

  console.log(`\n💰 Liquidity Details:`);
  console.log(`   LAND: ${landAmount} tokens`);
  console.log(`   ETH:  ${ethAmount} ETH`);
  console.log(`   Slippage: ${slippage}%`);

  // Calculate minimum amounts (with slippage)
  const slippageMultiplier = (100 - slippage) / 100;
  const landAmountMin = ethers.parseEther((parseFloat(landAmount) * slippageMultiplier).toString());
  const ethAmountMin = ethers.parseEther((parseFloat(ethAmount) * slippageMultiplier).toString());

  // Check if pool already exists
  const factory = new ethers.Contract(AERODROME_FACTORY, FACTORY_ABI, provider);
  const existingPair = await factory.getPair(LAND_TOKEN, WETH, false); // false = volatile pool

  if (existingPair !== ethers.ZeroAddress) {
    console.log(`\n⚠️  Pool already exists at: ${existingPair}`);
    console.log('   Use this address in your frontend .env.local:');
    console.log(`   NEXT_PUBLIC_LP_POOL_ADDRESS=${existingPair}\n`);
    return;
  }

  // Check balances
  const landToken = new ethers.Contract(LAND_TOKEN, ERC20_ABI, wallet);
  const landBalance = await landToken.balanceOf(wallet.address);
  const ethBalance = await provider.getBalance(wallet.address);

  console.log(`\n📊 Current Balances:`);
  console.log(`   LAND: ${ethers.formatEther(landBalance)}`);
  console.log(`   ETH:  ${ethers.formatEther(ethBalance)}`);

  if (landBalance < landAmountWei) {
    throw new Error(`Insufficient LAND balance. Need ${landAmount}, have ${ethers.formatEther(landBalance)}`);
  }

  if (ethBalance < ethAmountWei) {
    throw new Error(`Insufficient ETH balance. Need ${ethAmount}, have ${ethers.formatEther(ethBalance)}`);
  }

  // Step 1: Approve LAND tokens
  console.log(`\n✅ Step 1/2: Approving LAND tokens...`);
  const approveTx = await landToken.approve(AERODROME_ROUTER, landAmountWei);
  console.log(`   Transaction: ${approveTx.hash}`);
  await approveTx.wait();
  console.log(`   ✓ Approved`);

  // Step 2: Add liquidity
  console.log(`\n✅ Step 2/2: Adding liquidity...`);
  const router = new ethers.Contract(AERODROME_ROUTER, ROUTER_ABI, wallet);

  const deadline = Math.floor(Date.now() / 1000) + 1800; // 30 minutes from now

  const tx = await router.addLiquidityETH(
    LAND_TOKEN,         // token
    false,              // stable (false = volatile pool)
    landAmountWei,      // amountTokenDesired
    landAmountMin,      // amountTokenMin
    ethAmountMin,       // amountETHMin
    wallet.address,     // to
    deadline,           // deadline
    { value: ethAmountWei }
  );

  console.log(`   Transaction: ${tx.hash}`);
  const receipt = await tx.wait();
  console.log(`   ✓ Liquidity added!`);

  // Get the newly created pair address
  const pairAddress = await factory.getPair(LAND_TOKEN, WETH, false);

  console.log(`\n🎉 SUCCESS! Pool Created`);
  console.log(`==========================`);
  console.log(`\nPool Address: ${pairAddress}`);
  console.log(`Transaction: https://basescan.org/tx/${tx.hash}`);
  console.log(`\n📝 Update your frontend .env.local:`);
  console.log(`NEXT_PUBLIC_LP_POOL_ADDRESS=${pairAddress}\n`);

  // Calculate initial price
  const landPriceETH = parseFloat(ethAmount) / parseFloat(landAmount);
  const ethPriceUSD = 2380; // Approximate
  const landPriceUSD = landPriceETH * ethPriceUSD;
  const marketCap = landPriceUSD * 21_000_000;

  console.log(`📊 Initial Market Stats:`);
  console.log(`   LAND Price: $${landPriceUSD.toFixed(4)}`);
  console.log(`   Market Cap: $${(marketCap / 1_000_000).toFixed(2)}M`);
  console.log(`   Liquidity:  $${((parseFloat(landAmount) * landPriceUSD + parseFloat(ethAmount) * ethPriceUSD) / 1000).toFixed(1)}K`);

  console.log(`\n✨ Pool is live and ready for trading!`);
}

function getArg(args: string[], flag: string, defaultValue: string): string {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : defaultValue;
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('\n❌ Error:', error.message);
    process.exit(1);
  });
