# ✅ HyperLand V2 - Mainnet Configuration Complete

**Date**: November 21, 2025
**Status**: Fully Configured for Base Mainnet

---

## 🎯 Summary

All HyperLand V2 components have been configured with Base Mainnet contract addresses and are ready for production deployment.

---

## 📦 Configured Components

### 1. Smart Contracts ✅
**Location**: `/Users/highlander/gamedev/hyperland/contracts/`

**Deployed Addresses** (Base Mainnet):
- LAND Token: `0x919e6e2b36b6944F52605bC705Ff609AFcb7c797`
- LandDeed NFT: `0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf`
- HyperLandCore: `0xB22b072503a381A2Db8309A8dD46789366D55074`

**Configuration File**:
- ✅ `.env.example` updated with mainnet + testnet addresses
- ✅ `deployments/base-mainnet.env` created with deployment info

---

### 2. SDK (TypeScript) ✅
**Location**: `/Users/highlander/gamedev/hyperland/packages/hyperland/`

**New Configuration Files Created**:
- ✅ `sdk/config/addresses.ts` - Network configurations
- ✅ `sdk/config/constants.ts` - System constants and utilities
- ✅ `.env.example` - Environment template

**Features**:
- Multi-network support (base-mainnet, base-sepolia, anvil)
- Default network: Base Mainnet
- Coordinate transformation utilities (BRC ↔ Blockchain)
- Fee/tax calculation helpers

---

### 3. Frontend (Next.js) ✅
**Location**: `/Users/highlander/gamedev/hyperland/projects/frontend/`

**Configuration File**:
- ✅ `.env.example` updated with mainnet addresses

**Configured Variables**:
```bash
NEXT_PUBLIC_LAND_TOKEN_ADDRESS=0x919e6e2b36b6944F52605bC705Ff609AFcb7c797
NEXT_PUBLIC_LAND_DEED_ADDRESS=0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf
NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=0xB22b072503a381A2Db8309A8dD46789366D55074
NEXT_PUBLIC_CHAIN_ID=8453
NEXT_PUBLIC_RPC_URL=https://mainnet.base.org
```

---

## 🚀 Quick Start Guides

### SDK Usage

```typescript
import { createHyperLandClient } from '@hyperland/sdk';

// Option 1: Use default (Base Mainnet)
const client = createHyperLandClient();

// Option 2: Specify network explicitly
const client = createHyperLandClient({
  network: 'base-mainnet'
});

// Option 3: Custom configuration
const client = createHyperLandClient({
  network: 'base-mainnet',
  provider: yourProvider,
  signer: yourSigner
});

// Read operations (no wallet needed)
const totalSupply = await client.land.totalSupply();
const parcel = await client.core.getParcel(1);

// Write operations (requires signer)
const clientWithSigner = client.connect(signer);
await clientWithSigner.core.payTax(parcelId);
```

### Frontend Setup

```bash
# 1. Copy environment template
cp .env.example .env.local

# 2. Configure for mainnet (already set in .env.example)
NEXT_PUBLIC_NETWORK=base-mainnet
NEXT_PUBLIC_CHAIN_ID=8453

# 3. Add your WalletConnect Project ID
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your_id_here

# 4. Start development server
npm run dev
```

### Contract Interactions

```bash
# Set environment
export CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
export RPC=https://mainnet.base.org

# Read operations (no wallet needed)
cast call $CORE "taxCycleSeconds()(uint256)" --rpc-url $RPC
cast call $CORE "protocolFeeBP()(uint256)" --rpc-url $RPC

# Write operations (requires private key)
cast send $CORE "payTax(uint256)" $PARCEL_ID \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

---

## 📋 Network Configurations

### Base Mainnet (Production)
```typescript
{
  name: 'Base Mainnet',
  chainId: 8453,
  rpcUrl: 'https://mainnet.base.org',
  blockExplorer: 'https://basescan.org',
  contracts: {
    LAND: '0x919e6e2b36b6944F52605bC705Ff609AFcb7c797',
    LandDeed: '0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf',
    HyperLandCore: '0xB22b072503a381A2Db8309A8dD46789366D55074'
  }
}
```

### Base Sepolia (Testnet)
```typescript
{
  name: 'Base Sepolia',
  chainId: 84532,
  rpcUrl: 'https://sepolia.base.org',
  blockExplorer: 'https://sepolia.basescan.org',
  contracts: {
    LAND: '0xCB650697F12785376A34537114Ad6De21670252d',
    LandDeed: '0xac08a0E4c854992C58d44A1625C73f30BC91139d',
    HyperLandCore: '0x47Ef963D494DcAb8CC567b584E708Ef55C26c303'
  }
}
```

---

## 🛠️ Utility Functions

### Coordinate Transformation

```typescript
import { brcToBlockchain, blockchainToBrc } from '@hyperland/sdk';

