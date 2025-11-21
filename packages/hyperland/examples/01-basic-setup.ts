/**
 * Example 1: Basic Setup and Configuration
 *
 * This example shows how to:
 * - Create a HyperLand client
 * - Connect to different networks
 * - Check contract addresses
 * - Query basic information
 */

import { createHyperLandClient, formatEther } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Basic Setup ===\n');

  // 1. Create client with default (Anvil local network)
  console.log('1. Creating client for local Anvil network...');
  const client = createHyperLandClient({
    network: 'anvil',
  });

  console.log('Contract addresses:');
  console.log('  LAND Token:', client.land.address);
  console.log('  LandDeed NFT:', client.deed.address);
  console.log('  HyperLandCore:', client.core.address);
  console.log();

  // 2. Get network information
  console.log('2. Network information:');
  const network = await client.getNetwork();
  console.log('  Chain ID:', network.chainId);
  console.log('  Network Name:', network.name);
  const blockNumber = await client.getBlockNumber();
  console.log('  Current Block:', blockNumber);
  console.log();

  // 3. Query contract information
  console.log('3. Contract information:');

  // LAND token info
  const landName = await client.land.name();
  const landSymbol = await client.land.symbol();
  const landTotalSupply = await client.land.totalSupply();
  console.log(`  ${landName} (${landSymbol})`);
  console.log('  Total Supply:', formatEther(landTotalSupply), 'LAND');
  console.log();

  // LandDeed NFT info
  const deedName = await client.deed.name();
  const deedSymbol = await client.deed.symbol();
  console.log(`  ${deedName} (${deedSymbol})`);
  console.log();

  // HyperLandCore configuration
  const treasury = await client.core.treasury();
  const landMintRate = await client.core.landMintRate();
  const protocolCut = await client.core.protocolCutBP();
  const taxRate = await client.core.taxRateBP();
  const currentCycle = await client.core.getCurrentCycle();

  console.log('  HyperLandCore Configuration:');
  console.log('    Treasury:', treasury);
  console.log('    LAND Mint Rate:', landMintRate.toString(), 'LAND per ETH');
  console.log('    Protocol Fee:', (Number(protocolCut) / 100).toFixed(2), '%');
  console.log('    Tax Rate:', (Number(taxRate) / 100).toFixed(2), '%');
  console.log('    Current Tax Cycle:', currentCycle.toString());
  console.log();

  // 4. Create client with custom provider and signer
  console.log('4. Creating client with custom signer...');
  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');

  // Get the first account from Anvil (for testing)
  const accounts = await provider.listAccounts();
  if (accounts.length > 0) {
    const signer = await provider.getSigner(0);
    const address = await signer.getAddress();

    const clientWithSigner = client.connect(signer);
    console.log('  Connected with address:', address);

    // Check LAND balance
    const balance = await clientWithSigner.land.balanceOf(address);
    console.log('  LAND Balance:', formatEther(balance), 'LAND');
  }

  console.log('\n✅ Setup complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
