# HyperLand - Blockchain Land Management System

A decentralized land management platform on Base blockchain, featuring NFT land parcels with property taxes, a LAND utility token with AMM trading, and a dynamic marketplace.

**🚀 Status**: Live on Base Mainnet | [View Contracts on BaseScan](https://basescan.org/address/0xB22b072503a381A2Db8309A8dD46789366D55074)

## 🏗️ Project Structure

```
hyperland/
├── contracts/          # Foundry smart contracts (Solidity)
│   ├── src/           # Core contracts (HyperLandCore, LAND, LandDeed)
│   ├── test/          # Comprehensive test suite
│   └── script/        # Deployment & utility scripts
├── projects/frontend/ # Next.js 15 web application
│   ├── app/           # App router pages
│   ├── components/    # React components
│   └── lib/           # Services, ABIs, utilities
├── packages/hyperland/# SDK and backend utilities
├── docs/              # Comprehensive documentation
│   ├── status/        # Current status & updates
│   ├── deployment/    # Deployment guides
│   ├── guides/        # User & developer guides
│   └── contracts/     # Smart contract docs
└── scripts/           # Utility scripts
```

## 🎮 Core Features

### LAND Token (ERC20)
- Purchase with ETH/BASE (80% to buyer, 20% to treasury)
- Used for all in-system transactions
- Unified currency for parcels and taxes

### Land Parcels (ERC721 NFTs)
- Unique land parcels with coordinates and size
- Fully tradeable on the marketplace
- Assessed value determines property taxes

### Property Tax System
- Automatic tax accrual based on assessed value
- Pay taxes to maintain ownership
- Delinquent parcels enter lien period

### Lien & Auction Mechanics
- Third parties can pay delinquent taxes
- Starts 3-cycle grace period for owner
- Unpaid liens trigger auctions
- Highest bidder wins ownership

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ and npm
- Foundry (for smart contracts)
- MetaMask or compatible Web3 wallet

### Frontend Development

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:3000`

### Smart Contract Development

```bash
cd contracts
forge build
forge test
```

## 📖 Documentation

**Quick Links**:
- **[Current Status](docs/status/MAINNET_TRADING_STATUS.md)** - Latest deployment status & next steps
- **[Setup Guide](SETUP.md)** - Quick start for developers
- **[Full Documentation Index](docs/README.md)** - Complete documentation library

**Key Documents**:
- [V3 Architecture](docs/status/V3_SIMPLIFIED_DESIGN.md) - Current system design
- [Smart Contracts](docs/contracts/smart-contracts-plan.md) - Contract architecture
- [Wallet Setup](docs/guides/WALLET_AUTH_QUICKSTART.md) - Connect your wallet
- [Deployment Guide](docs/deployment/MAINNET_DEPLOYMENT.md) - Production deployment

## 🛠️ Tech Stack

- **Smart Contracts**: Solidity + Foundry + OpenZeppelin
- **Frontend**: Next.js 15 + TypeScript + Tailwind CSS
- **Blockchain**: EVM-compatible (Ethereum, Base, etc.)

## 🔗 Routes

### Frontend Pages

- `/` - Homepage with platform overview
- `/marketplace` - Browse and buy land parcels
- `/my-lands` - View and manage owned parcels
- `/land/[id]` - Detailed parcel information

### Key Features Per Page

**Marketplace**:
- Browse all listed parcels
- Filter by size and price
- Purchase parcels with LAND tokens

**My Lands**:
- View owned parcels
- Buy LAND tokens with ETH
- Pay property taxes
- List parcels for sale

**Land Detail**:
- Parcel information and history
- Tax status and payments
- Owner information
- Transaction history

## 💰 Economic Model

### Revenue Streams (Treasury)
1. 20% of all LAND token mints
2. 20% protocol fee on all parcel sales
3. 100% of property tax payments
4. 20% fee on auction settlements

### Tax System
- Assessed value-based taxation
- Configurable tax cycles
- Automatic accrual
- Lien system for delinquency

## 🔐 Smart Contract Architecture

```
HyperLandCore (Main Logic)
    ├── LANDToken (ERC20)
    ├── LandDeed (ERC721)
    ├── Marketplace
    ├── Tax System
    └── Auction System
```

## 🧪 Testing

### Frontend
```bash
cd frontend
npm run build  # Verify production build
npm run lint   # Check code quality
```

### Smart Contracts
```bash
cd contracts
forge test -vv           # Run tests with verbose output
forge test --gas-report  # Generate gas usage report
```

## 📦 Deployment

### Smart Contracts
```bash
cd contracts
forge script script/Deploy.s.sol --rpc-url <RPC_URL> --broadcast
```

### Frontend
```bash
cd frontend
npm run build
npm start  # or deploy to Vercel
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - See LICENSE file for details

## 🌐 Deployed Contracts (Base Mainnet)

| Contract | Address | Explorer |
|----------|---------|----------|
| **HyperLandCore** | `0xB22b072503a381A2Db8309A8dD46789366D55074` | [View](https://basescan.org/address/0xB22b072503a381A2Db8309A8dD46789366D55074) |
| **LAND Token** | `0x919e6e2b36b6944F52605bC705Ff609AFcb7c797` | [View](https://basescan.org/token/0x919e6e2b36b6944F52605bC705Ff609AFcb7c797) |
| **LandDeed NFT** | `0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf` | [View](https://basescan.org/address/0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf) |

**DEX Integration**: Aerodrome Finance (Base's leading DEX)
- Trading: LAND/WETH volatile pool
- Router: `0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43`

## 🔗 Links

- [GitHub Repository](https://github.com/Degenerate-Laboratories/hyperland)
- [Live Application](https://hyperland.vercel.app) (Coming Soon)
- [BaseScan Contracts](https://basescan.org/address/0xB22b072503a381A2Db8309A8dD46789366D55074)
- [Documentation](docs/README.md)

**Resources**:
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Base Network](https://base.org)

## 🚧 Roadmap

### Phase 1: Foundation ✅ COMPLETE
- ✅ Smart contract architecture & deployment
- ✅ Base Mainnet deployment (all contracts verified)
- ✅ Frontend structure & wallet integration
- ✅ LAND token with DEX integration

### Phase 2: Trading & Marketplace 🔄 IN PROGRESS
- ✅ Aerodrome DEX integration
- ✅ Real-time price oracle
- ✅ Buy/sell LAND with ETH
- 🚧 Liquidity pool creation ($1M target market cap)
- 🚧 Parcel marketplace (primary sales via bonding curve)
- 🚧 Secondary market for parcel trading

### Phase 3: Core Features ⏳ NEXT
- Property tax system activation
- Tax payment and tracking
- Delinquency and lien mechanics
- Parcel auction system
- 3D interactive map

### Phase 4: Enhancement 📅 PLANNED
- Dynamic parcel valuations
- Neighbor-based pricing
- Parcel improvements/upgrades
- DAO governance for parameters
- Mobile app

### Phase 5: Scale 🎯 FUTURE
- Cross-chain expansion
- Rental/lease system
- Metaverse integrations
- Enterprise land management tools

---

**Built with ❤️ by Degenerate Laboratories**
