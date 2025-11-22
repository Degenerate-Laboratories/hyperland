/**
 * Mint and List All 1,205 BRC Parcels
 *
 * This script:
 * 1. Mints all 1,205 parcels to the admin address
 * 2. Lists them for sale at their assessed values
 * 3. Makes them available in the marketplace
 */

import { readFileSync } from 'fs';
import { parseEther } from 'ethers';

// Load parcel data
const parcelsData = JSON.parse(
  readFileSync('./data/processed/parcels-processed.json', 'utf-8')
);

console.log(`\n🚀 Minting and Listing ${parcelsData.length} BRC Parcels\n`);
console.log('Network: Base Mainnet');
console.log('HyperLandCore: 0xB22b072503a381A2Db8309A8dD46789366D55074');
console.log('Admin: 0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D\n');

// Generate cast commands for minting
console.log('='.repeat(80));
console.log('STEP 1: MINT ALL PARCELS (Admin Only)');
console.log('='.repeat(80));
console.log('\n# Save this as mint-all.sh and run it:\n');

console.log('#!/bin/bash');
console.log('');
console.log('CORE=0xB22b072503a381A2Db8309A8dD46789366D55074');
console.log('ADMIN=0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D');
console.log('RPC=https://mainnet.base.org');
console.log('');
console.log('# Mint all parcels in batches of 10');
console.log('');

for (let i = 0; i < parcelsData.length; i++) {
  const parcel = parcelsData[i];
  const assessedValueWei = parseEther(parcel.assessedValue.toString()).toString();

  console.log(`# Parcel ${parcel.parcelNumber}: ${parcel.ring} - ${parcel.address}`);
  console.log(`cast send $CORE \\`);
  console.log(`  "mintParcel(address,uint256,uint256,uint256,uint256)" \\`);
  console.log(`  $ADMIN ${parcel.x} ${parcel.y} ${parcel.size} ${assessedValueWei} \\`);
  console.log(`  --rpc-url $RPC --private-key $PRIVATE_KEY`);
  console.log('');

  // Add delay every 10 parcels
  if ((i + 1) % 10 === 0) {
    console.log('echo "Waiting 5 seconds..."');
    console.log('sleep 5');
    console.log('');
  }
}

console.log('\n' + '='.repeat(80));
console.log('STEP 2: LIST ALL PARCELS FOR SALE');
console.log('='.repeat(80));
console.log('\n# Save this as list-all.sh and run it AFTER minting:\n');

console.log('#!/bin/bash');
console.log('');
console.log('CORE=0xB22b072503a381A2Db8309A8dD46789366D55074');
console.log('RPC=https://mainnet.base.org');
console.log('');
console.log('# List all parcels for sale');
console.log('');

for (let i = 0; i < parcelsData.length; i++) {
  const parcel = parcelsData[i];
  const priceWei = parseEther(parcel.assessedValue.toString()).toString();
  const tokenId = i + 1; // Token IDs start at 1

  console.log(`# List parcel ${tokenId}: ${parcel.ring} - ${parcel.address} for ${parcel.assessedValue} LAND`);
  console.log(`cast send $CORE \\`);
  console.log(`  "listDeed(uint256,uint256)" \\`);
  console.log(`  ${tokenId} ${priceWei} \\`);
  console.log(`  --rpc-url $RPC --private-key $PRIVATE_KEY`);
  console.log('');

  // Add delay every 10 parcels
  if ((i + 1) % 10 === 0) {
    console.log('echo "Waiting 3 seconds..."');
    console.log('sleep 3');
    console.log('');
  }
}

console.log('\n' + '='.repeat(80));
console.log('SUMMARY');
console.log('='.repeat(80));
console.log(`Total Parcels: ${parcelsData.length}`);
console.log(`Total Value: ${parcelsData.reduce((sum: number, p: any) => sum + p.assessedValue, 0).toLocaleString()} LAND`);
console.log('');
console.log('By Ring:');
const byRing: Record<string, { count: number; value: number }> = {};
parcelsData.forEach((p: any) => {
  if (!byRing[p.ring]) {
    byRing[p.ring] = { count: 0, value: 0 };
  }
  byRing[p.ring].count++;
  byRing[p.ring].value += p.assessedValue;
});

Object.entries(byRing).forEach(([ring, stats]) => {
  console.log(`  ${ring}: ${stats.count} parcels @ ${stats.value / stats.count} LAND = ${stats.value.toLocaleString()} LAND`);
});

console.log('\n📝 IMPORTANT NOTES:');
console.log('1. Make sure you have the PRIVATE_KEY environment variable set');
console.log('2. Ensure the admin wallet has enough ETH for gas fees');
console.log('3. Minting all parcels will take ~20-30 minutes');
console.log('4. Listing all parcels will take ~15-20 minutes');
console.log('5. Total estimated gas cost: ~0.5-1 ETH on Base Mainnet');
console.log('');
