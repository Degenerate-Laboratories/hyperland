#!/usr/bin/env tsx
/**
 * Mint LAND tokens for pool creation
 */

import { parseEther, formatEther } from 'viem';
import dotenv from 'dotenv';
import { walletClient, publicClient } from '../src/clients/base-mainnet';

dotenv.config();

const LAND_TOKEN = process.env.MAINNET_LAND_TOKEN as `0x${string}`;
const MINT_AMOUNT = parseEther('10000'); // 10,000 LAND for pool

const LAND_ABI = [
  {
    inputs: [
      { name: 'to', type: 'address' },
      { name: 'amount', type: 'uint256' },
    ],
    name: 'mint',
    outputs: [],
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
  const [account] = await walletClient.getAddresses();
  console.log(`📍 Wallet: ${account}`);

  // Check current balance
  const balance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: LAND_ABI,
    functionName: 'balanceOf',
    args: [account],
  });

  console.log(`Current LAND Balance: ${formatEther(balance)} LAND`);

  if (balance >= MINT_AMOUNT) {
    console.log('✅ Already have enough LAND tokens!');
    return;
  }

  console.log(`\n🪙 Minting ${formatEther(MINT_AMOUNT)} LAND tokens...`);

  const tx = await walletClient.writeContract({
    address: LAND_TOKEN,
    abi: LAND_ABI,
    functionName: 'mint',
    args: [account, MINT_AMOUNT],
  });

  console.log(`TX Hash: ${tx}`);
  await publicClient.waitForTransactionReceipt({ hash: tx });

  const newBalance = await publicClient.readContract({
    address: LAND_TOKEN,
    abi: LAND_ABI,
    functionName: 'balanceOf',
    args: [account],
  });

  console.log(`\n✅ New LAND Balance: ${formatEther(newBalance)} LAND`);
}

main().catch(console.error);
