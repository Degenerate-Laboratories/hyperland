#!/usr/bin/env npx tsx
/**
 * Transfer LAND tokens from main address to pool wallet
 *
 * From: 0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D (main address with all LAND)
 * To: 0x658DE0443259a1027caA976ef9a42E6982037A03 (WALLET_BACKUP for pool)
 * Amount: 10,000 LAND tokens
 */

import { parseEther, formatEther, createWalletClient, createPublicClient, http } from 'viem';
import { mnemonicToAccount, privateKeyToAccount } from 'viem/accounts';
import { base } from 'viem/chains';
import dotenv from 'dotenv';

dotenv.config();

const LAND_TOKEN = '0x919e6e2b36b6944F52605bC705Ff609AFcb7c797';
const MAIN_ADDRESS = '0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D'; // Has all LAND
const POOL_WALLET = '0x658DE0443259a1027caA976ef9a42E6982037A03'; // WALLET_BACKUP
const TRANSFER_AMOUNT = parseEther('10000'); // 10,000 LAND for pool

const ERC20_ABI = [
  {
    inputs: [
      { name: 'to', type: 'address' },
      { name: 'amount', type: 'uint256' },
    ],
    name: 'transfer',
    outputs: [{ name: '', type: 'bool' }],
    stateMutability: 'nonpayable',
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
  console.log('\n💸 LAND Transfer for Pool Setup');
  console.log('═══════════════════════════════════════════════════\n');

  // Create public client
  const publicClient = createPublicClient({
    chain: base,
    transport: http('https://mainnet.base.org'),
  });

  // Check balances before
  console.log('📊 Before Transfer:');
  const mainBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [MAIN_ADDRESS],
  });

  const poolBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [POOL_WALLET],
  });

  console.log(`Main Address: ${formatEther(mainBalance)} LAND`);
  console.log(`Pool Wallet:  ${formatEther(poolBalance)} LAND`);

  if (mainBalance < TRANSFER_AMOUNT) {
    throw new Error(`Insufficient LAND in main address. Need ${formatEther(TRANSFER_AMOUNT)}, have ${formatEther(mainBalance)}`);
  }

  console.log(`\n🔄 Transferring ${formatEther(TRANSFER_AMOUNT)} LAND...`);
  console.log(`From: ${MAIN_ADDRESS}`);
  console.log(`To:   ${POOL_WALLET}`);

  // You need to provide the private key for the main address
  console.log('\n⚠️  IMPORTANT: You need to sign this transaction from the main address.');
  console.log('Please add MAIN_PRIVATE_KEY to your .env file:');
  console.log('MAIN_PRIVATE_KEY=0x...');

  const mainPrivateKey = process.env.MAIN_PRIVATE_KEY as `0x${string}`;

  if (!mainPrivateKey) {
    throw new Error('MAIN_PRIVATE_KEY not found in .env. This is the private key for 0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D');
  }

  // Create wallet client for main address
  const mainAccount = privateKeyToAccount(mainPrivateKey);
  const mainWalletClient = createWalletClient({
    account: mainAccount,
    chain: base,
    transport: http('https://mainnet.base.org'),
  });

  // Verify account matches
  if (mainAccount.address.toLowerCase() !== MAIN_ADDRESS.toLowerCase()) {
    throw new Error(`Private key doesn't match main address. Expected ${MAIN_ADDRESS}, got ${mainAccount.address}`);
  }

  // Execute transfer
  const tx = await mainWalletClient.writeContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'transfer',
    args: [POOL_WALLET, TRANSFER_AMOUNT],
  });

  console.log(`\n📝 Transaction Hash: ${tx}`);
  console.log('⏳ Waiting for confirmation...');

  await publicClient.waitForTransactionReceipt({ hash: tx });

  // Check balances after
  console.log('\n✅ Transfer Complete!');
  console.log('═══════════════════════════════════════════════════');

  const newMainBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [MAIN_ADDRESS],
  });

  const newPoolBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: ERC20_ABI,
    functionName: 'balanceOf',
    args: [POOL_WALLET],
  });

  console.log('\n📊 After Transfer:');
  console.log(`Main Address: ${formatEther(newMainBalance)} LAND (-${formatEther(TRANSFER_AMOUNT)})`);
  console.log(`Pool Wallet:  ${formatEther(newPoolBalance)} LAND (+${formatEther(TRANSFER_AMOUNT)})`);

  console.log(`\n🔗 View on BaseScan:`);
  console.log(`https://basescan.org/tx/${tx}`);

  console.log('\n✅ Ready to deploy pool!');
  console.log('Run: npx tsx scripts/deploy-minimal-pool.ts');
}

main().catch(console.error);
