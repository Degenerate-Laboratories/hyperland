# HyperLand V2 - Frontend Integration Quick Start

## Overview

This guide shows how to integrate the HyperLand V2 SDK into your Next.js frontend projects to build clean, maintainable applications.

## Installation

```bash
cd projects/frontend
npm link ../../packages/hyperland
```

Add to `package.json` dependencies:
```json
{
  "dependencies": {
    "@hyperland/sdk": "link:../../packages/hyperland"
  }
}
```

## Project Setup

### 1. Create SDK Provider (Context)

**File**: `lib/hyperland-provider.tsx`

```typescript
'use client';

import { createContext, useContext, useEffect, useState } from 'react';
import { createHyperLandClient, HyperLandClient } from '@hyperland/sdk';
import { useWalletClient, usePublicClient } from 'wagmi';

const HyperLandContext = createContext<HyperLandClient | null>(null);

export function HyperLandProvider({ children }: { children: React.ReactNode }) {
  const [client, setClient] = useState<HyperLandClient | null>(null);
  const { data: walletClient } = useWalletClient();
  const publicClient = usePublicClient();

  useEffect(() => {
    async function initClient() {
      if (!publicClient) return;

      const client = await createHyperLandClient({
        provider: publicClient,
        signer: walletClient,
        chainId: 84532, // Base Sepolia
      });

      setClient(client);
    }

    initClient();
  }, [walletClient, publicClient]);

  return (
    <HyperLandContext.Provider value={client}>
      {children}
    </HyperLandContext.Provider>
  );
}

export function useHyperLand() {
  const context = useContext(HyperLandContext);
  if (!context) throw new Error('useHyperLand must be used within HyperLandProvider');
  return context;
}
```

### 2. Wrap App with Provider

**File**: `app/layout.tsx`

```typescript
import { HyperLandProvider } from '@/lib/hyperland-provider';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html>
      <body>
        <WagmiProvider>
          <HyperLandProvider>
            {children}
          </HyperLandProvider>
        </WagmiProvider>
      </body>
    </html>
  );
}
```

## Common UI Patterns

### Pattern 1: Marketplace Browser

**File**: `components/MarketplaceBrowser.tsx`

```typescript
'use client';

import { useState, useEffect } from 'react';
import { useHyperLand } from '@/lib/hyperland-provider';
import { MarketplaceService, MarketplaceListing, formatEther } from '@hyperland/sdk';

export function MarketplaceBrowser() {
  const client = useHyperLand();
  const [listings, setListings] = useState<MarketplaceListing[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadListings() {
      if (!client) return;

      const marketplace = new MarketplaceService(
        client.coreClient,
        client.deedClient,
        client.provider
      );

      const result = await marketplace.getListings({
        sortBy: 'price',
        sortOrder: 'asc',
        limit: 20,
      });

      setListings(result.data);
      setLoading(false);
    }

    loadListings();
  }, [client]);

  if (loading) return <div>Loading...</div>;

  return (
    <div className="grid grid-cols-3 gap-4">
      {listings.map((listing) => (
        <ListingCard key={listing.parcelId.toString()} listing={listing} />
      ))}
    </div>
  );
}

function ListingCard({ listing }: { listing: MarketplaceListing }) {
  const client = useHyperLand();

  async function buyListing() {
    if (!client) return;

    const marketplace = new MarketplaceService(
      client.coreClient,
      client.deedClient,
      client.provider
    );

    await marketplace.buyListing(listing.parcelId);
    alert('Purchase successful!');
  }

  return (
    <div className="border p-4 rounded">
      <h3>Parcel #{listing.parcelId.toString()}</h3>
      <p>Location: ({listing.x.toString()}, {listing.y.toString()})</p>
      <p>Size: {listing.size.toString()}</p>
      <p>Price: {formatEther(listing.priceLAND)} LAND</p>
      <button onClick={buyListing} className="btn-primary">
        Buy Now
      </button>
    </div>
  );
}
```

### Pattern 2: User Profile Page

**File**: `app/profile/[address]/page.tsx`

```typescript
import { UserProfile } from '@/components/UserProfile';

export default function ProfilePage({ params }: { params: { address: string } }) {
  return (
    <div>
      <h1>User Profile</h1>
      <UserProfile address={params.address} />
    </div>
  );
}
```

**File**: `components/UserProfile.tsx`

