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
    functionName: 'getCurrentETHPrice',
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
    functionName: 'getCurrentETHPrice',
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
    totalETHCollected: stats[4],       // index 3 is currentETHPrice
    totalLiquidityCreated: stats[5],
    totalLPBurned: stats[6],
  };

  return {
    stats: bondingStats,
    refetch,
  };
}

/**
 * Hook for getting parcel configuration
 * Returns parcel details from PrimarySale
 */
export function useParcelConfig(tokenId: number) {
  const { data: parcel } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getParcel',
    args: [BigInt(tokenId)],
  });

  if (!parcel) return null;

  return {
    x: Number(parcel[0]),
    y: Number(parcel[1]),
    size: Number(parcel[2]),
    exists: parcel[3],
    sold: parcel[4],
    price: parcel[5],
    priceETH: formatEther(parcel[5]),
    available: parcel[3] && !parcel[4], // exists && !sold
  };
}

/**
 * Hook for checking if a parcel is available
 * Checks if parcel is configured and not yet sold
 */
export function useParcelAvailability(tokenId: number) {
  const config = useParcelConfig(tokenId);

  return {
    isAvailable: config?.available ?? false,
  };
}

/**
 * Hook for getting parcel details
 * Alias for useParcelConfig for backwards compatibility
 */
export function useParcelDetails(tokenId: number) {
  return useParcelConfig(tokenId);
}
