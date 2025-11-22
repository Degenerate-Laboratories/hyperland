/**
 * HyperLand Context Provider
 *
 * Provides unified access to HyperLand data, automatically switching between:
 * - Real blockchain data (when connected to wallet)
 * - Pre-defined parcels for initial sale (bonding curve)
 */

'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode, useCallback } from 'react';
import { useAccount, useBalance, useReadContract, useWriteContract } from 'wagmi';
import { formatEther, parseEther } from 'ethers';
import { LAND_TOKEN_ABI, HYPERLAND_CORE_ABI, PARCEL_SALE_ABI } from './abis';

// Temporary data types until we have real blockchain indexing
interface TempParcel {
  tokenId: number;
  x: number;
  y: number;
  owner: string;
  taxDeadline: number;
  isDelinquent: boolean;
  listing?: { price: string; seller: string };
  auction?: { startPrice: string; endTime: number; bids: Array<{ bidder: string; amount: string }> };
}

interface HyperLandContextType {
  // Mode
  isConnected: boolean;

  // User data
  address?: string;
  landBalance: string;
  ethBalance: string;

  // Parcels
  allParcels: TempParcel[];
  userParcels: TempParcel[];
  listedParcels: TempParcel[];
  auctionParcels: TempParcel[];

  // Stats
  stats: {
    totalParcels: number;
    ownedParcels: number;
    listedParcels: number;
    auctionParcels: number;
    activeOwners: number;
  };

  // Actions
  buyLAND: (ethAmount: string) => Promise<void>;
  listParcel: (tokenId: number, price: string) => Promise<void>;
  buyParcel: (tokenId: number) => Promise<void>;
  payTaxes: (tokenId: number) => Promise<void>;
  placeBid: (tokenId: number, amount: string) => Promise<void>;
  getParcel: (tokenId: number) => TempParcel | undefined;
  getParcelByCoordinates: (x: number, y: number) => TempParcel | undefined;

  // UI state
  isLoading: boolean;
  error: string | null;
}

const HyperLandContext = createContext<HyperLandContextType | undefined>(undefined);

const LAND_TOKEN = process.env.NEXT_PUBLIC_LAND_TOKEN_ADDRESS as `0x${string}`;
const HYPERLAND_CORE = process.env.NEXT_PUBLIC_HYPERLAND_CORE_ADDRESS as `0x${string}`;
const LAND_DEED = process.env.NEXT_PUBLIC_LAND_DEED_ADDRESS as `0x${string}`;
const PARCEL_SALE = process.env.NEXT_PUBLIC_PARCEL_SALE_ADDRESS as `0x${string}` | undefined;

