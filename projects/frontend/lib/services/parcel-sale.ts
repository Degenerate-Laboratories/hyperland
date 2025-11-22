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

    // Execute purchase with current bonding curve price
    const txHash = await writeContractAsync({
      address: PARCEL_SALE,
      abi: PARCEL_SALE_ABI,
      functionName: 'purchaseParcel',
      args: [BigInt(parcelNumber)],
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
 * Hook for checking if a parcel is available
 */
export function useParcelAvailability(parcelNumber: number) {
  const { data: isAvailable } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'isAvailable',
    args: [BigInt(parcelNumber)],
  });

  return {
    isAvailable: !!isAvailable,
  };
}

/**
 * Hook for getting parcel details
 */
export function useParcelDetails(parcelNumber: number) {
  const { data: parcel } = useReadContract({
    address: PARCEL_SALE,
    abi: PARCEL_SALE_ABI,
    functionName: 'getParcel',
    args: [BigInt(parcelNumber)],
  });

  if (!parcel) return null;

  return {
    x: Number(parcel[0]),
    y: Number(parcel[1]),
    size: Number(parcel[2]),
    price: parcel[3],
    priceETH: formatEther(parcel[3]),
    sold: parcel[4],
  };
}
