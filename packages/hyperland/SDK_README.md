# HyperLand TypeScript SDK

> TypeScript SDK for interacting with HyperLand smart contracts

## Overview

The HyperLand SDK provides a comprehensive TypeScript interface for interacting with the HyperLand blockchain land management system. It includes:

- **Type-safe contract interactions** using ethers.js v6
- **High-level client abstractions** for common operations
- **Utility functions** for calculations and formatting
- **Complete examples** demonstrating all features
- **Multi-network support** (Anvil, Base Sepolia, Base Mainnet)

## Installation

```bash
npm install @hyperland/sdk ethers
```

## Quick Start

```typescript
import { createHyperLandClient, parseEther } from '@hyperland/sdk';
import { ethers } from 'ethers';

// Create client for local Anvil network
const client = createHyperLandClient({ network: 'anvil' });

// Connect with a signer for transactions
const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');
const signer = await provider.getSigner();
const clientWithSigner = client.connect(signer);

// Buy LAND tokens
await clientWithSigner.core.buyLAND(parseEther('1.0'));

// Get your balance
const address = await signer.getAddress();
const balance = await clientWithSigner.land.balanceOf(address);
console.log('LAND Balance:', balance);
```

## Architecture

### Main Client

The `HyperLandClient` is the main entry point that provides access to all contracts:

```typescript
const client = createHyperLandClient({
  network: 'anvil', // 'anvil' | 'base-sepolia' | 'base'
  provider, // optional custom provider
  signer, // optional signer for transactions
});

// Access individual contract clients
client.land; // LAND ERC20 token
client.deed; // LandDeed ERC721 NFT
client.core; // HyperLandCore main logic
```

### Contract Clients

#### LANDClient (ERC20 Token)

```typescript
// Token information
const name = await client.land.name();
const symbol = await client.land.symbol();
const totalSupply = await client.land.totalSupply();

// Balance operations
const balance = await client.land.balanceOf(address);
const formatted = await client.land.balanceOfFormatted(address);

// Transfers
await client.land.transfer(to, amount);
await client.land.transferEther(to, '100.0'); // with string amount

// Approvals
await client.land.approve(spender, amount);
const allowance = await client.land.allowance(owner, spender);
```

#### LandDeedClient (ERC721 NFT)

```typescript
// Ownership
const owner = await client.deed.ownerOf(tokenId);
const balance = await client.deed.balanceOf(address);

// Parcel data
const { x, y, size } = await client.deed.getParcelData(tokenId);
const parcelInfo = await client.deed.getParcelInfo(tokenId);

// Coordinate lookup
const tokenId = await client.deed.getTokenIdByCoordinates(x, y);
const isOccupied = await client.deed.isCoordinateOccupied(x, y);

// Transfers
await client.deed.transferFrom(from, to, tokenId);
await client.deed.approve(to, tokenId);
```

#### HyperLandCoreClient (Main Logic)

```typescript
// Buy LAND with ETH
await client.core.buyLAND(ethAmount);
await client.core.buyLANDEther('1.0'); // with string amount

// Parcel operations
const parcel = await client.core.getParcel(tokenId);
const fullInfo = await client.core.getCompleteParcelInfo(tokenId);

// Marketplace
await client.core.listDeed(tokenId, price);
await client.core.buyDeed(tokenId);
const listing = await client.core.getListing(tokenId);

// Tax system
const taxOwed = await client.core.calculateTaxOwed(tokenId);
await client.core.payTaxes(tokenId);
await client.core.payTaxesFor(tokenId); // starts lien

// Auctions
await client.core.startAuction(tokenId);
await client.core.placeBid(tokenId, bidAmount);
await client.core.settleAuction(tokenId);
const auction = await client.core.getAuction(tokenId);
```

## Configuration

### Network Configurations

Built-in support for multiple networks:

```typescript
import { NETWORK_CONFIGS } from '@hyperland/sdk';

// Anvil (local development)
const anvil = NETWORK_CONFIGS.anvil;

// Base Sepolia (testnet)
const baseSepolia = NETWORK_CONFIGS['base-sepolia'];

// Base Mainnet
const base = NETWORK_CONFIGS.base;
```

### Custom Configuration

```typescript
const client = createHyperLandClient({
  network: 'anvil',
  provider: customProvider,
  signer: customSigner,
  addresses: {
    LAND: '0x...',
    LandDeed: '0x...',
    HyperLandCore: '0x...',
  },
});
```

### Environment Variables

For testnet/mainnet, set these in your `.env`:

