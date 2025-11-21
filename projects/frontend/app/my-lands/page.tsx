'use client';

import { ParcelCard } from '@/components/ParcelCard';
import { useHyperLand } from '@/lib/hyperland-context';
import { useState } from 'react';

export default function MyLands() {
  const {
    userParcels,
    landBalance,
    buyLAND,
    listParcel,
    payTaxes,
    isLoading,
    isMockMode,
    address,
  } = useHyperLand();

  const [ethAmount, setEthAmount] = useState('');
  const [buyingLand, setBuyingLand] = useState(false);

  async function handleBuyLAND() {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    if (!ethAmount || parseFloat(ethAmount) <= 0) {
      alert('Please enter a valid ETH amount');
      return;
    }

    setBuyingLand(true);
    try {
      await buyLAND(ethAmount);
      alert('LAND purchase successful!');
      setEthAmount('');
    } catch (error) {
      console.error('Buy LAND failed:', error);
      alert('Buy LAND failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    } finally {
      setBuyingLand(false);
    }
  }

  async function handleListParcel(tokenId: number, price: string) {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    try {
      await listParcel(tokenId, price);
      alert('Parcel listed successfully!');
    } catch (error) {
      console.error('List parcel failed:', error);
      alert('List parcel failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    }
  }

  async function handlePayTaxes(tokenId: number) {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    try {
      await payTaxes(tokenId);
      alert('Taxes paid successfully!');
    } catch (error) {
      console.error('Pay taxes failed:', error);
      alert('Pay taxes failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">My Lands</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage your land parcels and LAND tokens
          </p>
          {isMockMode && (
            <p className="text-sm text-orange-600 mt-1">
              🟠 Running in mock mode (offline data)
            </p>
          )}
        </div>
        <div className="bg-blue-100 dark:bg-blue-900 px-6 py-3 rounded-lg">
          <p className="text-sm text-gray-600 dark:text-gray-300">
            LAND Balance
          </p>
          <p className="text-2xl font-bold text-blue-600 dark:text-blue-400">
            {landBalance} LAND
          </p>
        </div>
      </div>

      {/* Buy LAND Section */}
      <div className="border rounded-lg p-6 bg-gradient-to-r from-green-50 to-blue-50 dark:from-gray-800 dark:to-gray-700">
        <h2 className="text-2xl font-bold mb-4">Buy LAND Tokens</h2>
        <div className="flex gap-4">
          <input
            type="number"
            value={ethAmount}
            onChange={(e) => setEthAmount(e.target.value)}
            placeholder="Amount in ETH"
            className="border rounded px-4 py-2 flex-1 dark:bg-gray-800"
            disabled={buyingLand || !address}
          />
          <button
            onClick={handleBuyLAND}
            disabled={buyingLand || !address || !ethAmount}
            className="bg-green-600 hover:bg-green-700 disabled:bg-gray-400 text-white px-6 py-2 rounded font-medium"
          >
            {buyingLand ? 'Buying...' : 'Buy LAND'}
          </button>
        </div>
        <p className="text-sm text-gray-600 dark:text-gray-300 mt-2">
          You receive 80% in LAND tokens, 20% goes to treasury (Rate: 1 ETH = 800 LAND)
        </p>
        {!address && (
          <p className="text-sm text-red-600 mt-2">
            Please connect your wallet to buy LAND
          </p>
        )}
      </div>

      {/* Loading */}
      {isLoading && (
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600 dark:text-gray-400">Loading your parcels...</p>
        </div>
      )}

      {/* My Parcels */}
      {!isLoading && (
        <div>
          <h2 className="text-2xl font-bold mb-4">
            My Parcels ({userParcels.length})
          </h2>
          {userParcels.length === 0 ? (
            <div className="text-center py-12 border rounded-lg bg-gray-50 dark:bg-gray-800">
              <p className="text-xl text-gray-600 dark:text-gray-300 mb-4">
                You don't own any land parcels yet
              </p>
              <a
                href="/marketplace"
                className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded inline-block font-medium"
              >
                Browse Marketplace
              </a>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
              {userParcels.map((parcel) => (
                <ParcelCard
                  key={parcel.tokenId}
                  parcel={parcel}
                  onList={handleListParcel}
                  onPayTaxes={handlePayTaxes}
                  isOwner={true}
                  showActions={true}
                />
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  );
}
