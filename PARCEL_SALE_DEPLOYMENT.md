# 🎉 ParcelSale with Bonding Curve - Deployed!

**Deployment Date:** November 22, 2025
**Network:** Base Mainnet

---

## ✅ Deployed Contracts

### ParcelSaleWithLiquidity
**Address:** `0xc5428954d2F75a6602fe10CDd4157B17f91A7598`

**Features:**
- ✅ Bonding curve pricing (0.001 → 0.01 ETH)
- ✅ Automatic liquidity creation (50% market buy + 50% LP)
- ✅ Automatic LP token burning (protocol-owned liquidity)
- ✅ Connected to BaseSwap pool: `0x035877E50562f11daC3D158a3485eBEc89A4B707`

### HyperLandCore (Upgraded)
**Address:** `0x70fafeFDC236E2b4bF3F13b0c11cf6Fad9E2665F`

**Updates:**
- ✅ Added authorized minter system
- ✅ ParcelSale contract authorized as minter
- ✅ Maintains all original HyperLand functionality

---

## 🔗 Contract Addresses Summary

| Contract | Address | Status |
|----------|---------|--------|
| **ParcelSaleWithLiquidity** | `0xc5428954d2F75a6602fe10CDd4157B17f91A7598` | ✅ Active |
| **HyperLandCore (NEW)** | `0x70fafeFDC236E2b4bF3F13b0c11cf6Fad9E2665F` | ✅ Active |
| **HyperLandCore (OLD)** | `0xB22b072503a381A2Db8309A8dD46789366D55074` | ⚠️ Deprecated |
| **LAND Token** | `0x919e6e2b36b6944F52605bC705Ff609AFcb7c797` | ✅ Unchanged |
| **LandDeed NFT** | `0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf` | ✅ Unchanged |
| **BaseSwap Pool** | `0x035877E50562f11daC3D158a3485eBEc89A4B707` | ✅ Active |
| **BaseSwap Router** | `0x327Df1E6de05895d2ab08513aaDD9313Fe505d86` | ✅ Active |
| **WETH** | `0x4200000000000000000000000000000000000006` | ✅ Base Native |

---

## 📈 Bonding Curve Pricing

**Formula:** `price = startPrice + (soldCount × increment)`

**Parameters:**
- Start Price: 0.001 ETH
- Price Increment: 0.0001 ETH per sale
- Max Price: 0.01 ETH (capped)

**Example Prices:**
| Parcel # | Price (ETH) | USD @ $2,400/ETH |
|----------|-------------|------------------|
| 1        | 0.001       | $2.40            |
| 10       | 0.0019      | $4.56            |
| 50       | 0.0059      | $14.16           |
| 100+     | 0.01 (cap)  | $24.00           |

---

## ⚠️ CRITICAL: Manual Step Required

**Transfer LandDeed Ownership:**

The LandDeed contract still points to the old HyperLandCore. You need to transfer ownership:

```bash
cast send 0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf \
  "transferOwnership(address)" \
  0x70fafeFDC236E2b4bF3F13b0c11cf6Fad9E2665F \
  --rpc-url https://mainnet.base.org \
  --private-key $OWNER_PRIVATE_KEY
```

**Who can do this:** Current LandDeed owner (likely the old HyperLandCore or deployer)

---

## 🎨 Frontend Integration

### Update Environment Variables

Update `projects/frontend/.env.local`:

```bash
# OLD (deprecated)
# NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=0xB22b072503a381A2Db8309A8dD46789366D55074

# NEW (use this)
NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=0x70fafeFDC236E2b4bF3F13b0c11cf6Fad9E2665F
NEXT_PUBLIC_PARCEL_SALE_ADDRESS=0xc5428954d2F75a6602fe10CDd4157B17f91A7598
```

### Purchase Flow (Single Transaction!)

```typescript
import { parseEther } from 'viem';

// 1. Get current price
const currentPrice = await parcelSaleContract.read.getCurrentPrice();

// 2. Buy parcel - ONE transaction does everything!
const tx = await parcelSaleContract.write.purchaseParcel(
  [parcelNumber],
  { value: currentPrice }
);

// Behind the scenes (automatic):
// ✅ 50% ETH → Buy LAND tokens
// ✅ 50% ETH + LAND → Add liquidity
// ✅ LP tokens → Burned
// ✅ Parcel NFT → Minted to buyer
```

