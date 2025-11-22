/**
 * LAND Token Trading Service
 * Handles buying and selling LAND tokens via Aerodrome DEX
 */

'use client';

import { useWriteContract, useWaitForTransactionReceipt, useReadContract } from 'wagmi';
import { parseEther, formatUnits } from 'viem';
import { LAND_TOKEN_ABI, AERODROME_ROUTER_ABI, AERODROME_PAIR_ABI } from '../abis';
import { calculateSwapOutput, calculatePriceImpact } from './price-oracle';

const LAND_TOKEN = process.env.NEXT_PUBLIC_LAND_TOKEN_ADDRESS as `0x${string}`;
const WETH = process.env.NEXT_PUBLIC_WETH_ADDRESS as `0x${string}`;
const ROUTER = process.env.NEXT_PUBLIC_AERODROME_ROUTER as `0x${string}`;
const LP_POOL = process.env.NEXT_PUBLIC_LP_POOL_ADDRESS as `0x${string}` | undefined;

export interface SwapQuote {
  amountIn: string;
  amountOut: string;
  priceImpact: number;
  minimumReceived: string;
  route: Array<{ from: string; to: string; stable: boolean }>;
}

/**
 * Hook for buying LAND tokens with ETH
 */
export function useBuyLand() {
  const { writeContract, data: hash, isPending } = useWriteContract();
  const { isLoading, isSuccess } = useWaitForTransactionReceipt({ hash });

  // Get pool reserves for quote calculation
  const { data: reserves } = useReadContract({
    address: LP_POOL,
    abi: AERODROME_PAIR_ABI,
    functionName: 'getReserves',
    query: { enabled: !!LP_POOL },
  });

  const { data: token0 } = useReadContract({
    address: LP_POOL,
    abi: AERODROME_PAIR_ABI,
    functionName: 'token0',
    query: { enabled: !!LP_POOL },
  });

  async function buyLand(
    ethAmount: string,
    slippageBps: number = 200 // 2% default
  ): Promise<void> {
    if (!LP_POOL) {
      throw new Error('Liquidity pool not created yet. Cannot buy LAND.');
    }

    if (!reserves || !token0) {
      throw new Error('Failed to fetch pool data');
    }

    const [reserve0, reserve1] = reserves as [bigint, bigint, bigint];
    const isToken0Land = token0.toLowerCase() === LAND_TOKEN.toLowerCase();

    const landReserve = isToken0Land ? reserve0 : reserve1;
    const ethReserve = isToken0Land ? reserve1 : reserve0;

    // Calculate expected output
    const amountIn = parseEther(ethAmount);
    const amountOut = calculateSwapOutput(amountIn, ethReserve, landReserve);

    // Apply slippage tolerance
    const minAmountOut = (amountOut * BigInt(10000 - slippageBps)) / 10000n;

    // Build route
    const route = [
      {
        from: WETH,
        to: LAND_TOKEN,
        stable: false, // Volatile pool
      },
    ];

    // Deadline: 20 minutes from now
    const deadline = Math.floor(Date.now() / 1000) + 1200;

    await writeContract({
      address: ROUTER,
      abi: AERODROME_ROUTER_ABI,
      functionName: 'swapExactETHForTokens',
      args: [minAmountOut, route, undefined as any, BigInt(deadline)],
      value: amountIn,
    });
  }

  function getQuote(ethAmount: string): SwapQuote | null {
    if (!reserves || !token0 || !LP_POOL) return null;

    const [reserve0, reserve1] = reserves as [bigint, bigint, bigint];
    const isToken0Land = token0.toLowerCase() === LAND_TOKEN.toLowerCase();

    const landReserve = isToken0Land ? reserve0 : reserve1;
    const ethReserve = isToken0Land ? reserve1 : reserve0;

    const amountIn = parseEther(ethAmount);
    const amountOut = calculateSwapOutput(amountIn, ethReserve, landReserve);
    const priceImpact = calculatePriceImpact(amountIn, ethReserve, landReserve);
    const minReceived = (amountOut * 9800n) / 10000n; // 2% slippage

    return {
      amountIn: ethAmount,
      amountOut: formatUnits(amountOut, 18),
      priceImpact,
      minimumReceived: formatUnits(minReceived, 18),
      route: [{ from: WETH, to: LAND_TOKEN, stable: false }],
    };
  }

  return {
    buyLand,
    getQuote,
    isPending: isPending || isLoading,
    isSuccess,
    hash,
  };
}

