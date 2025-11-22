# HyperLand Mainnet Integration & Market Launch Plan

## 🎯 Objective
Connect frontend to Base Mainnet contracts, establish LAND token liquidity, and target $1M market cap.

## 📋 Current State Analysis

### Deployed Contracts (Base Mainnet)
- **LAND Token**: `0x919e6e2b36b6944F52605bC705Ff609AFcb7c797`
- **LandDeed NFT**: `0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf`
- **HyperLandCore**: `0xB22b072503a381A2Db8309A8dD46789366D55074`
- **Total Supply**: 21,000,000 LAND tokens
- **Current State**: Tokens deployed but NO liquidity pool exists

### Frontend Status
- ✅ All routes built (6 pages)
- ✅ Mock mode fully functional
- ❌ **ALL blockchain interactions use TODO placeholders**
- ❌ No real contract integration
- ❌ No price feeds
- ❌ No liquidity pool integration

## 🚀 Implementation Phases

### Phase 1: Real Blockchain Integration (Days 1-2)

#### Task 1.1: Update Environment Configuration
**File**: `projects/frontend/.env.local`
```env
# Enable mainnet mode
NEXT_PUBLIC_NETWORK=base-mainnet
NEXT_PUBLIC_CHAIN_ID=8453
NEXT_PUBLIC_RPC_URL=https://mainnet.base.org

# Contract addresses
NEXT_PUBLIC_LAND_TOKEN_ADDRESS=0x919e6e2b36b6944F52605bC705Ff609AFcb7c797
NEXT_PUBLIC_LAND_DEED_ADDRESS=0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf
NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS=0xB22b072503a381A2Db8309A8dD46789366D55074

# Liquidity pool (TBD after creation)
NEXT_PUBLIC_LP_POOL_ADDRESS=0x...
NEXT_PUBLIC_DEX_ROUTER=0x... # Aerodrome or Uniswap V3
```

#### Task 1.2: Wire Up Real Contract Calls
**Files to Update**:
1. `lib/hyperland-context.tsx` - Replace ALL mock calls
2. `lib/hyperland-sdk.ts` - Implement real contract interactions
3. `app/buy-land/page.tsx` - Real LAND token purchase

**Implementation Pattern**:
```typescript
// OLD (Mock):
if (isMockMode) {
  mockState.buyLAND(address, ethAmount);
} else {
  throw new Error('Blockchain transactions not yet implemented');
}

// NEW (Real):
import { useWriteContract, useReadContract } from 'wagmi';
import { parseEther } from 'viem';
import { LAND_ABI } from '@/lib/abis';

// Read LAND balance
const { data: balance } = useReadContract({
  address: process.env.NEXT_PUBLIC_LAND_TOKEN_ADDRESS,
  abi: LAND_ABI,
  functionName: 'balanceOf',
  args: [address],
});

// Buy LAND tokens (via LP pool)
const { writeContract } = useWriteContract();
await writeContract({
  address: lpPoolAddress,
  abi: ROUTER_ABI,
  functionName: 'swapExactETHForTokens',
  args: [minAmountOut, [WETH, LAND], address, deadline],
  value: parseEther(ethAmount),
});
```

### Phase 2: Liquidity Pool Setup (Day 2-3)

#### Option A: Aerodrome Finance (Recommended for Base)
- **Why**: Official Base DEX, better liquidity incentives
- **Pool Type**: Volatile pool (LAND/WETH)
- **Router**: `0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43`

#### Option B: Uniswap V3 (Alternative)
- **Pool Type**: 0.3% fee tier
- **Router**: Base Uniswap V3 Router

#### Initial Liquidity Calculation (Target: $1M Market Cap)
**Assumptions**:
- Initial LAND price: $0.0476 (21M supply @ $1M cap)
- Starting liquidity: ~$50K-$100K
- Pair: LAND/WETH on Base

