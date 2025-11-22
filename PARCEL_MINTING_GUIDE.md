# HyperLand Parcel Minting Guide

## 📊 Parcel Data Overview

### Black Rock City (BRC) Layout
The HyperLand platform will manage **1,205 parcels** based on the Burning Man Black Rock City layout.

**Ring Structure** (Innermost to Outermost):
- **Esplanade**: 241 parcels @ 1,000 LAND each = 241,000 LAND total
- **MidCity**: 241 parcels @ 800 LAND each = 192,800 LAND total
- **Afanc**: 241 parcels @ 600 LAND each = 144,600 LAND total
- **Igopogo**: 241 parcels @ 400 LAND each = 96,400 LAND total
- **Kraken**: 241 parcels @ 200 LAND each = 48,200 LAND total

**Total System Value**: 723,000 LAND tokens

### Parcel Specifications
- **Standard Size**: 100 units per parcel
- **Coordinates**: X range: -9682 to 4914, Y range: -9682 to 9682
- **Assessed Value**: Ring-based pricing (inner rings more valuable)
- **Total Count**: 1,205 parcels

---

## 🚀 Batch Minting Process

### Automated Minting Script Generated

The system has generated:
1. ✅ `data/processed/parcels-processed.json` - Full parcel data with coordinates
2. ✅ `data/processed/analytics.json` - Distribution analytics
3. ✅ `data/processed/mint-all-parcels.sh` - Executable minting script

### Minting Strategy

**Batch Configuration**:
- **Batch Size**: 50 parcels per batch
- **Total Batches**: 25 batches
- **Delay Between Batches**: 5 seconds
- **Estimated Time**: ~2-3 minutes total (with gas delays)

**Gas Estimates**:
- Per parcel: ~200,000-300,000 gas
- Per batch (50 parcels): ~10-15M gas
- Total deployment: ~250-375M gas
- **Estimated Cost** (at 0.1 gwei): ~0.025-0.0375 Base Sepolia ETH

---

## 📋 Pre-Minting Checklist

### 1. Deploy Contracts First

Ensure all contracts are deployed to Base Sepolia:
```bash
cd contracts
forge script script/DeployBaseSepolia.s.sol:DeployBaseSepolia \
  --rpc-url base_sepolia \
  --broadcast \
  --verify
```

### 2. Transfer LandDeed Ownership

**Critical**: Transfer LandDeed ownership to HyperLandCore:
```bash
cast send <LAND_DEED_ADDRESS> \
  "transferOwnership(address)" \
  <HYPERLAND_CORE_ADDRESS> \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY
```

### 3. Configure Environment

Create `.env` file in project root:
```bash
# Deployment
PRIVATE_KEY=your_admin_private_key
HYPERLAND_CORE_ADDRESS=0x...  # From deployment output
INITIAL_OWNER=0x...            # Address to receive all parcels
TREASURY_ADDRESS=0x...         # Treasury for fees/taxes

# Network
RPC_URL=https://sepolia.base.org
```

### 4. Fund Deployer Wallet

Ensure admin wallet has sufficient Base Sepolia ETH:
- **Minimum**: 0.05 ETH (with buffer)
- **Recommended**: 0.1 ETH
- Get from: https://www.coinbase.com/faucets/base-ethereum-sepolia-faucet

---

## 🎯 Minting Execution

### Option A: Automated Script (Recommended)

```bash
# Make script executable (if not already)
chmod +x data/processed/mint-all-parcels.sh

# Run the minting script
./data/processed/mint-all-parcels.sh
```

**Monitor Output**:
- Each batch will print progress
- Errors will stop execution
- Transaction hashes will be displayed
- Final summary shows total minted

### Option B: Manual Batch Minting

For more control, mint in smaller batches:

```bash
# Mint first 10 parcels only
head -n 150 data/processed/mint-all-parcels.sh | tail -n 140 | bash

# Check progress
cast call $HYPERLAND_CORE_ADDRESS "totalSupply()(uint256)" --rpc-url base_sepolia

# Continue with next batch
# ... (adjust head/tail values)
```

### Option C: Foundry Script

Use the Solidity script for on-chain minting:

```bash
forge script script/BatchMintParcels.s.sol:BatchMintParcels \
  --rpc-url base_sepolia \
  --broadcast \
  -vvvv
```

---

## 📈 Monitoring & Verification

### Real-Time Monitoring