export function HyperLandProvider({ children }: { children: ReactNode }) {
  const { address, isConnected } = useAccount();

  // Real blockchain balance hooks
  const { data: ethBalanceData } = useBalance({
    address: address as `0x${string}`,
    query: { enabled: isConnected },
  });

  const { data: landBalanceData } = useReadContract({
    address: LAND_TOKEN,
    abi: LAND_TOKEN_ABI,
    functionName: 'balanceOf',
    args: [address as `0x${string}`],
    query: { enabled: isConnected && !!address },
  });

  const [landBalance, setLandBalance] = useState('0');
  const [ethBalance, setEthBalance] = useState('0');
  const [allParcels, setAllParcels] = useState<TempParcel[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Contract interaction hooks
  const { writeContractAsync } = useWriteContract();

  // Update balances from blockchain data
  useEffect(() => {
    if (isConnected) {
      if (ethBalanceData) {
        setEthBalance(ethBalanceData.formatted);
      }
      if (landBalanceData) {
        setLandBalance(formatEther(landBalanceData.toString()));
      }
    }
  }, [ethBalanceData, landBalanceData, isConnected]);

  // Load all 1,205 pre-defined parcels as available for initial purchase
  useEffect(() => {
    async function loadParcels() {
      setIsLoading(true);
      setError(null);

      try {
        console.log('Loading 1,205 pre-defined parcels...');

        // Load the parcel data
        const response = await fetch('/parcels.json');
        const parcelData = await response.json();

        const parcels: TempParcel[] = parcelData.map((parcel: any) => ({
          tokenId: parcel.parcelNumber,
          x: parcel.x,
          y: parcel.y,
          owner: '0x0000000000000000000000000000000000000000', // Available for purchase
          taxDeadline: 0,
          isDelinquent: false,
          listing: {
            price: parcel.assessedValue.toString(),
            seller: `${parcel.ring} Ring - ${parcel.address}`,
          },
        }));

        console.log(`✅ Loaded ${parcels.length} parcels available for initial purchase`);
        setAllParcels(parcels);
      } catch (err) {
        console.error('Error loading parcels:', err);
        setError(err instanceof Error ? err.message : 'Failed to load parcels');
      } finally {
        setIsLoading(false);
      }
    }

    loadParcels();
  }, []);

  // Actions
  async function buyLAND(ethAmount: string) {
    throw new Error('Use /buy-land page with DEX integration');
  }

  async function listParcel(tokenId: number, price: string) {
    throw new Error('Listing functionality coming soon');
  }

  async function buyParcel(tokenId: number) {
    if (!address) {
      throw new Error('Please connect your wallet');
    }

    if (!PARCEL_SALE) {
      throw new Error('ParcelSale contract not configured. Please set NEXT_PUBLIC_PARCEL_SALE_ADDRESS');
    }

    if (!LAND_TOKEN) {
      throw new Error('LAND Token address not configured');
    }

    const parcel = getParcel(tokenId);
    if (!parcel || !parcel.listing) {
      throw new Error('Parcel not found or not available');
    }

    const priceInWei = parseEther(parcel.listing.price);

    try {
      // First approve the LAND token spend to ParcelSale contract
      console.log(`Approving ${parcel.listing.price} LAND for ParcelSale contract...`);
      const approveTx = await writeContractAsync({
        address: LAND_TOKEN,
        abi: LAND_TOKEN_ABI,
        functionName: 'approve',
        args: [PARCEL_SALE, priceInWei],
      });

      console.log('Approval transaction:', approveTx);

      // Wait for approval to be mined
      await new Promise(resolve => setTimeout(resolve, 3000));

      // Purchase the parcel via ParcelSale contract
      console.log(`Purchasing parcel #${tokenId}...`);
      const purchaseTx = await writeContractAsync({
        address: PARCEL_SALE,
        abi: PARCEL_SALE_ABI,
        functionName: 'purchaseParcel',
        args: [BigInt(tokenId)],
      });

      console.log('Purchase transaction:', purchaseTx);
      return purchaseTx;
    } catch (err) {
      console.error('Purchase error:', err);
      throw err;
    }
  }

  async function payTaxes(tokenId: number) {
    throw new Error('Tax payment functionality coming soon');
  }

  async function placeBid(tokenId: number, amount: string) {
    throw new Error('Auction bidding coming soon');
  }

  function getParcel(tokenId: number): TempParcel | undefined {
    return allParcels.find(p => p.tokenId === tokenId);
  }

  function getParcelByCoordinates(x: number, y: number): TempParcel | undefined {
    return allParcels.find(p => p.x === x && p.y === y);
  }

  // Computed values
  const userParcels = address
    ? allParcels.filter(p => p.owner.toLowerCase() === address.toLowerCase())
    : [];

  const listedParcels = allParcels.filter(p => p.listing);
  const auctionParcels = allParcels.filter(p => p.auction);

  const stats = {
    totalParcels: 1205,
    ownedParcels: userParcels.length,
    listedParcels: listedParcels.length,
    auctionParcels: auctionParcels.length,
    activeOwners: 0,
  };

  const value: HyperLandContextType = {
    isConnected,
    address,
    landBalance,
    ethBalance,
    allParcels,
    userParcels,
    listedParcels,
    auctionParcels,
    stats,
    buyLAND,
    listParcel,
    buyParcel,
    payTaxes,
    placeBid,
    getParcel,
    getParcelByCoordinates,
    isLoading,
    error,
  };

  return (
    <HyperLandContext.Provider value={value}>
      {children}
    </HyperLandContext.Provider>
  );
}

export function useHyperLand() {
  const context = useContext(HyperLandContext);
  if (!context) {
    throw new Error('useHyperLand must be used within HyperLandProvider');
  }
  return context;
}
