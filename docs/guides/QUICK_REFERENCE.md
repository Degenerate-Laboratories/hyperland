# HyperLand V2 - Quick Reference Card

## 📍 Contract Addresses (Base Mainnet)

```bash
LAND_TOKEN=0x919e6e2b36b6944F52605bC705Ff609AFcb7c797
LAND_DEED=0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf
HYPERLAND_CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
ADMIN=0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D
RPC=https://mainnet.base.org
```

## 🚀 Common Commands

### Check Status
```bash
# Check LAND supply
cast call $LAND_TOKEN "totalSupply()(uint256)" --rpc-url $RPC

# Check your LAND balance
cast call $LAND_TOKEN "balanceOf(address)(uint256)" $YOUR_ADDRESS --rpc-url $RPC

# Check total parcels minted
cast call $LAND_DEED "totalSupply()(uint256)" --rpc-url $RPC

# Check tax cycle
cast call $HYPERLAND_CORE "taxCycleSeconds()(uint256)" --rpc-url $RPC

# Check auction duration
cast call $HYPERLAND_CORE "auctionDuration()(uint256)" --rpc-url $RPC
```

### Mint Parcel
```bash
cast send $HYPERLAND_CORE \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $OWNER_ADDRESS $X $Y $SIZE $VALUE \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

### List Parcel for Sale
```bash
# Approve NFT transfer first
cast send $LAND_DEED \
  "approve(address,uint256)" $HYPERLAND_CORE $PARCEL_ID \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# List parcel
cast send $HYPERLAND_CORE \
  "listDeed(uint256,uint256)" $PARCEL_ID $PRICE \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

### Buy Parcel
```bash
# Approve LAND spending first
cast send $LAND_TOKEN \
  "approve(address,uint256)" $HYPERLAND_CORE $AMOUNT \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# Buy parcel
cast send $HYPERLAND_CORE \
  "buyDeed(uint256)" $PARCEL_ID \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

### Pay Taxes
```bash
# Pay current taxes
cast send $HYPERLAND_CORE \
  "payTax(uint256)" $PARCEL_ID \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# Pay taxes in advance (V2 feature)
cast send $HYPERLAND_CORE \
  "payTaxesInAdvance(uint256,uint256)" $PARCEL_ID $CYCLES \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

## 📊 BaseScan Links

- **LAND**: https://basescan.org/token/0x919e6e2b36b6944f52605bc705ff609afcb7c797
- **Deeds**: https://basescan.org/address/0x28f5b7a911f61e875caaa16819211bf25dca0adf
- **Core**: https://basescan.org/address/0xb22b072503a381a2db8309a8dd46789366d55074

## ⚙️ System Parameters

- Protocol Fee: **20%**
- Tax Rate: **5% per cycle**
- Tax Cycle: **7 days** (604800 sec)
- Auction Duration: **15 min** ⚠️ (needs update to 3 days)
- Lien Grace: **3 cycles** (21 days)

## 🔑 Admin Functions

```bash
# Set auction duration to 3 days (REMAINING TASK)
cast send $HYPERLAND_CORE \
  "setAuctionDuration(uint256)" 259200 \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# Register assessor
cast send $HYPERLAND_CORE \
  "registerAssessor(address,string)" \
  $ASSESSOR_ADDRESS "ipfs://credentials" \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# Pause contract (emergency)
cast send $HYPERLAND_CORE "pause()" \
  --rpc-url $RPC --private-key $PRIVATE_KEY

# Unpause contract
cast send $HYPERLAND_CORE "unpause()" \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

## 📦 BRC Coordinate Transform

```typescript
// BRC coordinates → Blockchain coordinates
const OFFSET = 10000;
const chainX = brcX + OFFSET;
const chainY = brcY + OFFSET;

// Example: BRC (616, 1088) → Blockchain (10616, 11088)
```

## 🎯 Quick Test

```bash
# Test mint single parcel at BRC coordinates (616, 1088)
cast send $HYPERLAND_CORE \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $ADMIN 10616 11088 100 1000000000000000000000 \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

---

**Status**: ✅ Live on Base Mainnet
**Version**: 2.0
**Last Updated**: Nov 21, 2025
