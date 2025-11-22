#!/bin/bash
# Batch Mint Script for HyperLand Parcels
# Generated: 2025-11-21T22:38:39.399Z
# Total Parcels: 1205
# Batch Size: 50
# Total Batches: 25

# Load environment variables
source .env

# Check required variables
if [ -z "$HYPERLAND_CORE_ADDRESS" ]; then
  echo "Error: HYPERLAND_CORE_ADDRESS not set"
  exit 1
fi

if [ -z "$INITIAL_OWNER" ]; then
  echo "Error: INITIAL_OWNER not set"
  exit 1
fi

if [ -z "$PRIVATE_KEY" ]; then
  echo "Error: PRIVATE_KEY not set"
  exit 1
fi

echo "==================================="
echo "HyperLand Batch Minting"
echo "==================================="
echo "Core: $HYPERLAND_CORE_ADDRESS"
echo "Owner: $INITIAL_OWNER"
echo "Total Parcels: 1205"
echo "Batches: 25"
echo "-----------------------------------"
echo ""


# Batch 1/25 (Parcels 1-50)
echo "Processing batch 1/25..."

# BRC-0001: "2:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  616 \
  1088 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0002: "2:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  596 \
  1099 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0003: "2:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  577 \
  1109 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0004: "2:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  558 \
  1119 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0005: "2:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  538 \
  1128 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0006: "2:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  518 \
  1137 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0007: "2:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  498 \
  1146 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0008: "2:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  478 \
  1155 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0009: "2:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  458 \
  1163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0010: "2:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  438 \
  1171 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0011: "2:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  417 \
  1178 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0012: "2:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  397 \
  1185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0013: "2:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  376 \
  1192 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0014: "2:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  355 \
  1199 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0015: "2:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  334 \
  1205 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0016: "2:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  313 \
  1210 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0017: "2:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  292 \
  1215 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0018: "2:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  271 \
  1220 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0019: "2:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  249 \
  1225 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0020: "2:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  228 \
  1229 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0021: "2:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  206 \
  1233 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0022: "2:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  185 \
  1236 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0023: "2:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  163 \
  1239 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0024: "2:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  142 \
  1242 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0025: "2:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  120 \
  1244 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0026: "2:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  98 \
  1246 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0027: "2:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  76 \
  1248 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0028: "2:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  55 \
  1249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0029: "2:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  33 \
  1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0030: "2:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  11 \
  1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0031: "3:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -11 \
  1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0032: "3:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -33 \
  1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0033: "3:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -55 \
  1249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0034: "3:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -76 \
  1248 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0035: "3:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -98 \
  1246 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0036: "3:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -120 \
  1244 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0037: "3:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -142 \
  1242 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0038: "3:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -163 \
  1239 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0039: "3:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -185 \
  1236 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0040: "3:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -206 \
  1233 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0041: "3:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -228 \
  1229 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0042: "3:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -249 \
  1225 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0043: "3:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -271 \
  1220 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0044: "3:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -292 \
  1215 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0045: "3:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -313 \
  1210 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0046: "3:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -334 \
  1205 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0047: "3:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -355 \
  1199 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0048: "3:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -376 \
  1192 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0049: "3:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -397 \
  1185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0050: "3:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -417 \
  1178 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 1 complete. Sleeping 5 seconds..."
sleep 5

# Batch 2/25 (Parcels 51-100)
echo "Processing batch 2/25..."

# BRC-0051: "3:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -438 \
  1171 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0052: "3:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -458 \
  1163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0053: "3:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -478 \
  1155 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0054: "3:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -498 \
  1146 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0055: "3:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -518 \
  1137 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0056: "3:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -538 \
  1128 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0057: "3:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -558 \
  1119 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0058: "3:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -577 \
  1109 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0059: "3:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -596 \
  1099 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0060: "3:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -616 \
  1088 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0061: "4:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -634 \
  1077 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0062: "4:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -653 \
  1066 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0063: "4:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -672 \
  1054 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0064: "4:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -690 \
  1042 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0065: "4:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -708 \
  1030 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0066: "4:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -726 \
  1018 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0067: "4:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -744 \
  1005 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0068: "4:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -761 \
  992 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0069: "4:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -778 \
  978 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0070: "4:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -795 \
  965 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0071: "4:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -812 \
  951 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0072: "4:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -828 \
  936 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0073: "4:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -844 \
  922 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0074: "4:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -860 \
  907 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0075: "4:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -876 \
  892 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0076: "4:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -892 \
  876 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0077: "4:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -907 \
  860 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0078: "4:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -922 \
  844 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0079: "4:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -936 \
  828 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0080: "4:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -951 \
  812 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0081: "4:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -965 \
  795 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0082: "4:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -978 \
  778 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0083: "4:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -992 \
  761 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0084: "4:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1005 \
  744 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0085: "4:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1018 \
  726 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0086: "4:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1030 \
  708 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0087: "4:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1042 \
  690 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0088: "4:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1054 \
  672 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0089: "4:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1066 \
  653 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0090: "4:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1077 \
  634 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0091: "5:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1088 \
  616 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0092: "5:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1099 \
  596 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0093: "5:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1109 \
  577 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0094: "5:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1119 \
  558 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0095: "5:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1128 \
  538 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0096: "5:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1137 \
  518 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0097: "5:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1146 \
  498 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0098: "5:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1155 \
  478 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0099: "5:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1163 \
  458 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0100: "5:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1171 \
  438 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 2 complete. Sleeping 5 seconds..."
sleep 5

# Batch 3/25 (Parcels 101-150)
echo "Processing batch 3/25..."

# BRC-0101: "5:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1178 \
  417 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0102: "5:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1185 \
  397 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0103: "5:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1192 \
  376 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0104: "5:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1199 \
  355 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0105: "5:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1205 \
  334 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0106: "5:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1210 \
  313 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0107: "5:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1215 \
  292 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0108: "5:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1220 \
  271 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0109: "5:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1225 \
  249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0110: "5:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1229 \
  228 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0111: "5:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1233 \
  206 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0112: "5:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1236 \
  185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0113: "5:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1239 \
  163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0114: "5:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1242 \
  142 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0115: "5:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1244 \
  120 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0116: "5:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1246 \
  98 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0117: "5:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1248 \
  76 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0118: "5:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1249 \
  55 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0119: "5:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1250 \
  33 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0120: "5:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1250 \
  11 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0121: "6:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1250 \
  -11 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0122: "6:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1250 \
  -33 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0123: "6:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1249 \
  -55 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0124: "6:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1248 \
  -76 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0125: "6:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1246 \
  -98 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0126: "6:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1244 \
  -120 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0127: "6:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1242 \
  -142 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0128: "6:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1239 \
  -163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0129: "6:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1236 \
  -185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0130: "6:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1233 \
  -206 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0131: "6:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1229 \
  -228 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0132: "6:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1225 \
  -249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0133: "6:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1220 \
  -271 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0134: "6:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1215 \
  -292 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0135: "6:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1210 \
  -313 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0136: "6:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1205 \
  -334 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0137: "6:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1199 \
  -355 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0138: "6:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1192 \
  -376 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0139: "6:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1185 \
  -397 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0140: "6:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1178 \
  -417 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0141: "6:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1171 \
  -438 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0142: "6:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1163 \
  -458 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0143: "6:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1155 \
  -478 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0144: "6:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1146 \
  -498 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0145: "6:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1137 \
  -518 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0146: "6:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1128 \
  -538 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0147: "6:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1119 \
  -558 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0148: "6:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1109 \
  -577 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0149: "6:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1099 \
  -596 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0150: "6:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1088 \
  -616 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 3 complete. Sleeping 5 seconds..."
