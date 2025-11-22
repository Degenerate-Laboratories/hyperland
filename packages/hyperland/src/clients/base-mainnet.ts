/**
 * Base Mainnet Wallet and Public Clients
 */

import { createPublicClient, createWalletClient, http } from 'viem';
import { base } from 'viem/chains';
import { mnemonicToAccount } from 'viem/accounts';
import dotenv from 'dotenv';

dotenv.config();

// Get mnemonic from env
const mnemonic = process.env.MNEMONIC;
if (!mnemonic) {
  throw new Error('MNEMONIC not found in .env file');
}

// Create account from mnemonic
const account = mnemonicToAccount(mnemonic);

// Public client for reading
export const publicClient = createPublicClient({
  chain: base,
  transport: http('https://mainnet.base.org'),
});

// Wallet client for transactions
export const walletClient = createWalletClient({
  account,
  chain: base,
  transport: http('https://mainnet.base.org'),
});
