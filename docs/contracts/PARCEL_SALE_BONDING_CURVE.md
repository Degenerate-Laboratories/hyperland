# ParcelSale with Bonding Curve & Auto-Liquidity

Complete guide for deploying and using the ParcelSaleWithLiquidity contract with automated bonding curve pricing and protocol-owned liquidity creation.

## 🎯 Strategy Overview

### What Happens When Someone Buys a Parcel?

**Single Transaction, Multiple Actions:**

1. **User pays ETH** → Price determined by bonding curve
2. **50% of ETH** → Market buy LAND tokens from BaseSwap
3. **50% ETH + LAND** → Added as liquidity to LAND/WETH pool
4. **LP tokens** → Automatically burned (sent to dead address)
5. **Parcel NFT** → Minted to buyer

**Result:** Every parcel sale creates permanent, protocol-owned liquidity!

## 📈 Bonding Curve Pricing

### Linear Bonding Curve

```
price = startPrice + (soldCount × priceIncrement)
```

**Default Parameters:**
- **Start Price:** 0.001 ETH (1st parcel)
- **Price Increment:** 0.0001 ETH per sale
- **Max Price:** 0.01 ETH (price cap)

### Example Pricing

| Parcel # | Price (ETH) | USD @ $2,400 |
|----------|-------------|--------------|
| 1        | 0.001       | $2.40        |
| 10       | 0.0019      | $4.56        |
| 25       | 0.0034      | $8.16        |
| 50       | 0.0059      | $14.16       |
| 90       | 0.0099      | $23.76       |
| 100+     | 0.01 (cap)  | $24.00       |

### Benefits

✅ **Fair pricing** - Early adopters get lower prices
✅ **Predictable** - Users know exactly what they'll pay
✅ **Revenue growth** - Later sales generate more liquidity
✅ **Price discovery** - Market finds natural equilibrium
✅ **Scarcity premium** - Drives urgency as price increases

## 🚀 Deployment

### Prerequisites

```bash
# Ensure you have deployed:
# 1. HyperLandCore contract
# 2. LAND token contract
# 3. LAND/WETH pool on BaseSwap (or will create it)

# Set environment variables in contracts/.env.deploy
PRIVATE_KEY=your_private_key
MAINNET_HYPERLAND_CORE=0x...
MAINNET_LAND_TOKEN=0x...
```

### Step 1: Deploy Contract

```bash
cd contracts
forge script script/DeployParcelSaleWithLiquidity.s.sol:DeployParcelSaleWithLiquidity \
  --rpc-url https://mainnet.base.org \
  --broadcast \
  --verify
```

**Output:**
```
ParcelSaleWithLiquidity: 0x...
Pool: 0x...

Bonding Curve Pricing:
Parcel 1: 0.001 ETH
Parcel 10: 0.0019 ETH
Parcel 50: 0.0059 ETH
Parcel 100+: 0.01 ETH (capped)
```

### Step 2: Add Parcels

**No prices needed!** The bonding curve determines pricing automatically.

```bash
# Using cast (for testing)
cast send $PARCEL_SALE \
  "addParcelsBatch(uint256[],uint256[],uint256[],uint256[])" \
  "[1,2,3]" \
  "[100,101,102]" \
  "[100,100,100]" \
  "[1,1,1]" \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

Or create a batch script (recommended):

```typescript
// scripts/add-parcels-batch.ts
import parcels from './parcels.json';

const parcelNumbers = parcels.map(p => p.id);
const xs = parcels.map(p => p.x);
const ys = parcels.map(p => p.y);
const sizes = parcels.map(p => p.size);

await contract.addParcelsBatch(parcelNumbers, xs, ys, sizes);
```

### Step 3: Set Pool Address (if not auto-set)

```bash
cast send $PARCEL_SALE \
  "setPool(address)" \
  $POOL_ADDRESS \
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

## 📱 Frontend Integration

