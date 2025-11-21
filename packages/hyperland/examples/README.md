# HyperLand SDK Examples

This directory contains comprehensive examples demonstrating all features of the HyperLand SDK.

## Prerequisites

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Build the SDK**:
   ```bash
   npm run build
   ```

3. **Start local Anvil node** (in a separate terminal):
   ```bash
   anvil
   ```

4. **Deploy contracts** (in another terminal):
   ```bash
   make deploy-local
   ```

## Examples

### 01 - Basic Setup (`01-basic-setup.ts`)

Learn how to:
- Create a HyperLand client
- Connect to different networks
- Query contract information
- Connect a signer

```bash
npx ts-node examples/01-basic-setup.ts
```

### 02 - Buy LAND Tokens (`02-buy-land-tokens.ts`)

Learn how to:
- Buy LAND tokens with ETH
- Calculate expected amounts
- Check token balances
- Verify treasury distribution

```bash
npx ts-node examples/02-buy-land-tokens.ts
```

### 03 - Parcel Operations (`03-parcel-operations.ts`)

Learn how to:
- Mint land parcels
- Query parcel information
- Check ownership
- Lookup parcels by coordinates

```bash
npx ts-node examples/03-parcel-operations.ts
```

### 04 - Marketplace (`04-marketplace.ts`)

Learn how to:
- List parcels for sale
- Browse listings
- Buy parcels from marketplace
- Handle NFT and token approvals

```bash
npx ts-node examples/04-marketplace.ts
```

### 05 - Tax System (`05-tax-system.ts`)

Learn how to:
- Calculate property taxes
- Pay taxes as owner
- Pay taxes for others (create lien)
- Check tax status and delinquency

```bash
npx ts-node examples/05-tax-system.ts
```

### 06 - Auction System (`06-auction-system.ts`)

Learn how to:
- Start auctions for delinquent parcels
- Place and update bids
- Check auction status
- Settle auctions
- Verify ownership transfer

```bash
npx ts-node examples/06-auction-system.ts
```

## Running All Examples

Run all examples in sequence:

```bash
npm run examples
```

Or individually:

```bash
npm run example:01
npm run example:02
npm run example:03
npm run example:04
npm run example:05
npm run example:06
```

## Troubleshooting

### "Contract not deployed"

Make sure you've deployed the contracts:
```bash
make deploy-local
```

### "Provider not connected"

Ensure Anvil is running:
```bash
anvil
```

### "Signer required"

Some operations require a connected signer. The examples automatically connect to Anvil's first account.

### "Insufficient funds"

The examples assume Anvil's default funded accounts. If using a custom account, ensure it has ETH.

## Next Steps

After running the examples, you can:

1. **Modify the examples** - Change parameters, try different scenarios
2. **Build your own app** - Use the SDK in your own project
3. **Deploy to testnet** - Try the SDK on Base Sepolia
4. **Read the docs** - Check SDK_README.md for full API reference

## Support

- SDK Documentation: `../SDK_README.md`
- Smart Contract Docs: `../../docs/smart-contracts-plan.md`
- GitHub Issues: Report problems or ask questions
