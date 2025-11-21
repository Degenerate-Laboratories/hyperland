/**
 * Example 4: Marketplace Operations
 *
 * This example shows how to:
 * - List parcels for sale
 * - Browse listings
 * - Buy parcels
 * - Handle approvals
 */

import { createHyperLandClient, parseEther, formatEther, formatCoordinates } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Marketplace Operations ===\n');

  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');

  // Setup seller (account 0)
  const seller = await provider.getSigner(0);
  const sellerAddress = await seller.getAddress();
  const sellerClient = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: seller,
  });

  // Setup buyer (account 1)
  const buyer = await provider.getSigner(1);
  const buyerAddress = await buyer.getAddress();
  const buyerClient = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: buyer,
  });

  console.log('Seller:', sellerAddress);
  console.log('Buyer:', buyerAddress);
  console.log();

  // 1. Seller mints a parcel
  console.log('1. Seller minting parcel...');
  const x = 50n;
  const y = 50n;
  const size = 100n;
  const assessedValue = parseEther('1000');

  await sellerClient.core.mintInitialParcel(sellerAddress, x, y, size, assessedValue);
  const tokenId = await sellerClient.deed.getTokenIdByCoordinates(x, y);
  console.log('  Minted parcel #', tokenId.toString(), 'at', formatCoordinates(x, y));
  console.log();

  // 2. Buyer gets LAND tokens
  console.log('2. Buyer acquiring LAND tokens...');
  await buyerClient.core.buyLANDEther('5.0');
  const buyerBalance = await buyerClient.land.balanceOf(buyerAddress);
  console.log('  Buyer LAND balance:', formatEther(buyerBalance), 'LAND');
  console.log();

  // 3. Seller lists parcel
  console.log('3. Seller listing parcel...');
  const listPrice = parseEther('500'); // 500 LAND
  await sellerClient.core.listDeed(tokenId, listPrice);
  console.log('  Listed parcel #', tokenId.toString(), 'for', formatEther(listPrice), 'LAND');
  console.log();

  // 4. Check listing
  console.log('4. Checking listing...');
  const listing = await sellerClient.core.getListing(tokenId);
  console.log('  Seller:', listing.seller);
  console.log('  Price:', formatEther(listing.priceLAND), 'LAND');
  console.log('  Active:', listing.active);
  console.log();

  // 5. Buyer purchases parcel
  console.log('5. Buyer purchasing parcel...');
  const buyReceipt = await buyerClient.core.buyDeed(tokenId);
  console.log('  Transaction hash:', buyReceipt.hash);
  console.log('  Gas used:', buyReceipt.gasUsed.toString());
  console.log();

  // 6. Verify ownership transfer
  console.log('6. Verifying ownership...');
  const newOwner = await buyerClient.deed.ownerOf(tokenId);
  console.log('  New owner:', newOwner);
  console.log('  Is buyer:', newOwner === buyerAddress);
  console.log();

  // 7. Check final balances
  console.log('7. Final balances:');
  const sellerLandBalance = await sellerClient.land.balanceOf(sellerAddress);
  const buyerLandBalance = await buyerClient.land.balanceOf(buyerAddress);
  console.log('  Seller LAND:', formatEther(sellerLandBalance), 'LAND');
  console.log('  Buyer LAND:', formatEther(buyerLandBalance), 'LAND');
  console.log();

  // 8. Verify listing is no longer active
  console.log('8. Checking listing status...');
  const updatedListing = await sellerClient.core.getListing(tokenId);
  console.log('  Listing active:', updatedListing.active);

  console.log('\n✅ Marketplace operations complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
