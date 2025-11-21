/**
 * HyperLand Context Provider
 *
 * Provides unified access to HyperLand data, automatically switching between:
 * - Real blockchain data (when connected to wallet)
 * - Mock data (for offline development/testing)
 */

'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useAccount } from 'wagmi';
import { mockState, useMockData, type MockParcel } from './mock-data';
import type { ParcelInfo, ParcelState } from './hyperland-sdk';
import { formatEther, parseEther } from 'ethers';

interface HyperLandContextType {
  // Mode
  isMockMode: boolean;
  isConnected: boolean;

  // User data
  address?: string;
  landBalance: string;
  ethBalance: string;

  // Parcels
  allParcels: MockParcel[];
  userParcels: MockParcel[];
  listedParcels: MockParcel[];
  auctionParcels: MockParcel[];

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
  getParcel: (tokenId: number) => MockParcel | undefined;
  getParcelByCoordinates: (x: number, y: number) => MockParcel | undefined;

  // UI state
  isLoading: boolean;
  error: string | null;
}

const HyperLandContext = createContext<HyperLandContextType | undefined>(undefined);

export function HyperLandProvider({ children }: { children: ReactNode }) {
  const { address, isConnected } = useAccount();
  const isMockMode = useMockData();

  const [landBalance, setLandBalance] = useState('0');
  const [ethBalance, setEthBalance] = useState('0');
  const [allParcels, setAllParcels] = useState<MockParcel[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Load data on mount and when address changes
  useEffect(() => {
    loadData();
  }, [address, isMockMode]);

  async function loadData() {
    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        // Load mock data
        const parcels = mockState.getAllParcels();
        setAllParcels(parcels);

        if (address) {
          const user = mockState.getUser(address);
          setLandBalance(user.landBalance);
          setEthBalance(user.ethBalance);
        }
      } else {
        // TODO: Load real blockchain data using SDK
        // const client = createHyperLandClient({ network: 'base-sepolia' });
        // const balance = await client.land.balanceOf(address);
        // setLandBalance(formatEther(balance));
        console.log('Blockchain mode not yet implemented');
        setAllParcels(mockState.getAllParcels());
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load data');
      console.error('Error loading HyperLand data:', err);
    } finally {
      setIsLoading(false);
    }
  }

  // Actions
  async function buyLAND(ethAmount: string) {
    if (!address) throw new Error('Wallet not connected');

    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        mockState.buyLAND(address, ethAmount);
        await loadData();
      } else {
        // TODO: Real blockchain transaction
        // await client.core.buyLAND(parseEther(ethAmount));
        throw new Error('Blockchain transactions not yet implemented');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Transaction failed');
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  async function listParcel(tokenId: number, price: string) {
    if (!address) throw new Error('Wallet not connected');

    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        mockState.listParcel(tokenId, price, address);
        await loadData();
      } else {
        // TODO: Real blockchain transaction
        throw new Error('Blockchain transactions not yet implemented');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Transaction failed');
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  async function buyParcel(tokenId: number) {
    if (!address) throw new Error('Wallet not connected');

    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        mockState.buyParcel(tokenId, address);
        await loadData();
      } else {
        // TODO: Real blockchain transaction
        throw new Error('Blockchain transactions not yet implemented');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Transaction failed');
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  async function payTaxes(tokenId: number) {
    if (!address) throw new Error('Wallet not connected');

    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        mockState.payTaxes(tokenId, address);
        await loadData();
      } else {
        // TODO: Real blockchain transaction
        throw new Error('Blockchain transactions not yet implemented');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Transaction failed');
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  async function placeBid(tokenId: number, amount: string) {
    if (!address) throw new Error('Wallet not connected');

    setIsLoading(true);
    setError(null);

    try {
      if (isMockMode) {
        mockState.placeBid(tokenId, address, amount);
        await loadData();
      } else {
        // TODO: Real blockchain transaction
        throw new Error('Blockchain transactions not yet implemented');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Transaction failed');
      throw err;
    } finally {
      setIsLoading(false);
    }
  }

  function getParcel(tokenId: number): MockParcel | undefined {
    return isMockMode ? mockState.getParcel(tokenId) : undefined;
  }

  function getParcelByCoordinates(x: number, y: number): MockParcel | undefined {
    return isMockMode ? mockState.getParcelByCoordinates(x, y) : undefined;
  }

  // Computed values
  const userParcels = address
    ? allParcels.filter(p => p.owner.toLowerCase() === address.toLowerCase())
    : [];

  const listedParcels = allParcels.filter(p => p.listing);
  const auctionParcels = allParcels.filter(p => p.inAuction);

  const stats = isMockMode ? mockState.getStats() : {
    totalParcels: allParcels.length,
    ownedParcels: allParcels.filter(p => p.owner !== '0x0000000000000000000000000000000000000000').length,
    listedParcels: listedParcels.length,
    auctionParcels: auctionParcels.length,
    activeOwners: 0,
  };

  const value: HyperLandContextType = {
    isMockMode,
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
