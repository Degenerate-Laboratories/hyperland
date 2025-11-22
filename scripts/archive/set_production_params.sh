#!/bin/bash

# Update HyperLand to production timing parameters

CORE=0xB22b072503a381A2Db8309A8dD46789366D55074
RPC=https://mainnet.base.org

# Load private key from .env
cd "$(dirname "$0")/contracts"
export $(grep "^PRIVATE_KEY" .env | xargs)

echo "Setting production parameters..."
echo ""

# Set 7-day tax cycle
echo "[1/2] Setting tax cycle to 7 days..."
cast send $CORE "setTaxCycleDuration(uint256)" 604800 --rpc-url $RPC --private-key $PRIVATE_KEY --confirmations 1

# Set 3-day auction duration
echo "[2/2] Setting auction duration to 3 days..."
cast send $CORE "setAuctionDuration(uint256)" 259200 --rpc-url $RPC --private-key $PRIVATE_KEY --confirmations 1

echo ""
echo "Verifying..."
TAX=$(cast call $CORE "taxCycleSeconds()(uint256)" --rpc-url $RPC)
AUCTION=$(cast call $CORE "auctionDuration()(uint256)" --rpc-url $RPC)

echo "Tax Cycle: $TAX seconds ($(($TAX / 86400)) days)"
echo "Auction Duration: $AUCTION seconds ($(($AUCTION / 86400)) days)"
echo ""
echo "✅ Production parameters set!"
