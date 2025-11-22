# HyperLand Deployment Guide

This guide covers deploying the HyperLand platform to production.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Smart Contract Deployment](#smart-contract-deployment)
- [Frontend Deployment](#frontend-deployment)
- [Database Setup](#database-setup)
- [Post-Deployment](#post-deployment)

## Prerequisites

### Required Tools
- **Node.js 18+** and npm
- **Foundry** (for smart contracts) - Install: `curl -L https://foundry.paradigm.xyz | bash`
- **Docker & Docker Compose** (for PostgreSQL)
- **Vercel CLI** (optional) - Install: `npm i -g vercel`

### Required Accounts
- **Alchemy** account for RPC endpoints (https://alchemy.com)
- **WalletConnect** Project ID (https://cloud.walletconnect.com)
- **Vercel** account for hosting (https://vercel.com)
- **Ethereum wallet** with funds for contract deployment

## Smart Contract Deployment

### 1. Install Foundry (if not already installed)
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 2. Build and Test Contracts
```bash
cd contracts
forge build
forge test -vv
```

### 3. Deploy to Network

For testnet (Base Sepolia):
```bash
forge script script/Deploy.s.sol \
  --rpc-url https://sepolia.base.org \
  --private-key YOUR_PRIVATE_KEY \
  --broadcast \
  --verify
```

For mainnet (Base):
```bash
forge script script/Deploy.s.sol \
  --rpc-url https://mainnet.base.org \
  --private-key YOUR_PRIVATE_KEY \
  --broadcast \
  --verify
```

### 4. Save Contract Addresses
After deployment, save the following addresses:
- `HYPERLAND_CORE_ADDRESS`
- `LAND_TOKEN_ADDRESS`
- `LAND_DEED_ADDRESS`

## Database Setup

### 1. Install Docker Desktop (macOS)
Download and install from: https://www.docker.com/products/docker-desktop

### 2. Start PostgreSQL
```bash
make db-up
```

### 3. Verify Database Connection
```bash
make db-shell
# You should see a PostgreSQL prompt
```

### 4. Production Database
For production, use a managed PostgreSQL service:
- **Vercel Postgres** (recommended for Vercel deployments)
- **Supabase** (https://supabase.com)
- **Railway** (https://railway.app)
- **Neon** (https://neon.tech)

## Frontend Deployment

### Landing Page (Main App)

#### Option 1: Deploy to Vercel (Recommended)

1. **Install Vercel CLI**
```bash
npm i -g vercel
```

2. **Deploy from CLI**
```bash
cd projects/frontend
vercel
```

3. **Configure Environment Variables in Vercel Dashboard**
   - Go to Project Settings > Environment Variables
   - Add all variables from `.env.example`:
     - `DATABASE_URL`
     - `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID`
     - `NEXT_PUBLIC_ALCHEMY_API_KEY`
     - `NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS`
     - `NEXT_PUBLIC_LAND_TOKEN_ADDRESS`
     - `NEXT_PUBLIC_LAND_DEED_ADDRESS`
     - `NEXT_PUBLIC_CHAIN_ID`
     - `NEXT_PUBLIC_NETWORK_NAME`

4. **Deploy to Production**
```bash
vercel --prod
```

#### Option 2: Self-Hosted with Docker

1. **Create Dockerfile** (if needed)
2. **Build and run**:
```bash
docker build -t hyperland-frontend .
docker run -p 3000:3000 hyperland-frontend
```

### Hyperfy App

Same process as Landing Page:
```bash
cd projects/hypery-hyperland/frontend
vercel
# Configure environment variables
vercel --prod
```

## Environment Variables Reference

### Landing Page (`projects/frontend`)

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://user:pass@host:5432/db` |
| `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID` | WalletConnect project ID | `abc123...` |
| `NEXT_PUBLIC_ALCHEMY_API_KEY` | Alchemy API key | `xyz789...` |
| `NEXT_PUBLIC_RPC_URL` | Blockchain RPC URL | `https://base-mainnet.g.alchemy.com/v2/KEY` |
| `NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS` | Deployed core contract address | `0x...` |
| `NEXT_PUBLIC_LAND_TOKEN_ADDRESS` | Deployed token address | `0x...` |
| `NEXT_PUBLIC_LAND_DEED_ADDRESS` | Deployed NFT address | `0x...` |
| `NEXT_PUBLIC_CHAIN_ID` | Network chain ID | `8453` (Base) or `84532` (Base Sepolia) |
| `NEXT_PUBLIC_NETWORK_NAME` | Network name | `base` or `base-sepolia` |

### Hyperfy App (`projects/hypery-hyperland/frontend`)

Similar to above, but without database variables.

## Post-Deployment Checklist

- [ ] Smart contracts deployed and verified on block explorer
- [ ] Contract addresses updated in frontend environment variables
- [ ] Database connected and accessible
- [ ] Frontend applications deployed and accessible
- [ ] Wallet connection working (test with MetaMask)
- [ ] Test LAND token purchase flow
- [ ] Test parcel purchase flow
- [ ] Test property tax payment
- [ ] Set up monitoring (Sentry, LogRocket, etc.)
- [ ] Configure custom domain (if applicable)
- [ ] Set up SSL/TLS certificates
- [ ] Enable CORS if needed for API routes

## Testing Production Build Locally

Before deploying, test the production build locally:

### Landing Page
```bash
cd projects/frontend
npm run build
npm start
# Visit http://localhost:3000
```

### Hyperfy App
```bash
cd projects/hypery-hyperland/frontend
npm run build
npm start
# Visit http://localhost:3000
```

## Monitoring & Maintenance

### Health Checks
- Monitor contract gas usage
- Check database connection pool
- Monitor RPC endpoint rate limits
- Track frontend error rates

### Recommended Services
- **Sentry** for error tracking
- **Vercel Analytics** for performance monitoring
- **Tenderly** for smart contract monitoring
- **PagerDuty** for alerting

## Rollback Procedure

If issues arise:

1. **Revert Frontend**: Use Vercel's instant rollback feature
2. **Database**: Restore from backup
3. **Smart Contracts**: Cannot be rolled back - deploy new version with fixes

## Support & Resources

- **Main README**: [README.md](./README.md)
- **Smart Contracts Docs**: [docs/smart-contracts-plan.md](./docs/smart-contracts-plan.md)
- **Foundry Docs**: https://book.getfoundry.sh/
- **Next.js Deployment**: https://nextjs.org/docs/deployment
- **Vercel Docs**: https://vercel.com/docs

## Quick Deploy Commands

```bash
# Full build and deploy workflow
make build                    # Build both frontends
make test                     # Run contract tests
cd contracts && forge script script/Deploy.s.sol --broadcast  # Deploy contracts
cd projects/frontend && vercel --prod              # Deploy landing page
cd projects/hypery-hyperland/frontend && vercel --prod  # Deploy hyperfy app
```

---

**Note**: Always test on testnet (Base Sepolia) before deploying to mainnet!