```typescript
'use client';

import { useState, useEffect } from 'react';
import { useHyperLand } from '@/lib/hyperland-provider';
import { UserService, UserProfile as UserProfileType, formatEther } from '@hyperland/sdk';

export function UserProfile({ address }: { address: string }) {
  const client = useHyperLand();
  const [profile, setProfile] = useState<UserProfileType | null>(null);

  useEffect(() => {
    async function loadProfile() {
      if (!client) return;

      const users = new UserService(
        client.coreClient,
        client.deedClient,
        client.landClient
      );

      const data = await users.getProfile(address);
      setProfile(data);
    }

    loadProfile();
  }, [client, address]);

  if (!profile) return <div>Loading...</div>;

  return (
    <div className="profile-card">
      <h2>{address}</h2>
      <div className="stats">
        <div>Parcels: {profile.parcelCount}</div>
        <div>Total Value: {formatEther(profile.totalValue)} LAND</div>
        <div>Active Listings: {profile.activeListings}</div>
        {profile.isAssessor && (
          <div className="assessor-badge">
            ✓ Approved Assessor ({profile.assessorInfo?.assessmentCount.toString()} assessments)
          </div>
        )}
      </div>
    </div>
  );
}
```

### Pattern 3: Parcel Map View

**File**: `components/ParcelMap.tsx`

```typescript
'use client';

import { useState, useEffect } from 'react';
import { useHyperLand } from '@/lib/hyperland-provider';
import { ParcelService, MapParcel } from '@hyperland/sdk';

export function ParcelMap() {
  const client = useHyperLand();
  const [parcels, setParcels] = useState<MapParcel[]>([]);
  const [viewport, setViewport] = useState({
    minX: -50n,
    maxX: 50n,
    minY: -50n,
    maxY: 50n,
  });

  useEffect(() => {
    async function loadMapData() {
      if (!client) return;

      const parcelService = new ParcelService(
        client.coreClient,
        client.deedClient
      );

      const data = await parcelService.getMapParcels(viewport);
      setParcels(data);
    }

    loadMapData();
  }, [client, viewport]);

  return (
    <div className="map-container">
      <div className="map-grid">
        {parcels.map((parcel) => (
          <MapTile
            key={`${parcel.x}_${parcel.y}`}
            parcel={parcel}
          />
        ))}
      </div>
    </div>
  );
}

function MapTile({ parcel }: { parcel: MapParcel }) {
  return (
    <div
      className={`map-tile ${parcel.isMinted ? 'minted' : 'available'}`}
      data-x={parcel.x.toString()}
      data-y={parcel.y.toString()}
      title={parcel.isMinted ? `Owner: ${parcel.owner}` : 'Available'}
    />
  );
}
```

### Pattern 4: Assessor Dashboard

**File**: `components/AssessorDashboard.tsx`

```typescript
'use client';

import { useState } from 'react';
import { useHyperLand } from '@/lib/hyperland-provider';
import { AssessorService, VALUATION_METHODOLOGIES } from '@hyperland/sdk';

export function AssessorDashboard() {
  const client = useHyperLand();
  const [parcelId, setParcelId] = useState('');
  const [value, setValue] = useState('');
  const [methodology, setMethodology] = useState('comparable_sales');

  async function submitValuation() {
    if (!client) return;

    const assessors = new AssessorService(
      client.coreClient,
      client.deedClient
    );

    await assessors.submitValuation({
      parcelId: BigInt(parcelId),
      proposedValue: BigInt(value),
      methodology,
    });

    alert('Valuation submitted!');
  }

  return (
    <div className="assessor-dashboard">
      <h2>Submit Valuation</h2>
      <form onSubmit={(e) => { e.preventDefault(); submitValuation(); }}>
        <input
          type="number"
          placeholder="Parcel ID"
          value={parcelId}
          onChange={(e) => setParcelId(e.target.value)}
        />
        <input
          type="number"
          placeholder="Proposed Value (LAND)"
          value={value}
          onChange={(e) => setValue(e.target.value)}
        />
        <select
          value={methodology}
          onChange={(e) => setMethodology(e.target.value)}
        >
          {Object.keys(VALUATION_METHODOLOGIES).map((key) => (
            <option key={key} value={key}>
              {VALUATION_METHODOLOGIES[key as keyof typeof VALUATION_METHODOLOGIES].name}
            </option>
          ))}
        </select>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}
```

## API Routes (Backend for Frontend)

### Route 1: Get All Parcels

**File**: `app/api/parcels/route.ts`

```typescript
import { NextResponse } from 'next/server';
import { createHyperLandClient, ParcelService } from '@hyperland/sdk';
import { ethers } from 'ethers';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const limit = parseInt(searchParams.get('limit') || '20');
  const offset = parseInt(searchParams.get('offset') || '0');

  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const client = await createHyperLandClient({
    provider,
    chainId: 84532,
  });

  const service = new ParcelService(client.coreClient, client.deedClient);
  const result = await service.listParcels({
    limit: BigInt(limit),
    offset: BigInt(offset),
  });

  return NextResponse.json(result);
}
```

### Route 2: Get User Profile

