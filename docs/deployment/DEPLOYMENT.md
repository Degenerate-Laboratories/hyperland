# HyperLand Base Sepolia Deployment Guide

## 📋 Pre-Deployment Checklist

### ✅ Smart Contracts Status
- [x] LANDToken (ERC20) implemented and tested
- [x] LandDeed (ERC721) implemented and tested
- [x] HyperLandCore (Main Logic) implemented and tested
- [x] Marketplace functionality complete
- [x] Tax system complete
- [x] Lien mechanism complete
- [x] **Auction system complete** ✅
- [x] All tests passing (37/37 tests)

### 📝 Environment Setup Required

Create a `.env` file in the `contracts/` directory with:

```bash
# Deployer wallet
PRIVATE_KEY=your_private_key_here

# Admin address (will receive LAND tokens and control contracts)
ADMIN_ADDRESS=your_admin_address_here

# Treasury address (will receive protocol fees and taxes)
TREASURY_ADDRESS=your_treasury_address_here

# For contract verification on BaseScan
ETHERSCAN_API_KEY=your_basescan_api_key_here
```

### 💰 Funding Requirements

**Base Sepolia ETH needed**: ~0.01 ETH for deployment + gas
- Get testnet ETH from: https://www.coinbase.com/faucets/base-ethereum-sepolia-faucet

---

## 🚀 Deployment Steps

### Step 1: Test Deployment Locally

```bash
cd contracts

# Run tests to ensure everything works
forge test

# Test deployment script locally (dry-run)
forge script script/DeployBaseSepolia.s.sol:DeployBaseSepolia --rpc-url base_sepolia
```

### Step 2: Deploy to Base Sepolia

```bash
# Deploy contracts
forge script script/DeployBaseSepolia.s.sol:DeployBaseSepolia \
  --rpc-url base_sepolia \
  --broadcast \
  --verify \
  -vvvv
```

**Expected Output**:
- LAND Token address
- LandDeed address
- HyperLandCore address
- Deployment info saved to `deployments/base-sepolia.env`

### Step 3: Post-Deployment Configuration

#### 3.1 Transfer LandDeed Ownership

The HyperLandCore contract needs to own the LandDeed contract to mint parcels:

```bash
# Option A: Using cast
cast send <LAND_DEED_ADDRESS> \
  "transferOwnership(address)" \
  <HYPERLAND_CORE_ADDRESS> \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY

# Option B: Using a wallet UI (MetaMask, etc.)
# Call deed.transferOwnership(coreAddress) from the admin address
```

#### 3.2 Verify Contracts (if not auto-verified)

```bash
# Verify LAND Token
forge verify-contract <LAND_TOKEN_ADDRESS> \
  src/LANDToken.sol:LANDToken \
  --chain base-sepolia \
  --constructor-args $(cast abi-encode "constructor(address)" $ADMIN_ADDRESS)

# Verify LandDeed
forge verify-contract <LAND_DEED_ADDRESS> \
  src/LandDeed.sol:LandDeed \
  --chain base-sepolia \
  --constructor-args $(cast abi-encode "constructor(address)" $ADMIN_ADDRESS)

# Verify HyperLandCore
forge verify-contract <HYPERLAND_CORE_ADDRESS> \
  src/HyperLandCore.sol:HyperLandCore \
  --chain base-sepolia \
  --constructor-args $(cast abi-encode "constructor(address,address,address,address)" \
    $LAND_TOKEN_ADDRESS $LAND_DEED_ADDRESS $TREASURY_ADDRESS $ADMIN_ADDRESS)
```

### Step 4: Mint Test Parcels

```bash
# Mint a test parcel
cast send <HYPERLAND_CORE_ADDRESS> \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  <OWNER_ADDRESS> \
  0 \
  0 \
  100 \
  1000000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY
```

---

## 🧪 Testing on Testnet

### Test Scenarios

#### 1. LAND Token Functionality
```bash
# Check admin balance
cast call <LAND_TOKEN_ADDRESS> "balanceOf(address)(uint256)" $ADMIN_ADDRESS --rpc-url base_sepolia

# Transfer LAND to a test user
cast send <LAND_TOKEN_ADDRESS> \
  "transfer(address,uint256)" \
  <TEST_USER_ADDRESS> \
  1000000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY
```

#### 2. Parcel Minting
```bash
# Mint several test parcels at different coordinates
cast send <HYPERLAND_CORE_ADDRESS> \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  <USER1_ADDRESS> 0 0 100 1000000000000000000000 \
  --rpc-url base_sepolia --private-key $PRIVATE_KEY

cast send <HYPERLAND_CORE_ADDRESS> \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  <USER2_ADDRESS> 100 0 100 1500000000000000000000 \
  --rpc-url base_sepolia --private-key $PRIVATE_KEY
```

