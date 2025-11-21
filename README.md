# HyperLand - Blockchain Land Management System

A decentralized land management platform powered by smart contracts, featuring NFT parcels, a utility token (LAND), property taxes, and an auction system.

## 🏗️ Project Structure

```
hyperland/
├── contracts/          # Foundry smart contracts
│   ├── src/           # Solidity contracts
│   ├── test/          # Contract tests
│   └── script/        # Deployment scripts
├── frontend/          # Next.js web application
│   ├── app/           # App router pages
│   └── components/    # React components
├── docs/              # Documentation
└── README.md          # This file
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

See the `/docs` directory for detailed documentation:
- [Smart Contracts Plan](docs/smart-contracts-plan.md) - Comprehensive contract architecture

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

## 🔗 Links

- [GitHub Repository](https://github.com/Degenerate-Laboratories/hyperland)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [Next.js Documentation](https://nextjs.org/docs)

## 🚧 Roadmap

### Phase 1: MVP (Current)
- ✅ Smart contract planning
- ✅ Frontend structure
- 🚧 Smart contract implementation
- 🚧 Frontend-blockchain integration

### Phase 2: Core Features
- LAND token minting
- Parcel minting and trading
- Tax system implementation
- Lien and auction mechanics

### Phase 3: Enhancement
- Dynamic assessed values
- Neighbor-based pricing
- Parcel improvements
- Mobile responsiveness

### Phase 4: Advanced Features
- DAO governance
- Rental system
- Parcel upgrades
- Layer 2 deployment

---

**Built with ❤️ by Degenerate Laboratories**