**Example Initial Pool**:
```
Option 1: Conservative
- 500,000 LAND (~$23,800 @ $0.0476)
- 10 ETH (~$23,800 @ $2,380/ETH)
- Total Liquidity: ~$47,600
- Market Cap Impact: ~5% of supply

Option 2: Moderate
- 1,000,000 LAND (~$47,600 @ $0.0476)
- 20 ETH (~$47,600 @ $2,380/ETH)
- Total Liquidity: ~$95,200
- Market Cap Impact: ~10% of supply

Option 3: Aggressive
- 2,100,000 LAND (~$100,000 @ $0.0476)
- 42 ETH (~$100,000 @ $2,380/ETH)
- Total Liquidity: ~$200,000
- Market Cap Impact: ~10% of supply
```

**Recommended**: Start with Option 2 (Moderate) for balanced liquidity.

#### Task 2.1: Create Liquidity Pool
**Steps**:
1. Approve LAND tokens for router contract
2. Call `addLiquidityETH` on Aerodrome Router
3. Receive LP tokens
4. Verify pool creation on BaseScan

**Script** (`scripts/create-liquidity-pool.ts`):
```typescript
import { ethers } from 'ethers';

const AERODROME_ROUTER = '0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43';
const LAND_TOKEN = '0x919e6e2b36b6944F52605bC705Ff609AFcb7c797';
const WETH = '0x4200000000000000000000000000000000000006'; // Base WETH

async function createPool() {
  // 1. Approve LAND
  await landToken.approve(AERODROME_ROUTER, parseEther('1000000'));

  // 2. Add liquidity
  const tx = await router.addLiquidityETH(
    LAND_TOKEN,                    // token
    parseEther('1000000'),         // amountTokenDesired (1M LAND)
    parseEther('950000'),          // amountTokenMin (5% slippage)
    parseEther('19'),              // amountETHMin (20 ETH - 5%)
    deployerAddress,               // to
    Math.floor(Date.now() / 1000) + 1800, // deadline (30 min)
    { value: parseEther('20') }    // 20 ETH
  );

  console.log('Pool created:', tx.hash);
}
```

### Phase 3: Price Feed Integration (Day 3-4)

#### Task 3.1: Add Price Oracle Service
**File**: `lib/services/price-oracle.ts`
```typescript
import { useReadContract } from 'wagmi';

export function useLandPrice() {
  // Get LAND/WETH price from Aerodrome pool
  const { data: reserves } = useReadContract({
    address: LP_POOL_ADDRESS,
    abi: PAIR_ABI,
    functionName: 'getReserves',
  });

  // Calculate price: (WETH reserve / LAND reserve) * ETH price
  const landPriceInETH = reserves[1] / reserves[0];
  const ethPriceUSD = await fetchETHPrice(); // From Coinbase/Kraken API

  return {
    landPriceUSD: landPriceInETH * ethPriceUSD,
    landPriceETH: landPriceInETH,
    marketCap: landPriceUSD * 21_000_000,
    liquidity: (reserves[0] * landPriceUSD) + (reserves[1] * ethPriceUSD),
  };
}
```

#### Task 3.2: Update Buy/Sell Interface
**File**: `app/buy-land/page.tsx`
```typescript
const { landPriceUSD, landPriceETH, marketCap } = useLandPrice();

// Real-time pricing
<div className="price-display">
  <div>LAND Price: ${landPriceUSD.toFixed(4)}</div>
  <div>Market Cap: ${(marketCap / 1_000_000).toFixed(2)}M</div>
  <div>24h Volume: ${volume24h.toLocaleString()}</div>
</div>

// Dynamic exchange rate (not fixed 1:1000)
const landToReceive = ethAmount
  ? (parseFloat(ethAmount) / landPriceETH * 0.98) // 2% slippage
  : '0';
```

### Phase 4: Trading Interface (Day 4-5)

#### Task 4.1: Enhanced Buy Interface
**Features**:
- Real-time price updates (every 10s)
- Slippage tolerance settings (0.5%, 1%, 2%, custom)
- Price impact calculator
- Gas estimation
- Transaction preview