#### 3. Marketplace Listing
```bash
# Approve core to transfer NFT
cast send <LAND_DEED_ADDRESS> \
  "approve(address,uint256)" \
  <HYPERLAND_CORE_ADDRESS> 1 \
  --rpc-url base_sepolia --private-key $USER1_PRIVATE_KEY

# List parcel for sale
cast send <HYPERLAND_CORE_ADDRESS> \
  "listDeed(uint256,uint256)" \
  1 \
  2000000000000000000000 \
  --rpc-url base_sepolia --private-key $USER1_PRIVATE_KEY
```

#### 4. Tax Payment
```bash
# Fast forward time (if using local fork)
# Then check taxes owed
cast call <HYPERLAND_CORE_ADDRESS> \
  "calculateTaxOwed(uint256)(uint256)" \
  1 \
  --rpc-url base_sepolia

# Pay taxes
cast send <HYPERLAND_CORE_ADDRESS> \
  "payTaxes(uint256)" \
  1 \
  --rpc-url base_sepolia --private-key $USER1_PRIVATE_KEY
```

#### 5. Auction System
```bash
# Create lien (pay taxes for someone else)
cast send <HYPERLAND_CORE_ADDRESS> \
  "payTaxesFor(uint256)" \
  1 \
  --rpc-url base_sepolia --private-key $USER2_PRIVATE_KEY

# After 3 cycles (21 days), start auction
cast send <HYPERLAND_CORE_ADDRESS> \
  "startAuction(uint256)" \
  1 \
  --rpc-url base_sepolia --private-key $ANYONE_PRIVATE_KEY

# Place bid
cast send <HYPERLAND_CORE_ADDRESS> \
  "placeBid(uint256,uint256)" \
  1 \
  2500000000000000000000 \
  --rpc-url base_sepolia --private-key $USER3_PRIVATE_KEY

# After auction ends, settle
cast send <HYPERLAND_CORE_ADDRESS> \
  "settleAuction(uint256)" \
  1 \
  --rpc-url base_sepolia --private-key $ANYONE_PRIVATE_KEY
```

---

## 📊 Contract Addresses Reference

After deployment, update these addresses in:

### Frontend `.env`
```bash
NEXT_PUBLIC_LAND_TOKEN_ADDRESS=<LAND_TOKEN_ADDRESS>
NEXT_PUBLIC_LAND_DEED_ADDRESS=<LAND_DEED_ADDRESS>
NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=<HYPERLAND_CORE_ADDRESS>
NEXT_PUBLIC_CHAIN_ID=84532
NEXT_PUBLIC_RPC_URL=https://sepolia.base.org
```

### Contract ABIs
Extract ABIs for frontend:
```bash
# Extract ABIs from build artifacts
cat out/LANDToken.sol/LANDToken.json | jq '.abi' > ../projects/frontend/lib/abis/LANDToken.json
cat out/LandDeed.sol/LandDeed.json | jq '.abi' > ../projects/frontend/lib/abis/LandDeed.json
cat out/HyperLandCore.sol/HyperLandCore.json | jq '.abi' > ../projects/frontend/lib/abis/HyperLandCore.json
```

---

## 🔍 Monitoring & Verification

### BaseScan URLs
- Transactions: `https://sepolia.basescan.org/tx/<TX_HASH>`
- Contracts: `https://sepolia.basescan.org/address/<CONTRACT_ADDRESS>`

### Check Deployment Status
```bash
# Check contract deployment
cast code <CONTRACT_ADDRESS> --rpc-url base_sepolia

# Check contract owner
cast call <CONTRACT_ADDRESS> "owner()(address)" --rpc-url base_sepolia

# Check system state
cast call <HYPERLAND_CORE_ADDRESS> "getCurrentCycle()(uint256)" --rpc-url base_sepolia
```

---

## ⚠️ Troubleshooting

### Common Issues

**Issue**: "Deployment failed: insufficient funds"
- **Solution**: Ensure deployer address has enough Base Sepolia ETH

**Issue**: "Contract verification failed"
- **Solution**: Manually verify using the constructor args shown in deployment output

**Issue**: "mintParcel reverts: Ownable: caller is not the owner"
- **Solution**: Deed ownership not transferred. Run Step 3.1 again.

**Issue**: "Auction cannot start"
- **Solution**: Ensure 3+ tax cycles have passed since lien started

---

## 🎯 Success Criteria

Deployment is successful when:
- [ ] All 3 contracts deployed and verified on BaseScan
- [ ] LandDeed ownership transferred to HyperLandCore
- [ ] Test parcel minted successfully
- [ ] LAND tokens transferred to test users
- [ ] Marketplace listing works
- [ ] Tax payment works
- [ ] Auction can be started, bid on, and settled

---

## 🚦 Next Phase: Mainnet Deployment

**DO NOT** proceed to mainnet until:
1. ✅ 2+ weeks of stable testnet operation
2. ✅ External security audit completed
3. ✅ Frontend fully integrated and tested
4. ✅ Emergency pause mechanism tested
5. ✅ Multi-sig wallet configured for admin functions
6. ✅ Monitoring and alerting infrastructure ready

---

## 📞 Support

For issues or questions:
- Create an issue in the GitHub repository
- Review test files for expected behavior
- Check BaseScan for transaction details
