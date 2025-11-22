# HyperLand - Quick Setup Guide

## Current Status

✅ **Completed:**
- Project structure initialized
- Git submodules configured
- Dependencies installed
- Development servers tested
- Production builds successful
- Environment templates created
- Deployment configurations ready

⚠️ **Pending:**
- Docker/Docker Compose installation (for PostgreSQL)
- Foundry installation (for smart contract development)
- Smart contract implementation
- Environment variable configuration
- Database initialization

## Quick Start (Development)

### 1. Start Development Servers
```bash
make start
```

This will start:
- Landing page: http://localhost:4001
- Hyperfy app: http://localhost:4000

### 2. Build for Production
```bash
make build
```

Both projects build successfully!

## What You Need to Install

### 1. Docker Desktop (for Database)
```bash
# Download from:
https://www.docker.com/products/docker-desktop

# After installation, start database:
make db-up
```

### 2. Foundry (for Smart Contracts)
```bash
# Install Foundry:
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Build contracts:
cd contracts
forge build
forge test
```

### 3. Environment Variables

Copy the example files and fill in your values:

**Landing Page:**
```bash
cp projects/frontend/.env.example projects/frontend/.env.local
# Edit projects/frontend/.env.local with your values
```

**Hyperfy App:**
```bash
cp projects/hypery-hyperland/frontend/.env.example projects/hypery-hyperland/frontend/.env.local
# Edit projects/hypery-hyperland/frontend/.env.local with your values
```

**Required API Keys:**
- **Alchemy**: Get free API key at https://alchemy.com
- **WalletConnect**: Get project ID at https://cloud.walletconnect.com

## Development Workflow

### Common Commands

```bash
# Start everything
make start

# Build for production
make build

# Run tests
make test

# Start database
make db-up

# Stop database
make db-down

# View database logs
make db-logs

# Connect to database shell
make db-shell

# View all available commands
make help
```

### Project Structure

```
hyperland/
├── projects/
│   ├── frontend/                    # Main landing page (Next.js)
│   │   ├── .env.example            # Environment template
│   │   ├── vercel.json             # Vercel deployment config
│   │   └── app/                    # Next.js app router
│   │
│   ├── hypery-hyperland/           # Hyperfy submodule
│   │   └── frontend/               # Hyperfy frontend (Next.js)
│   │       ├── .env.example        # Environment template
│   │       └── vercel.json         # Vercel deployment config
│   │
│   └── shared/                     # Shared utilities
│
├── contracts/                       # Foundry smart contracts
│   ├── src/                        # Solidity contracts
│   ├── test/                       # Contract tests
│   └── script/                     # Deployment scripts
│
├── db/                             # Database initialization
├── docs/                           # Documentation
├── Makefile                        # Build automation
├── docker-compose.yml              # PostgreSQL config
├── DEPLOYMENT.md                   # Deployment guide
└── README.md                       # Project overview
```

## Next Steps for Deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md) for full deployment guide.

### Quick Deploy to Vercel

1. **Install Vercel CLI**
```bash
npm i -g vercel
```

2. **Deploy Landing Page**
```bash
cd projects/frontend
vercel
```

3. **Deploy Hyperfy**
```bash
cd projects/hypery-hyperland/frontend
vercel
```

4. **Configure Environment Variables**
   - Go to Vercel Dashboard → Project Settings → Environment Variables
   - Add all variables from `.env.example`

## Troubleshooting

### Port Already in Use
```bash
make kill-ports
```

### Submodule Issues
```bash
git submodule update --init --recursive
```

### Build Errors
```bash
# Clean and rebuild
make clean
rm -rf projects/*/node_modules
make install
make build
```

### Database Connection Issues
```bash
# Reset database
make db-reset

# Check logs
make db-logs
```

## Important Files Created

- ✅ `projects/frontend/.env.example` - Environment template for landing page
- ✅ `projects/hypery-hyperland/frontend/.env.example` - Environment template for hyperfy
- ✅ `projects/frontend/vercel.json` - Deployment config for landing page
- ✅ `projects/hypery-hyperland/frontend/vercel.json` - Deployment config for hyperfy
- ✅ `DEPLOYMENT.md` - Complete deployment guide
- ✅ `Makefile` - Updated with correct paths

## Resources

- **Main README**: [README.md](./README.md)
- **Deployment Guide**: [DEPLOYMENT.md](./DEPLOYMENT.md)
- **Smart Contracts Plan**: [docs/smart-contracts-plan.md](./docs/smart-contracts-plan.md)
- **Next.js Docs**: https://nextjs.org/docs
- **Foundry Book**: https://book.getfoundry.sh/
- **Vercel Docs**: https://vercel.com/docs

---

**You're all set!** Run `make start` to begin development.