/**
 * Hook for selling LAND tokens for ETH
 */
export function useSellLand() {
  const { writeContract, data: hash, isPending } = useWriteContract();
  const { isLoading, isSuccess } = useWaitForTransactionReceipt({ hash });

  // Get pool reserves for quote calculation
  const { data: reserves } = useReadContract({
    address: LP_POOL,
    abi: AERODROME_PAIR_ABI,
    functionName: 'getReserves',
    query: { enabled: !!LP_POOL },
  });

  const { data: token0 } = useReadContract({
    address: LP_POOL,
    abi: AERODROME_PAIR_ABI,
    functionName: 'token0',
    query: { enabled: !!LP_POOL },
  });

  async function sellLand(
    landAmount: string,
    slippageBps: number = 200 // 2% default
  ): Promise<void> {
    if (!LP_POOL) {
      throw new Error('Liquidity pool not created yet. Cannot sell LAND.');
    }

    if (!reserves || !token0) {
      throw new Error('Failed to fetch pool data');
    }

    const [reserve0, reserve1] = reserves as [bigint, bigint, bigint];
    const isToken0Land = token0.toLowerCase() === LAND_TOKEN.toLowerCase();

    const landReserve = isToken0Land ? reserve0 : reserve1;
    const ethReserve = isToken0Land ? reserve1 : reserve0;

    // Calculate expected output
    const amountIn = parseEther(landAmount);
    const amountOut = calculateSwapOutput(amountIn, landReserve, ethReserve);

    // Apply slippage tolerance
    const minAmountOut = (amountOut * BigInt(10000 - slippageBps)) / 10000n;

    // Build route
    const route = [
      {
        from: LAND_TOKEN,
        to: WETH,
        stable: false,
      },
    ];

    // Deadline: 20 minutes from now
    const deadline = Math.floor(Date.now() / 1000) + 1200;

    // First approve router to spend LAND tokens
    const { writeContract: approve } = useWriteContract();
    await approve({
      address: LAND_TOKEN,
      abi: LAND_TOKEN_ABI,
      functionName: 'approve',
      args: [ROUTER, amountIn],
    });

    // Then execute swap
    await writeContract({
      address: ROUTER,
      abi: AERODROME_ROUTER_ABI,
      functionName: 'swapExactTokensForETH',
      args: [amountIn, minAmountOut, route, undefined as any, BigInt(deadline)],
    });
  }

  function getQuote(landAmount: string): SwapQuote | null {
    if (!reserves || !token0 || !LP_POOL) return null;

    const [reserve0, reserve1] = reserves as [bigint, bigint, bigint];
    const isToken0Land = token0.toLowerCase() === LAND_TOKEN.toLowerCase();

    const landReserve = isToken0Land ? reserve0 : reserve1;
    const ethReserve = isToken0Land ? reserve1 : reserve0;

    const amountIn = parseEther(landAmount);
    const amountOut = calculateSwapOutput(amountIn, landReserve, ethReserve);
    const priceImpact = calculatePriceImpact(amountIn, landReserve, ethReserve);
    const minReceived = (amountOut * 9800n) / 10000n; // 2% slippage

    return {
      amountIn: landAmount,
      amountOut: formatUnits(amountOut, 18),
      priceImpact,
      minimumReceived: formatUnits(minReceived, 18),
      route: [{ from: LAND_TOKEN, to: WETH, stable: false }],
    };
  }

  return {
    sellLand,
    getQuote,
    isPending: isPending || isLoading,
    isSuccess,
    hash,
  };
}
