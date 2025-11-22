# HyperLand Smart Contracts - Planning Document

## Overview
HyperLand is a blockchain-based land management system with NFT parcels, a utility token, property taxes, and auction mechanics. Inspired by the HyperDeeds system.

## Core Components

### 1. LAND Token (ERC20)
**Purpose**: Unified utility token for all transactions within HyperLand

**Mechanics**:
- Users purchase LAND with ETH/BASE
- Minting split: 80% to buyer, 20% to treasury
- All deed transactions use LAND
- Tax payments require LAND

**Key Functions**:
```
mint(address to, uint256 amount) - Only owner/core contract
transfer(address to, uint256 amount) - Standard ERC20
balanceOf(address owner) - View balance
```

### 2. LandDeed (ERC721)
**Purpose**: NFT representation of land parcels

**Parcel Data**:
- Token ID (unique identifier)
- Coordinates (x, y)
- Size (plot dimensions)
- Assessed value (in LAND)
- Owner address

**Key Functions**:
```
mint(address to, uint256 x, uint256 y, uint256 size) - Create new parcel
ownerOf(uint256 tokenId) - Get current owner
transfer(address from, address to, uint256 tokenId) - Transfer ownership
```

### 3. HyperLandCore
**Purpose**: Main game logic contract handling marketplace, taxes, and auctions

**Core Systems**:

#### A. Marketplace
- List parcels for sale (fixed price in LAND)
- Buy listed parcels
- 20% protocol fee on all sales

#### B. Property Tax System
- Assessed value based on parcel
- Tax accrual per cycle (configurable duration)
- Owner pays taxes in LAND to treasury
- Tax formula: `assessedValue * taxRate * cyclesPassed`

#### C. Lien System
- Third-party can pay delinquent taxes
- Starts 3-cycle grace period
- Original owner can reclaim by paying back taxes
- If not paid after 3 cycles → auction

#### D. Auction System
- Triggered after lien grace period expires
- Conducted entirely in LAND tokens
- English auction (highest bidder wins)
- Old owner receives proceeds (minus 20% protocol fee)
- Winner assumes all future tax obligations

## Contract Architecture

```
┌─────────────────────┐
│   HyperLandCore     │
│  (Main Logic)       │
│                     │
│  - buyLAND()        │
│  - listDeed()       │
│  - buyDeed()        │
│  - payTaxes()       │
│  - payTaxesFor()    │
│  - startAuction()   │
│  - placeBid()       │
│  - settleAuction()  │
└──────┬──────────────┘
       │
       ├─────────────────┐
       │                 │
   ┌───▼──────┐    ┌─────▼────────┐
   │  LAND    │    │  LandDeed    │
   │ (ERC20)  │    │  (ERC721)    │
   └──────────┘    └──────────────┘
```

## Data Structures

### Parcel
```solidity
struct Parcel {
    address owner;
    uint256 assessedValueLAND;  // Value in LAND tokens
    uint256 lastTaxPaidCycle;   // Last cycle taxes were paid
    uint256 lienStartCycle;     // When lien started (0 if none)
    bool lienActive;            // Is there an active lien?
    bool inAuction;             // Is parcel in auction?
    uint256 x;                  // X coordinate
    uint256 y;                  // Y coordinate
    uint256 size;               // Parcel size
}
```

### Listing
```solidity
struct Listing {
    address seller;
    uint256 priceLAND;  // Price in LAND tokens
    bool active;
}
```

### AuctionState
```solidity
struct AuctionState {
    uint256 parcelId;
    address highestBidder;
    uint256 highestBid;
    uint256 endTime;
    bool active;
}
```

## Economic Model

### Revenue Streams (Treasury)
1. **LAND Minting**: 20% of all LAND minted
2. **Sale Fees**: 20% of all deed sales
3. **Tax Revenue**: 100% of property taxes
4. **Auction Fees**: 20% of auction sale prices

### Tax System
- **Tax Rate**: Configurable (e.g., 5% per cycle)
- **Tax Cycle**: Configurable duration (e.g., 7 days)
- **Calculation**: `tax = assessedValue * taxRate * unpaidCycles / 10000`

### Lien & Auction Flow
```
Owner fails to pay taxes
        ↓
Third party pays (lien starts)
        ↓
Grace period: 3 cycles
        ↓
Owner still hasn't paid?
        ↓
Auction triggered
        ↓
Highest bidder wins
        ↓
Old owner receives proceeds (80%)
Treasury receives fee (20%)
New owner assumes tax obligations
```

