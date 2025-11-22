# 🚀 HyperLand V2 Mainnet Deployment Checklist

**Date**: November 21, 2025
**Network**: Base Mainnet (Chain ID: 8453)
**Status**: READY TO DEPLOY ✅

---

## Pre-Deployment Verification

### Wallet & Funds
- [x] **Deployer Address**: `0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D`
- [x] **Deployer Balance**: 0.01 ETH (minimum required: ~0.01 ETH)
- [x] **Admin Address**: `0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D` (same as deployer for now)
- [x] **Treasury Address**: `0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D` (same as deployer for now)

### Network Configuration
- [x] **RPC URL**: https://mainnet.base.org
- [x] **Chain ID**: 8453
- [x] **Foundry Config**: Configured for Base mainnet
- [x] **Etherscan API Key**: Set in .env

### Smart Contracts
- [x] **LANDToken.sol**: 21M supply, audited ✅
- [x] **LandDeed.sol**: ERC-721 NFT, coordinate system ✅
- [x] **HyperLandCore.sol**: V2 features (tax prepayment, batch, pause) ✅
- [x] **All Tests**: 88/88 passing ✅
- [x] **Gas Optimization**: Enabled with 200 runs ✅

### Deployment Script
- [x] **Script Created**: `script/DeployBaseMainnet.s.sol`
- [x] **Safety Checks**: Balance verification, address validation
- [x] **Post-Deployment Steps**: Documented in script output

---

## Deployment Command

```bash
# Navigate to contracts directory
cd /Users/highlander/gamedev/hyperland/contracts

# Deploy to Base Mainnet
forge script script/DeployBaseMainnet.s.sol:DeployBaseMainnet \
  --rpc-url base \
  --broadcast \
  --verify \
  --slow
```

**Estimated Gas Cost**: ~0.008-0.010 ETH

---

## Post-Deployment Steps (CRITICAL)

### Step 1: Transfer LandDeed Ownership ⚠️ REQUIRED
```bash
# LandDeed must be owned by HyperLandCore to mint parcels
cast send <LAND_DEED_ADDRESS> \
  "transferOwnership(address)" <HYPERLAND_CORE_ADDRESS> \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

### Step 2: Set Production Timing Parameters ⚠️ REQUIRED
```bash
# Set tax cycle to 7 days (currently 15 minutes)
cast send <HYPERLAND_CORE_ADDRESS> \
  "setTaxCycleDuration(uint256)" 604800 \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY

# Set auction duration to 3 days (currently 15 minutes)
cast send <HYPERLAND_CORE_ADDRESS> \
  "setAuctionDuration(uint256)" 259200 \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

### Step 3: Verify Contracts on BaseScan
Forge will attempt automatic verification. If it fails, manually verify:

```bash
# LANDToken
forge verify-contract <LAND_TOKEN_ADDRESS> \
  src/LANDToken.sol:LANDToken \
  --chain base \
  --constructor-args $(cast abi-encode "constructor(address)" <ADMIN_ADDRESS>)

# LandDeed
forge verify-contract <LAND_DEED_ADDRESS> \
  src/LandDeed.sol:LandDeed \
  --chain base \
  --constructor-args $(cast abi-encode "constructor(address)" <ADMIN_ADDRESS>)

# HyperLandCore
forge verify-contract <HYPERLAND_CORE_ADDRESS> \
  src/HyperLandCore.sol:HyperLandCore \
  --chain base \
  --constructor-args $(cast abi-encode "constructor(address,address,address,address)" <LAND_TOKEN_ADDRESS> <LAND_DEED_ADDRESS> <TREASURY_ADDRESS> <ADMIN_ADDRESS>)
```

### Step 4: Test Deployment
```bash
# Check LAND token supply
cast call <LAND_TOKEN_ADDRESS> "totalSupply()(uint256)" --rpc-url https://mainnet.base.org

# Check admin LAND balance (should be 21M)
cast call <LAND_TOKEN_ADDRESS> "balanceOf(address)(uint256)" <ADMIN_ADDRESS> --rpc-url https://mainnet.base.org

# Check LandDeed owner (should be HyperLandCore after Step 1)
cast call <LAND_DEED_ADDRESS> "owner()(address)" --rpc-url https://mainnet.base.org

# Check tax cycle (should be 604800 after Step 2)
cast call <HYPERLAND_CORE_ADDRESS> "taxCycleSeconds()(uint256)" --rpc-url https://mainnet.base.org
```

---

## Expected Results

### Contract Addresses (Will be populated after deployment)
```bash
LAND_TOKEN_ADDRESS=0x...
LAND_DEED_ADDRESS=0x...
HYPERLAND_CORE_ADDRESS=0x...
```

### Initial State
- **LAND Supply**: 21,000,000 tokens
- **Admin Balance**: 21,000,000 LAND
- **Total Parcels**: 0 (minting comes after deployment)
- **Protocol Fee**: 20%
- **Tax Rate**: 5% per cycle
- **Tax Cycle**: 604800 seconds (7 days) after configuration
- **Auction Duration**: 259200 seconds (3 days) after configuration

---

## Safety Checklist ✅

- [x] Private keys secured and not committed to git
- [x] Sufficient ETH for deployment (~0.01 ETH)
- [x] All tests passing (88/88)
- [x] Deployment script tested on testnet
- [x] Post-deployment steps documented
- [x] Contract verification configured
- [ ] Multi-sig setup planned (future enhancement)

---

## Rollback Plan

If deployment fails or issues are discovered:

1. **DO NOT** mint any parcels on failed deployment
2. Redeploy with fixes to new addresses
3. Update frontend/SDK to point to new addresses
4. Original failed deployment can be abandoned (no user funds at risk)

**Note**: Since no parcels are minted during deployment, rollback is simple.

---

## Next Steps After Deployment

1. **Immediate** (within 1 hour):
   - Transfer LandDeed ownership
   - Set production timing parameters
   - Verify all contracts on BaseScan

2. **Short-term** (within 24 hours):
   - Test mint 3-5 parcels to verify system
   - Deploy blockchain indexer
   - Set up event monitoring

3. **Medium-term** (within 1 week):
   - Import 1200 BRC parcels to database
   - Batch mint BRC parcels
   - Deploy frontend with mainnet config
   - Launch public beta

4. **Long-term** (within 1 month):
   - Implement multi-sig admin controls
   - Set up monitoring/alerts
   - Complete documentation
   - Full public launch

---

**Deployment Confidence**: 95% → 99% after successful deployment ✅