sleep 5

# Batch 4/25 (Parcels 151-200)
echo "Processing batch 4/25..."

# BRC-0151: "7:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1077 \
  -634 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0152: "7:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1066 \
  -653 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0153: "7:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1054 \
  -672 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0154: "7:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1042 \
  -690 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0155: "7:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1030 \
  -708 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0156: "7:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1018 \
  -726 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0157: "7:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1005 \
  -744 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0158: "7:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -992 \
  -761 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0159: "7:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -978 \
  -778 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0160: "7:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -965 \
  -795 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0161: "7:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -951 \
  -812 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0162: "7:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -936 \
  -828 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0163: "7:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -922 \
  -844 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0164: "7:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -907 \
  -860 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0165: "7:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -892 \
  -876 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0166: "7:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -876 \
  -892 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0167: "7:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -860 \
  -907 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0168: "7:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -844 \
  -922 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0169: "7:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -828 \
  -936 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0170: "7:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -812 \
  -951 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0171: "7:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -795 \
  -965 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0172: "7:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -778 \
  -978 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0173: "7:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -761 \
  -992 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0174: "7:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -744 \
  -1005 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0175: "7:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -726 \
  -1018 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0176: "7:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -708 \
  -1030 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0177: "7:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -690 \
  -1042 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0178: "7:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -672 \
  -1054 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0179: "7:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -653 \
  -1066 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0180: "7:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -634 \
  -1077 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0181: "8:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -616 \
  -1088 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0182: "8:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -596 \
  -1099 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0183: "8:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -577 \
  -1109 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0184: "8:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -558 \
  -1119 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0185: "8:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -538 \
  -1128 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0186: "8:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -518 \
  -1137 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0187: "8:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -498 \
  -1146 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0188: "8:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -478 \
  -1155 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0189: "8:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -458 \
  -1163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0190: "8:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -438 \
  -1171 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0191: "8:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -417 \
  -1178 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0192: "8:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -397 \
  -1185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0193: "8:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -376 \
  -1192 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0194: "8:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -355 \
  -1199 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0195: "8:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -334 \
  -1205 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0196: "8:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -313 \
  -1210 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0197: "8:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -292 \
  -1215 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0198: "8:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -271 \
  -1220 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0199: "8:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -249 \
  -1225 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0200: "8:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -228 \
  -1229 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 4 complete. Sleeping 5 seconds..."
sleep 5

# Batch 5/25 (Parcels 201-250)
echo "Processing batch 5/25..."

# BRC-0201: "8:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -206 \
  -1233 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0202: "8:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -185 \
  -1236 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0203: "8:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -163 \
  -1239 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0204: "8:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -142 \
  -1242 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0205: "8:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -120 \
  -1244 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0206: "8:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -98 \
  -1246 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0207: "8:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -76 \
  -1248 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0208: "8:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -55 \
  -1249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0209: "8:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -33 \
  -1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0210: "8:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -11 \
  -1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0211: "9:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  11 \
  -1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0212: "9:02 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  33 \
  -1250 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0213: "9:04 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  55 \
  -1249 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0214: "9:06 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  76 \
  -1248 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0215: "9:08 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  98 \
  -1246 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0216: "9:10 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  120 \
  -1244 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0217: "9:12 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  142 \
  -1242 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0218: "9:14 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  163 \
  -1239 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0219: "9:16 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  185 \
  -1236 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0220: "9:18 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  206 \
  -1233 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0221: "9:20 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  228 \
  -1229 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0222: "9:22 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  249 \
  -1225 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0223: "9:24 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  271 \
  -1220 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0224: "9:26 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  292 \
  -1215 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0225: "9:28 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  313 \
  -1210 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0226: "9:30 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  334 \
  -1205 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0227: "9:32 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  355 \
  -1199 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0228: "9:34 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  376 \
  -1192 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0229: "9:36 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  397 \
  -1185 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0230: "9:38 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  417 \
  -1178 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0231: "9:40 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  438 \
  -1171 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0232: "9:42 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  458 \
  -1163 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0233: "9:44 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  478 \
  -1155 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0234: "9:46 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  498 \
  -1146 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0235: "9:48 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  518 \
  -1137 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0236: "9:50 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  538 \
  -1128 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0237: "9:52 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  558 \
  -1119 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0238: "9:54 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  577 \
  -1109 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0239: "9:56 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  596 \
  -1099 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0240: "9:58 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  616 \
  -1088 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0241: "10:00 & Esplanade"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  634 \
  -1077 \
  100 \
  1e+21 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0242: "2:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1465 \
  2589 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0243: "2:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1420 \
  2614 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0244: "2:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1374 \
  2639 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0245: "2:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1327 \
  2662 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0246: "2:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1281 \
  2685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0247: "2:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1234 \
  2707 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0248: "2:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1186 \
  2728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0249: "2:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1138 \
  2749 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0250: "2:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1090 \
  2768 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 5 complete. Sleeping 5 seconds..."
sleep 5

# Batch 6/25 (Parcels 251-300)
echo "Processing batch 6/25..."

# BRC-0251: "2:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1042 \
  2787 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0252: "2:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  993 \
  2804 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0253: "2:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  944 \
  2821 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0254: "2:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  895 \
  2837 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0255: "2:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  845 \
  2852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0256: "2:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  795 \
  2867 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0257: "2:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  745 \
  2880 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0258: "2:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  694 \
  2893 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0259: "2:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  644 \
  2904 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0260: "2:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  593 \
  2915 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0261: "2:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  542 \
  2925 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0262: "2:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  491 \
  2934 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0263: "2:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  440 \
  2942 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0264: "2:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  388 \
  2950 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0265: "2:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  337 \
  2956 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0266: "2:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  285 \
  2961 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0267: "2:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  233 \
  2966 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0268: "2:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  182 \
  2969 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0269: "2:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  130 \
  2972 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0270: "2:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  78 \
  2974 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0271: "2:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  26 \
  2975 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0272: "3:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -26 \
  2975 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0273: "3:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -78 \
  2974 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0274: "3:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -130 \
  2972 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0275: "3:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -182 \
  2969 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0276: "3:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -233 \
  2966 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0277: "3:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -285 \
  2961 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0278: "3:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -337 \
  2956 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0279: "3:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -388 \
  2950 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0280: "3:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -440 \
  2942 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0281: "3:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -491 \
  2934 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0282: "3:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -542 \
  2925 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0283: "3:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -593 \
  2915 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0284: "3:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -644 \
  2904 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0285: "3:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -694 \
  2893 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0286: "3:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -745 \
  2880 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0287: "3:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -795 \
  2867 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0288: "3:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -845 \
  2852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0289: "3:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -895 \
  2837 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0290: "3:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -944 \
  2821 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0291: "3:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -993 \
  2804 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0292: "3:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1042 \
  2787 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0293: "3:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1090 \
  2768 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0294: "3:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1138 \
  2749 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0295: "3:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1186 \
  2728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0296: "3:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1234 \
  2707 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0297: "3:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1281 \
  2685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0298: "3:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1327 \
  2662 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0299: "3:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1374 \
  2639 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0300: "3:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1420 \
  2614 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 6 complete. Sleeping 5 seconds..."