```bash
BASE_SEPOLIA_RPC_URL=https://sepolia.base.org
LAND_ADDRESS_BASE_SEPOLIA=0x...
LANDDEED_ADDRESS_BASE_SEPOLIA=0x...
HYPERLAND_CORE_ADDRESS_BASE_SEPOLIA=0x...
```

## Constants and Calculations

The SDK provides constants and helper functions for calculations:

```typescript
import {
  CONSTANTS,
  calculateLandFromEth,
  calculateBuyerAmount,
  calculateProtocolFee,
  calculateTax,
  parseEther,
  formatEther,
} from '@hyperland/sdk';

// Constants
CONSTANTS.LAND_MINT_RATE; // 1000 LAND per ETH
CONSTANTS.PROTOCOL_FEE_BP; // 2000 (20%)
CONSTANTS.TAX_RATE_BP; // 500 (5%)
CONSTANTS.TAX_CYCLE_SECONDS; // 7 days
CONSTANTS.LIEN_GRACE_CYCLES; // 3 cycles

// Calculations
const totalLand = calculateLandFromEth(ethAmount);
const buyerAmount = calculateBuyerAmount(totalLand); // 80%
const fee = calculateProtocolFee(amount); // 20%
const tax = calculateTax(assessedValue, cyclesPassed);
```

## Utility Functions

```typescript
import {
  formatLAND,
  parseLAND,
  formatCoordinates,
  calculateParcelArea,
  isAuctionEnded,
  getAuctionTimeRemaining,
  formatTimeRemaining,
  shortenAddress,
  basisPointsToPercent,
} from '@hyperland/sdk';

// Formatting
formatLAND(amount); // '1000.0'
parseLAND('1000.0'); // 1000000000000000000000n
formatCoordinates(10n, 20n); // '(10, 20)'

// Time utilities
isAuctionEnded(endTime); // boolean
getAuctionTimeRemaining(endTime); // seconds
formatTimeRemaining(7200); // '2h'

// Address utilities
shortenAddress('0x1234...5678'); // '0x1234...5678'
```

## Examples

Complete working examples are provided in the `examples/` directory:

1. **01-basic-setup.ts** - Client setup and configuration
2. **02-buy-land-tokens.ts** - Buying LAND with ETH
3. **03-parcel-operations.ts** - Minting and querying parcels
4. **04-marketplace.ts** - Listing and buying parcels
5. **05-tax-system.ts** - Paying taxes and creating liens
6. **06-auction-system.ts** - Full auction workflow

Run examples:

```bash
# Install dependencies
npm install

# Build SDK
npm run build

# Run example (requires local Anvil node running)
npx ts-node examples/01-basic-setup.ts
```

## Error Handling

```typescript
try {
  await client.core.buyDeed(tokenId);
} catch (error) {
  if (error.code === 'INSUFFICIENT_FUNDS') {
    console.error('Not enough LAND tokens');
  } else if (error.message.includes('Not listed')) {
    console.error('Parcel is not listed for sale');
  } else {
    console.error('Transaction failed:', error);
  }
}
```

## Testing

```bash
# Run tests
npm test

# Watch mode
npm run test:watch
```

## Development

```bash
# Install dependencies
npm install

# Build TypeScript
npm run build

# Watch mode
npm run build:watch

# Lint
npm run lint

# Format
npm run format
```

## API Reference

Full API documentation is available at [docs.hyperland.io](https://docs.hyperland.io) (coming soon).

## Project Goals

HyperLand is a blockchain-based land management system that combines:

- **NFT Land Parcels**: Unique coordinate-based land plots as ERC721 tokens
- **Utility Token (LAND)**: ERC20 token for all in-game transactions
- **Property Tax System**: Regular tax cycles with penalties for delinquency
- **Lien Mechanism**: Third-party tax payment system that starts foreclosure
- **Auction System**: English auctions for delinquent properties
- **Marketplace**: Peer-to-peer land trading with protocol fees

The system is designed to:

- Create a sustainable token economy through fees and taxes
- Encourage active land ownership and participation
- Provide opportunities for tax-paying investors
- Enable community-driven land valuation

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](../../LICENSE) for details.

## Support

- Documentation: [docs.hyperland.io](https://docs.hyperland.io)
- Discord: [discord.gg/hyperland](https://discord.gg/hyperland)
- GitHub Issues: [github.com/hyperland/hyperland](https://github.com/hyperland/hyperland)

## Related Packages

- `@hyperland/contracts` - Solidity smart contracts
- `@hyperland/web` - Web frontend (coming soon)
- `@hyperland/api` - REST API (coming soon)
