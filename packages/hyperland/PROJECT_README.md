# HyperLand - Complete Package

> Blockchain-based land management system with NFT parcels, utility token, property taxes, and auction mechanics

This package contains both the **Solidity smart contracts** and the **TypeScript SDK** for HyperLand.

## 📦 Package Contents

```
packages/hyperland/
├── src/                    # Solidity smart contracts
│   ├── LAND.sol           # ERC20 utility token
│   ├── LandDeed.sol       # ERC721 NFT parcels
│   └── HyperLandCore.sol  # Main game logic
├── test/                   # Foundry tests
├── script/                 # Deployment scripts
├── sdk/                    # TypeScript SDK
│   ├── client/            # Contract client wrappers
│   ├── config/            # Network configs & addresses
│   ├── abis/              # Contract ABIs
│   └── utils/             # Utility functions
└── examples/               # SDK usage examples
```

## 🚀 Quick Start

### For Smart Contract Development

```bash
# Install Foundry dependencies
make install

# Build contracts
make build

# Run tests
make test

# Deploy locally
make deploy-local
```

See [Smart Contracts Documentation](./README.md) for details.

### For SDK/TypeScript Development

```bash
# Install Node dependencies
npm install

# Build TypeScript SDK
npm run build

# Run examples
npx ts-node examples/01-basic-setup.ts
```

See [SDK Documentation](./SDK_README.md) for details.

## 📚 Documentation

- **[Smart Contracts README](./README.md)** - Solidity contracts, testing, deployment
- **[SDK README](./SDK_README.md)** - TypeScript SDK API reference
- **[Examples README](./examples/README.md)** - SDK usage examples
- **[Design Document](../../docs/smart-contracts-plan.md)** - System architecture

## 🏗️ Project Structure

### Smart Contracts (Foundry)

**Technology Stack**:
- Solidity 0.8.28
- Foundry for development
- OpenZeppelin contracts
- Ethers.js for scripting

**Key Contracts**:
1. **LAND Token** - ERC20 utility token for all transactions
2. **LandDeed NFT** - ERC721 parcels with coordinate tracking
3. **HyperLandCore** - Main logic: marketplace, taxes, auctions

### TypeScript SDK

**Technology Stack**:
- TypeScript 5.3+
- Ethers.js v6
- Node.js 20+

**Features**:
- Type-safe contract interactions
- High-level client abstractions
- Utility functions for calculations
- Complete working examples
- Multi-network support

## 🎯 System Overview

### Core Mechanics

**1. LAND Token Economics**
- Buy LAND with ETH (80% to buyer, 20% to treasury)
- Used for all in-game transactions
- Protocol fees create sustainable economy

**2. Land Parcel System**
- Unique coordinate-based parcels (x, y, size)
- ERC721 NFT representation
- Marketplace for P2P trading

**3. Property Tax System**
- Periodic tax cycles (default: 7 days)
- Tax rate: 5% of assessed value per cycle
- Penalties for delinquency

**4. Lien Mechanism**
- Third parties can pay delinquent taxes
- 3-cycle grace period for owner
- Leads to auction if unpaid

**5. Auction System**
- English auction (highest bidder wins)
- 7-day auction duration
- Old owner receives 80% of winning bid
- 20% protocol fee to treasury

## 🔧 Development Workflows

### Contract Development

```bash
# Write Solidity contracts in src/
# Write tests in test/
forge test

# Deploy to local Anvil
anvil  # in separate terminal
make deploy-local

# Deploy to testnet
make deploy-testnet
```

### SDK Development

```bash
# Make changes to sdk/
npm run build

# Test with examples
npx ts-node examples/01-basic-setup.ts

# Run tests
npm test
```

### Full Stack Development

```bash
# Terminal 1: Start Anvil
anvil

# Terminal 2: Deploy contracts
make deploy-local

# Terminal 3: Run SDK examples
npm run examples
```

## 🧪 Testing

### Smart Contract Tests

```bash
# Run all tests
forge test

# With gas reporting
forge test --gas-report

# Specific test
forge test --match-test test_BuyLAND

# Coverage
forge coverage
```

**Test Coverage**: 24/24 tests passing ✅

### SDK/Integration Tests

```bash
# Unit tests
npm test

# Watch mode
npm run test:watch

# Run examples as integration tests
npm run examples
```

## 📊 Gas Estimates

| Operation | Gas Cost |
|-----------|----------|
| buyLAND() | ~145K |
| mintInitialParcel() | ~199K |
| listDeed() | ~66K |
| buyDeed() | ~123K |
| payTaxes() | ~87K |
| startAuction() | ~113K |
| placeBid() | ~109K |
| settleAuction() | ~119K |

## 🌐 Supported Networks

- **Anvil** (local) - Development and testing
- **Base Sepolia** (testnet) - Public testing
- **Base** (mainnet) - Production deployment

## 🔐 Security

**Features**:
- ✅ ReentrancyGuard on all state-changing functions
- ✅ Ownable access control
- ✅ Input validation and require statements
- ✅ SafeERC20/ERC721 operations
- ✅ No floating pragma versions
- ✅ Comprehensive test coverage

**Status**: ⚠️ **Not audited** - Experimental software, use at own risk

## 📝 License

MIT License - see [LICENSE](../../LICENSE)

## 🤝 Contributing

See [CONTRIBUTING.md](../../CONTRIBUTING.md)

## 🔗 Links

- Documentation: [docs.hyperland.io](https://docs.hyperland.io)
- GitHub: [github.com/hyperland/hyperland](https://github.com/hyperland/hyperland)
- Discord: [discord.gg/hyperland](https://discord.gg/hyperland)

## 💡 Project Goals

HyperLand aims to create a sustainable blockchain-based land economy where:

- 🏠 **Land ownership** is represented as NFTs with real utility
- 💰 **Token economics** are balanced through fees and taxes
- 🎯 **Active participation** is encouraged through tax obligations
- 🔨 **Auctions** provide opportunities for new participants
- 🌍 **Community-driven** land valuation and governance

## 🗺️ Roadmap

### ✅ Phase 1: Core Contracts (Complete)
- [x] LAND ERC20 token
- [x] LandDeed ERC721 NFT
- [x] HyperLandCore logic
- [x] Comprehensive tests
- [x] TypeScript SDK

### 🚧 Phase 2: Enhancement (In Progress)
- [ ] Web frontend
- [ ] Subgraph indexing
- [ ] REST API
- [ ] Mobile SDK

### 📋 Phase 3: Expansion (Planned)
- [ ] Dynamic assessed values
- [ ] Multiple parcel types
- [ ] Land improvements
- [ ] Rental system
- [ ] DAO governance

## 🆘 Support

**Having issues?**

1. Check the documentation:
   - [Smart Contracts README](./README.md)
   - [SDK README](./SDK_README.md)
   - [Examples](./examples/README.md)

2. Search existing issues:
   - [GitHub Issues](https://github.com/hyperland/hyperland/issues)

3. Join the community:
   - [Discord](https://discord.gg/hyperland)

4. Create a new issue:
   - Provide context and reproduction steps
   - Include error messages and logs
   - Tag appropriately (contracts, sdk, docs, etc.)

---

Built with ❤️ by the HyperLand team