sleep 5

# Batch 7/25 (Parcels 301-350)
echo "Processing batch 7/25..."

# BRC-0301: "3:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1465 \
  2589 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0302: "4:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1510 \
  2563 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0303: "4:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1554 \
  2537 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0304: "4:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1598 \
  2509 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0305: "4:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1642 \
  2481 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0306: "4:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1685 \
  2452 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0307: "4:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1728 \
  2422 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0308: "4:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1770 \
  2391 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0309: "4:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1811 \
  2360 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0310: "4:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1852 \
  2328 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0311: "4:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1892 \
  2296 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0312: "4:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1932 \
  2262 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0313: "4:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1971 \
  2228 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0314: "4:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2010 \
  2193 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0315: "4:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2048 \
  2158 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0316: "4:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2085 \
  2122 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0317: "4:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2122 \
  2085 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0318: "4:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2158 \
  2048 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0319: "4:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2193 \
  2010 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0320: "4:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2228 \
  1971 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0321: "4:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2262 \
  1932 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0322: "4:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2296 \
  1892 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0323: "4:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2328 \
  1852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0324: "4:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2360 \
  1811 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0325: "4:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2391 \
  1770 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0326: "4:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2422 \
  1728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0327: "4:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2452 \
  1685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0328: "4:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2481 \
  1642 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0329: "4:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2509 \
  1598 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0330: "4:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2537 \
  1554 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0331: "4:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2563 \
  1510 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0332: "5:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2589 \
  1465 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0333: "5:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2614 \
  1420 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0334: "5:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2639 \
  1374 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0335: "5:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2662 \
  1327 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0336: "5:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2685 \
  1281 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0337: "5:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2707 \
  1234 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0338: "5:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2728 \
  1186 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0339: "5:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2749 \
  1138 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0340: "5:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2768 \
  1090 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0341: "5:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2787 \
  1042 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0342: "5:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2804 \
  993 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0343: "5:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2821 \
  944 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0344: "5:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2837 \
  895 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0345: "5:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2852 \
  845 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0346: "5:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2867 \
  795 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0347: "5:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2880 \
  745 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0348: "5:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2893 \
  694 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0349: "5:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2904 \
  644 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0350: "5:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2915 \
  593 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 7 complete. Sleeping 5 seconds..."
sleep 5

# Batch 8/25 (Parcels 351-400)
echo "Processing batch 8/25..."

# BRC-0351: "5:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2925 \
  542 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0352: "5:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2934 \
  491 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0353: "5:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2942 \
  440 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0354: "5:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2950 \
  388 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0355: "5:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2956 \
  337 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0356: "5:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2961 \
  285 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0357: "5:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2966 \
  233 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0358: "5:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2969 \
  182 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0359: "5:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2972 \
  130 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0360: "5:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2974 \
  78 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0361: "5:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2975 \
  26 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0362: "6:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2975 \
  -26 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0363: "6:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2974 \
  -78 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0364: "6:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2972 \
  -130 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0365: "6:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2969 \
  -182 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0366: "6:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2966 \
  -233 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0367: "6:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2961 \
  -285 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0368: "6:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2956 \
  -337 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0369: "6:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2950 \
  -388 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0370: "6:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2942 \
  -440 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0371: "6:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2934 \
  -491 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0372: "6:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2925 \
  -542 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0373: "6:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2915 \
  -593 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0374: "6:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2904 \
  -644 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0375: "6:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2893 \
  -694 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0376: "6:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2880 \
  -745 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0377: "6:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2867 \
  -795 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0378: "6:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2852 \
  -845 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0379: "6:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2837 \
  -895 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0380: "6:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2821 \
  -944 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0381: "6:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2804 \
  -993 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0382: "6:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2787 \
  -1042 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0383: "6:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2768 \
  -1090 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0384: "6:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2749 \
  -1138 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0385: "6:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2728 \
  -1186 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0386: "6:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2707 \
  -1234 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0387: "6:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2685 \
  -1281 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0388: "6:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2662 \
  -1327 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0389: "6:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2639 \
  -1374 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0390: "6:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2614 \
  -1420 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0391: "6:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2589 \
  -1465 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0392: "7:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2563 \
  -1510 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0393: "7:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2537 \
  -1554 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0394: "7:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2509 \
  -1598 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0395: "7:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2481 \
  -1642 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0396: "7:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2452 \
  -1685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0397: "7:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2422 \
  -1728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0398: "7:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2391 \
  -1770 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0399: "7:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2360 \
  -1811 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0400: "7:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2328 \
  -1852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 8 complete. Sleeping 5 seconds..."
sleep 5

# Batch 9/25 (Parcels 401-450)
echo "Processing batch 9/25..."

# BRC-0401: "7:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2296 \
  -1892 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0402: "7:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2262 \
  -1932 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0403: "7:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2228 \
  -1971 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0404: "7:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2193 \
  -2010 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0405: "7:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2158 \
  -2048 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0406: "7:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2122 \
  -2085 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0407: "7:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2085 \
  -2122 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0408: "7:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2048 \
  -2158 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0409: "7:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2010 \
  -2193 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0410: "7:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1971 \
  -2228 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0411: "7:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1932 \
  -2262 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0412: "7:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1892 \
  -2296 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0413: "7:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1852 \
  -2328 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0414: "7:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1811 \
  -2360 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0415: "7:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1770 \
  -2391 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0416: "7:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1728 \
  -2422 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0417: "7:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1685 \
  -2452 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0418: "7:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1642 \
  -2481 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0419: "7:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1598 \
  -2509 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0420: "7:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1554 \
  -2537 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0421: "7:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1510 \
  -2563 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0422: "8:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1465 \
  -2589 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0423: "8:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1420 \
  -2614 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0424: "8:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1374 \
  -2639 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0425: "8:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1327 \
  -2662 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0426: "8:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1281 \
  -2685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0427: "8:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1234 \
  -2707 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0428: "8:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1186 \
  -2728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0429: "8:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1138 \
  -2749 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0430: "8:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1090 \
  -2768 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0431: "8:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1042 \
  -2787 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0432: "8:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -993 \
  -2804 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0433: "8:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -944 \
  -2821 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0434: "8:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -895 \
  -2837 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0435: "8:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -845 \
  -2852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0436: "8:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -795 \
  -2867 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0437: "8:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -745 \
  -2880 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0438: "8:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -694 \
  -2893 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0439: "8:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -644 \
  -2904 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0440: "8:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -593 \
  -2915 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0441: "8:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -542 \
  -2925 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0442: "8:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -491 \
  -2934 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0443: "8:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -440 \
  -2942 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0444: "8:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -388 \
  -2950 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0445: "8:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -337 \
  -2956 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0446: "8:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -285 \
  -2961 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0447: "8:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -233 \
  -2966 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0448: "8:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -182 \
  -2969 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0449: "8:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -130 \
  -2972 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0450: "8:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -78 \
  -2974 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 9 complete. Sleeping 5 seconds..."
sleep 5

# Batch 10/25 (Parcels 451-500)
echo "Processing batch 10/25..."

