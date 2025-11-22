# HyperLand Marketplace Setup Guide

## Current Issue

The marketplace is trying to let users mint parcels directly, but **only the contract owner can mint**. The correct flow is:

1. **Admin mints all 1,205 parcels** to themselves
2. **Admin lists them for sale** at assessed values
3. **Users buy listed parcels** from the admin

## Solution: Mint & List All Parcels

### Prerequisites

- Admin private key with owner permissions
- Sufficient Base ETH for gas (~0.5-1 ETH for all parcels)
- HyperLandCore: `0xB22b072503a381A2Db8309A8dD46789366D55074`
- Admin Address: `0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D`

### Step 1: Mint Parcels

The admin needs to mint all 1,205 parcels. Here's a sample command:

```bash
# Set environment
export CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
export ADMIN=0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D
export RPC=https://mainnet.base.org
export PRIVATE_KEY=your_admin_private_key

# Example: Mint first Esplanade parcel (x=616, y=1088, size=100, value=1000 LAND)
cast send $CORE \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $ADMIN 616 1088 100 1000000000000000000000 \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

**Note**: The assessed value must be in Wei (1000 LAND = 1000000000000000000000 Wei)

### Step 2: List Parcels for Sale

After minting, list each parcel:

```bash
# Example: List parcel #1 for 1000 LAND
cast send $CORE \
  "listDeed(uint256,uint256)" \
  1 1000000000000000000000 \
  --rpc-url $RPC --private-key $PRIVATE_KEY
```

### Parcel Pricing by Ring

| Ring | Count | Price per Parcel | Total Value |
|------|-------|------------------|-------------|
| **Esplanade** | 241 | 1,000 LAND | 241,000 LAND |
| **MidCity** | 241 | 800 LAND | 192,800 LAND |
| **Afanc** | 241 | 600 LAND | 144,600 LAND |
| **Igopogo** | 241 | 400 LAND | 96,400 LAND |
| **Kraken** | 241 | 200 LAND | 48,200 LAND |
| **TOTAL** | **1,205** | - | **723,000 LAND** |

### Automated Minting Script

Use the existing script that's already generated:

```bash
cd /Users/highlander/gamedev/hyperland
chmod +x data/processed/mint-all-parcels.sh

# Set your private key
export PRIVATE_KEY=your_admin_private_key

# Run the minting script
./data/processed/mint-all-parcels.sh
```

### Step 3: After Minting - Create Listing Script

Once all parcels are minted, you need to list them. Here's a template:

```bash
#!/bin/bash
# list-all-parcels.sh

CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
RPC=https://mainnet.base.org

for tokenId in {1..1205}; do
  echo "Listing parcel $tokenId..."

  # Determine price based on token ID ranges
  # Parcels 1-241: Esplanade (1000 LAND)
  # Parcels 242-482: MidCity (800 LAND)
  # Parcels 483-723: Afanc (600 LAND)
  # Parcels 724-964: Igopogo (400 LAND)
  # Parcels 965-1205: Kraken (200 LAND)

  if [ $tokenId -le 241 ]; then
    price=1000000000000000000000  # 1000 LAND
  elif [ $tokenId -le 482 ]; then
    price=800000000000000000000   # 800 LAND
  elif [ $tokenId -le 723 ]; then
    price=600000000000000000000   # 600 LAND
  elif [ $tokenId -le 964 ]; then
    price=400000000000000000000   # 400 LAND
  else
    price=200000000000000000000   # 200 LAND
  fi

  cast send $CORE \
    "listDeed(uint256,uint256)" \
    $tokenId $price \
    --rpc-url $RPC --private-key $PRIVATE_KEY

  # Wait a bit between transactions
  if [ $((tokenId % 10)) -eq 0 ]; then
    echo "Batch complete, waiting 5 seconds..."
    sleep 5
  fi
done

echo "✅ All parcels listed!"
```

### Estimated Costs & Time

- **Minting**: ~200K gas per parcel × 1,205 = ~241M gas
  - Cost at 0.1 gwei: ~0.024 ETH (~$60)
  - Time: ~20-30 minutes

- **Listing**: ~100K gas per parcel × 1,205 = ~120M gas
  - Cost at 0.1 gwei: ~0.012 ETH (~$30)
  - Time: ~15-20 minutes

- **Total**: ~0.036 ETH (~$90) + ~40-50 minutes

### Alternative: Batch Minting Contract

For efficiency, consider deploying a batch minting contract that mints multiple parcels in one transaction.

## After Setup

Once all parcels are minted and listed:

1. ✅ Marketplace will show all 1,205 parcels
2. ✅ Users can buy parcels with their LAND tokens
3. ✅ Each purchase transfers ownership to the buyer
4. ✅ 20% protocol fee goes to treasury
5. ✅ 80% goes to the admin (initial seller)

## Quick Start Commands

```bash
# Check if you're the owner
cast call 0xB22b072503a381A2Db8309A8dD46789366D55074 \
  "owner()(address)" \
  --rpc-url https://mainnet.base.org

# Check current parcel count
cast call 0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf \
  "totalSupply()(uint256)" \
  --rpc-url https://mainnet.base.org

# Check if a parcel is listed
cast call 0xB22b072503a381A2Db8309A8dD46789366D55074 \
  "listings(uint256)((address,uint256,bool))" \
  1 \
  --rpc-url https://mainnet.base.org
```