// BRC coordinates → Blockchain coordinates
const { x, y } = brcToBlockchain(616, 1088);
// Result: { x: 10616n, y: 11088n }

// Blockchain coordinates → BRC coordinates
const { x, y } = blockchainToBrc(10616n, 11088n);
// Result: { x: 616, y: 1088 }
```

### Fee Calculations

```typescript
import {
  calculateProtocolFee,
  calculateSellerProceeds,
  calculateTax,
  parseEther,
  formatEther
} from '@hyperland/sdk';

// Calculate fees from sale
const salePrice = parseEther('2000'); // 2000 LAND
const protocolFee = calculateProtocolFee(salePrice); // 400 LAND (20%)
const sellerGets = calculateSellerProceeds(salePrice); // 1600 LAND (80%)

// Calculate tax
const assessedValue = parseEther('1000');
const taxOwed = calculateTax(assessedValue, 1); // 50 LAND (5% of 1000)

// Format for display
console.log(`Sale: ${formatEther(salePrice)} LAND`);
console.log(`Fee: ${formatEther(protocolFee)} LAND`);
console.log(`Seller gets: ${formatEther(sellerGets)} LAND`);
```

---

## 🔐 Security Notes

### Environment Variables
- ✅ `.env.example` files are safe to commit (no secrets)
- ❌ Never commit actual `.env` or `.env.local` files
- ❌ Never hardcode private keys in code
- ✅ Use environment variables for all sensitive data

### Mainnet vs Testnet
- Always test on Base Sepolia before mainnet
- Double-check `NEXT_PUBLIC_NETWORK` before deploying
- Verify contract addresses match the network

---

## 📚 Reference Documentation

### Created Files
1. `packages/hyperland/sdk/config/addresses.ts` - Network configurations
2. `packages/hyperland/sdk/config/constants.ts` - System constants
3. `packages/hyperland/.env.example` - SDK environment template
4. `projects/frontend/.env.example` - Frontend environment template
5. `contracts/.env.example` - Contract deployment template

### Deployment Documentation
- `MAINNET_DEPLOYMENT_SUCCESS.md` - Full deployment report
- `MAINNET_STATUS.md` - Current system status
- `QUICK_REFERENCE.md` - Command reference
- `deployments/base-mainnet.env` - Deployment info

### BaseScan Links
- **LAND**: https://basescan.org/address/0x919e6e2b36b6944f52605bc705ff609afcb7c797
- **Deed**: https://basescan.org/address/0x28f5b7a911f61e875caaa16819211bf25dca0adf
- **Core**: https://basescan.org/address/0xb22b072503a381a2db8309a8dd46789366d55074

---

## ✅ Checklist

### Configuration
- [x] Smart contracts deployed to Base Mainnet
- [x] SDK configured with mainnet addresses
- [x] Frontend environment template updated
- [x] Contract .env.example updated
- [x] Network configurations created
- [x] Constants and utilities added

### Next Steps
- [ ] Deploy frontend to Vercel/production
- [ ] Set up PostgreSQL database
- [ ] Deploy blockchain event indexer
- [ ] Batch mint 1200 BRC parcels
- [ ] Test all features on mainnet
- [ ] Set up monitoring/alerts

---

## 🎉 Success!

All configuration is complete. Your project is now ready for:

1. **Development**: Use Base Sepolia for testing
2. **Production**: Deploy to Base Mainnet with confidence
3. **Local**: Test with Anvil/Hardhat locally

**HyperLand V2 is ready for production deployment!** 🚀

---

**Last Updated**: November 21, 2025
**Status**: ✅ Configuration Complete