# BRC-0451: "8:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -26 \
  -2975 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0452: "9:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  26 \
  -2975 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0453: "9:02 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  78 \
  -2974 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0454: "9:04 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  130 \
  -2972 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0455: "9:06 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  182 \
  -2969 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0456: "9:08 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  233 \
  -2966 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0457: "9:10 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  285 \
  -2961 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0458: "9:12 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  337 \
  -2956 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0459: "9:14 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  388 \
  -2950 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0460: "9:16 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  440 \
  -2942 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0461: "9:18 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  491 \
  -2934 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0462: "9:20 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  542 \
  -2925 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0463: "9:22 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  593 \
  -2915 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0464: "9:24 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  644 \
  -2904 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0465: "9:26 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  694 \
  -2893 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0466: "9:28 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  745 \
  -2880 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0467: "9:30 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  795 \
  -2867 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0468: "9:32 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  845 \
  -2852 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0469: "9:34 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  895 \
  -2837 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0470: "9:36 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  944 \
  -2821 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0471: "9:38 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  993 \
  -2804 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0472: "9:40 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1042 \
  -2787 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0473: "9:42 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1090 \
  -2768 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0474: "9:44 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1138 \
  -2749 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0475: "9:46 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1186 \
  -2728 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0476: "9:48 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1234 \
  -2707 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0477: "9:50 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1281 \
  -2685 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0478: "9:52 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1327 \
  -2662 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0479: "9:54 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1374 \
  -2639 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0480: "9:56 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1420 \
  -2614 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0481: "9:58 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1465 \
  -2589 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0482: "10:00 & Afanc"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1510 \
  -2563 \
  100 \
  600000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0483: "2:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2130 \
  3764 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0484: "2:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2064 \
  3801 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0485: "2:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1997 \
  3836 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0486: "2:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1930 \
  3871 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0487: "2:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1862 \
  3904 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0488: "2:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1794 \
  3936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0489: "2:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1725 \
  3966 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0490: "2:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1655 \
  3996 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0491: "2:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1585 \
  4024 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0492: "2:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1515 \
  4051 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0493: "2:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1444 \
  4077 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0494: "2:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1372 \
  4101 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0495: "2:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1301 \
  4125 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0496: "2:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1228 \
  4147 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0497: "2:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1156 \
  4168 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0498: "2:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1083 \
  4187 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0499: "2:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1010 \
  4205 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0500: "2:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  936 \
  4222 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 10 complete. Sleeping 5 seconds..."
sleep 5

# Batch 11/25 (Parcels 501-550)
echo "Processing batch 11/25..."

# BRC-0501: "2:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  862 \
  4238 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0502: "2:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  788 \
  4253 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0503: "2:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  714 \
  4266 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0504: "2:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  639 \
  4277 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0505: "2:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  565 \
  4288 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0506: "2:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  490 \
  4297 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0507: "2:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  415 \
  4305 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0508: "2:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  339 \
  4312 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0509: "2:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  264 \
  4317 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0510: "2:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  189 \
  4321 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0511: "2:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  113 \
  4324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0512: "2:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  38 \
  4325 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0513: "3:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -38 \
  4325 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0514: "3:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -113 \
  4324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0515: "3:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -189 \
  4321 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0516: "3:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -264 \
  4317 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0517: "3:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -339 \
  4312 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0518: "3:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -415 \
  4305 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0519: "3:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -490 \
  4297 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0520: "3:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -565 \
  4288 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0521: "3:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -639 \
  4277 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0522: "3:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -714 \
  4266 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0523: "3:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -788 \
  4253 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0524: "3:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -862 \
  4238 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0525: "3:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -936 \
  4222 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0526: "3:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1010 \
  4205 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0527: "3:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1083 \
  4187 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0528: "3:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1156 \
  4168 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0529: "3:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1228 \
  4147 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0530: "3:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1301 \
  4125 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0531: "3:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1372 \
  4101 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0532: "3:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1444 \
  4077 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0533: "3:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1515 \
  4051 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0534: "3:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1585 \
  4024 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0535: "3:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1655 \
  3996 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0536: "3:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1725 \
  3966 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0537: "3:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1794 \
  3936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0538: "3:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1862 \
  3904 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0539: "3:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1930 \
  3871 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0540: "3:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1997 \
  3836 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0541: "3:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2064 \
  3801 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0542: "3:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2130 \
  3764 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0543: "4:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2195 \
  3727 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0544: "4:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2260 \
  3688 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0545: "4:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2324 \
  3648 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0546: "4:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2387 \
  3607 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0547: "4:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2450 \
  3564 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0548: "4:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2512 \
  3521 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0549: "4:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2573 \
  3477 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0550: "4:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2633 \
  3431 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 11 complete. Sleeping 5 seconds..."
sleep 5

# Batch 12/25 (Parcels 551-600)
echo "Processing batch 12/25..."

# BRC-0551: "4:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2692 \
  3385 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0552: "4:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2751 \
  3337 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0553: "4:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2809 \
  3289 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0554: "4:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2866 \
  3239 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0555: "4:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2922 \
  3189 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0556: "4:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2977 \
  3137 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0557: "4:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3031 \
  3085 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0558: "4:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3085 \
  3031 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0559: "4:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3137 \
  2977 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0560: "4:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3189 \
  2922 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0561: "4:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3239 \
  2866 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0562: "4:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3289 \
  2809 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0563: "4:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3337 \
  2751 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0564: "4:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3385 \
  2692 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0565: "4:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3431 \
  2633 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0566: "4:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3477 \
  2573 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0567: "4:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3521 \
  2512 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0568: "4:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3564 \
  2450 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0569: "4:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3607 \
  2387 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0570: "4:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3648 \
  2324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0571: "4:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3688 \
  2260 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0572: "4:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3727 \
  2195 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0573: "5:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3764 \
  2130 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0574: "5:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3801 \
  2064 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0575: "5:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3836 \
  1997 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0576: "5:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3871 \
  1930 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0577: "5:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3904 \
  1862 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0578: "5:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3936 \
  1794 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0579: "5:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3966 \
  1725 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0580: "5:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3996 \
  1655 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0581: "5:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4024 \
  1585 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0582: "5:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4051 \
  1515 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0583: "5:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4077 \
  1444 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0584: "5:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4101 \
  1372 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0585: "5:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4125 \
  1301 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0586: "5:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4147 \
  1228 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0587: "5:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4168 \
  1156 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0588: "5:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4187 \
  1083 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0589: "5:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4205 \
  1010 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0590: "5:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4222 \
  936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0591: "5:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4238 \
  862 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0592: "5:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4253 \
  788 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0593: "5:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4266 \
  714 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0594: "5:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4277 \
  639 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0595: "5:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4288 \
  565 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0596: "5:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4297 \
  490 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0597: "5:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4305 \
  415 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0598: "5:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4312 \
  339 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0599: "5:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4317 \
  264 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0600: "5:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4321 \
  189 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 12 complete. Sleeping 5 seconds..."
sleep 5

# Batch 13/25 (Parcels 601-650)
echo "Processing batch 13/25..."

