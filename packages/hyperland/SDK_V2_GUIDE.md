# HyperLand SDK V2 - Complete Guide

## Overview

The HyperLand SDK V2 provides a comprehensive TypeScript interface for interacting with the HyperLand V2 smart contracts. It includes low-level contract clients and high-level service abstractions for common operations.

## Table of Contents

1. [Installation](#installation)
2. [Quick Start](#quick-start)
3. [Architecture](#architecture)
4. [Core Clients](#core-clients)
5. [Service Layer](#service-layer)
6. [Usage Examples](#usage-examples)
7. [Types Reference](#types-reference)
8. [Best Practices](#best-practices)

## Installation

```bash
npm install @hyperland/sdk
# or
yarn add @hyperland/sdk
```

## Quick Start

```typescript
import { createHyperLandClient } from '@hyperland/sdk';
import { ethers } from 'ethers';

// Connect to network
const provider = new ethers.JsonRpcProvider('https://base-sepolia.g.alchemy.com/v2/YOUR_KEY');
const signer = new ethers.Wallet('PRIVATE_KEY', provider);

// Create SDK client
const client = await createHyperLandClient({
  provider,
  signer,
  chainId: 84532, // Base Sepolia
});

// Use the client
const totalParcels = await client.deedClient.totalSupply();
console.log(`Total parcels: ${totalParcels}`);
```

## Architecture

The SDK is organized into three layers:

### 1. Contract Clients (Low-Level)
Direct contract interactions with type-safe methods:
- `LANDClient` - ERC-20 token operations
- `LandDeedClient` - ERC-721 NFT operations
- `HyperLandCoreClient` - Core game logic (marketplace, taxes, auctions, assessors)

### 2. Service Layer (High-Level)
Aggregated business logic with filtering, pagination, and caching:
- `MarketplaceService` - Listing aggregation and market stats
- `ParcelService` - Discovery, search, and availability
- `UserService` - Portfolio and profile management
- `AssessorService` - Valuation operations

### 3. Types
Comprehensive TypeScript types for all data structures and operations.

## Core Clients

### LANDClient

```typescript
// Get LAND token balance
const balance = await client.landClient.balanceOf(address);

// Transfer LAND tokens
await client.landClient.transfer(toAddress, amount);

// Approve spending
await client.landClient.approve(spenderAddress, amount);
```

### LandDeedClient

```typescript
// Get parcel data
const parcelData = await client.deedClient.getParcelData(parcelId);
console.log(`Coordinates: (${parcelData.x}, ${parcelData.y})`);

// Get owner
const owner = await client.deedClient.ownerOf(parcelId);

// Transfer deed
await client.deedClient.transferFrom(fromAddress, toAddress, parcelId);

// Check if coordinates are available
const exists = await client.deedClient.parcelExistsAt(x, y);
```

### HyperLandCoreClient

#### Marketplace Operations

```typescript
// List a parcel
await client.coreClient.listDeed(parcelId, priceLAND);

// Buy a listing
await client.coreClient.buyDeed(parcelId);

// Cancel listing
await client.coreClient.contract.delistDeed(parcelId);

// Get listing details
const listing = await client.coreClient.getListing(parcelId);
```

#### Tax System

```typescript
// Calculate tax owed
const taxOwed = await client.coreClient.calculateTaxOwed(parcelId);

// Pay taxes
await client.coreClient.payTaxes(parcelId);

// Pay taxes for someone else (start lien)
await client.coreClient.payTaxesFor(parcelId);

// Pay taxes in advance
await client.coreClient.payTaxesInAdvance(parcelId, 10n); // 10 cycles

// Batch tax calculations
const taxes = await client.coreClient.calculateTaxOwedBatch([1n, 2n, 3n]);
```

#### Auction System

```typescript
// Start auction (lien holder only)
await client.coreClient.startAuction(parcelId);

// Place bid
await client.coreClient.placeBid(parcelId, bidAmount);

// Settle auction
await client.coreClient.settleAuction(parcelId);

// Get auction details
const auction = await client.coreClient.getAuction(parcelId);

// Check if auction can start
const canStart = await client.coreClient.canStartAuction(parcelId);
```

#### Assessor System (NEW in V2)

```typescript
// Register assessor (admin only)
await client.coreClient.registerAssessor(assessorAddress, credentialsIPFS);

// Submit valuation (assessor only)
await client.coreClient.submitValuation(
  parcelId,
  proposedValue,
  'comparable_sales'
);

// Get valuation history
const history = await client.coreClient.getValuationHistory(parcelId);

// Get pending valuations
const pending = await client.coreClient.getPendingValuations(parcelId);

// Approve valuation (admin only)
await client.coreClient.approveValuation(parcelId, valueIndex);

// Reject valuation (admin only)
await client.coreClient.rejectValuation(parcelId, valueIndex, reason);

// Check if address is assessor
const isAssessor = await client.coreClient.isApprovedAssessor(address);

// Get assessor info
const assessorInfo = await client.coreClient.getAssessorInfo(address);
```

## Service Layer

### MarketplaceService

```typescript
import { MarketplaceService } from '@hyperland/sdk';

const marketplace = new MarketplaceService(
  client.coreClient,
  client.deedClient,
  provider
);

// Get all listings with filters
const listings = await marketplace.getListings({
  minPrice: 1000n,
  maxPrice: 10000n,
  minSize: 100n,
  sortBy: 'price',
  sortOrder: 'asc',
  limit: 20,
  offset: 0,
});

// Get market statistics
const stats = await marketplace.getMarketStats();
console.log(`Floor price: ${stats.floorPriceLAND} LAND`);
console.log(`Total listings: ${stats.totalListings}`);

// Get price distribution
const distribution = await marketplace.getPriceDistribution();

// Search listings
const results = await marketplace.searchListings('0x123...');

// Get cheapest in area
const cheapest = await marketplace.getCheapestInArea({
  minX: 0n,
  maxX: 100n,
  minY: 0n,
  maxY: 100n,
});
```

### ParcelService

```typescript
import { ParcelService } from '@hyperland/sdk';

const parcels = new ParcelService(client.coreClient, client.deedClient);

// List all parcels with filters
const allParcels = await parcels.listParcels({
  owner: address,
  listed: true,
  delinquent: false,
  bounds: { minX: 0n, maxX: 100n, minY: 0n, maxY: 100n },
  sortBy: 'value',
  sortOrder: 'desc',
  limit: 50,
});

// Get available coordinates
const available = await parcels.getAvailableCoordinates({
  minX: -10n,
  maxX: 10n,
  minY: -10n,
  maxY: 10n,
});

// Get parcel by coordinates
const parcel = await parcels.getParcelByCoordinates(5n, 5n);

// Get nearby parcels
const neighbors = await parcels.getNearbyParcels(x, y, radius);

// Search parcels
const searchResults = await parcels.searchParcels({
  text: '10,20',
  filters: { listed: true },
});

// Get map data for rendering
const mapData = await parcels.getMapParcels({
  minX: 0n,
  maxX: 50n,
  minY: 0n,
  maxY: 50n,
});
```

### UserService

```typescript
import { UserService } from '@hyperland/sdk';

const users = new UserService(
  client.coreClient,
  client.deedClient,
  client.landClient
);

// Get user profile
const profile = await users.getProfile(address);
console.log(`Parcels owned: ${profile.parcelCount}`);
console.log(`Total value: ${profile.totalValue} LAND`);
console.log(`Is assessor: ${profile.isAssessor}`);

// Get user's parcels
const userParcels = await users.getParcels(address, {
  includeDelinquent: false,
  sortBy: 'value',
  sortOrder: 'desc',
});

// Get user statistics
const userStats = await users.getStats(address);
console.log(`Net worth: ${userStats.netWorth} LAND`);
console.log(`Average parcel size: ${userStats.averageParcelSize}`);
```

### AssessorService

```typescript
import { AssessorService } from '@hyperland/sdk';

const assessors = new AssessorService(client.coreClient, client.deedClient);

// Get assessor profile
const assessor = await assessors.getAssessor(address);
console.log(`Assessments: ${assessor?.assessmentCount}`);
console.log(`Approval rate: ${assessor?.approvalRate}%`);

// Submit valuation
await assessors.submitValuation({
  parcelId: 1n,
  proposedValue: 5000n,
  methodology: 'comparable_sales',
  notes: 'Based on 3 recent sales in the area',
});

// Get valuation history
const history = await assessors.getValuationHistory(parcelId, {
  approved: true,
  limit: 10,
});

// Check constraints before submitting
const constraints = await assessors.checkValuationConstraints(parcelId);
if (!constraints.canSubmit) {
  console.log(`Cannot submit: ${constraints.reason}`);
}

// Estimate value based on comparables
const estimate = await assessors.estimateValuation(parcelId, [2n, 3n, 4n]);
```

## Usage Examples

### Example 1: Buy Land and List It

```typescript
import { createHyperLandClient, parseEther, formatEther } from '@hyperland/sdk';

async function buyAndList() {
  const client = await createHyperLandClient({ provider, signer, chainId });

  // 1. Check available coordinates
  const parcels = new ParcelService(client.coreClient, client.deedClient);
  const available = await parcels.getAvailableCoordinates();
  console.log(`Found ${available.length} available coordinates`);

  // 2. Mint parcel (admin operation)
  const x = 10n, y = 20n, size = 100n, assessedValue = parseEther('1000');
  await client.coreClient.mintParcel(myAddress, x, y, size, assessedValue);

  // 3. List for sale
  const tokenId = await client.deedClient.getTokenIdByCoordinates(x, y);
  const listingPrice = parseEther('1200');
  await client.coreClient.listDeed(tokenId, listingPrice);

  console.log(`Listed parcel ${tokenId} for ${formatEther(listingPrice)} LAND`);
}
```

### Example 2: Monitor Marketplace and Find Deals

```typescript
import { MarketplaceService } from '@hyperland/sdk';

async function findDeals() {
  const client = await createHyperLandClient({ provider, signer, chainId });
  const marketplace = new MarketplaceService(
    client.coreClient,
    client.deedClient,
    provider
  );

  // Get market stats
  const stats = await marketplace.getMarketStats();
  console.log(`Floor price: ${formatEther(stats.floorPriceLAND)} LAND`);

  // Find undervalued listings (price < assessed value)
  const listings = await marketplace.getListings({ limit: 100 });
  const deals = listings.data.filter(
    (l) => l.priceLAND < l.assessedValue * 80n / 100n // 20% below assessed value
  );

  console.log(`Found ${deals.length} potential deals!`);
  deals.forEach((deal) => {
    console.log(
      `Parcel ${deal.parcelId} at (${deal.x}, ${deal.y}): ` +
      `${formatEther(deal.priceLAND)} LAND ` +
      `(assessed: ${formatEther(deal.assessedValue)})`
    );
  });
}
```

### Example 3: Manage Your Portfolio

```typescript
import { UserService } from '@hyperland/sdk';

async function managePortfolio() {
  const client = await createHyperLandClient({ provider, signer, chainId });
  const users = new UserService(
    client.coreClient,
    client.deedClient,
    client.landClient
  );

  // Get profile
  const profile = await users.getProfile(myAddress);
  console.log(`Portfolio value: ${formatEther(profile.totalValue)} LAND`);

  // Get all parcels
  const parcels = await users.getParcels(myAddress, {});

  // Find parcels with unpaid taxes
  const delinquent = parcels.data.filter((p) => p.taxOwed > 0n);

  // Pay taxes on all delinquent parcels
  for (const parcel of delinquent) {
    console.log(`Paying ${formatEther(parcel.taxOwed)} LAND in taxes for parcel ${parcel.tokenId}`);
    await client.coreClient.payTaxes(parcel.tokenId);
  }

  console.log('All taxes paid!');
}
```

### Example 4: Become an Assessor and Submit Valuations

```typescript
import { AssessorService, VALUATION_METHODOLOGIES } from '@hyperland/sdk';

async function assessorWorkflow() {
  const client = await createHyperLandClient({ provider, signer, chainId });
  const assessors = new AssessorService(client.coreClient, client.deedClient);

  // Check if I'm an assessor
  const isAssessor = await client.coreClient.isApprovedAssessor(myAddress);
  if (!isAssessor) {
    console.log('Not an assessor. Contact admin to register.');
    return;
  }

  // Find parcels to assess
  const parcelService = new ParcelService(client.coreClient, client.deedClient);
  const parcels = await parcelService.listParcels({ limit: 10 });

  for (const parcel of parcels.data) {
    // Check constraints
    const constraints = await assessors.checkValuationConstraints(parcel.tokenId);

    if (constraints.canSubmit) {
      // Estimate value based on nearby parcels
      const neighbors = await parcelService.getNearbyParcels(parcel.x, parcel.y, 5);
      const comparableIds = neighbors.slice(0, 3).map((n) => n.tokenId);

      if (comparableIds.length > 0) {
        const estimate = await assessors.estimateValuation(parcel.tokenId, comparableIds);

        // Submit valuation
        await assessors.submitValuation({
          parcelId: parcel.tokenId,
          proposedValue: estimate,
          methodology: 'comparable_sales',
        });

        console.log(
          `Submitted valuation for parcel ${parcel.tokenId}: ` +
          `${formatEther(estimate)} LAND`
        );
      }
    }
  }
}
```

## Types Reference

See the [types directory](./sdk/types/) for complete type definitions:

- `contracts.ts` - Core contract types
- `marketplace.ts` - Marketplace and sales types
- `user.ts` - User profile and portfolio types
- `assessor.ts` - Assessor and valuation types
- `parcel.ts` - Parcel discovery and search types
- `feed.ts` - Activity feed and events types

## Best Practices

### 1. Error Handling

```typescript
import { SDKError, SDKErrorCode } from '@hyperland/sdk';

try {
  await client.coreClient.buyDeed(parcelId);
} catch (error) {
  if (error instanceof SDKError) {
    switch (error.code) {
      case SDKErrorCode.INSUFFICIENT_FUNDS:
        console.log('Not enough LAND tokens');
        break;
      case SDKErrorCode.PARCEL_NOT_LISTED:
        console.log('Parcel is not for sale');
        break;
      default:
        console.error('SDK error:', error.message);
    }
  } else {
    console.error('Unexpected error:', error);
  }
}
```

### 2. Batch Operations

```typescript
// Instead of multiple individual calls
const tax1 = await client.coreClient.calculateTaxOwed(1n);
const tax2 = await client.coreClient.calculateTaxOwed(2n);
const tax3 = await client.coreClient.calculateTaxOwed(3n);

// Use batch methods
const taxes = await client.coreClient.calculateTaxOwedBatch([1n, 2n, 3n]);
```

### 3. Pagination

```typescript
// Always use pagination for large result sets
async function getAllListings() {
  const marketplace = new MarketplaceService(...);
  const allListings = [];
  let offset = 0;
  const limit = 50;

  while (true) {
    const result = await marketplace.getListings({ limit, offset });
    allListings.push(...result.data);

    if (!result.pagination.hasMore) break;
    offset += limit;
  }

  return allListings;
}
```

### 4. Caching

```typescript
// Cache frequently accessed data
const cache = new Map();

async function getCachedParcel(parcelId: bigint) {
  const key = `parcel_${parcelId}`;

  if (cache.has(key)) {
    const cached = cache.get(key);
    if (Date.now() - cached.timestamp < 60000) { // 1 min TTL
      return cached.data;
    }
  }

  const data = await parcelService.getParcel(parcelId);
  cache.set(key, { data, timestamp: Date.now() });
  return data;
}
```

### 5. Event Listening

```typescript
// Listen for contract events
client.coreClient.contract.on('DeedListed', (parcelId, seller, price, event) => {
  console.log(`New listing: Parcel ${parcelId} for ${formatEther(price)} LAND`);
});

client.coreClient.contract.on('DeedSold', (parcelId, from, to, price, event) => {
  console.log(`Sale: Parcel ${parcelId} sold for ${formatEther(price)} LAND`);
});
```

## Next Steps

- Check out the [API Architecture](./API_ARCHITECTURE.md) for backend integration
- See [examples](./examples/) for more usage patterns
- Read the [contract documentation](../../contracts/) for low-level details

## Support

- GitHub Issues: [github.com/hyperland/hyperland/issues](https://github.com/hyperland/hyperland/issues)
- Discord: [discord.gg/hyperland](https://discord.gg/hyperland)
- Documentation: [docs.hyperland.io](https://docs.hyperland.io)
