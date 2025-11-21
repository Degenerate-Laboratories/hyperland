/**
 * Example 5: Tax System
 *
 * This example shows how to:
 * - Calculate taxes owed
 * - Pay property taxes
 * - Pay taxes for others (create lien)
 * - Check tax status
 */

import { createHyperLandClient, parseEther, formatEther } from '../sdk';
import { ethers } from 'ethers';

async function main() {
  console.log('=== HyperLand SDK - Tax System ===\n');

  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');

  // Owner account
  const owner = await provider.getSigner(0);
  const ownerAddress = await owner.getAddress();
  const ownerClient = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: owner,
  });

  // Third party account
  const thirdParty = await provider.getSigner(1);
  const thirdPartyAddress = await thirdParty.getAddress();
  const thirdPartyClient = createHyperLandClient({
    network: 'anvil',
    provider,
    signer: thirdParty,
  });

  console.log('Owner:', ownerAddress);
  console.log('Third Party:', thirdPartyAddress);
  console.log();

  // 1. Setup: Mint parcel and give both parties LAND
  console.log('1. Setup: Minting parcel and distributing LAND...');
  const x = 100n;
  const y = 100n;
  const size = 100n;
  const assessedValue = parseEther('1000'); // 1000 LAND

  await ownerClient.core.mintInitialParcel(ownerAddress, x, y, size, assessedValue);
  const tokenId = await ownerClient.deed.getTokenIdByCoordinates(x, y);

  // Give both parties LAND tokens
  await ownerClient.core.buyLANDEther('2.0');
  await thirdPartyClient.core.buyLANDEther('2.0');

  console.log('  Parcel ID:', tokenId.toString());
  console.log('  Assessed Value:', formatEther(assessedValue), 'LAND');
  console.log();

  // 2. Get initial state
  console.log('2. Initial state:');
  const currentCycle = await ownerClient.core.getCurrentCycle();
  const parcel = await ownerClient.core.getParcel(tokenId);
  console.log('  Current Cycle:', currentCycle.toString());
  console.log('  Last Tax Paid Cycle:', parcel.lastTaxPaidCycle.toString());
  console.log('  Lien Active:', parcel.lienActive);
  console.log();

  // 3. Fast forward time (simulate tax cycles passing)
  console.log('3. Simulating time passage...');
  console.log('  (In real scenario, time would pass naturally)');
  // Note: In Anvil, you would use `anvil_mine` or `evm_increaseTime` to simulate this
  await provider.send('evm_increaseTime', [7 * 24 * 60 * 60]); // 7 days
  await provider.send('evm_mine', []);
  console.log('  ⏰ Advanced 1 tax cycle');
  console.log();

  // 4. Calculate taxes owed
  console.log('4. Calculating taxes owed...');
  const taxOwed = await ownerClient.core.calculateTaxOwed(tokenId);
  console.log('  Tax Owed:', formatEther(taxOwed), 'LAND');
  console.log();

  // 5. Owner pays taxes
  console.log('5. Owner paying taxes...');
  const payReceipt = await ownerClient.core.payTaxes(tokenId);
  console.log('  Transaction hash:', payReceipt.hash);
  console.log('  ✅ Taxes paid successfully');
  console.log();

  // 6. Verify taxes are cleared
  console.log('6. Verifying tax payment...');
  const taxOwedAfter = await ownerClient.core.calculateTaxOwed(tokenId);
  console.log('  Tax Owed After Payment:', formatEther(taxOwedAfter), 'LAND');
  console.log();

  // 7. Fast forward again and let taxes become delinquent
  console.log('7. Simulating delinquency...');
  await provider.send('evm_increaseTime', [7 * 24 * 60 * 60]);
  await provider.send('evm_mine', []);
  console.log('  ⏰ Advanced another tax cycle');

  const newTaxOwed = await ownerClient.core.calculateTaxOwed(tokenId);
  console.log('  New Tax Owed:', formatEther(newTaxOwed), 'LAND');
  console.log();

  // 8. Third party pays taxes (creates lien)
  console.log('8. Third party paying taxes (creating lien)...');
  const lienReceipt = await thirdPartyClient.core.payTaxesFor(tokenId);
  console.log('  Transaction hash:', lienReceipt.hash);
  console.log('  ⚠️  Lien started!');
  console.log();

  // 9. Check parcel state with lien
  console.log('9. Parcel state after lien:');
  const parcelWithLien = await ownerClient.core.getParcel(tokenId);
  console.log('  Owner:', parcelWithLien.owner);
  console.log('  Lien Active:', parcelWithLien.lienActive);
  console.log('  Lien Start Cycle:', parcelWithLien.lienStartCycle.toString());
  console.log('  Current Cycle:', (await ownerClient.core.getCurrentCycle()).toString());
  console.log();

  // 10. Check if eligible for auction
  console.log('10. Checking auction eligibility...');
  const isEligible = await ownerClient.core.isEligibleForAuction(tokenId);
  console.log('  Eligible for Auction:', isEligible);
  console.log('  (Requires 3 cycles after lien)');

  console.log('\n✅ Tax system demonstration complete!');
}

// Run the example
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error('Error:', error);
    process.exit(1);
  });