# BRC-0601: "5:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4324 \
  113 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0602: "5:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4325 \
  38 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0603: "6:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4325 \
  -38 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0604: "6:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4324 \
  -113 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0605: "6:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4321 \
  -189 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0606: "6:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4317 \
  -264 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0607: "6:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4312 \
  -339 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0608: "6:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4305 \
  -415 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0609: "6:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4297 \
  -490 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0610: "6:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4288 \
  -565 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0611: "6:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4277 \
  -639 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0612: "6:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4266 \
  -714 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0613: "6:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4253 \
  -788 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0614: "6:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4238 \
  -862 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0615: "6:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4222 \
  -936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0616: "6:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4205 \
  -1010 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0617: "6:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4187 \
  -1083 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0618: "6:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4168 \
  -1156 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0619: "6:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4147 \
  -1228 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0620: "6:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4125 \
  -1301 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0621: "6:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4101 \
  -1372 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0622: "6:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4077 \
  -1444 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0623: "6:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4051 \
  -1515 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0624: "6:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4024 \
  -1585 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0625: "6:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3996 \
  -1655 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0626: "6:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3966 \
  -1725 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0627: "6:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3936 \
  -1794 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0628: "6:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3904 \
  -1862 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0629: "6:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3871 \
  -1930 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0630: "6:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3836 \
  -1997 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0631: "6:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3801 \
  -2064 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0632: "6:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3764 \
  -2130 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0633: "7:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3727 \
  -2195 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0634: "7:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3688 \
  -2260 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0635: "7:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3648 \
  -2324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0636: "7:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3607 \
  -2387 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0637: "7:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3564 \
  -2450 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0638: "7:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3521 \
  -2512 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0639: "7:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3477 \
  -2573 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0640: "7:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3431 \
  -2633 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0641: "7:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3385 \
  -2692 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0642: "7:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3337 \
  -2751 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0643: "7:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3289 \
  -2809 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0644: "7:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3239 \
  -2866 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0645: "7:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3189 \
  -2922 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0646: "7:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3137 \
  -2977 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0647: "7:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3085 \
  -3031 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0648: "7:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3031 \
  -3085 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0649: "7:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2977 \
  -3137 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0650: "7:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2922 \
  -3189 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 13 complete. Sleeping 5 seconds..."
sleep 5

# Batch 14/25 (Parcels 651-700)
echo "Processing batch 14/25..."

# BRC-0651: "7:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2866 \
  -3239 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0652: "7:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2809 \
  -3289 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0653: "7:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2751 \
  -3337 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0654: "7:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2692 \
  -3385 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0655: "7:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2633 \
  -3431 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0656: "7:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2573 \
  -3477 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0657: "7:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2512 \
  -3521 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0658: "7:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2450 \
  -3564 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0659: "7:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2387 \
  -3607 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0660: "7:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2324 \
  -3648 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0661: "7:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2260 \
  -3688 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0662: "7:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2195 \
  -3727 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0663: "8:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2130 \
  -3764 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0664: "8:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2064 \
  -3801 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0665: "8:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1997 \
  -3836 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0666: "8:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1930 \
  -3871 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0667: "8:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1862 \
  -3904 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0668: "8:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1794 \
  -3936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0669: "8:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1725 \
  -3966 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0670: "8:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1655 \
  -3996 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0671: "8:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1585 \
  -4024 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0672: "8:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1515 \
  -4051 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0673: "8:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1444 \
  -4077 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0674: "8:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1372 \
  -4101 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0675: "8:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1301 \
  -4125 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0676: "8:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1228 \
  -4147 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0677: "8:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1156 \
  -4168 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0678: "8:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1083 \
  -4187 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0679: "8:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1010 \
  -4205 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0680: "8:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -936 \
  -4222 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0681: "8:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -862 \
  -4238 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0682: "8:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -788 \
  -4253 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0683: "8:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -714 \
  -4266 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0684: "8:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -639 \
  -4277 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0685: "8:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -565 \
  -4288 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0686: "8:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -490 \
  -4297 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0687: "8:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -415 \
  -4305 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0688: "8:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -339 \
  -4312 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0689: "8:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -264 \
  -4317 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0690: "8:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -189 \
  -4321 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0691: "8:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -113 \
  -4324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0692: "8:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -38 \
  -4325 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0693: "9:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  38 \
  -4325 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0694: "9:02 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  113 \
  -4324 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0695: "9:04 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  189 \
  -4321 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0696: "9:06 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  264 \
  -4317 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0697: "9:08 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  339 \
  -4312 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0698: "9:10 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  415 \
  -4305 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0699: "9:12 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  490 \
  -4297 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0700: "9:14 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  565 \
  -4288 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 14 complete. Sleeping 5 seconds..."
sleep 5

# Batch 15/25 (Parcels 701-750)
echo "Processing batch 15/25..."

# BRC-0701: "9:16 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  639 \
  -4277 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0702: "9:18 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  714 \
  -4266 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0703: "9:20 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  788 \
  -4253 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0704: "9:22 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  862 \
  -4238 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0705: "9:24 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  936 \
  -4222 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0706: "9:26 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1010 \
  -4205 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0707: "9:28 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1083 \
  -4187 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0708: "9:30 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1156 \
  -4168 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0709: "9:32 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1228 \
  -4147 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0710: "9:34 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1301 \
  -4125 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0711: "9:36 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1372 \
  -4101 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0712: "9:38 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1444 \
  -4077 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0713: "9:40 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1515 \
  -4051 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0714: "9:42 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1585 \
  -4024 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0715: "9:44 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1655 \
  -3996 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0716: "9:46 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1725 \
  -3966 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0717: "9:48 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1794 \
  -3936 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0718: "9:50 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1862 \
  -3904 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0719: "9:52 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1930 \
  -3871 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0720: "9:54 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1997 \
  -3836 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0721: "9:56 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2064 \
  -3801 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0722: "9:58 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2130 \
  -3764 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0723: "10:00 & MidCity"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2195 \
  -3727 \
  100 \
  800000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0724: "2:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3170 \
  5603 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0725: "2:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3072 \
  5657 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0726: "2:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2973 \
  5710 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0727: "2:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2872 \
  5761 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0728: "2:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2771 \
  5810 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0729: "2:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2670 \
  5858 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0730: "2:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2567 \
  5904 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0731: "2:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2464 \
  5947 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0732: "2:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2359 \
  5990 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0733: "2:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2254 \
  6030 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0734: "2:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2149 \
  6068 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0735: "2:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2043 \
  6105 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0736: "2:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1936 \
  6140 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0737: "2:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1828 \
  6172 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0738: "2:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1720 \
  6203 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0739: "2:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1612 \
  6232 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0740: "2:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1503 \
  6260 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0741: "2:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1393 \
  6285 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0742: "2:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1283 \
  6308 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0743: "2:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1173 \
  6330 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0744: "2:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1062 \
  6349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0745: "2:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  952 \
  6367 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0746: "2:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  840 \
  6382 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0747: "2:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  729 \
  6396 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0748: "2:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  617 \
  6408 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0749: "2:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  505 \
  6418 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0750: "2:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  393 \
  6425 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 15 complete. Sleeping 5 seconds..."
sleep 5

# Batch 16/25 (Parcels 751-800)
echo "Processing batch 16/25..."

