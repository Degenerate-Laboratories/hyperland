#!/usr/bin/env npx tsx
/**
 * Check wallet balance
 */

import { publicClient, walletClient } from '../src/clients/base-mainnet';
import { formatEther } from 'viem';

async function main() {
  const [account] = await walletClient.getAddresses();
  const balance = await publicClient.getBalance({ address: account });

  console.log('\n💰 Wallet Status');
  console.log('═══════════════════════════════════════════════════');
  console.log(`Address: ${account}`);
  console.log(`ETH Balance: ${formatEther(balance)} ETH`);
  console.log(`USD Value (@ $2,380/ETH): $${(parseFloat(formatEther(balance)) * 2380).toFixed(2)}`);
  console.log('═══════════════════════════════════════════════════\n');

  const minRequired = 0.025; // ~$60
  const current = parseFloat(formatEther(balance));

  if (current < minRequired) {
    console.log(`⚠️  Warning: Need at least ${minRequired} ETH (~$60) for pool + gas`);
    console.log(`   Current: ${current.toFixed(4)} ETH`);
    console.log(`   Short by: ${(minRequired - current).toFixed(4)} ETH (~$${((minRequired - current) * 2380).toFixed(2)})`);
  } else {
    console.log(`✅ Sufficient balance for pool deployment!`);
  }
}

main().catch(console.error);
