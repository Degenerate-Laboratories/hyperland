# HyperLand SDK & API Architecture

## Overview
Comprehensive SDK architecture for HyperLand V2 with assessor registry, marketplace, user profiles, and feed systems.

## Core Contract Analysis (V2)

### HyperLandCore Features
1. **Parcel Management**
   - Mint & initialize parcels
   - Track parcel state (assessed value, taxes, liens, auctions)
   - Batch operations for efficiency

2. **Marketplace**
   - List/delist parcels
   - Buy parcels with protocol fees
   - Active listing tracking

3. **Tax System**
   - Tax calculation (5% per 15min cycle)
   - Pay taxes (owner or third party)
   - Advance tax payments
   - Lien system (3 cycle grace period)

4. **Auction System**
   - Lien-based auctions
   - Anti-snipping (2min extensions)
   - Auction settlement
   - No-bid returns

5. **Assessor Registry** (NEW in V2)
   - Register/revoke assessors
   - Submit valuations with methodology
   - Approve/reject valuations
   - Valuation history tracking
   - Rate limiting & constraints

### LandDeed Features
- ERC-721 NFT for land parcels
- Coordinate-based uniqueness
- Parcel metadata (x, y, size, mintedAt)
- Token URI system

### LANDToken Features
- ERC-20 token
- Fixed supply mechanism
- Standard transfer/approval

## API Routes & Endpoints

### 1. Parcel Discovery & Availability
**Routes:**
- `GET /api/parcels` - List all parcels with filters
- `GET /api/parcels/available` - Available (unminted) coordinates
- `GET /api/parcels/:id` - Single parcel details
- `GET /api/parcels/coordinates/:x/:y` - Parcel by coordinates
- `GET /api/parcels/batch` - Batch parcel data

**Filters:**
- owner, listed, inAuction, delinquent
- coordinates (bounds), size
- priceRange, assessedValueRange
- Sort: price, assessedValue, taxOwed, coordinates

**SDK Methods:**
```typescript
parcels.list(filters)
parcels.getAvailable(bounds?)
parcels.getById(id)
parcels.getByCoordinates(x, y)
parcels.getBatch(ids)
```

### 2. Marketplace & Sales
**Routes:**
- `GET /api/marketplace/listings` - All active listings
- `GET /api/marketplace/listings/:id` - Listing details
- `GET /api/marketplace/sales` - Recent sales history
- `GET /api/marketplace/stats` - Market statistics
- `POST /api/marketplace/list` - Create listing (requires auth)
- `POST /api/marketplace/buy` - Purchase parcel (requires auth)
- `DELETE /api/marketplace/listings/:id` - Cancel listing (requires auth)

**SDK Methods:**
```typescript
marketplace.getListings(filters)
marketplace.getListing(parcelId)
marketplace.getSalesHistory(filters)
marketplace.getStats()
marketplace.createListing(parcelId, price)
marketplace.buyListing(parcelId)
marketplace.cancelListing(parcelId)
```

### 3. User Profiles & Portfolio
**Routes:**
- `GET /api/users/:address` - User profile
- `GET /api/users/:address/parcels` - User's parcels
- `GET /api/users/:address/listings` - User's active listings
- `GET /api/users/:address/bids` - User's auction bids
- `GET /api/users/:address/activity` - User activity feed
- `GET /api/users/:address/stats` - User statistics

**SDK Methods:**
```typescript
users.getProfile(address)
users.getParcels(address, filters)
users.getListings(address)
users.getBids(address)
users.getActivity(address, pagination)
users.getStats(address)
```

### 4. Assessor System (NEW)
**Routes:**
- `GET /api/assessors` - List all active assessors
- `GET /api/assessors/:address` - Assessor profile
- `GET /api/assessors/:address/valuations` - Assessor's valuations
- `GET /api/valuations/pending` - Pending valuations (admin)
- `GET /api/valuations/:parcelId` - Valuation history for parcel
- `POST /api/valuations/submit` - Submit valuation (requires assessor auth)
- `POST /api/valuations/:id/approve` - Approve valuation (requires admin)
- `POST /api/valuations/:id/reject` - Reject valuation (requires admin)