### Buy Parcel - Single Transaction UX

```typescript
import { parseEther } from 'viem';

// 1. Get current price from bonding curve
const currentPrice = await contract.read.getCurrentPrice();

// 2. Purchase parcel - ONE transaction!
const tx = await contract.write.purchaseParcel(
  [parcelNumber],
  { value: currentPrice }
);

// Behind the scenes (all automatic):
// ✅ 50% ETH → Buy LAND
// ✅ 50% ETH + LAND → Add liquidity
// ✅ LP tokens → Burned
// ✅ Parcel NFT → Minted to user
```

### Display Current Price

```typescript
// Show current price to users
const currentPrice = await contract.read.getCurrentPrice();
const nextPrice = currentPrice + priceIncrement;

console.log(`Current price: ${formatEther(currentPrice)} ETH`);
console.log(`Next price: ${formatEther(nextPrice)} ETH`);
```

### Show Bonding Curve Stats

```typescript
const stats = await contract.read.getStats();

const [
  totalParcels,
  soldCount,
  availableCount,
  totalETHCollected,
  totalLiquidityCreated,
  totalLPBurned
] = stats;

console.log({
  sold: soldCount,
  available: availableCount,
  ethCollected: formatEther(totalETHCollected),
  lpBurned: formatEther(totalLPBurned),
  currentPrice: formatEther(await contract.read.getCurrentPrice())
});
```

## 🔧 Configuration

### Update Bonding Curve (Owner Only)

You can adjust the bonding curve parameters anytime:

```bash
cast send $PARCEL_SALE \
  "updateBondingCurve(uint256,uint256,uint256)" \
  "1000000000000000" \    # 0.001 ETH start
  "100000000000000" \      # 0.0001 ETH increment
  "10000000000000000" \    # 0.01 ETH max
  --rpc-url https://mainnet.base.org \
  --private-key $PRIVATE_KEY
```

## 📊 Monitoring

### Check Liquidity Growth

```bash
# Total LP burned (protocol-owned liquidity)
cast call $PARCEL_SALE "totalLPBurned()" --rpc-url https://mainnet.base.org

# Total ETH collected
cast call $PARCEL_SALE "totalETHCollected()" --rpc-url https://mainnet.base.org

# Current price
cast call $PARCEL_SALE "getCurrentPrice()" --rpc-url https://mainnet.base.org
```

### View Pool Reserves

```bash
# Check pool growth on BaseScan
# https://basescan.org/address/$POOL_ADDRESS

# Or via cast
cast call $POOL "getReserves()" --rpc-url https://mainnet.base.org
```

## 🎨 Frontend Example Component

```typescript
export function ParcelPurchase({ parcelNumber }: { parcelNumber: number }) {
  const [currentPrice, setCurrentPrice] = useState(0n);
  const [soldCount, setSoldCount] = useState(0);

  useEffect(() => {
    // Get current price
    const price = await contract.read.getCurrentPrice();
    setCurrentPrice(price);

    // Get sold count for UI
    const stats = await contract.read.getStats();
    setSoldCount(Number(stats[1]));
  }, []);

  const handlePurchase = async () => {
    // Single transaction purchase
    const tx = await contract.write.purchaseParcel(
      [parcelNumber],
      { value: currentPrice }
    );

    await tx.wait();

    // Success! User now owns parcel + liquidity was auto-created
  };

  return (
    <div>
      <h3>Parcel #{parcelNumber}</h3>
      <p>Current Price: {formatEther(currentPrice)} ETH</p>
      <p>Parcels Sold: {soldCount} / 1205</p>
      <p className="text-sm text-gray-500">
        Next parcel: {formatEther(currentPrice + priceIncrement)} ETH
      </p>
      <button onClick={handlePurchase}>
        Buy Now
      </button>
      <div className="text-xs mt-2">
        ✨ Auto-creates liquidity + burns LP tokens
      </div>
    </div>
  );
}
```