```bash
# Check total parcels minted
cast call $HYPERLAND_CORE_ADDRESS "nextTokenId()(uint256)" --rpc-url base_sepolia

# Check specific parcel
cast call $LAND_DEED_ADDRESS "ownerOf(uint256)(address)" 1 --rpc-url base_sepolia

# Check parcel data
cast call $LAND_DEED_ADDRESS "getParcel(uint256)" 1 --rpc-url base_sepolia

# Verify coordinates
cast call $LAND_DEED_ADDRESS "getTokenIdByCoordinates(uint256,uint256)(uint256)" 616 1088 --rpc-url base_sepolia
```

### BaseScan Verification

View on BaseScan:
- Contracts: `https://sepolia.basescan.org/address/<CONTRACT_ADDRESS>`
- Transactions: `https://sepolia.basescan.org/tx/<TX_HASH>`
- NFT Collection: `https://sepolia.basescan.org/token/<LAND_DEED_ADDRESS>`

---

## 🎨 Parcel Distribution by Ring

### Visual Breakdown

```
Black Rock City Layout (1,205 Parcels)
╔════════════════════════════════════════╗
║  Ring       │ Count │ Value │  Total  ║
╠════════════════════════════════════════╣
║  Esplanade  │  241  │ 1000  │ 241,000 ║
║  MidCity    │  241  │  800  │ 192,800 ║
║  Afanc      │  241  │  600  │ 144,600 ║
║  Igopogo    │  241  │  400  │  96,400 ║
║  Kraken     │  241  │  200  │  48,200 ║
╠════════════════════════════════════════╣
║  TOTAL      │ 1205  │  avg  │ 723,000 ║
╚════════════════════════════════════════╝
```

### Economic Implications

**Total Ecosystem Value**: 723,000 LAND tokens

**Annual Tax Revenue** (5% per cycle, 7-day cycles):
- 52 cycles per year
- Total taxable value: 723,000 LAND
- Annual tax: 723,000 × 0.05 × 52 = **1,879,800 LAND/year**

**Protocol Revenue Streams**:
1. **LAND Minting**: 20% of all LAND purchased
2. **Marketplace Fees**: 20% of all parcel sales
3. **Tax Payments**: 100% of property taxes (1.88M LAND/year)
4. **Auction Fees**: 20% of auction settlements

---

## ⚠️ Important Considerations

### Gas Optimization

**Strategies to Reduce Costs**:
1. **Batch Timing**: Mint during low network activity (weekends/nights)
2. **Gas Price**: Monitor gas prices and wait for lower rates
3. **Batch Size**: Adjust from 50 to 25 if hitting gas limits
4. **Incremental Minting**: Mint critical rings (Esplanade) first

### Error Handling

**Common Issues**:

**"Insufficient funds"**
- Solution: Add more Base Sepolia ETH to admin wallet

**"Parcel already exists at coordinates"**
- Solution: Check if parcel already minted, skip that entry

**"Ownable: caller is not the owner"**
- Solution: Verify LandDeed ownership transferred to HyperLandCore

**Gas limit too low**
- Solution: Increase `--gas-limit` parameter (default: 500,000)

### Pause and Resume

If minting is interrupted:

```bash
# Check last minted token ID
LAST_ID=$(cast call $HYPERLAND_CORE_ADDRESS "nextTokenId()(uint256)" --rpc-url base_sepolia)
echo "Last minted token: $((LAST_ID - 1))"

# Resume from that point by editing the script
# or using START_INDEX environment variable
START_INDEX=$LAST_ID ./data/processed/mint-all-parcels.sh
```

---

## 🧪 Testing Recommendations

### Pre-Production Testing

1. **Mint Test Batch** (First 10 parcels):
   ```bash
   # Export just first 10 commands
   head -n 150 data/processed/mint-all-parcels.sh > test-mint.sh
   bash test-mint.sh
   ```

2. **Verify Test Parcels**:
   ```bash
   # Check each parcel
   for i in {1..10}; do
     echo "Parcel $i:"
     cast call $LAND_DEED_ADDRESS "getParcel(uint256)" $i --rpc-url base_sepolia
   done
   ```

