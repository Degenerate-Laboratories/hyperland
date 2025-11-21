# LAND Token Deployment - Base Mainnet

## Deployment Information

**Date**: November 21, 2025
**Network**: Base Mainnet (Chain ID: 8453)
**Status**: ✅ Deployed & Verified

### Contract Details

| Property | Value |
|----------|-------|
| Contract Address | `0x9E284a80a911b6121070df2BdD2e8C4527b74796` |
| Contract Name | LAND Token |
| Symbol | LAND |
| Decimals | 18 |
| Total Supply | 21,000,000 LAND |
| Standard | ERC-20 (OpenZeppelin v5.5.0) |
| Admin Address | `0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D` |
| Deployment Block | 38484102 |
| Deployment TX | [View on Basescan](https://basescan.org/address/0x9e284a80a911b6121070df2bdd2e8c4527b74796) |

### Links

- **Contract on Basescan**: https://basescan.org/address/0x9e284a80a911b6121070df2bdd2e8c4527b74796
- **Admin Wallet**: https://basescan.org/address/0x286A19A5f355bB63Cc03FfE95Fa6D8EE3022fE8D

## Token Economics

### Supply Distribution

- **Total Supply**: 21,000,000 LAND (fixed, non-mintable)
- **Initial Distribution**: 100% to admin wallet
- **Decimals**: 18 (standard ERC-20)

### Use Cases

The LAND token is the primary utility token for the HyperLand ecosystem:

1. **Land Parcel Purchases**: Buy virtual land plots via bonding curve
2. **Auction Participation**: Bid on premium land parcels
3. **Governance**: Vote on ecosystem proposals
4. **Staking**: Earn rewards for ecosystem participation
5. **Marketplace**: Trade land parcels and assets

## Technical Details

### Contract Implementation

- **Base Contract**: OpenZeppelin ERC-20 v5.5.0
- **Additional Features**: Ownable (for governance)
- **Compiler**: Solidity 0.8.20
- **Optimization**: Enabled (200 runs)
- **Security**: Audited OpenZeppelin implementation

### Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LANDToken is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 21_000_000 * 10**18;

    constructor(address admin) ERC20("LAND Token", "LAND") Ownable(admin) {
        require(admin != address(0), "LANDToken: admin is zero address");
        _mint(admin, TOTAL_SUPPLY);
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }
}
```

### Deployment Configuration

**Foundry Configuration** (`foundry.toml`):
```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.20"
optimizer = true
optimizer_runs = 200
via_ir = true
fs_permissions = [{ access = "read-write", path = "./deployments" }]

[rpc_endpoints]
base = "https://mainnet.base.org"

[etherscan]
base = { key = "${ETHERSCAN_API_KEY}" }
```

## Security

### Audit Status

- ✅ OpenZeppelin v5.5.0 (battle-tested, audited)
- ✅ Fixed supply (no minting after deployment)
- ✅ Standard ERC-20 implementation
- ✅ Comprehensive test coverage (10/10 tests passing)

### Test Results

```
✅ testInitialSupply           - Verify 21M supply
✅ testTokenMetadata          - Check name, symbol, decimals
✅ testAdminOwnership         - Verify admin ownership
✅ testTransfer               - Test token transfers
✅ testTransferFrom           - Test delegated transfers
✅ testApprove                - Test approvals
✅ testRevertWhenTransferInsufficientBalance
✅ testRevertWhenTransferFromWithoutApproval
✅ testRevertWhenConstructorZeroAddress
✅ testMultipleTransfers
```

### Admin Wallet Security

**Mnemonic**: Stored securely in `contracts/.env` (gitignored)
**Private Key**: Derived from mnemonic
**Backup**: ⚠️ Ensure mnemonic is backed up securely offline

## Gas Costs

- **Deployment Cost**: ~0.000005 ETH (~$0.02 at current prices)
- **Transfer Cost**: ~50,000 gas (~$0.0003)
- **Approval Cost**: ~45,000 gas (~$0.0003)

## Integration Guide

### Frontend Integration

```typescript
// Token ABI (standard ERC-20)
const LAND_TOKEN_ADDRESS = '0x9E284a80a911b6121070df2BdD2e8C4527b74796';

// Using ethers.js
import { ethers } from 'ethers';

const LANDAbi = [
  "function balanceOf(address owner) view returns (uint256)",
  "function transfer(address to, uint256 amount) returns (bool)",
  "function approve(address spender, uint256 amount) returns (bool)",
  "function allowance(address owner, address spender) view returns (uint256)"
];

const landToken = new ethers.Contract(LAND_TOKEN_ADDRESS, LANDAbi, provider);
```

### Web3 Integration

```javascript
// Check balance
const balance = await landToken.balanceOf(userAddress);

// Transfer tokens
const tx = await landToken.transfer(recipientAddress, amount);
await tx.wait();

// Approve spending
const approveTx = await landToken.approve(spenderAddress, amount);
await approveTx.wait();
```

## Next Steps

### Phase 2: HyperDeed NFT System

Now that LAND token is deployed, the next phase involves:

1. **HyperDeed Contract**: ERC-721 NFT for land parcels
2. **Plot Management**: Coordinate-based land ownership
3. **Auction House**: Dutch auction for premium parcels
4. **Bonding Curve**: Price discovery for initial sales
5. **Marketplace**: Secondary market for land trading

### Bonding Curve Design

Initial land sales will use a bonding curve:
- **Formula**: Price increases with supply
- **Benefits**: Fair price discovery, liquidity
- **Implementation**: Dedicated bonding curve contract

### Architecture

```
LAND Token (ERC-20) ← Bonding Curve Contract
                    ↓
            HyperDeed NFT (ERC-721)
                    ↓
         ┌──────────┴──────────┐
    Auction House          Marketplace
```

## Changelog

### v1.0.0 - November 21, 2025
- ✅ Initial deployment to Base mainnet
- ✅ 21M LAND tokens minted to admin
- ✅ Contract verified on Basescan
- ✅ All tests passing

## Support & Resources

- **Documentation**: `/contracts/README.md`
- **Deployment Guide**: `/contracts/DEPLOYMENT.md`
- **Test Suite**: `/contracts/test/LANDToken.t.sol`
- **Foundry Docs**: https://book.getfoundry.sh/
- **Base Docs**: https://docs.base.org/
- **OpenZeppelin**: https://docs.openzeppelin.com/