## 🔐 Security Features

### Built-in Protections

✅ **ReentrancyGuard** - Prevents reentrancy attacks
✅ **CEI Pattern** - Checks-Effects-Interactions for safe state updates
✅ **Ownable** - Only owner can add parcels and configure
✅ **Price validation** - Users must send exact bonding curve price
✅ **Pool validation** - Pool must be set before purchases

### Emergency Functions

```solidity
// Emergency withdrawal (owner only, for stuck funds)
emergencyWithdrawETH(address to, uint256 amount)
emergencyWithdrawTokens(address token, address to, uint256 amount)
```

## 📈 Economics

### Revenue Distribution Per Sale

For a 0.005 ETH sale:

1. **0.0025 ETH** → Market buy LAND tokens
2. **0.0025 ETH + LAND** → Added as liquidity
3. **LP tokens** → Permanently burned

### Protocol-Owned Liquidity Benefits

✅ **Permanent liquidity** - Can never be withdrawn
✅ **No mercenary capital** - No risk of liquidity providers dumping
✅ **Growing over time** - Every sale increases POL
✅ **Price stability** - Deeper liquidity = less slippage
✅ **Investor confidence** - Locked liquidity attracts buyers

## 🎯 Success Metrics

Track these to measure success:

1. **Total LP Burned** - Growing POL
2. **Current Price** - Market demand signal
3. **Sales Velocity** - Parcels sold per day
4. **Pool Reserves** - LAND/ETH liquidity depth
5. **Average Price** - Revenue per parcel

## 🚨 Common Issues

### "Incorrect ETH amount"

**Solution:** Get current price before purchase
```typescript
const price = await contract.read.getCurrentPrice();
await contract.write.purchaseParcel([id], { value: price });
```

### "Pool not set"

**Solution:** Set pool address first
```bash
cast send $PARCEL_SALE "setPool(address)" $POOL --rpc-url ...
```

### "Parcel already sold"

**Solution:** Check availability before showing buy button
```typescript
const isAvailable = await contract.read.isAvailable(parcelNumber);
```

## 📚 Contract Reference

### Key Functions

**View Functions:**
- `getCurrentPrice()` - Get current bonding curve price
- `getParcel(uint256)` - Get parcel details + current price
- `getStats()` - Get all contract statistics
- `isAvailable(uint256)` - Check if parcel can be purchased

**User Functions:**
- `purchaseParcel(uint256) payable` - Buy parcel at current price

**Owner Functions:**
- `addParcel(uint256, uint256, uint256, uint256)` - Add single parcel
- `addParcelsBatch(uint256[], uint256[], uint256[], uint256[])` - Batch add
- `setPool(address)` - Set LP pool address
- `updateBondingCurve(uint256, uint256, uint256)` - Update pricing

## 🔗 Resources

- Contract: `contracts/src/ParcelSaleWithLiquidity.sol`
- Deployment: `contracts/script/DeployParcelSaleWithLiquidity.s.sol`
- Test Script: `scripts/test-liquidity-strategy.ts`
- BaseSwap Router: `0x327Df1E6de05895d2ab08513aaDD9313Fe505d86`
- WETH: `0x4200000000000000000000000000000000000006`

## ✅ Deployment Checklist

- [ ] Deploy HyperLandCore contract
- [ ] Deploy LAND token contract
- [ ] Create LAND/WETH pool on BaseSwap
- [ ] Deploy ParcelSaleWithLiquidity contract
- [ ] Grant MINTER_ROLE to ParcelSale
- [ ] Set pool address on ParcelSale
- [ ] Add parcels using addParcelsBatch
- [ ] Test purchase with small ETH amount
- [ ] Verify LP tokens are being burned
- [ ] Monitor pool reserves growth
- [ ] Update frontend with contract address

---

**🎉 You're ready to launch!** Every parcel sale will automatically create protocol-owned liquidity with predictable bonding curve pricing.