# BRC-0751: "2:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  281 \
  6431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0752: "2:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  169 \
  6435 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0753: "2:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  56 \
  6437 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0754: "3:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -56 \
  6437 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0755: "3:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -169 \
  6435 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0756: "3:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -281 \
  6431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0757: "3:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -393 \
  6425 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0758: "3:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -505 \
  6418 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0759: "3:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -617 \
  6408 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0760: "3:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -729 \
  6396 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0761: "3:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -840 \
  6382 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0762: "3:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -952 \
  6367 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0763: "3:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1062 \
  6349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0764: "3:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1173 \
  6330 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0765: "3:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1283 \
  6308 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0766: "3:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1393 \
  6285 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0767: "3:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1503 \
  6260 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0768: "3:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1612 \
  6232 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0769: "3:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1720 \
  6203 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0770: "3:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1828 \
  6172 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0771: "3:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1936 \
  6140 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0772: "3:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2043 \
  6105 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0773: "3:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2149 \
  6068 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0774: "3:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2254 \
  6030 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0775: "3:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2359 \
  5990 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0776: "3:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2464 \
  5947 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0777: "3:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2567 \
  5904 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0778: "3:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2670 \
  5858 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0779: "3:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2771 \
  5810 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0780: "3:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2872 \
  5761 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0781: "3:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2973 \
  5710 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0782: "3:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3072 \
  5657 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0783: "3:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3170 \
  5603 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0784: "4:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3267 \
  5547 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0785: "4:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3364 \
  5489 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0786: "4:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3459 \
  5429 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0787: "4:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3553 \
  5368 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0788: "4:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3646 \
  5305 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0789: "4:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3738 \
  5241 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0790: "4:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3829 \
  5175 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0791: "4:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3919 \
  5107 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0792: "4:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4007 \
  5038 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0793: "4:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4095 \
  4967 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0794: "4:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4181 \
  4895 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0795: "4:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4266 \
  4821 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0796: "4:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4349 \
  4746 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0797: "4:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4431 \
  4670 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0798: "4:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4512 \
  4592 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0799: "4:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4592 \
  4512 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0800: "4:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4670 \
  4431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 16 complete. Sleeping 5 seconds..."
sleep 5

# Batch 17/25 (Parcels 801-850)
echo "Processing batch 17/25..."

# BRC-0801: "4:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4746 \
  4349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0802: "4:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4821 \
  4266 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0803: "4:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4895 \
  4181 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0804: "4:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4967 \
  4095 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0805: "4:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5038 \
  4007 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0806: "4:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5107 \
  3919 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0807: "4:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5175 \
  3829 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0808: "4:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5241 \
  3738 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0809: "4:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5305 \
  3646 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0810: "4:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5368 \
  3553 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0811: "4:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5429 \
  3459 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0812: "4:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5489 \
  3364 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0813: "4:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5547 \
  3267 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0814: "5:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5603 \
  3170 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0815: "5:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5657 \
  3072 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0816: "5:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5710 \
  2973 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0817: "5:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5761 \
  2872 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0818: "5:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5810 \
  2771 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0819: "5:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5858 \
  2670 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0820: "5:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5904 \
  2567 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0821: "5:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5947 \
  2464 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0822: "5:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5990 \
  2359 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0823: "5:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6030 \
  2254 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0824: "5:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6068 \
  2149 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0825: "5:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6105 \
  2043 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0826: "5:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6140 \
  1936 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0827: "5:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6172 \
  1828 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0828: "5:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6203 \
  1720 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0829: "5:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6232 \
  1612 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0830: "5:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6260 \
  1503 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0831: "5:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6285 \
  1393 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0832: "5:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6308 \
  1283 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0833: "5:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6330 \
  1173 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0834: "5:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6349 \
  1062 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0835: "5:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6367 \
  952 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0836: "5:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6382 \
  840 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0837: "5:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6396 \
  729 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0838: "5:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6408 \
  617 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0839: "5:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6418 \
  505 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0840: "5:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6425 \
  393 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0841: "5:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6431 \
  281 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0842: "5:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6435 \
  169 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0843: "5:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6437 \
  56 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0844: "6:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6437 \
  -56 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0845: "6:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6435 \
  -169 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0846: "6:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6431 \
  -281 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0847: "6:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6425 \
  -393 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0848: "6:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6418 \
  -505 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0849: "6:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6408 \
  -617 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0850: "6:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6396 \
  -729 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 17 complete. Sleeping 5 seconds..."
sleep 5

# Batch 18/25 (Parcels 851-900)
echo "Processing batch 18/25..."

# BRC-0851: "6:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6382 \
  -840 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0852: "6:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6367 \
  -952 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0853: "6:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6349 \
  -1062 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0854: "6:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6330 \
  -1173 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0855: "6:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6308 \
  -1283 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0856: "6:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6285 \
  -1393 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0857: "6:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6260 \
  -1503 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0858: "6:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6232 \
  -1612 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0859: "6:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6203 \
  -1720 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0860: "6:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6172 \
  -1828 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0861: "6:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6140 \
  -1936 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0862: "6:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6105 \
  -2043 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0863: "6:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6068 \
  -2149 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0864: "6:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6030 \
  -2254 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0865: "6:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5990 \
  -2359 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0866: "6:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5947 \
  -2464 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0867: "6:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5904 \
  -2567 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0868: "6:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5858 \
  -2670 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0869: "6:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5810 \
  -2771 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0870: "6:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5761 \
  -2872 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0871: "6:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5710 \
  -2973 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0872: "6:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5657 \
  -3072 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0873: "6:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5603 \
  -3170 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0874: "7:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5547 \
  -3267 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0875: "7:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5489 \
  -3364 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0876: "7:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5429 \
  -3459 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0877: "7:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5368 \
  -3553 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0878: "7:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5305 \
  -3646 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0879: "7:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5241 \
  -3738 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0880: "7:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5175 \
  -3829 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0881: "7:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5107 \
  -3919 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0882: "7:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5038 \
  -4007 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0883: "7:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4967 \
  -4095 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0884: "7:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4895 \
  -4181 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0885: "7:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4821 \
  -4266 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0886: "7:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4746 \
  -4349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0887: "7:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4670 \
  -4431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0888: "7:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4592 \
  -4512 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0889: "7:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4512 \
  -4592 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0890: "7:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4431 \
  -4670 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0891: "7:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4349 \
  -4746 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0892: "7:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4266 \
  -4821 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0893: "7:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4181 \
  -4895 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0894: "7:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4095 \
  -4967 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0895: "7:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4007 \
  -5038 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0896: "7:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3919 \
  -5107 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0897: "7:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3829 \
  -5175 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0898: "7:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3738 \
  -5241 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0899: "7:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3646 \
  -5305 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0900: "7:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3553 \
  -5368 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 18 complete. Sleeping 5 seconds..."
sleep 5

# Batch 19/25 (Parcels 901-950)
echo "Processing batch 19/25..."

