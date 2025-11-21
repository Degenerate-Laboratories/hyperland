# LAND Token Deployment Guide

## Overview

LAND Token is an ERC-20 token with a fixed supply of 21,000,000 tokens. This guide covers deployment to Base mainnet.

## Contract Details

- **Name**: LAND Token
- **Symbol**: LAND
- **Total Supply**: 21,000,000 LAND
- **Decimals**: 18
- **Network**: Base Mainnet
- **Standard**: ERC-20

## Prerequisites

1. **Foundry** installed (`curl -L https://foundry.paradigm.xyz | bash`)
2. **Private key** with ETH for gas fees on Base mainnet
3. **Admin wallet address** to receive initial token supply
4. **Basescan API key** for contract verification (get from https://basescan.org/myapikey)

## Setup

1. **Clone repository and navigate to contracts directory**
```bash
cd /Users/highlander/gamedev/hyperland/contracts
```

2. **Install dependencies** (already done)
```bash
forge install
```

3. **Create .env file**
```bash
cp .env.example .env
```

4. **Configure .env file** with your values:
```bash
# Your deployer wallet private key (DO NOT COMMIT!)
PRIVATE_KEY=0x1234567890abcdef...

# Admin wallet to receive 21M LAND tokens
ADMIN_ADDRESS=0xYourAdminWalletAddress

# Basescan API key for verification
BASESCAN_API_KEY=your_api_key_here
```

## Deployment

### Step 1: Dry Run (Simulation)

Test the deployment without broadcasting:

```bash
forge script script/DeployLAND.s.sol:DeployLAND --rpc-url base
```

This will simulate the deployment and show you:
- Gas estimates
- Deployer address
- Admin address that will receive tokens
- Contract address (simulated)

### Step 2: Deploy to Base Mainnet

**IMPORTANT**: This will use real ETH and deploy to mainnet!

```bash
forge script script/DeployLAND.s.sol:DeployLAND \
  --rpc-url base \
  --broadcast \
  --verify
```

### Step 3: Verify Deployment

The deployment will:
1. Deploy LAND token contract
2. Mint 21M tokens to admin address
3. Verify contract on Basescan
4. Save deployment info to `deployments/base-mainnet.env`

Check the deployment file:
```bash
cat deployments/base-mainnet.env
```

## Post-Deployment Verification

### 1. Check Contract on Basescan

Visit: `https://basescan.org/address/YOUR_CONTRACT_ADDRESS`

Verify:
- Contract is verified (green checkmark)
- Total supply is 21,000,000 LAND
- Admin has full balance

### 2. Check Admin Balance

```bash
forge script script/CheckBalance.s.sol:CheckBalance --rpc-url base
```

Or manually on Basescan:
`https://basescan.org/token/YOUR_CONTRACT_ADDRESS?a=YOUR_ADMIN_ADDRESS`

### 3. Test Transfer (Optional)

```bash
# Transfer 100 LAND to test address
cast send YOUR_CONTRACT_ADDRESS \
  "transfer(address,uint256)" \
  0xTestAddress \
  100000000000000000000 \
  --rpc-url base \
  --private-key $PRIVATE_KEY
```

## Security Notes

1. **NEVER commit your .env file or private keys**
2. The .env file is already in .gitignore
3. Store admin private key securely (hardware wallet recommended)
4. Consider using a multisig for admin address
5. Verify contract source code on Basescan

## Contract Addresses

After deployment, update this section:

- **LAND Token**: `TBD`
- **Admin Address**: `TBD`
- **Deployment Block**: `TBD`
- **Deployment TX**: `TBD`

## Gas Estimates

Estimated gas costs on Base mainnet:
- Deployment: ~0.001 ETH
- Verification: Free (Basescan API)

## Troubleshooting

### Issue: "insufficient funds for gas * price + value"
**Solution**: Ensure deployer wallet has enough ETH on Base mainnet

### Issue: "nonce too low"
**Solution**: Wait for previous transaction to confirm, or specify nonce manually

### Issue: "Contract verification failed"
**Solution**: Run verification separately:
```bash
forge verify-contract \
  YOUR_CONTRACT_ADDRESS \
  src/LANDToken.sol:LANDToken \
  --chain-id 8453 \
  --constructor-args $(cast abi-encode "constructor(address)" YOUR_ADMIN_ADDRESS)
```

### Issue: "RPC URL not responding"
**Solution**: Try alternative Base RPC:
- `https://mainnet.base.org` (default)
- `https://base.llamarpc.com`
- `https://1rpc.io/base`

## Next Steps

After successful deployment:

1. **Update frontend configuration** with LAND token address
2. **Implement token sale contract** (if needed)
3. **Set up token distribution plan**
4. **Configure admin controls** for land parcel sales
5. **Integrate with HyperDeed NFT system**

## Support

For deployment issues:
- Check Foundry docs: https://book.getfoundry.sh/
- Base docs: https://docs.base.org/
- Basescan: https://basescan.org/