#### Task 4.2: Sell Interface
**New Page**: `app/sell-land/page.tsx`
```typescript
export default function SellLand() {
  const { writeContract } = useWriteContract();

  async function sellLAND(landAmount: string) {
    // 1. Approve router
    await landToken.approve(ROUTER_ADDRESS, parseEther(landAmount));

    // 2. Swap LAND for ETH
    await router.swapExactTokensForETH(
      parseEther(landAmount),      // amountIn
      minETHOut,                   // amountOutMin (slippage)
      [LAND, WETH],                // path
      address,                     // to
      deadline                     // deadline
    );
  }

  return (
    <div className="sell-interface">
      <input type="number" value={landAmount} />
      <div>You receive: {ethToReceive} ETH</div>
      <div>Price impact: {priceImpact}%</div>
      <button onClick={() => sellLAND(landAmount)}>
        Sell LAND
      </button>
    </div>
  );
}
```

### Phase 5: Market Cap Dashboard (Day 5)

#### Task 5.1: Add Market Stats Widget
**Component**: `components/MarketStats.tsx`
```typescript
export function MarketStats() {
  const { landPriceUSD, marketCap, liquidity } = useLandPrice();
  const { data: totalSupply } = useReadContract({
    address: LAND_TOKEN,
    abi: LAND_ABI,
    functionName: 'totalSupply',
  });

  return (
    <div className="market-stats">
      <StatCard
        title="Market Cap"
        value={`$${(marketCap / 1_000_000).toFixed(2)}M`}
        target="$1.00M"
        progress={(marketCap / 1_000_000) * 100}
      />
      <StatCard title="LAND Price" value={`$${landPriceUSD.toFixed(4)}`} />
      <StatCard title="Total Liquidity" value={`$${(liquidity / 1000).toFixed(1)}K`} />
      <StatCard title="Circulating Supply" value={`${(totalSupply / 1e18).toLocaleString()} LAND`} />
    </div>
  );
}
```

## 🎯 Market Cap Strategy

### Target: $1M Market Cap

**Path 1: Organic Growth**
- Initial LP: $100K → Market cap starts ~$200K-$300K
- Community building + parcel sales
- Gradual price appreciation
- Timeline: 2-3 months

**Path 2: Aggressive Liquidity**
- Initial LP: $200K → Market cap starts ~$400K-$500K
- Marketing campaign
- Strategic partnerships
- Timeline: 1-2 months

**Path 3: Treasury Strategy**
- Use protocol treasury (20% fees) to buy back LAND
- Increase LP gradually over time
- Sustainable growth model
- Timeline: 3-6 months

### Recommended Approach: Hybrid
1. **Week 1**: Create moderate pool ($100K liquidity)
2. **Week 2-4**: Focus on parcel sales and utility
3. **Month 2**: Use accumulated fees to increase liquidity
4. **Month 3**: Marketing push toward $1M cap

## 📈 Success Metrics

- [ ] LAND token tradeable on DEX
- [ ] Real-time price displayed on all pages
- [ ] Buy/sell functionality working
- [ ] Market cap tracking dashboard
- [ ] Liquidity > $50K
- [ ] Daily volume > $5K
- [ ] Market cap trajectory toward $1M
- [ ] Zero critical bugs in production

## ⚠️ Risk Mitigation

1. **Smart Contract Risk**: Contracts already audited and deployed
2. **Liquidity Risk**: Start with moderate pool, expand gradually
3. **Price Volatility**: Implement slippage protection
4. **Rug Pull Prevention**: LP tokens locked/burned
5. **Front-running**: Use private RPC for sensitive txs

## 🔄 Next Immediate Steps

1. ✅ Audit complete - documented here
2. ⏭️ Create `.env.local` with mainnet config
3. ⏭️ Implement real contract calls in `hyperland-context.tsx`
4. ⏭️ Deploy liquidity pool with moderate capital
5. ⏭️ Wire up price feeds
6. ⏭️ Test buy/sell on mainnet
7. ⏭️ Deploy to production
8. ⏭️ Monitor and iterate