## Configuration Parameters

```solidity
uint256 public landMintRate;     // LAND tokens per 1 ETH
uint256 public protocolCutBP;    // Basis points (2000 = 20%)
uint256 public taxRateBP;        // Tax rate in basis points (500 = 5%)
uint256 public taxCycleSeconds;  // Length of one tax cycle
uint256 public startTimestamp;   // System start time
address public treasury;         // Treasury address
```

## Key Functions

### User Functions

**buyLAND()**
```
- Accepts ETH payment
- Mints LAND (80% to buyer, 20% to treasury)
- Transfers ETH to treasury
```

**listDeed(uint256 parcelId, uint256 price)**
```
- Requires: caller owns parcel
- Creates listing with price in LAND
```

**buyDeed(uint256 parcelId)**
```
- Transfers LAND from buyer (20% fee + seller proceeds)
- Transfers deed NFT to buyer
- Updates parcel owner
```

**payTaxes(uint256 parcelId)**
```
- Calculates tax owed
- Transfers LAND to treasury
- Updates lastTaxPaidCycle
- Clears any lien
```

**payTaxesFor(uint256 parcelId)**
```
- Third party pays taxes
- Starts lien countdown
- Sets lienStartCycle
```

**placeBid(uint256 parcelId, uint256 bidAmount)**
```
- Requires: auction active
- Transfers LAND to contract
- Returns previous bid to previous bidder
- Updates highest bidder
```

### Admin Functions

**mintInitialParcel(address to, uint256 x, uint256 y, uint256 size)**
```
- Mints new land deed NFT
- Initializes parcel data
- Sets assessed value
```

**setAssessedValue(uint256 parcelId, uint256 value)**
```
- Updates parcel assessed value
- Used for dynamic pricing
```

### Automation Functions

**startAuction(uint256 parcelId)**
```
- Callable by anyone
- Requires: lien active for 3+ cycles
- Initializes auction state
```

**settleAuction(uint256 parcelId)**
```
- Callable after auction end time
- Transfers LAND (80% to old owner, 20% to treasury)
- Transfers deed to winner
- Resets parcel state
```

## Events

```solidity
event LANDPurchased(address indexed buyer, uint256 amount, uint256 ethSpent);
event ParcelMinted(uint256 indexed parcelId, address indexed owner, uint256 x, uint256 y);
event DeedListed(uint256 indexed parcelId, address seller, uint256 price);
event DeedSold(uint256 indexed parcelId, address from, address to, uint256 price);
event TaxesPaid(uint256 indexed parcelId, address payer, uint256 amount);
event LienStarted(uint256 indexed parcelId, address thirdParty, uint256 cycle);
event AuctionStarted(uint256 indexed parcelId, uint256 endTime);
event BidPlaced(uint256 indexed parcelId, address bidder, uint256 amount);
event AuctionSettled(uint256 indexed parcelId, address winner, uint256 price);
```

## Security Considerations

### Reentrancy Protection
- Use `nonReentrant` modifier on all state-changing functions
- Follow checks-effects-interactions pattern

### Access Control
- Owner-only functions for minting and admin operations
- Validate ownership before allowing operations

### Economic Security
- Prevent price manipulation
- Ensure tax calculations are overflow-safe
- Validate auction parameters

## Testing Strategy

### Unit Tests
- LAND token minting and transfers
- Deed minting and ownership
- Tax calculation accuracy
- Auction bidding logic

### Integration Tests
- Complete purchase flow
- Tax delinquency → lien → auction
- Multiple bidders in auction
- Treasury accumulation

### Edge Cases
- Zero tax rate
- Instant auction (no bids)
- Concurrent operations
- Timestamp edge cases

## Deployment Plan

### Phase 1: Local Testing
- Deploy to Anvil (local Foundry node)
- Test all functions manually
- Validate economic model

### Phase 2: Testnet
- Deploy to Base Sepolia or Ethereum Goerli
- Community testing
- Gas optimization

### Phase 3: Mainnet
- Security audit
- Deploy to production
- Monitor and iterate

## Future Enhancements

### V2 Features
- Dynamic assessed values (neighbor-based)
- Multiple parcel sizes/types
- Parcel improvements/upgrades
- Rental system
- DAO governance for parameters

### Optimization Ideas
- Batch operations for gas efficiency
- Off-chain indexing for frontend
- Layer 2 deployment for lower fees