# BRC-0901: "7:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3459 \
  -5429 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0902: "7:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3364 \
  -5489 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0903: "7:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3267 \
  -5547 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0904: "8:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3170 \
  -5603 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0905: "8:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3072 \
  -5657 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0906: "8:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2973 \
  -5710 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0907: "8:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2872 \
  -5761 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0908: "8:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2771 \
  -5810 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0909: "8:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2670 \
  -5858 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0910: "8:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2567 \
  -5904 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0911: "8:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2464 \
  -5947 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0912: "8:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2359 \
  -5990 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0913: "8:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2254 \
  -6030 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0914: "8:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2149 \
  -6068 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0915: "8:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2043 \
  -6105 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0916: "8:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1936 \
  -6140 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0917: "8:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1828 \
  -6172 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0918: "8:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1720 \
  -6203 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0919: "8:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1612 \
  -6232 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0920: "8:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1503 \
  -6260 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0921: "8:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1393 \
  -6285 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0922: "8:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1283 \
  -6308 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0923: "8:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1173 \
  -6330 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0924: "8:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1062 \
  -6349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0925: "8:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -952 \
  -6367 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0926: "8:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -840 \
  -6382 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0927: "8:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -729 \
  -6396 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0928: "8:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -617 \
  -6408 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0929: "8:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -505 \
  -6418 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0930: "8:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -393 \
  -6425 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0931: "8:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -281 \
  -6431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0932: "8:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -169 \
  -6435 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0933: "8:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -56 \
  -6437 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0934: "9:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  56 \
  -6437 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0935: "9:02 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  169 \
  -6435 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0936: "9:04 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  281 \
  -6431 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0937: "9:06 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  393 \
  -6425 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0938: "9:08 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  505 \
  -6418 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0939: "9:10 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  617 \
  -6408 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0940: "9:12 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  729 \
  -6396 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0941: "9:14 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  840 \
  -6382 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0942: "9:16 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  952 \
  -6367 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0943: "9:18 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1062 \
  -6349 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0944: "9:20 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1173 \
  -6330 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0945: "9:22 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1283 \
  -6308 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0946: "9:24 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1393 \
  -6285 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0947: "9:26 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1503 \
  -6260 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0948: "9:28 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1612 \
  -6232 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0949: "9:30 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1720 \
  -6203 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0950: "9:32 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1828 \
  -6172 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 19 complete. Sleeping 5 seconds..."
sleep 5

# Batch 20/25 (Parcels 951-1000)
echo "Processing batch 20/25..."

# BRC-0951: "9:34 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1936 \
  -6140 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0952: "9:36 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2043 \
  -6105 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0953: "9:38 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2149 \
  -6068 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0954: "9:40 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2254 \
  -6030 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0955: "9:42 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2359 \
  -5990 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0956: "9:44 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2464 \
  -5947 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0957: "9:46 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2567 \
  -5904 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0958: "9:48 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2670 \
  -5858 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0959: "9:50 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2771 \
  -5810 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0960: "9:52 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2872 \
  -5761 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0961: "9:54 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2973 \
  -5710 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0962: "9:56 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3072 \
  -5657 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0963: "9:58 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3170 \
  -5603 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0964: "10:00 & Igopogo"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3267 \
  -5547 \
  100 \
  400000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0965: "2:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4768 \
  8427 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0966: "2:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4620 \
  8509 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0967: "2:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4471 \
  8588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0968: "2:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4320 \
  8665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0969: "2:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4168 \
  8739 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0970: "2:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4015 \
  8811 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0971: "2:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3861 \
  8879 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0972: "2:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3705 \
  8945 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0973: "2:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3549 \
  9009 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0974: "2:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3391 \
  9069 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0975: "2:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3232 \
  9127 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0976: "2:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3072 \
  9182 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0977: "2:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2912 \
  9234 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0978: "2:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2750 \
  9284 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0979: "2:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2588 \
  9330 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0980: "2:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2424 \
  9374 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0981: "2:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2260 \
  9415 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0982: "2:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2096 \
  9453 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0983: "2:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1930 \
  9488 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0984: "2:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1764 \
  9520 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0985: "2:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1598 \
  9550 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0986: "2:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1431 \
  9576 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0987: "2:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1264 \
  9600 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0988: "2:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1096 \
  9620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0989: "2:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  928 \
  9638 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0990: "2:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  760 \
  9653 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0991: "2:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  591 \
  9664 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0992: "2:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  422 \
  9673 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0993: "2:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  253 \
  9679 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0994: "2:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  84 \
  9682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0995: "3:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -84 \
  9682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0996: "3:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -253 \
  9679 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0997: "3:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -422 \
  9673 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0998: "3:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -591 \
  9664 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-0999: "3:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -760 \
  9653 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1000: "3:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -928 \
  9638 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 20 complete. Sleeping 5 seconds..."
sleep 5

# Batch 21/25 (Parcels 1001-1050)
echo "Processing batch 21/25..."

# BRC-1001: "3:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1096 \
  9620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1002: "3:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1264 \
  9600 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1003: "3:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1431 \
  9576 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1004: "3:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1598 \
  9550 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1005: "3:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1764 \
  9520 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1006: "3:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1930 \
  9488 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1007: "3:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2096 \
  9453 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1008: "3:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2260 \
  9415 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1009: "3:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2424 \
  9374 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1010: "3:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2588 \
  9330 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1011: "3:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2750 \
  9284 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1012: "3:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2912 \
  9234 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1013: "3:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3072 \
  9182 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1014: "3:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3232 \
  9127 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1015: "3:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3391 \
  9069 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1016: "3:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3549 \
  9009 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1017: "3:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3705 \
  8945 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1018: "3:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3861 \
  8879 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1019: "3:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4015 \
  8811 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1020: "3:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4168 \
  8739 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1021: "3:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4320 \
  8665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1022: "3:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4471 \
  8588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1023: "3:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4620 \
  8509 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1024: "3:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4768 \
  8427 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1025: "4:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4914 \
  8343 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1026: "4:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5059 \
  8256 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1027: "4:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5202 \
  8166 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1028: "4:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5344 \
  8074 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1029: "4:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5484 \
  7980 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1030: "4:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5623 \
  7883 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1031: "4:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5759 \
  7783 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1032: "4:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5894 \
  7682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1033: "4:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6027 \
  7578 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1034: "4:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6159 \
  7471 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1035: "4:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6288 \
  7363 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1036: "4:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6416 \
  7252 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1037: "4:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6541 \
  7139 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1038: "4:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6665 \
  7023 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1039: "4:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6787 \
  6906 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1040: "4:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6906 \
  6787 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1041: "4:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7023 \
  6665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1042: "4:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7139 \
  6541 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1043: "4:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7252 \
  6416 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1044: "4:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7363 \
  6288 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1045: "4:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7471 \
  6159 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1046: "4:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7578 \
  6027 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1047: "4:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7682 \
  5894 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1048: "4:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7783 \
  5759 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1049: "4:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7883 \
  5623 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1050: "4:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7980 \
  5484 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 21 complete. Sleeping 5 seconds..."
sleep 5

# Batch 22/25 (Parcels 1051-1100)
echo "Processing batch 22/25..."

