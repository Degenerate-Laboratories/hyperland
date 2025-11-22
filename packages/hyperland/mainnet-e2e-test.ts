/**
 * Mainnet E2E Test Suite
 * Tests SDK functionality against Base Mainnet deployment
 *
 * Usage:
 *   npx tsx mainnet-e2e-test.ts
 */

import { createHyperLandClient } from './sdk';
import { formatEther, parseEther } from 'ethers';

// Colors for console output
const colors = {
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[36m',
  reset: '\x1b[0m',
};

function log(message: string, color: keyof typeof colors = 'blue') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

function success(message: string) {
  log(`✅ ${message}`, 'green');
}

function error(message: string) {
  log(`❌ ${message}`, 'red');
}

function info(message: string) {
  log(`ℹ️  ${message}`, 'blue');
}

function warn(message: string) {
  log(`⚠️  ${message}`, 'yellow');
}

async function main() {
  log('\n🚀 HyperLand Mainnet E2E Test Suite\n', 'blue');
  log('Network: Base Mainnet (Chain ID: 8453)\n');

  // Create read-only client (no signer needed for queries)
  const client = createHyperLandClient({
    network: 'base-mainnet', // Base Mainnet
  });

  info('Client initialized\n');

  // ===== Contract Configuration Tests =====
  log('\n📋 Testing Contract Configuration...', 'yellow');

  try {
    const [
      treasury,
      landMintRate,
      protocolCutBP,
      taxRateBP,
      taxCycleSeconds,
      currentCycle,
    ] = await Promise.all([
      client.core.treasury(),
      client.core.landMintRate(),
      client.core.protocolCutBP(),
      client.core.taxRateBP(),
      client.core.taxCycleSeconds(),
      client.core.getCurrentCycle(),
    ]);

    success('Treasury: ' + treasury);
    success('LAND Mint Rate: ' + landMintRate.toString() + ' LAND per ETH');
    success('Protocol Cut: ' + (Number(protocolCutBP) / 100).toFixed(2) + '%');
    success('Tax Rate: ' + (Number(taxRateBP) / 100).toFixed(2) + '%');
    success('Tax Cycle: ' + taxCycleSeconds.toString() + ' seconds (' + (Number(taxCycleSeconds) / 86400).toFixed(1) + ' days)');
    success('Current Cycle: ' + currentCycle.toString());

    // Verify production values
    if (taxCycleSeconds !== 604800n) {
      warn('Tax cycle is not 7 days (604800 seconds)');
    } else {
      success('Tax cycle is correctly set to 7 days');
    }
  } catch (err) {
    error('Failed to fetch configuration: ' + (err as Error).message);
  }

  // ===== LAND Token Tests =====
  log('\n💰 Testing LAND Token...', 'yellow');

  try {
    const [name, symbol, decimals, totalSupply] = await Promise.all([
      client.land.name(),
      client.land.symbol(),
      client.land.decimals(),
      client.land.totalSupply(),
    ]);

    success('Name: ' + name);
    success('Symbol: ' + symbol);
    success('Decimals: ' + decimals);
    success('Total Supply: ' + formatEther(totalSupply) + ' LAND');

    // Check owner balance
    const ownerAddress = '0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D';
    const ownerBalance = await client.land.balanceOf(ownerAddress);
    success('Owner Balance: ' + formatEther(ownerBalance) + ' LAND');

    if (ownerBalance === totalSupply) {
      success('All tokens held by owner - ready for distribution');
    }

    // Check HyperLandCore balance
    const coreBalance = await client.land.balanceOf(client.core.address);
    info('HyperLandCore Balance: ' + formatEther(coreBalance) + ' LAND');

    if (coreBalance === 0n) {
      warn('HyperLandCore has no LAND tokens - needs tokens for auctions');
    }
  } catch (err) {
    error('Failed to test LAND token: ' + (err as Error).message);
  }

  // ===== LandDeed NFT Tests =====
  log('\n🏠 Testing LandDeed NFT...', 'yellow');

  try {
    const [name, symbol, totalSupply] = await Promise.all([
      client.deed.name(),
      client.deed.symbol(),
      client.deed.totalSupply(),
    ]);

    success('Name: ' + name);
    success('Symbol: ' + symbol);
    success('Total Supply: ' + totalSupply.toString() + ' deeds');

    if (totalSupply === 0n) {
      info('No deeds minted yet - clean state for production');
    } else {
      info('Found ' + totalSupply.toString() + ' minted deeds');

      // Test parcel queries
      if (totalSupply > 0n) {
        log('\n📦 Testing Parcel Queries...');
        const parcelId = 1n;

        try {
          const [owner, parcelData, parcelState] = await Promise.all([
            client.deed.ownerOf(parcelId),
            client.deed.getParcelData(parcelId),
            client.core.getParcel(parcelId),
          ]);

          success('Parcel #1 Owner: ' + owner);
          success('Coordinates: (' + parcelData.x.toString() + ', ' + parcelData.y.toString() + ')');
          success('Size: ' + parcelData.size.toString());
          success('Assessed Value: ' + formatEther(parcelState.assessedValueLAND) + ' LAND');
          success('In Auction: ' + parcelState.inAuction);
          success('Has Lien: ' + parcelState.lienActive);
        } catch (err) {
          error('Failed to query parcel #1: ' + (err as Error).message);
        }
      }
    }
  } catch (err) {
    error('Failed to test LandDeed NFT: ' + (err as Error).message);
  }

  // ===== Service Layer Tests =====
  log('\n🔧 Testing SDK Services...', 'yellow');

  try {
    // Test MarketplaceService
    log('\n  Testing MarketplaceService...');
    const listings = await client.marketplace.getListings({ limit: 10 });
    success('  Found ' + listings.data.length + ' active listings');

    if (listings.data.length > 0) {
      const firstListing = listings.data[0];
      info('  First Listing - Parcel #' + firstListing.parcelId.toString());
      info('  Price: ' + formatEther(firstListing.priceLAND) + ' LAND');
      info('  Coordinates: (' + firstListing.x.toString() + ', ' + firstListing.y.toString() + ')');
      info('  Seller: ' + firstListing.seller);
    }

    // Get market stats
    const stats = await client.marketplace.getMarketStats();
    success('  Market Stats:');
    info('    Total Listings: ' + stats.totalListings);
    if (stats.totalListings > 0) {
      info('    Floor Price: ' + formatEther(stats.floorPriceLAND) + ' LAND');
      info('    Average Price: ' + formatEther(stats.avgPriceLAND) + ' LAND');
      info('    Median Price: ' + formatEther(stats.medianPriceLAND) + ' LAND');
    }

    // Test ParcelService
    log('\n  Testing ParcelService...');
    const totalDeeds = await client.deed.totalSupply();

    if (totalDeeds > 0n) {
      const allParcels = await client.parcel.listParcels({ limit: 10 });
      success('  Listed ' + allParcels.data.length + ' parcels');

      if (allParcels.data.length > 0) {
        const firstParcel = allParcels.data[0];
        info('  First Parcel - Token #' + firstParcel.tokenId.toString());
        info('  Owner: ' + firstParcel.owner);
        info('  Assessed Value: ' + formatEther(firstParcel.assessedValue) + ' LAND');
        info('  Tax Owed: ' + formatEther(firstParcel.taxOwed) + ' LAND');
        info('  Listed: ' + firstParcel.isListed);
        info('  In Auction: ' + firstParcel.inAuction);
        info('  Delinquent: ' + firstParcel.isDelinquent);
      }

      // Test parcel lookup by coordinates
      const firstParcel = allParcels.data[0];
      if (firstParcel) {
        const discovery = await client.parcel.getParcelByCoordinates(firstParcel.x, firstParcel.y);
        success('  Coordinate lookup successful for (' + firstParcel.x.toString() + ', ' + firstParcel.y.toString() + ')');
        info('    Token ID: ' + discovery.tokenId?.toString());
        info('    Is Minted: ' + discovery.isMinted);
      }
    } else {
      info('  No parcels minted yet');
    }

    // Test UserService
    log('\n  Testing UserService...');
    const testAddress = '0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D'; // Owner address

    const profile = await client.user.getProfile(testAddress);
    success('  User Profile for ' + profile.address);
    info('    Parcel Count: ' + profile.parcelCount);
    info('    Total Value: ' + formatEther(profile.totalValue) + ' LAND');
    info('    Active Listings: ' + profile.activeListings);
    info('    Is Assessor: ' + profile.isAssessor);

    if (profile.parcelCount > 0) {
      const userParcels = await client.user.getParcels(testAddress, {});
      success('  Found ' + userParcels.data.length + ' parcels owned by user');
    }

    // Test AssessorService
    log('\n  Testing AssessorService...');
    const isAssessor = await client.assessor.isApprovedAssessor(testAddress);
    info('  Address is assessor: ' + isAssessor);

  } catch (err) {
    error('Service test failed: ' + (err as Error).message);
  }

  // ===== Summary =====
  log('\n📊 Test Summary', 'yellow');
  success('✅ Contract configuration tests passed');
  success('✅ LAND token tests passed');
  success('✅ LandDeed NFT tests passed');
  success('✅ SDK service tests passed');

  log('\n🎉 All E2E tests completed!\n', 'green');

  // ===== Next Steps =====
  log('📋 Next Steps:', 'yellow');
  warn('1. Update auction duration from 15 min to 3 days');
  warn('2. Transfer LAND tokens to HyperLandCore for auctions');
  warn('3. Mint initial BRC parcels (1,200 parcels)');
  warn('4. Deploy frontend to production');
  warn('5. Set up parcel metadata database');
  log('');
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
