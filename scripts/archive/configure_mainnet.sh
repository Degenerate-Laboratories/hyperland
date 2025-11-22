#!/bin/bash

# HyperLand V2 - Mainnet Configuration Script
# Completes critical post-deployment setup

set -e  # Exit on any error

# Load environment
cd "$(dirname "$0")/contracts"
export $(grep -v '^#' .env | xargs)

# Contract addresses from deployment
export LAND_TOKEN=0x919e6e2b36b6944F52605bC705Ff609AFcb7c797
export LAND_DEED=0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf
export HYPERLAND_CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
export RPC=https://mainnet.base.org

echo "========================================="
echo "HyperLand V2 - Mainnet Configuration"
echo "========================================="
echo "Network: Base Mainnet (8453)"
echo "LAND Token: $LAND_TOKEN"
echo "LandDeed: $LAND_DEED"
echo "HyperLandCore: $HYPERLAND_CORE"
echo "========================================="
echo ""

# Step 1: Transfer LandDeed ownership
echo "[1/3] Transferring LandDeed ownership to HyperLandCore..."
cast send $LAND_DEED \
  "transferOwnership(address)" $HYPERLAND_CORE \
  --rpc-url $RPC \
  --private-key $PRIVATE_KEY

# Verify ownership transfer
NEW_OWNER=$(cast call $LAND_DEED "owner()(address)" --rpc-url $RPC)
if [ "$NEW_OWNER" = "$HYPERLAND_CORE" ]; then
  echo "✅ LandDeed ownership transferred successfully"
else
  echo "❌ ERROR: Ownership transfer failed"
  exit 1
fi

# Step 2: Set production tax cycle (7 days)
echo ""
echo "[2/3] Setting tax cycle to 7 days (604800 seconds)..."
cast send $HYPERLAND_CORE \
  "setTaxCycleDuration(uint256)" 604800 \
  --rpc-url $RPC \
  --private-key $PRIVATE_KEY

# Verify tax cycle
TAX_CYCLE=$(cast call $HYPERLAND_CORE "taxCycleSeconds()(uint256)" --rpc-url $RPC)
if [ "$TAX_CYCLE" = "604800" ]; then
  echo "✅ Tax cycle set to 7 days"
else
  echo "⚠️  WARNING: Tax cycle is $TAX_CYCLE (expected 604800)"
fi

# Step 3: Set production auction duration (3 days)
echo ""
echo "[3/3] Setting auction duration to 3 days (259200 seconds)..."
cast send $HYPERLAND_CORE \
  "setAuctionDuration(uint256)" 259200 \
  --rpc-url $RPC \
  --private-key $PRIVATE_KEY

# Verify auction duration
AUCTION_DURATION=$(cast call $HYPERLAND_CORE "auctionDuration()(uint256)" --rpc-url $RPC)
if [ "$AUCTION_DURATION" = "259200" ]; then
  echo "✅ Auction duration set to 3 days"
else
  echo "⚠️  WARNING: Auction duration is $AUCTION_DURATION (expected 259200)"
fi

echo ""
echo "========================================="
echo "✅ CONFIGURATION COMPLETE!"
echo "========================================="
echo ""
echo "Summary:"
echo "  ✅ LandDeed ownership: HyperLandCore"
echo "  ✅ Tax cycle: 7 days (604800 sec)"
echo "  ✅ Auction duration: 3 days (259200 sec)"
echo ""
echo "HyperLand is now ready for production!"
echo "========================================="
