/**
 * Example 2: Buy LAND Tokens
 *
 * This example shows how to:
 * - Buy LAND tokens with ETH
 * - Check token balances
 * - Calculate expected amounts
 * - Listen for events
 */

import { createHyperLandClient, parseEther, formatEther, calculateLandFromEth, calculateBuyerAmount } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Buy LAND Tokens ===\n');

  // Setup
  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');
  const signer = await provider.getSigner(0);
  const address = await signer.getAddress();

  const client = createHyperLandClient({
    network: 'anvil',
    provider,
    signer,
  });

  console.log('Connected as:', address);
  console.log();

  // 1. Check initial balances
  console.log('1. Initial balances:');
  const initialEthBalance = await provider.getBalance(address);
  const initialLandBalance = await client.land.balanceOf(address);
  console.log('  ETH:', formatEther(initialEthBalance));
  console.log('  LAND:', formatEther(initialLandBalance));
  console.log();

  // 2. Calculate expected LAND amount
  const ethAmount = parseEther('1.0'); // 1 ETH
  console.log('2. Buying LAND with', formatEther(ethAmount), 'ETH');

  const totalLand = calculateLandFromEth(ethAmount);
  const buyerAmount = calculateBuyerAmount(totalLand);

  console.log('  Expected total LAND minted:', formatEther(totalLand));
  console.log('  Expected buyer amount (80%):', formatEther(buyerAmount));
  console.log('  Expected treasury amount (20%):', formatEther(totalLand - buyerAmount));
  console.log();

  // 3. Buy LAND tokens
  console.log('3. Executing buyLAND transaction...');
  const receipt = await client.core.buyLAND(ethAmount);
  console.log('  Transaction hash:', receipt.hash);
  console.log('  Gas used:', receipt.gasUsed.toString());
  console.log('  Block number:', receipt.blockNumber);
  console.log();

  // 4. Check final balances
  console.log('4. Final balances:');
  const finalEthBalance = await provider.getBalance(address);
  const finalLandBalance = await client.land.balanceOf(address);
  console.log('  ETH:', formatEther(finalEthBalance));
  console.log('  LAND:', formatEther(finalLandBalance));
  console.log();

  // 5. Calculate changes
  console.log('5. Changes:');
  const ethSpent = initialEthBalance - finalEthBalance;
  const landReceived = finalLandBalance - initialLandBalance;
  console.log('  ETH spent:', formatEther(ethSpent));
  console.log('  LAND received:', formatEther(landReceived));
  console.log();

  // 6. Verify treasury received tokens
  console.log('6. Treasury balance:');
  const treasury = await client.core.treasury();
  const treasuryBalance = await client.land.balanceOf(treasury);
  console.log('  Treasury address:', treasury);
  console.log('  Treasury LAND balance:', formatEther(treasuryBalance));

  console.log('\n✅ LAND purchase complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
