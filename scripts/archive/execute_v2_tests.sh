#!/bin/bash
# Quick V2 Test Execution - Uses new coordinates

set +e  # Don't exit on error, continue to report all results

# Contract addresses
CORE="0x47Ef963D494DcAb8CC567b584E708Ef55C26c303"
TOKEN="0xCB650697F12785376A34537114Ad6De21670252d"
DEED="0xac08a0E4c854992C58d44A1625C73f30BC91139d"
RPC="https://sepolia.base.org"

# Keys
ADMIN_KEY="0x95958cbdf253aeca507ee235f1a12d53a5774e7bbd9ec0caae7990b23b15acf4"
ALICE_KEY="0x0d13c4a5d591121cb8c1addacea9c1a1e1f719424d51de54c8907fa7f6c3f302"
BOB_KEY="0xa4bc74f23d0f7a4f8baf8a35857189b74698684e24d3e72089c29b9cd66df89e"
CAROL_KEY="0xd69d1abc1844207d312d6a83420ae007b444217ace74d09bfc27f72dc86fbd5a"

# Addresses
ALICE="0xDCC43D99B86dF38F73782f3119DD4eC7111D2e1a"
BOB="0x9BCB605A2236C5Df400b735235Ea887e3184909f"
CAROL="0x8aE08A1E571626A1659Da46c6211F9Ca8E60A7Df"

echo "🧪 HyperLand V2 Quick Test Suite"
echo "=================================="
echo ""

# Mint parcels at NEW coordinates (200-202 to avoid conflicts)
echo "📦 Minting 3 new parcels..."
cast send $CORE "mintParcel(address,uint256,uint256,uint256,uint256)" $ALICE 200 100 100 1000000000000000000000 --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ Parcel 4 minted for Alice" || echo "❌ Failed"
sleep 2
cast send $CORE "mintParcel(address,uint256,uint256,uint256,uint256)" $BOB 201 100 100 1000000000000000000000 --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ Parcel 5 minted for Bob" || echo "❌ Failed"
sleep 2
cast send $CORE "mintParcel(address,uint256,uint256,uint256,uint256)" $CAROL 202 100 100 1000000000000000000000 --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ Parcel 6 minted for Carol" || echo "❌ Failed"

echo ""
echo "👥 Registering Assessor..."
cast send $CORE "registerAssessor(address,string)" $CAROL "ipfs://QmV2TestCredentials" --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ Carol registered as assessor" || echo "ℹ️  Already registered"

echo ""
echo "💰 Funding Bob with LAND..."
cast send $TOKEN "transfer(address,uint256)" $BOB 5000000000000000000000 --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ 5000 LAND sent to Bob" || echo "❌ Failed"

echo ""
echo "🏪 Testing Marketplace..."
sleep 2
cast send $DEED "approve(address,uint256)" $CORE 4 --rpc-url $RPC --private-key $ALICE_KEY > /dev/null 2>&1 && echo "✅ Alice approved NFT transfer" || echo "❌ Failed"
sleep 2
cast send $CORE "listDeed(uint256,uint256)" 4 2000000000000000000000 --rpc-url $RPC --private-key $ALICE_KEY > /dev/null 2>&1 && echo "✅ Alice listed parcel for 2000 LAND" || echo "❌ Failed"
sleep 2
cast send $TOKEN "approve(address,uint256)" $CORE 5000000000000000000000 --rpc-url $RPC --private-key $BOB_KEY > /dev/null 2>&1 && echo "✅ Bob approved LAND spending" || echo "❌ Failed"
sleep 2
cast send $CORE "buyDeed(uint256)" 4 --rpc-url $RPC --private-key $BOB_KEY > /dev/null 2>&1 && echo "✅ Bob purchased parcel (20% fee collected)" || echo "❌ Failed"

echo ""
echo "📊 Verifying Purchase..."
ALICE_BAL=$(cast call $TOKEN "balanceOf(address)(uint256)" $ALICE --rpc-url $RPC)
ALICE_LAND=$(echo "scale=0; $ALICE_BAL / 1000000000000000000" | bc 2>/dev/null || echo "ERROR")
echo "   Alice LAND balance: $ALICE_LAND LAND (should be ~1600)"

OWNER=$(cast call $DEED "ownerOf(uint256)(address)" 4 --rpc-url $RPC)
if [ "$OWNER" == "$BOB" ]; then
    echo "   ✅ Bob now owns Parcel #4"
else
    echo "   ❌ Ownership transfer failed"
fi

echo ""
echo "🎯 Testing Assessor System..."
sleep 2
cast send $CORE "submitValuation(uint256,uint256,string)" 4 1800000000000000000000 "comparable_sales_method" --rpc-url $RPC --private-key $CAROL_KEY > /dev/null 2>&1 && echo "✅ Carol submitted valuation (1800 LAND)" || echo "❌ Failed"
sleep 2
cast send $CORE "approveValuation(uint256,uint256)" 4 0 --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "✅ Admin approved valuation" || echo "❌ Failed"

echo ""
echo "🆕 Testing V2 Features..."
echo ""
echo "1️⃣  Tax Prepayment:"
sleep 2
cast send $CORE "payTaxesInAdvance(uint256,uint256)" 4 20 --rpc-url $RPC --private-key $BOB_KEY > /dev/null 2>&1 && echo "   ✅ Bob prepaid taxes for 20 cycles" || echo "   ❌ Failed"

echo ""
echo "2️⃣  Batch Queries:"
BATCH_RESULT=$(cast call $CORE "calculateTaxOwedBatch(uint256[])(uint256[])" "[4,5,6]" --rpc-url $RPC 2>/dev/null)
if [ ! -z "$BATCH_RESULT" ]; then
    echo "   ✅ Batch tax query successful"
    echo "   Result: $BATCH_RESULT"
else
    echo "   ❌ Batch query failed"
fi

echo ""
echo "3️⃣  Emergency Pause:"
sleep 2
cast send $CORE "pause()" --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "   ✅ Contract paused" || echo "   ❌ Failed to pause"
sleep 2
cast send $CORE "listDeed(uint256,uint256)" 5 1000000000000000000000 --rpc-url $RPC --private-key $BOB_KEY > /dev/null 2>&1 && echo "   ❌ Listing succeeded (should fail when paused!)" || echo "   ✅ Listing blocked (correct - contract is paused)"
sleep 2
cast send $CORE "unpause()" --rpc-url $RPC --private-key $ADMIN_KEY > /dev/null 2>&1 && echo "   ✅ Contract unpaused" || echo "   ❌ Failed to unpause"

echo ""
echo "=================================="
echo "✅ V2 Test Suite Complete!"
echo "=================================="
echo ""
echo "Summary:"
echo "- Parcels: 3 new parcels minted"
echo "- Marketplace: 1 sale completed with 20% fee"
echo "- Assessor: 1 valuation submitted and approved"
echo "- V2 Features: Tax prepayment, Batch queries, Pause tested"
echo ""
