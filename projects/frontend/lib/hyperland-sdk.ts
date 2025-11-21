/**
 * HyperLand SDK Integration
 *
 * This module exports the SDK from the local packages directory
 * You can also install from npm once published: npm install @hyperland/sdk
 */

// For now, we'll create type definitions and wrappers
// Once the SDK package is built, import from: '../../packages/hyperland/sdk'

import { ethers } from 'ethers';

// Re-export types and constants for now
export interface ContractAddresses {
  LAND: string;
  LandDeed: string;
  HyperLandCore: string;
}

export interface ParcelData {
  x: bigint;
  y: bigint;
  size: bigint;
}

export interface ParcelInfo extends ParcelData {
  tokenId: bigint;
  owner: string;
}

export interface ParcelState {
  owner: string;
  assessedValueLAND: bigint;
  lastTaxPaidCycle: bigint;
  lienStartCycle: bigint;
  lienActive: boolean;
  inAuction: boolean;
}

export interface Listing {
  seller: string;
  priceLAND: bigint;
  active: boolean;
}

export interface AuctionState {
  parcelId: bigint;
  highestBidder: string;
  highestBid: bigint;
  endTime: bigint;
  active: boolean;
}

export const NETWORK_CONFIGS = {
  anvil: {
    name: 'Anvil',
    chainId: 31337,
    rpcUrl: 'http://127.0.0.1:8545',
    blockExplorer: 'http://localhost:8545',
    contracts: {
      LAND: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
      LandDeed: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
      HyperLandCore: '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0',
    },
  },
  'base-sepolia': {
    name: 'Base Sepolia',
    chainId: 84532,
    rpcUrl: process.env.NEXT_PUBLIC_BASE_SEPOLIA_RPC_URL || 'https://sepolia.base.org',
    blockExplorer: 'https://sepolia.basescan.org',
    contracts: {
      LAND: process.env.NEXT_PUBLIC_LAND_ADDRESS_BASE_SEPOLIA || '',
      LandDeed: process.env.NEXT_PUBLIC_LANDDEED_ADDRESS_BASE_SEPOLIA || '',
      HyperLandCore: process.env.NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS_BASE_SEPOLIA || '',
    },
  },
} as const;

export const CONSTANTS = {
  LAND_MINT_RATE: 1000n,
  PROTOCOL_FEE_BP: 2000n,
  TAX_RATE_BP: 500n,
  TAX_CYCLE_SECONDS: 7n * 24n * 60n * 60n,
  LIEN_GRACE_CYCLES: 3n,
  AUCTION_DURATION: 7n * 24n * 60n * 60n,
  BASIS_POINTS: 10000n,
} as const;

// Utility functions
export function calculateLandFromEth(ethAmount: bigint): bigint {
  return ethAmount * CONSTANTS.LAND_MINT_RATE;
}

export function calculateBuyerAmount(totalLand: bigint): bigint {
  return (totalLand * 8000n) / CONSTANTS.BASIS_POINTS;
}

export function calculateProtocolFee(amount: bigint): bigint {
  return (amount * CONSTANTS.PROTOCOL_FEE_BP) / CONSTANTS.BASIS_POINTS;
}

export function calculateTax(assessedValue: bigint, cyclesPassed: bigint): bigint {
  return (assessedValue * CONSTANTS.TAX_RATE_BP * cyclesPassed) / CONSTANTS.BASIS_POINTS;
}

export function formatCoordinates(x: bigint | number, y: bigint | number): string {
  return `(${x}, ${y})`;
}

export function shortenAddress(address: string, chars: number = 4): string {
  if (!address || address.length < 10) return address;
  return `${address.substring(0, chars + 2)}...${address.substring(42 - chars)}`;
}

export function formatTimeRemaining(seconds: number): string {
  if (seconds <= 0) return 'Ended';

  const days = Math.floor(seconds / (24 * 60 * 60));
  const hours = Math.floor((seconds % (24 * 60 * 60)) / (60 * 60));
  const minutes = Math.floor((seconds % (60 * 60)) / 60);

  const parts: string[] = [];
  if (days > 0) parts.push(`${days}d`);
  if (hours > 0) parts.push(`${hours}h`);
  if (minutes > 0) parts.push(`${minutes}m`);

  return parts.join(' ') || '<1m';
}

export { parseEther, formatEther } from 'ethers';