**SDK Methods:**
```typescript
assessors.list()
assessors.getProfile(address)
assessors.getValuations(address, filters)
assessors.submitValuation(parcelId, value, methodology)

valuations.getPending()
valuations.getHistory(parcelId)
valuations.approve(parcelId, valueIndex)
valuations.reject(parcelId, valueIndex, reason)
```

### 5. Auction System
**Routes:**
- `GET /api/auctions` - Active auctions
- `GET /api/auctions/:parcelId` - Auction details
- `GET /api/auctions/history` - Completed auctions
- `POST /api/auctions/:parcelId/bid` - Place bid (requires auth)
- `POST /api/auctions/:parcelId/settle` - Settle auction

**SDK Methods:**
```typescript
auctions.getActive(filters)
auctions.getAuction(parcelId)
auctions.getHistory(filters)
auctions.placeBid(parcelId, amount)
auctions.settle(parcelId)
```

### 6. Tax System
**Routes:**
- `GET /api/taxes/:parcelId` - Tax information
- `GET /api/taxes/delinquent` - Delinquent parcels
- `POST /api/taxes/:parcelId/pay` - Pay taxes (requires auth)
- `POST /api/taxes/:parcelId/pay-for` - Pay for others (start lien)
- `POST /api/taxes/:parcelId/pay-advance` - Pay in advance

**SDK Methods:**
```typescript
taxes.getInfo(parcelId)
taxes.getDelinquent(filters)
taxes.pay(parcelId)
taxes.payFor(parcelId)
taxes.payInAdvance(parcelId, cycles)
```

### 7. Activity Feed
**Routes:**
- `GET /api/feed` - Global activity feed
- `GET /api/feed/sales` - Recent sales
- `GET /api/feed/listings` - New listings
- `GET /api/feed/auctions` - Auction activity
- `GET /api/feed/valuations` - Valuation submissions

**SDK Methods:**
```typescript
feed.getGlobal(pagination)
feed.getSales(pagination)
feed.getListings(pagination)
feed.getAuctions(pagination)
feed.getValuations(pagination)
```

### 8. Analytics & Statistics
**Routes:**
- `GET /api/stats/global` - Platform statistics
- `GET /api/stats/market` - Market metrics
- `GET /api/stats/parcels` - Parcel distribution
- `GET /api/stats/assessors` - Assessor statistics

**SDK Methods:**
```typescript
stats.getGlobal()
stats.getMarket()
stats.getParcels()
stats.getAssessors()
```

## SDK Architecture

### Core Structure
```
packages/hyperland/
├── sdk/
│   ├── client/
│   │   ├── HyperLandClient.ts       # Main client (existing)
│   │   ├── HyperLandCoreClient.ts   # Core contract (update)
│   │   ├── LANDClient.ts            # LAND token (existing)
│   │   └── LandDeedClient.ts        # Deed NFT (existing)
│   ├── services/
│   │   ├── AssessorService.ts       # Assessor operations (NEW)
│   │   ├── MarketplaceService.ts    # Marketplace aggregation (NEW)
│   │   ├── UserService.ts           # User profiles (NEW)
│   │   ├── ParcelService.ts         # Parcel discovery (NEW)
│   │   ├── AuctionService.ts        # Auction operations (NEW)
│   │   ├── TaxService.ts            # Tax utilities (NEW)
│   │   ├── FeedService.ts           # Activity feeds (NEW)
│   │   └── StatsService.ts          # Analytics (NEW)
│   ├── types/
│   │   ├── contracts.ts             # Contract types
│   │   ├── assessor.ts              # Assessor types (NEW)
│   │   ├── marketplace.ts           # Marketplace types (NEW)
│   │   ├── user.ts                  # User types (NEW)
│   │   └── index.ts                 # Type exports
│   ├── utils/
│   │   ├── formatting.ts            # Format helpers
│   │   ├── validation.ts            # Input validation
│   │   └── index.ts                 # Utility exports
│   ├── config/
│   │   ├── addresses.ts             # Contract addresses
│   │   └── constants.ts             # System constants
│   ├── abis/
│   │   └── index.ts                 # Contract ABIs
│   └── index.ts                     # Main exports
```

### Service Layer Design

