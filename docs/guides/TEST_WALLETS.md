# HyperLand Test Wallets

## Test Wallet Configuration

### Wallet 1 (Alice - Land Owner & Seller)
- **Address:** `0xDCC43D99B86dF38F73782f3119DD4eC7111D2e1a`
- **Private Key:** `0x0d13c4a5d591121cb8c1addacea9c1a1e1f719424d51de54c8907fa7f6c3f302`
- **Role:** Initial parcel owner, will list at 2x price

### Wallet 2 (Bob - LAND Buyer & Parcel Purchaser)
- **Address:** `0x9BCB605A2236C5Df400b735235Ea887e3184909f`
- **Private Key:** `0xa4bc74f23d0f7a4f8baf8a35857189b74698684e24d3e72089c29b9cd66df89e`
- **Role:** Will buy LAND tokens and purchase Alice's parcel

### Wallet 3 (Carol - Assessor)
- **Address:** `0x8aE08A1E571626A1659Da46c6211F9Ca8E60A7Df`
- **Private Key:** `0xd69d1abc1844207d312d6a83420ae007b444217ace74d09bfc27f72dc86fbd5a`
- **Role:** Will reassess land values after sale

## Deployed Contracts (Base Sepolia)

- **LANDToken:** `0x9E284a80a911b6121070df2BdD2e8C4527b74796`
- **LandDeed:** `0x919e6e2b36b6944F52605bC705Ff609AFcb7c797`
- **HyperLandCore:** `0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf`

## Test Scenario

1. **Mint 3 Parcels:** Distribute to Alice, Bob, Carol
2. **Alice Lists:** Self-assess at 1000 LAND, list at 2000 LAND
3. **Bob Buys:** Acquire LAND tokens, purchase Alice's parcel
4. **Carol Reassesses:** Update land values as assessor
5. **Tax Collection:** Trigger and verify tax generation
6. **Audit:** Complete mathematical audit of all transactions