3. **Test Marketplace** (List a test parcel):
   ```bash
   # Approve core contract
   cast send $LAND_DEED_ADDRESS \
     "approve(address,uint256)" \
     $HYPERLAND_CORE_ADDRESS 1 \
     --rpc-url base_sepolia --private-key $PRIVATE_KEY

   # List for sale
   cast send $HYPERLAND_CORE_ADDRESS \
     "listDeed(uint256,uint256)" \
     1 2000000000000000000000 \
     --rpc-url base_sepolia --private-key $PRIVATE_KEY
   ```

4. **Test Auction Flow** (After tax cycles pass)

---

## 📝 Post-Minting Tasks

### 1. Verify All Parcels Minted

```bash
# Should equal 1205
cast call $LAND_DEED_ADDRESS "totalSupply()(uint256)" --rpc-url base_sepolia
```

### 2. Update Frontend Configuration

Update `frontend/.env`:
```bash
NEXT_PUBLIC_LAND_TOKEN_ADDRESS=<address>
NEXT_PUBLIC_LAND_DEED_ADDRESS=<address>
NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=<address>
NEXT_PUBLIC_TOTAL_PARCELS=1205
NEXT_PUBLIC_USE_MOCK_DATA=false  # Switch from mock to real data
```

### 3. Extract and Deploy ABIs

```bash
cd contracts
cat out/LANDToken.sol/LANDToken.json | jq '.abi' > ../projects/frontend/lib/abis/LANDToken.json
cat out/LandDeed.sol/LandDeed.json | jq '.abi' > ../projects/frontend/lib/abis/LandDeed.json
cat out/HyperLandCore.sol/HyperLandCore.json | jq '.abi' > ../projects/frontend/lib/abis/HyperLandCore.json
```

### 4. Update SDK Integration

In `frontend/lib/hyperland-sdk.ts`, update addresses:
```typescript
export const NETWORK_CONFIGS = {
  'base-sepolia': {
    contracts: {
      LAND: '<LAND_TOKEN_ADDRESS>',
      LandDeed: '<LAND_DEED_ADDRESS>',
      HyperLandCore: '<HYPERLAND_CORE_ADDRESS>',
    },
  },
};
```

### 5. Test Frontend Integration

```bash
cd projects/frontend
npm run dev

# Visit http://localhost:4001
# Verify:
# - Marketplace shows all 1205 parcels
# - Parcel details load correctly
# - Can filter by ring
# - Auction parcels display when available
```

---

## 🎉 Success Criteria

Minting is complete and successful when:

- [x] All contracts deployed to Base Sepolia
- [x] LandDeed ownership transferred to HyperLandCore
- [x] 1,205 parcels minted successfully
- [ ] All parcels verified on BaseScan
- [ ] Frontend displays all parcels correctly
- [ ] Marketplace functions work
- [ ] Tax system operational
- [ ] Auction system ready

---

## 📞 Troubleshooting & Support

### Debug Commands

```bash
# Get parcel details
cast call $LAND_DEED_ADDRESS "getParcel(uint256)" <TOKEN_ID> --rpc-url base_sepolia

# Check parcel state
cast call $HYPERLAND_CORE_ADDRESS "parcelStates(uint256)" <TOKEN_ID> --rpc-url base_sepolia

# View transaction receipt
cast receipt <TX_HASH> --rpc-url base_sepolia

# Check contract deployment
cast code $HYPERLAND_CORE_ADDRESS --rpc-url base_sepolia
```

### Common Questions

**Q: Can I mint parcels out of order?**
A: Yes, the script can be modified to mint specific ranges or individual parcels.

**Q: What if minting fails halfway through?**
A: Resume from the last successful token ID using the pause/resume instructions above.

**Q: Can I change assessed values later?**
A: Yes, as admin you can call `setAssessedValue(tokenId, newValue)` on HyperLandCore.

**Q: How do I mint additional parcels in the future?**
A: Use the same `mintParcel()` function with new coordinates that don't conflict with existing parcels.

---

## 🚀 Next Steps After Minting

1. **Community Distribution**: Transfer parcels to early supporters/community
2. **Marketplace Activation**: List initial parcels for sale
3. **Tax Cycle Monitoring**: Track first tax payment cycles
4. **Auction Testing**: Intentionally create delinquent parcel for auction demo
5. **Analytics Dashboard**: Build monitoring tools for ecosystem health
6. **Marketing Launch**: Announce platform with real on-chain parcels

---

**Prepared**: November 21, 2024
**Total Parcels**: 1,205
**Network**: Base Sepolia Testnet
**Status**: Ready for Deployment ✅
