/**
 * Example 3: Parcel Operations
 *
 * This example shows how to:
 * - Mint parcels (admin)
 * - Query parcel information
 * - Check ownership
 * - Lookup by coordinates
 */

import { createHyperLandClient, parseEther, formatEther, formatCoordinates } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Parcel Operations ===\n');

  // Setup with admin account (first Anvil account)
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

  // 1. Mint a new parcel
  console.log('1. Minting new parcel...');
  const x = 10n;
  const y = 20n;
  const size = 100n;
  const assessedValue = parseEther('1000'); // 1000 LAND

  const mintReceipt = await client.core.mintInitialParcel(
    address,
    x,
    y,
    size,
    assessedValue
  );

  console.log('  Transaction hash:', mintReceipt.hash);
  console.log('  Coordinates:', formatCoordinates(x, y));
  console.log('  Size:', size.toString());
  console.log('  Assessed Value:', formatEther(assessedValue), 'LAND');
  console.log();

  // 2. Find the token ID by coordinates
  console.log('2. Looking up parcel by coordinates...');
  const tokenId = await client.deed.getTokenIdByCoordinates(x, y);
  console.log('  Token ID:', tokenId.toString());
  console.log();

  // 3. Get complete parcel information
  console.log('3. Parcel information:');
  const parcelInfo = await client.core.getCompleteParcelInfo(tokenId);

  console.log('  NFT Data:');
  console.log('    Owner:', parcelInfo.owner);
  console.log('    Coordinates:', formatCoordinates(parcelInfo.x, parcelInfo.y));
  console.log('    Size:', parcelInfo.size.toString());
  console.log();

  console.log('  State Data:');
  console.log('    Assessed Value:', formatEther(parcelInfo.assessedValueLAND), 'LAND');
  console.log('    Last Tax Paid Cycle:', parcelInfo.lastTaxPaidCycle.toString());
  console.log('    Lien Active:', parcelInfo.lienActive);
  console.log('    In Auction:', parcelInfo.inAuction);
  console.log('    Tax Owed:', formatEther(parcelInfo.taxOwed), 'LAND');
  console.log();

  // 4. Check parcel status
  console.log('4. Parcel status:');
  const isDelinquent = await client.core.isParcelDelinquent(tokenId);
  const isEligibleForAuction = await client.core.isEligibleForAuction(tokenId);
  console.log('  Is Delinquent:', isDelinquent);
  console.log('  Eligible for Auction:', isEligibleForAuction);
  console.log();

  // 5. Get owner's parcel count
  console.log('5. Owner information:');
  const parcelCount = await client.deed.balanceOf(address);
  console.log('  Parcels owned:', parcelCount.toString());
  console.log();

  // 6. Check if coordinates are occupied
  console.log('6. Checking coordinate availability:');
  const isOccupied1 = await client.deed.isCoordinateOccupied(x, y);
  const isOccupied2 = await client.deed.isCoordinateOccupied(999n, 999n);
  console.log('  Coordinates', formatCoordinates(x, y), 'occupied:', isOccupied1);
  console.log('  Coordinates (999, 999) occupied:', isOccupied2);

  console.log('\n✅ Parcel operations complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
