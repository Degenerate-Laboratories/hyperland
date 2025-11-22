/**
 * ParcelSale Service
 * Handles purchasing parcels with bonding curve pricing
 */

'use client';

import { useWriteContract, useWaitForTransactionReceipt, useReadContract } from 'wagmi';
import { formatEther } from 'viem';
import { PARCEL_SALE_ABI } from '../abis';

const PARCEL_SALE = process.env.NEXT_PUBLIC_PARCEL_SALE_ADDRESS as `0x${string}`;

export interface BondingCurveStats {
  currentPrice: bigint;
  soldCount: number;
  totalParcels: number;
  availableCount: number;
  totalETHCollected: bigint;
  totalLiquidityCreated: bigint;
  totalLPBurned: bigint;
}

/**
 * Hook for purchasing parcels with bonding curve pricing
 */
export function usePurchaseParcel() {
  const { writeContractAsync, data: hash, isPending } = useWriteContract();
  const { isLoading, isSuccess } = useWaitForTransactionReceipt({ hash });

  // Get current price from bonding curve
  const { data: currentPrice } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getCurrentPrice',
  });

  async function purchaseParcel(parcelNumber: number): Promise<`0x${string}`> {
    if (!currentPrice) {
      throw new Error('Failed to fetch current price');
    }

    // PrimarySaleV3 uses purchaseNextParcel() - no parcel number needed
    // It automatically sells the next available parcel in sequence
    const txHash = await writeContractAsync({
      address: PARCEL_SALE,
      abi: PARCEL_SALE_ABI,
      functionName: 'purchaseNextParcel',
      args: [], // No arguments - buys next available parcel
      value: currentPrice,
    });

    console.log('Parcel purchase transaction submitted:', txHash);
    return txHash;
  }

  return {
    purchaseParcel,
    currentPrice,
    currentPriceETH: currentPrice ? formatEther(currentPrice) : '0',
    isPending: isPending || isLoading,
    isSuccess,
    hash,
  };
}

/**
 * Hook for getting bonding curve statistics
 */
export function useBondingCurveStats() {
  const { data: stats, refetch } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getStats',
  });

  const { data: currentPrice } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getCurrentPrice',
  });

  if (!stats || !currentPrice) {
    return {
      stats: null,
      refetch,
    };
  }

  const bondingStats: BondingCurveStats = {
    currentPrice,
    totalParcels: Number(stats[0]),
    soldCount: Number(stats[1]),
    availableCount: Number(stats[2]),
    totalETHCollected: stats[3],
    totalLiquidityCreated: stats[4],
    totalLPBurned: stats[5],
  };

  return {
    stats: bondingStats,
    refetch,
  };
}

/**
 * Hook for getting parcel configuration (V3)
 * Returns parcel details from PrimarySaleV3
 */
export function useParcelConfig(tokenId: number) {
  const { data: config } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getParcelConfig',
    args: [BigInt(tokenId)],
  });

  if (!config) return null;

  return {
    x: Number(config[0]),
    y: Number(config[1]),
    size: Number(config[2]),
    assessedValue: config[3],
    price: config[4],
    priceETH: formatEther(config[4]),
    available: config[5],
  };
}

/**
 * Hook for checking if a parcel is available (V3)
 * Checks if parcel is configured and not yet sold
 */
export function useParcelAvailability(tokenId: number) {
  const config = useParcelConfig(tokenId);

  return {
    isAvailable: config?.available ?? false,
  };
}

/**
 * Hook for getting parcel details (V3)
 * Alias for useParcelConfig for backwards compatibility
 */
export function useParcelDetails(tokenId: number) {
  return useParcelConfig(tokenId);
}
