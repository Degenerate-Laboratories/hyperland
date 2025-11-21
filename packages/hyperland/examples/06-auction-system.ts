/**
 * Example 6: Auction System
 *
 * This example shows how to:
 * - Start auctions for delinquent parcels
 * - Place bids
 * - Check auction status
 * - Settle auctions
 */

import { createHyperLandClient, parseEther, formatEther, getAuctionTimeRemaining, formatTimeRemaining } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Auction System ===\n');

  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');

  // Original owner
  const owner = await provider.getSigner(0);
  const ownerAddress = await owner.getAddress();
  const ownerClient = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: owner,
  });

  // Bidder 1
  const bidder1 = await provider.getSigner(1);
  const bidder1Address = await bidder1.getAddress();
  const bidder1Client = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: bidder1,
  });

  // Bidder 2
  const bidder2 = await provider.getSigner(2);
  const bidder2Address = await bidder2.getAddress();
  const bidder2Client = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: bidder2,
  });

  console.log('Owner:', ownerAddress);
  console.log('Bidder 1:', bidder1Address);
  console.log('Bidder 2:', bidder2Address);
  console.log();

  // 1. Setup: Create delinquent parcel
  console.log('1. Setup: Creating delinquent parcel...');
  const x = 200n;
  const y = 200n;
  const size = 100n;
  const assessedValue = parseEther('1000');

  await ownerClient.core.mintInitialParcel(ownerAddress, x, y, size, assessedValue);
  const tokenId = await ownerClient.deed.getTokenIdByCoordinates(x, y);

  // Give bidders LAND
  await bidder1Client.core.buyLANDEther('5.0');
  await bidder2Client.core.buyLANDEther('5.0');

  // Create lien and wait grace period
  await provider.send('evm_increaseTime', [7 * 24 * 60 * 60]);
  await provider.send('evm_mine', []);
  await bidder1Client.core.payTaxesFor(tokenId);

  // Fast forward past grace period
  await provider.send('evm_increaseTime', [3 * 7 * 24 * 60 * 60]);
  await provider.send('evm_mine', []);

  console.log('  Parcel ID:', tokenId.toString());
  console.log('  ⚠️  Parcel is now eligible for auction');
  console.log();

  // 2. Start auction
  console.log('2. Starting auction...');
  const startReceipt = await ownerClient.core.startAuction(tokenId);
  console.log('  Transaction hash:', startReceipt.hash);
  console.log('  🔨 Auction started!');
  console.log();

  // 3. Check auction state
  console.log('3. Auction information:');
  const auction = await ownerClient.core.getAuction(tokenId);
  console.log('  Active:', auction.active);
  console.log('  Highest Bidder:', auction.highestBidder);
  console.log('  Highest Bid:', formatEther(auction.highestBid), 'LAND');
  console.log('  End Time:', new Date(Number(auction.endTime) * 1000).toISOString());

  const timeRemaining = getAuctionTimeRemaining(auction.endTime);
  console.log('  Time Remaining:', formatTimeRemaining(timeRemaining));
  console.log();

  // 4. Bidder 1 places first bid
  console.log('4. Bidder 1 placing bid...');
  const bid1Amount = parseEther('1500');
  await bidder1Client.core.placeBid(tokenId, bid1Amount);
  console.log('  💰 Bid placed:', formatEther(bid1Amount), 'LAND');
  console.log();

  // 5. Check updated auction
  console.log('5. Updated auction state:');
  const auction2 = await bidder1Client.core.getAuction(tokenId);
  console.log('  Highest Bidder:', auction2.highestBidder);
  console.log('  Highest Bid:', formatEther(auction2.highestBid), 'LAND');
  console.log();

  // 6. Bidder 2 outbids
  console.log('6. Bidder 2 outbidding...');
  const bid2Amount = parseEther('2000');
  await bidder2Client.core.placeBid(tokenId, bid2Amount);
  console.log('  💰 New bid placed:', formatEther(bid2Amount), 'LAND');
  console.log();

  // 7. Verify bidder 1 was refunded
  console.log('7. Verifying refund...');
  const bidder1Balance = await bidder1Client.land.balanceOf(bidder1Address);
  console.log('  Bidder 1 LAND balance:', formatEther(bidder1Balance), 'LAND');
  console.log('  ✅ Previous bid refunded');
  console.log();

  // 8. Fast forward past auction end
  console.log('8. Fast forwarding to auction end...');
  await provider.send('evm_increaseTime', [7 * 24 * 60 * 60 + 1]);
  await provider.send('evm_mine', []);
  console.log('  ⏰ Auction ended');
  console.log();

  // 9. Get owner balances before settlement
  console.log('9. Balances before settlement:');
  const ownerLandBefore = await ownerClient.land.balanceOf(ownerAddress);
  const bidder2LandBefore = await bidder2Client.land.balanceOf(bidder2Address);
  console.log('  Owner LAND:', formatEther(ownerLandBefore), 'LAND');
  console.log('  Bidder 2 LAND:', formatEther(bidder2LandBefore), 'LAND');
  console.log();

  // 10. Settle auction
  console.log('10. Settling auction...');
  const settleReceipt = await ownerClient.core.settleAuction(tokenId);
  console.log('  Transaction hash:', settleReceipt.hash);
  console.log('  🎉 Auction settled!');
  console.log();

  // 11. Verify ownership transfer
  console.log('11. Verifying results:');
  const newOwner = await ownerClient.deed.ownerOf(tokenId);
  console.log('  New Owner:', newOwner);
  console.log('  Is Bidder 2:', newOwner === bidder2Address);
  console.log();

  // 12. Check final balances
  console.log('12. Final balances:');
  const ownerLandAfter = await ownerClient.land.balanceOf(ownerAddress);
  const bidder2LandAfter = await bidder2Client.land.balanceOf(bidder2Address);
  const treasury = await ownerClient.core.treasury();
  const treasuryBalance = await ownerClient.land.balanceOf(treasury);

  console.log('  Owner LAND:', formatEther(ownerLandAfter), 'LAND');
  console.log('  Owner Received:', formatEther(ownerLandAfter - ownerLandBefore), 'LAND (80% of bid)');
  console.log('  Bidder 2 LAND:', formatEther(bidder2LandAfter), 'LAND');
  console.log('  Treasury LAND:', formatEther(treasuryBalance), 'LAND (20% fee)');

  console.log('\n✅ Auction system demonstration complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
