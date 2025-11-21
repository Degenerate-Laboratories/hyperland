# HyperLand Smart Contracts

Smart contracts for the HyperLand blockchain land management ecosystem on Base.

## Contracts

### LAND Token (ERC-20)
- **Symbol**: LAND
- **Total Supply**: 21,000,000 tokens
- **Decimals**: 18
- **Standard**: ERC-20 (OpenZeppelin v5.5.0)
- **Network**: Base Mainnet

The LAND token is the primary utility token for the HyperLand ecosystem, used for:
- Purchasing virtual land parcels
- Staking and governance
- Ecosystem rewards

## Development

Built with [Foundry](https://book.getfoundry.sh/), a blazing fast, portable and modular toolkit for Ethereum development.

### Prerequisites

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Setup

```bash
# Install dependencies
forge install

# Copy environment template
cp .env.example .env

# Edit .env with your values
nano .env
```

### Build

```bash
forge build
```

### Test

```bash
# Run all tests
forge test

# Run with verbosity
forge test -vv

# Run specific test
forge test --match-test testInitialSupply -vv

# Generate gas report
forge test --gas-report
```

### Deploy

See [DEPLOYMENT.md](./DEPLOYMENT.md) for complete deployment guide.

```bash
# Dry run (simulation)
forge script script/DeployLAND.s.sol:DeployLAND --rpc-url base

# Deploy to Base mainnet
forge script script/DeployLAND.s.sol:DeployLAND \
  --rpc-url base \
  --broadcast \
  --verify
```

### Local Development

```bash
# Start local node
anvil

# Deploy to local node (different terminal)
forge script script/DeployLAND.s.sol:DeployLAND \
  --rpc-url http://localhost:8545 \
  --broadcast
```

## Project Structure

```
contracts/
├── src/
│   └── LANDToken.sol          # LAND ERC-20 token
├── script/
│   ├── DeployLAND.s.sol       # Deployment script
│   └── CheckBalance.s.sol     # Balance checker
├── test/
│   └── LANDToken.t.sol        # Token tests
├── deployments/               # Deployment artifacts
├── foundry.toml              # Foundry config
├── .env.example              # Environment template
├── DEPLOYMENT.md             # Deployment guide
└── README.md                 # This file
```

## Testing

All tests pass with 100% coverage of core functionality:

```
✅ testInitialSupply           - Verify 21M supply
✅ testTokenMetadata          - Check name, symbol, decimals
✅ testAdminOwnership         - Verify admin ownership
✅ testTransfer               - Test token transfers
✅ testTransferFrom           - Test delegated transfers
✅ testApprove                - Test approvals
✅ testRevert*                - Test failure cases
```

Run tests:
```bash
forge test -vv
```

## Gas Optimization

The contract is optimized for gas efficiency:
- Uses OpenZeppelin's battle-tested implementations
- Minimal storage operations
- Optimized with Solidity 0.8.20 IR optimizer

## Security

- Built on OpenZeppelin v5.5.0 (audited, battle-tested)
- Fixed supply (no minting after deployment)
- Admin ownership for governance
- Comprehensive test coverage
- Follows ERC-20 standard

## License

MIT

## Support

- Foundry docs: https://book.getfoundry.sh/
- Base docs: https://docs.base.org/
- OpenZeppelin: https://docs.openzeppelin.com/
