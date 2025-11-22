/**
 * Wagmi Configuration
 */

import { getDefaultConfig } from '@rainbow-me/rainbowkit';
import { base, baseSepolia, localhost } from 'wagmi/chains';

export const config = getDefaultConfig({
  appName: 'HyperLand',
  projectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || 'YOUR_PROJECT_ID',
  chains: [
    base,           // Base Mainnet (production)
    baseSepolia,    // Base Sepolia testnet
    // localhost,   // Commented out for production
  ],
  ssr: true,
});
