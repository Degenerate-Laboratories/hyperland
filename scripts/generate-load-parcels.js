/**
 * Generate script to load all 1,205 parcels into ParcelSale contract
 */

const fs = require('fs');
const path = require('path');

// Load parcel data
const parcelsPath = path.join(__dirname, '../data/processed/parcels-processed.json');
const parcels = JSON.parse(fs.readFileSync(parcelsPath, 'utf-8'));

console.log('#!/bin/bash');
console.log('# Load all 1,205 parcels into ParcelSale contract');
console.log('# Generated automatically - do not edit manually');
console.log('');
console.log('set -e  # Exit on error');
console.log('');
console.log('SALE_ADDRESS=$1');
console.log('RPC_URL=${RPC_URL:-https://mainnet.base.org}');
console.log('');
console.log('if [ -z "$SALE_ADDRESS" ]; then');
console.log('  echo "Usage: ./load-parcels.sh <PARCEL_SALE_ADDRESS>"');
console.log('  exit 1');
console.log('fi');
console.log('');
console.log('if [ -z "$PRIVATE_KEY" ]; then');
console.log('  echo "Error: PRIVATE_KEY environment variable not set"');
console.log('  exit 1');
console.log('fi');
console.log('');
console.log('echo "Loading 1,205 parcels into ParcelSale contract..."');
console.log('echo "Contract: $SALE_ADDRESS"');
console.log('echo "RPC: $RPC_URL"');
console.log('echo ""');
console.log('');

// Batch size for addParcelsBatch
const BATCH_SIZE = 50;
let batchCount = 0;

for (let i = 0; i < parcels.length; i += BATCH_SIZE) {
  const batch = parcels.slice(i, Math.min(i + BATCH_SIZE, parcels.length));
  batchCount++;

  console.log(`echo "Loading batch ${batchCount}/${Math.ceil(parcels.length / BATCH_SIZE)} (parcels ${i + 1}-${i + batch.length})..."`);

  // Build arrays for batch call
  const parcelNumbers = batch.map(p => p.parcelNumber).join(',');
  const xs = batch.map(p => p.x).join(',');
  const ys = batch.map(p => p.y).join(',');
  const sizes = batch.map(p => p.size).join(',');
  const prices = batch.map(p => {
    // Convert assessed value to Wei (LAND has 18 decimals)
    return p.assessedValue + '000000000000000000'; // Append 18 zeros
  }).join(',');

  // Use cast to call addParcelsBatch
  console.log(`cast send $SALE_ADDRESS \\`);
  console.log(`  "addParcelsBatch(uint256[],uint256[],uint256[],uint256[],uint256[])" \\`);
  console.log(`  "[${parcelNumbers}]" \\`);
  console.log(`  "[${xs}]" \\`);
  console.log(`  "[${ys}]" \\`);
  console.log(`  "[${sizes}]" \\`);
  console.log(`  "[${prices}]" \\`);
  console.log(`  --rpc-url $RPC_URL \\`);
  console.log(`  --private-key $PRIVATE_KEY`);
  console.log('');

  // Add delay between batches
  if (i + BATCH_SIZE < parcels.length) {
    console.log('echo "Waiting 3 seconds..."');
    console.log('sleep 3');
    console.log('');
  }
}

console.log('echo ""');
console.log('echo "✅ All parcels loaded successfully!"');
console.log('echo ""');
console.log('echo "Verification:"');
console.log('cast call $SALE_ADDRESS \\');
console.log('  "getStats()(uint256,uint256,uint256)" \\');
console.log('  --rpc-url $RPC_URL');
console.log('');
console.log('echo ""');
console.log('echo "Expected: (1205, 0, 1205)"');
console.log('echo "  - Total parcels: 1205"');
console.log('echo "  - Sold: 0"');
console.log('echo "  - Available: 1205"');
