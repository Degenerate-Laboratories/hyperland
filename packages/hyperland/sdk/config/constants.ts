/**
 * HyperLand V2 System Constants
 */

import { parseUnits, formatUnits, parseEther, formatEther } from 'ethers';

/**
 * System constants
 */
export const CONSTANTS = {
  // Token decimals
  LAND_DECIMALS: 18,

  // Total supply
  TOTAL_LAND_SUPPLY: 21_000_000n * 10n**18n, // 21 million LAND (in wei)

  // Basis points (for percentage calculations)
  BASIS_POINTS: 10000,

  // Fee structure (default mainnet values)
  PROTOCOL_FEE_BP: 2000, // 20%
  TAX_RATE_BP: 500, // 5% per cycle

  // Timing (production values)
  TAX_CYCLE_SECONDS: 604800, // 7 days
  AUCTION_DURATION: 259200, // 3 days
  LIEN_GRACE_CYCLES: 3, // 21 days grace period

  // Auction parameters
  AUCTION_EXTENSION_TIME: 120, // 2 minutes
  AUCTION_EXTENSION_THRESHOLD: 120, // 2 minutes

  // Tax prepayment limits
  MAX_TAX_PREPAYMENT_CYCLES: 100, // Can prepay up to 100 cycles

  // Coordinate system
  BRC_COORDINATE_OFFSET: 10000, // Offset for negative BRC coordinates

  // Gas limits (estimates)
  GAS_LIMITS: {
    MINT_PARCEL: 150000,
    LIST_DEED: 100000,
    BUY_DEED: 180000,
    PAY_TAX: 100000,
    PAY_TAX_ADVANCE: 120000,
    SUBMIT_VALUATION: 120000,
    PLACE_BID: 120000,
    SETTLE_AUCTION: 150000,
  },
} as const;

/**
 * Parse LAND amount to wei
 */
export function parseEther(amount: string | number): bigint {
  return parseUnits(amount.toString(), CONSTANTS.LAND_DECIMALS);
}

/**
 * Format wei to LAND amount
 */
export function formatEther(amount: bigint): string {
  return formatUnits(amount, CONSTANTS.LAND_DECIMALS);
}

/**
 * Calculate LAND equivalent from ETH value
 * (For reference only - LAND is not pegged to ETH)
 */
export function calculateLandFromEth(ethAmount: bigint, landPriceInEth: bigint): bigint {
  return (ethAmount * parseEther('1')) / landPriceInEth;
}

/**
 * Calculate total buyer payment (includes protocol fee)
 */
export function calculateBuyerAmount(listingPrice: bigint): bigint {
  return listingPrice; // Buyer pays full listing price
}

/**
 * Calculate protocol fee from sale
 */
export function calculateProtocolFee(salePrice: bigint, feeBP: number = CONSTANTS.PROTOCOL_FEE_BP): bigint {
  return (salePrice * BigInt(feeBP)) / BigInt(CONSTANTS.BASIS_POINTS);
}

/**
 * Calculate seller proceeds (listing price - protocol fee)
 */
export function calculateSellerProceeds(listingPrice: bigint, feeBP: number = CONSTANTS.PROTOCOL_FEE_BP): bigint {
  const fee = calculateProtocolFee(listingPrice, feeBP);
  return listingPrice - fee;
}

/**
 * Calculate treasury amount from sale
 */
export function calculateTreasuryAmount(salePrice: bigint, feeBP: number = CONSTANTS.PROTOCOL_FEE_BP): bigint {
  return calculateProtocolFee(salePrice, feeBP);
}

/**
 * Calculate tax owed for given number of cycles
 */
export function calculateTax(
  assessedValue: bigint,
  cycles: number | bigint,
  taxRateBP: number = CONSTANTS.TAX_RATE_BP
): bigint {
  return (assessedValue * BigInt(taxRateBP) * BigInt(cycles)) / BigInt(CONSTANTS.BASIS_POINTS);
}

/**
 * Calculate tax per single cycle
 */
export function calculateTaxPerCycle(
  assessedValue: bigint,
  taxRateBP: number = CONSTANTS.TAX_RATE_BP
): bigint {
  return (assessedValue * BigInt(taxRateBP)) / BigInt(CONSTANTS.BASIS_POINTS);
}

/**
 * Convert BRC coordinates to blockchain coordinates
 */
export function brcToBlockchain(x: number, y: number): { x: bigint; y: bigint } {
  return {
    x: BigInt(x + CONSTANTS.BRC_COORDINATE_OFFSET),
    y: BigInt(y + CONSTANTS.BRC_COORDINATE_OFFSET),
  };
}

/**
 * Convert blockchain coordinates to BRC coordinates
 */
export function blockchainToBrc(x: bigint, y: bigint): { x: number; y: number } {
  return {
    x: Number(x) - CONSTANTS.BRC_COORDINATE_OFFSET,
    y: Number(y) - CONSTANTS.BRC_COORDINATE_OFFSET,
  };
}

/**
 * Format percentage from basis points
 */
export function formatBasisPoints(bp: number): string {
  return `${bp / 100}%`;
}

/**
 * Convert seconds to human-readable time
 */
export function formatDuration(seconds: number | bigint): string {
  const sec = Number(seconds);
  const days = Math.floor(sec / 86400);
  const hours = Math.floor((sec % 86400) / 3600);
  const minutes = Math.floor((sec % 3600) / 60);

  if (days > 0) return `${days}d ${hours}h`;
  if (hours > 0) return `${hours}h ${minutes}m`;
  return `${minutes}m`;
}

/**
 * Check if address is valid Ethereum address
 */
export function isValidAddress(address: string): boolean {
  return /^0x[a-fA-F0-9]{40}$/.test(address);
}

/**
 * Shorten address for display (0x1234...5678)
 */
export function shortenAddress(address: string, chars: number = 4): string {
  if (!isValidAddress(address)) return address;
  return `${address.slice(0, chars + 2)}...${address.slice(-chars)}`;
}
