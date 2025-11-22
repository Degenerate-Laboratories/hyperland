/**
 * Price Oracle Service
 * Provides real-time LAND token pricing from Aerodrome DEX
 */

'use client';

import { useReadContract } from 'wagmi';
import { useState, useEffect } from 'react';
import { AERODROME_PAIR_ABI } from '../abis';
import { formatUnits } from 'viem';

interface PriceData {
  landPriceUSD: number;
  landPriceETH: number;
  marketCap: number;
  liquidity: number;
  volume24h: number;
  priceChange24h: number;
  lastUpdate: number;
}

const ETH_PRICE_USD = 2380; // Fallback, should fetch from API

/**
 * Hook to get real-time LAND token price
 */
export function useLandPrice(): PriceData & { isLoading: boolean; error: string | null } {
  const [ethPriceUSD, setEthPriceUSD] = useState(ETH_PRICE_USD);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const lpPoolAddress = process.env.NEXT_PUBLIC_LP_POOL_ADDRESS as `0x${string}` | undefined;

  // Read pool reserves
  const { data: reserves, isError, isLoading: reservesLoading } = useReadContract({
    address: lpPoolAddress,
    abi: AERODROME_PAIR_ABI,
    functionName: 'getReserves',
    query: {
      enabled: !!lpPoolAddress,
      refetchInterval: 10000, // Update every 10 seconds
    },
  });

  // Read token0 address to determine which is LAND
  const { data: token0 } = useReadContract({
    address: lpPoolAddress,
    abi: AERODROME_PAIR_ABI,
    functionName: 'token0',
    query: {
      enabled: !!lpPoolAddress,
    },
  });

  // Fetch ETH price from Coinbase API
  useEffect(() => {
    async function fetchETHPrice() {
      try {
        const response = await fetch('https://api.coinbase.com/v2/prices/ETH-USD/spot');
        const data = await response.json();
        if (data?.data?.amount) {
          setEthPriceUSD(parseFloat(data.data.amount));
        }
      } catch (err) {
        console.error('Failed to fetch ETH price:', err);
      }
    }

    fetchETHPrice();
    const interval = setInterval(fetchETHPrice, 60000); // Update every minute
    return () => clearInterval(interval);
  }, []);

  // Calculate price data
  useEffect(() => {
    if (!reserves || !lpPoolAddress) {
      setIsLoading(false);
      return;
    }

    try {
      const [reserve0, reserve1] = reserves as [bigint, bigint, bigint];

      // Determine which reserve is LAND based on token0 address
      const landToken = process.env.NEXT_PUBLIC_LAND_TOKEN_ADDRESS?.toLowerCase();
      const isToken0Land = token0?.toLowerCase() === landToken;

      const landReserve = isToken0Land ? Number(formatUnits(reserve0, 18)) : Number(formatUnits(reserve1, 18));
      const ethReserve = isToken0Land ? Number(formatUnits(reserve1, 18)) : Number(formatUnits(reserve0, 18));

      if (landReserve === 0) {
        setError('Pool has no liquidity');
        setIsLoading(false);
        return;
      }

      // Calculate prices
      const landPriceETH = ethReserve / landReserve;
      const landPriceUSD = landPriceETH * ethPriceUSD;
      const totalSupply = 21_000_000; // 21M LAND tokens
      const marketCap = landPriceUSD * totalSupply;
      const liquidity = (landReserve * landPriceUSD) + (ethReserve * ethPriceUSD);

      setError(null);
      setIsLoading(false);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to calculate price');
      setIsLoading(false);
    }
  }, [reserves, token0, ethPriceUSD, lpPoolAddress]);

  // If no pool exists yet, return default values
  if (!lpPoolAddress) {
    return {
      landPriceUSD: 0,
      landPriceETH: 0,
      marketCap: 0,
      liquidity: 0,
      volume24h: 0,
      priceChange24h: 0,
      lastUpdate: Date.now(),
      isLoading: false,
      error: 'Liquidity pool not created yet',
    };
  }

  if (isError) {
    return {
      landPriceUSD: 0,
      landPriceETH: 0,
      marketCap: 0,
      liquidity: 0,
      volume24h: 0,
      priceChange24h: 0,
      lastUpdate: Date.now(),
      isLoading: false,
      error: 'Failed to fetch pool data',
    };
  }

  const [reserve0, reserve1] = (reserves as [bigint, bigint, bigint]) || [0n, 0n, 0n];
  const landToken = process.env.NEXT_PUBLIC_LAND_TOKEN_ADDRESS?.toLowerCase();
  const isToken0Land = token0?.toLowerCase() === landToken;

  const landReserve = isToken0Land ? Number(formatUnits(reserve0, 18)) : Number(formatUnits(reserve1, 18));
  const ethReserve = isToken0Land ? Number(formatUnits(reserve1, 18)) : Number(formatUnits(reserve0, 18));

  const landPriceETH = landReserve > 0 ? ethReserve / landReserve : 0;
  const landPriceUSD = landPriceETH * ethPriceUSD;
  const totalSupply = 21_000_000;
  const marketCap = landPriceUSD * totalSupply;
  const liquidity = (landReserve * landPriceUSD) + (ethReserve * ethPriceUSD);

  return {
    landPriceUSD,
    landPriceETH,
    marketCap,
    liquidity,
    volume24h: 0, // TODO: Fetch from subgraph
    priceChange24h: 0, // TODO: Calculate from historical data
    lastUpdate: Date.now(),
    isLoading: reservesLoading,
    error,
  };
}

/**
 * Calculate output amount for a swap
 */
export function calculateSwapOutput(
  amountIn: bigint,
  reserveIn: bigint,
  reserveOut: bigint,
  feePercent: number = 0.2 // 0.2% Aerodrome fee
): bigint {
  const amountInWithFee = amountIn * BigInt(Math.floor((100 - feePercent) * 100));
  const numerator = amountInWithFee * reserveOut;
  const denominator = (reserveIn * 10000n) + amountInWithFee;
  return numerator / denominator;
}

/**
 * Calculate price impact of a swap
 */
export function calculatePriceImpact(
  amountIn: bigint,
  reserveIn: bigint,
  reserveOut: bigint
): number {
  const amountOut = calculateSwapOutput(amountIn, reserveIn, reserveOut);
  const currentPrice = Number(reserveOut) / Number(reserveIn);
  const newPrice = Number(reserveOut - amountOut) / Number(reserveIn + amountIn);
  const impact = ((newPrice - currentPrice) / currentPrice) * 100;
  return Math.abs(impact);
}