**File**: `app/api/users/[address]/route.ts`

```typescript
import { NextResponse } from 'next/server';
import { createHyperLandClient, UserService } from '@hyperland/sdk';
import { ethers } from 'ethers';

export async function GET(
  request: Request,
  { params }: { params: { address: string } }
) {
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const client = await createHyperLandClient({
    provider,
    chainId: 84532,
  });

  const service = new UserService(
    client.coreClient,
    client.deedClient,
    client.landClient
  );

  const profile = await service.getProfile(params.address);

  return NextResponse.json(profile);
}
```

### Route 3: Get Market Stats

**File**: `app/api/marketplace/stats/route.ts`

```typescript
import { NextResponse } from 'next/server';
import { createHyperLandClient, MarketplaceService } from '@hyperland/sdk';
import { ethers } from 'ethers';

export async function GET() {
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const client = await createHyperLandClient({
    provider,
    chainId: 84532,
  });

  const service = new MarketplaceService(
    client.coreClient,
    client.deedClient,
    provider
  );

  const stats = await service.getMarketStats();

  return NextResponse.json(stats);
}
```

## Custom Hooks

### useMarketplace Hook

**File**: `hooks/useMarketplace.ts`

```typescript
import { useState, useEffect } from 'react';
import { useHyperLand } from '@/lib/hyperland-provider';
import { MarketplaceService, MarketplaceListing } from '@hyperland/sdk';

export function useMarketplace(filters?: any) {
  const client = useHyperLand();
  const [listings, setListings] = useState<MarketplaceListing[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      if (!client) return;

      const service = new MarketplaceService(
        client.coreClient,
        client.deedClient,
        client.provider
      );

      const result = await service.getListings(filters);
      setListings(result.data);
      setLoading(false);
    }

    load();
  }, [client, JSON.stringify(filters)]);

  return { listings, loading };
}
```

Usage:
```typescript
function MyComponent() {
  const { listings, loading } = useMarketplace({
    minPrice: 1000n,
    maxPrice: 10000n,
    limit: 10,
  });

  // ...
}
```

## Environment Variables

**File**: `.env.local`

```bash
# RPC URL
RPC_URL=https://base-sepolia.g.alchemy.com/v2/YOUR_KEY

# Contract Addresses (Base Sepolia)
NEXT_PUBLIC_LAND_TOKEN=0x...
NEXT_PUBLIC_LAND_DEED=0x...
NEXT_PUBLIC_HYPERLAND_CORE=0x...

# Chain ID
NEXT_PUBLIC_CHAIN_ID=84532
```

## Utilities

### Format Helpers

```typescript
import { formatEther, parseEther } from '@hyperland/sdk';

// Display LAND amount
const displayValue = formatEther(1000000000000000000n); // "1.0"

// Parse user input
const value = parseEther("100"); // 100000000000000000000n
```

### Error Handling

```typescript
import { SDKError, SDKErrorCode } from '@hyperland/sdk';

try {
  await marketplace.buyListing(parcelId);
} catch (error) {
  if (error instanceof SDKError) {
    switch (error.code) {
      case SDKErrorCode.INSUFFICIENT_FUNDS:
        toast.error('Not enough LAND tokens');
        break;
      case SDKErrorCode.PARCEL_NOT_LISTED:
        toast.error('Parcel is not for sale');
        break;
      default:
        toast.error(error.message);
    }
  }
}
```

## Performance Tips

1. **Use API routes for expensive operations**
   - Parcel scanning
   - Historical data queries
   - Market statistics

2. **Implement client-side caching**
   - React Query for API calls
   - Local state for static data

3. **Batch operations**
   - Use `calculateTaxOwedBatch()`
   - Use `getParcelStatesBatch()`

4. **Lazy load data**
   - Pagination for lists
   - Infinite scroll for feeds

## Common Pages to Build

1. **Home** - Landing with stats and featured parcels
2. **Marketplace** - Browse and filter listings
3. **Map View** - Interactive parcel map
4. **Profile** - User portfolio and stats
5. **Parcel Details** - Single parcel view with actions
6. **Assessor Dashboard** - Valuation submission and tracking
7. **Admin Panel** - System management (if admin)

## Next Steps

1. Set up the provider in your app
2. Build marketplace browser component
3. Add user profile pages
4. Implement map view
5. Create assessor dashboard (if applicable)
6. Add activity feed
7. Implement notifications

## Resources

- **SDK Guide**: `packages/hyperland/SDK_V2_GUIDE.md`
- **API Architecture**: `packages/hyperland/API_ARCHITECTURE.md`
- **Type Definitions**: `packages/hyperland/sdk/types/`

---

**Ready to build!** Start with the marketplace browser and expand from there. Keep your components clean by using the service layer instead of direct contract calls.