#### AssessorService
```typescript
class AssessorService {
  // Assessor management
  async listAssessors(filters?)
  async getAssessor(address)
  async getValuations(address, filters?)
  async submitValuation(parcelId, value, methodology)

  // Valuation management (admin)
  async getPendingValuations()
  async approveValuation(parcelId, valueIndex)
  async rejectValuation(parcelId, valueIndex, reason)

  // Utilities
  async canSubmitValuation(parcelId)
  async estimateValuation(parcelId, comparables)
}
```

#### MarketplaceService
```typescript
class MarketplaceService {
  // Listing operations
  async getListings(filters)
  async getListing(parcelId)
  async createListing(parcelId, price)
  async cancelListing(parcelId)
  async buyListing(parcelId)

  // Sales data
  async getSalesHistory(filters)
  async getRecentSales(limit)

  // Market analytics
  async getMarketStats()
  async getFloorPrice()
  async getPriceDistribution()
}
```

#### UserService
```typescript
class UserService {
  // Profile data
  async getProfile(address)
  async getPortfolio(address)
  async getStats(address)

  // User parcels
  async getParcels(address, filters)
  async getListings(address)
  async getBids(address)

  // Activity
  async getActivity(address, pagination)
  async getNotifications(address)
}
```

#### ParcelService
```typescript
class ParcelService {
  // Discovery
  async listParcels(filters)
  async getAvailableCoordinates(bounds?)
  async searchParcels(query)

  // Details
  async getParcel(id)
  async getParcelByCoordinates(x, y)
  async getBatchParcels(ids)

  // Utilities
  async isCoordinateAvailable(x, y)
  async getNearbyParcels(x, y, radius)
  async getParcelNeighbors(id)
}
```

## Data Flow

### Read Operations
```
Frontend → SDK Service → Contract Client → Blockchain
                    ↓
                API Cache (optional)
```

### Write Operations
```
Frontend → SDK Service → Contract Client → Signer → Blockchain
                                              ↓
                                         Event Listeners
                                              ↓
                                         Update UI
```

## Caching Strategy

### Client-Side (SDK)
- Parcel metadata (5 min TTL)
- Market stats (1 min TTL)
- User profiles (2 min TTL)
- Assessor list (10 min TTL)

### Server-Side (Next.js API)
- Active listings (30s TTL)
- Recent sales (1 min TTL)
- Global stats (5 min TTL)

## Authentication & Authorization

### Wallet-Based Auth
- Sign message for session token
- JWT with address claim
- Role-based access (user, assessor, admin)

### Required Auth Endpoints
- `POST /api/auth/challenge` - Get nonce
- `POST /api/auth/verify` - Verify signature
- `POST /api/auth/refresh` - Refresh token
- `GET /api/auth/session` - Get session

## Real-Time Updates

### Event Subscriptions
```typescript
client.on('DeedListed', (event) => {})
client.on('DeedSold', (event) => {})
client.on('TaxesPaid', (event) => {})
client.on('AuctionStarted', (event) => {})
client.on('BidPlaced', (event) => {})
client.on('ValuationSubmitted', (event) => {})
```

### WebSocket Support (Future)
- Real-time market updates
- Live auction bidding
- Activity feed streams

## Error Handling

### SDK Error Types
```typescript
enum ErrorCode {
  NETWORK_ERROR,
  CONTRACT_ERROR,
  VALIDATION_ERROR,
  AUTH_ERROR,
  NOT_FOUND,
  INSUFFICIENT_FUNDS,
  UNAUTHORIZED
}
```

### Retry Strategy
- Network errors: 3 retries with exponential backoff
- Transaction errors: User confirmation required
- Read errors: Cache fallback

## Performance Optimization

### Batch Operations
- Multiple parcel queries
- Bulk tax calculations
- Batch approval checks

### Lazy Loading
- Pagination for lists
- Infinite scroll for feeds
- On-demand parcel details

### Prefetching
- User portfolio on login
- Nearby parcels on map view
- Related listings

## Testing Strategy

### Unit Tests
- Service layer logic
- Utility functions
- Type validation

### Integration Tests
- Contract interactions
- Multi-step workflows
- Error scenarios

### E2E Tests
- Complete user flows
- Marketplace operations
- Assessor workflows
