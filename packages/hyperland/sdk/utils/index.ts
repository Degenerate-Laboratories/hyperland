/**
 * Utility functions for HyperLand SDK
 */

import { formatEther, parseEther } from 'ethers';

/**
 * Format LAND token amount to human-readable string
 */
export function formatLAND(amount: bigint): string {
  return formatEther(amount);
}

/**
 * Parse LAND token amount from human-readable string
 */
export function parseLAND(amount: string): bigint {
  return parseEther(amount);
}

/**
 * Format coordinates as string
 */
export function formatCoordinates(x: bigint, y: bigint): string {
  return `(${x}, ${y})`;
}

/**
 * Calculate parcel area
 */
export function calculateParcelArea(size: bigint): bigint {
  return size * size;
}

/**
 * Convert cycle to approximate date
 */
export function cycleToDate(cycle: bigint, startTimestamp: bigint, cycleSeconds: bigint): Date {
  const timestamp = Number(startTimestamp + cycle * cycleSeconds);
  return new Date(timestamp * 1000);
}

/**
 * Convert date to cycle
 */
export function dateToCycle(date: Date, startTimestamp: bigint, cycleSeconds: bigint): bigint {
  const timestamp = BigInt(Math.floor(date.getTime() / 1000));
  return (timestamp - startTimestamp) / cycleSeconds;
}

/**
 * Check if auction has ended
 */
export function isAuctionEnded(endTime: bigint): boolean {
  return BigInt(Math.floor(Date.now() / 1000)) >= endTime;
}

/**
 * Get time remaining in auction
 */
export function getAuctionTimeRemaining(endTime: bigint): number {
  const now = BigInt(Math.floor(Date.now() / 1000));
  if (now >= endTime) return 0;
  return Number(endTime - now);
}

/**
 * Format time remaining as human-readable string
 */
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

/**
 * Validate Ethereum address
 */
export function isValidAddress(address: string): boolean {
  return /^0x[a-fA-F0-9]{40}$/.test(address);
}

/**
 * Shorten address for display
 */
export function shortenAddress(address: string, chars: number = 4): string {
  if (!isValidAddress(address)) return address;
  return `${address.substring(0, chars + 2)}...${address.substring(42 - chars)}`;
}

/**
 * Convert basis points to percentage
 */
export function basisPointsToPercent(bp: bigint): number {
  return Number(bp) / 100;
}

/**
 * Convert percentage to basis points
 */
export function percentToBasisPoints(percent: number): bigint {
  return BigInt(Math.floor(percent * 100));
}