# BRC-1051: "4:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8074 \
  5344 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1052: "4:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8166 \
  5202 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1053: "4:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8256 \
  5059 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1054: "4:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8343 \
  4914 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1055: "5:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8427 \
  4768 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1056: "5:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8509 \
  4620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1057: "5:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8588 \
  4471 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1058: "5:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8665 \
  4320 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1059: "5:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8739 \
  4168 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1060: "5:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8811 \
  4015 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1061: "5:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8879 \
  3861 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1062: "5:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8945 \
  3705 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1063: "5:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9009 \
  3549 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1064: "5:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9069 \
  3391 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1065: "5:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9127 \
  3232 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1066: "5:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9182 \
  3072 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1067: "5:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9234 \
  2912 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1068: "5:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9284 \
  2750 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1069: "5:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9330 \
  2588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1070: "5:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9374 \
  2424 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1071: "5:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9415 \
  2260 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1072: "5:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9453 \
  2096 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1073: "5:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9488 \
  1930 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1074: "5:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9520 \
  1764 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1075: "5:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9550 \
  1598 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1076: "5:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9576 \
  1431 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1077: "5:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9600 \
  1264 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1078: "5:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9620 \
  1096 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1079: "5:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9638 \
  928 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1080: "5:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9653 \
  760 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1081: "5:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9664 \
  591 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1082: "5:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9673 \
  422 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1083: "5:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9679 \
  253 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1084: "5:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9682 \
  84 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1085: "6:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9682 \
  -84 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1086: "6:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9679 \
  -253 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1087: "6:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9673 \
  -422 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1088: "6:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9664 \
  -591 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1089: "6:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9653 \
  -760 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1090: "6:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9638 \
  -928 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1091: "6:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9620 \
  -1096 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1092: "6:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9600 \
  -1264 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1093: "6:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9576 \
  -1431 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1094: "6:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9550 \
  -1598 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1095: "6:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9520 \
  -1764 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1096: "6:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9488 \
  -1930 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1097: "6:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9453 \
  -2096 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1098: "6:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9415 \
  -2260 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1099: "6:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9374 \
  -2424 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1100: "6:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9330 \
  -2588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 22 complete. Sleeping 5 seconds..."
sleep 5

# Batch 23/25 (Parcels 1101-1150)
echo "Processing batch 23/25..."

# BRC-1101: "6:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9284 \
  -2750 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1102: "6:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9234 \
  -2912 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1103: "6:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9182 \
  -3072 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1104: "6:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9127 \
  -3232 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1105: "6:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9069 \
  -3391 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1106: "6:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -9009 \
  -3549 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1107: "6:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8945 \
  -3705 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1108: "6:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8879 \
  -3861 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1109: "6:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8811 \
  -4015 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1110: "6:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8739 \
  -4168 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1111: "6:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8665 \
  -4320 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1112: "6:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8588 \
  -4471 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1113: "6:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8509 \
  -4620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1114: "6:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8427 \
  -4768 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1115: "7:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8343 \
  -4914 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1116: "7:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8256 \
  -5059 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1117: "7:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8166 \
  -5202 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1118: "7:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -8074 \
  -5344 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1119: "7:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7980 \
  -5484 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1120: "7:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7883 \
  -5623 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1121: "7:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7783 \
  -5759 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1122: "7:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7682 \
  -5894 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1123: "7:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7578 \
  -6027 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1124: "7:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7471 \
  -6159 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1125: "7:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7363 \
  -6288 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1126: "7:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7252 \
  -6416 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1127: "7:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7139 \
  -6541 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1128: "7:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -7023 \
  -6665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1129: "7:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6906 \
  -6787 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1130: "7:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6787 \
  -6906 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1131: "7:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6665 \
  -7023 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1132: "7:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6541 \
  -7139 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1133: "7:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6416 \
  -7252 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1134: "7:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6288 \
  -7363 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1135: "7:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6159 \
  -7471 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1136: "7:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -6027 \
  -7578 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1137: "7:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5894 \
  -7682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1138: "7:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5759 \
  -7783 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1139: "7:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5623 \
  -7883 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1140: "7:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5484 \
  -7980 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1141: "7:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5344 \
  -8074 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1142: "7:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5202 \
  -8166 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1143: "7:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -5059 \
  -8256 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1144: "7:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4914 \
  -8343 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1145: "8:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4768 \
  -8427 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1146: "8:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4620 \
  -8509 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1147: "8:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4471 \
  -8588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1148: "8:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4320 \
  -8665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1149: "8:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4168 \
  -8739 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1150: "8:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -4015 \
  -8811 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 23 complete. Sleeping 5 seconds..."
sleep 5

# Batch 24/25 (Parcels 1151-1200)
echo "Processing batch 24/25..."

# BRC-1151: "8:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3861 \
  -8879 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1152: "8:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3705 \
  -8945 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1153: "8:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3549 \
  -9009 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1154: "8:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3391 \
  -9069 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1155: "8:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3232 \
  -9127 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1156: "8:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -3072 \
  -9182 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1157: "8:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2912 \
  -9234 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1158: "8:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2750 \
  -9284 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1159: "8:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2588 \
  -9330 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1160: "8:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2424 \
  -9374 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1161: "8:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2260 \
  -9415 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1162: "8:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -2096 \
  -9453 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1163: "8:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1930 \
  -9488 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1164: "8:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1764 \
  -9520 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1165: "8:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1598 \
  -9550 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1166: "8:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1431 \
  -9576 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1167: "8:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1264 \
  -9600 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1168: "8:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -1096 \
  -9620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1169: "8:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -928 \
  -9638 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1170: "8:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -760 \
  -9653 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1171: "8:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -591 \
  -9664 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1172: "8:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -422 \
  -9673 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1173: "8:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -253 \
  -9679 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1174: "8:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  -84 \
  -9682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1175: "9:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  84 \
  -9682 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1176: "9:02 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  253 \
  -9679 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1177: "9:04 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  422 \
  -9673 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1178: "9:06 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  591 \
  -9664 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1179: "9:08 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  760 \
  -9653 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1180: "9:10 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  928 \
  -9638 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1181: "9:12 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1096 \
  -9620 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1182: "9:14 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1264 \
  -9600 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1183: "9:16 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1431 \
  -9576 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1184: "9:18 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1598 \
  -9550 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1185: "9:20 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1764 \
  -9520 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1186: "9:22 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  1930 \
  -9488 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1187: "9:24 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2096 \
  -9453 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1188: "9:26 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2260 \
  -9415 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1189: "9:28 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2424 \
  -9374 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1190: "9:30 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2588 \
  -9330 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1191: "9:32 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2750 \
  -9284 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1192: "9:34 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  2912 \
  -9234 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1193: "9:36 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3072 \
  -9182 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1194: "9:38 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3232 \
  -9127 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1195: "9:40 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3391 \
  -9069 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1196: "9:42 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3549 \
  -9009 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1197: "9:44 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3705 \
  -8945 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1198: "9:46 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  3861 \
  -8879 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1199: "9:48 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4015 \
  -8811 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1200: "9:50 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4168 \
  -8739 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 24 complete. Sleeping 5 seconds..."
sleep 5

# Batch 25/25 (Parcels 1201-1205)
echo "Processing batch 25/25..."

# BRC-1201: "9:52 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4320 \
  -8665 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1202: "9:54 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4471 \
  -8588 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1203: "9:56 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4620 \
  -8509 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1204: "9:58 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4768 \
  -8427 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

# BRC-1205: "10:00 & Kraken"
cast send $HYPERLAND_CORE_ADDRESS \
  "mintParcel(address,uint256,uint256,uint256,uint256)" \
  $INITIAL_OWNER \
  4914 \
  -8343 \
  100 \
  200000000000000000000 \
  --rpc-url base_sepolia \
  --private-key $PRIVATE_KEY \
  --gas-limit 500000

echo "Batch 25 complete. Sleeping 5 seconds..."
sleep 5

echo ""
echo "==================================="
echo "Minting Complete!"
echo "==================================="
echo "Total Parcels Minted: 1205"