---

## 🧪 Testing

### Add Test Parcels

```bash
cd /Users/highlander/gamedev/hyperland/contracts

# Add a single test parcel
cast send 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 \
  "addParcel(uint256,uint256,uint256,uint256)" \
  1 100 100 1 \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY

# Or batch add
cast send 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 \
  "addParcelsBatch(uint256[],uint256[],uint256[],uint256[])" \
  "[1,2,3]" \
  "[100,101,102]" \
  "[100,100,100]" \
  "[1,1,1]" \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

### Test Purchase

```bash
# Get current price
cast call 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 \
  "getCurrentPrice()" \
  --rpc-url https://mainnet.base.org

# Purchase parcel #1
cast send 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 \
  "purchaseParcel(uint256)" \
  1 \
  --value 0.001ether \
  --rpc-url https://mainnet.base.org \
  --private-key $BUYER_KEY
```

---

## 📊 Monitoring

### Check Stats

```bash
# Contract stats
cast call 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 "getStats()" \
  --rpc-url https://mainnet.base.org

# Current price
cast call 0xc5428954d2F75a6602fe10CDd4157B17f91A7598 "getCurrentPrice()" \
  --rpc-url https://mainnet.base.org

# Pool reserves
cast call 0x035877E50562f11daC3D158a3485eBEc89A4B707 "getReserves()" \
  --rpc-url https://mainnet.base.org
```

### View on BaseScan

- **ParcelSale:** https://basescan.org/address/0xc5428954d2F75a6602fe10CDd4157B17f91A7598
- **HyperLandCore:** https://basescan.org/address/0x70fafeFDC236E2b4bF3F13b0c11cf6Fad9E2665F
- **Pool:** https://basescan.org/address/0x035877E50562f11daC3D158a3485eBEc89A4B707

---

## ✅ Deployment Checklist

- [x] Deploy ParcelSaleWithLiquidity contract
- [x] Set pool address on ParcelSale
- [x] Deploy upgraded HyperLandCore
- [x] Authorize ParcelSale as minter
- [ ] **Transfer LandDeed ownership to new HyperLandCore** ⚠️ MANUAL STEP
- [ ] Update frontend environment variables
- [ ] Add initial parcels for sale
- [ ] Test purchase flow
- [ ] Verify LP tokens are being burned
- [ ] Monitor pool liquidity growth

---

## 🎉 How It Works

### User Journey

1. **User browses parcels** → Sees current bonding curve price
2. **User clicks "Buy"** → Sends single transaction with ETH
3. **Contract executes:**
   - Takes ETH payment at current price
   - Uses 50% to market buy LAND from BaseSwap
   - Adds remaining 50% ETH + all LAND as liquidity
   - Burns LP tokens (permanent protocol-owned liquidity)
   - Mints parcel NFT to buyer
4. **Result:** User owns parcel + protocol has more permanent liquidity!

### Economic Model

Every parcel sale:
- ✅ Increases protocol-owned liquidity (POL)
- ✅ Deepens LAND/ETH pool
- ✅ Reduces slippage for future trades
- ✅ Creates buying pressure on LAND token
- ✅ Price increases with each sale (bonding curve)

---

## 🔐 Security

- ✅ ReentrancyGuard on purchase function
- ✅ Checks-Effects-Interactions pattern
- ✅ Ownable access control
- ✅ Price validation (exact payment required)
- ✅ Pool validation before operations

---

## 📚 Resources

- Full Documentation: `/PARCEL_SALE_BONDING_CURVE.md`
- Contract Source: `/contracts/src/ParcelSaleWithLiquidity.sol`
- Deployment Script: `/contracts/script/DeployParcelSaleWithLiquidity.s.sol`
- Upgrade Script: `/contracts/script/UpgradeHyperLandCore.s.sol`

---

**🚀 Ready to launch! Just complete the manual LandDeed ownership transfer and update the frontend.**
