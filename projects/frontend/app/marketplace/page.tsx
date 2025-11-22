'use client';

import { ParcelCard } from '@/components/ParcelCard';
import { useHyperLand } from '@/lib/hyperland-context';
import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function Marketplace() {
  const router = useRouter();
  const {
    listedParcels,
    auctionParcels,
    buyParcel,
    placeBid,
    isLoading,
    address,
    landBalance,
    getParcel,
  } = useHyperLand();

  const [filter, setFilter] = useState<'all' | 'listed' | 'auction'>('all');

  const displayParcels =
    filter === 'listed'
      ? listedParcels
      : filter === 'auction'
      ? auctionParcels
      : [...listedParcels, ...auctionParcels];

  async function handleBuy(tokenId: number) {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    // Check if user has enough LAND tokens
    const parcel = getParcel(tokenId);
    if (parcel && parcel.listing) {
      const price = parseFloat(parcel.listing.price);
      const balance = parseFloat(landBalance);

      if (balance < price) {
        const confirmed = confirm(
          `Insufficient LAND tokens!\n\n` +
          `You need: ${price} LAND\n` +
          `Your balance: ${balance} LAND\n` +
          `Shortage: ${(price - balance).toFixed(2)} LAND\n\n` +
          `Would you like to buy more LAND tokens?`
        );

        if (confirmed) {
          router.push('/buy-land');
        }
        return;
      }
    }

    try {
      await buyParcel(tokenId);
      alert('Purchase successful!');
    } catch (error) {
      console.error('Purchase failed:', error);
      alert('Purchase failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    }
  }

  async function handleBid(tokenId: number, amount: string) {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    // Check if user has enough LAND tokens
    const bidAmount = parseFloat(amount);
    const balance = parseFloat(landBalance);

    if (balance < bidAmount) {
      const confirmed = confirm(
        `Insufficient LAND tokens!\n\n` +
        `Bid amount: ${bidAmount} LAND\n` +
        `Your balance: ${balance} LAND\n` +
        `Shortage: ${(bidAmount - balance).toFixed(2)} LAND\n\n` +
        `Would you like to buy more LAND tokens?`
      );

      if (confirmed) {
        router.push('/buy-land');
      }
      return;
    }

    try {
      await placeBid(tokenId, amount);
      alert('Bid placed successfully!');
    } catch (error) {
      console.error('Bid failed:', error);
      alert('Bid failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Marketplace</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Browse and purchase land parcels
          </p>
        </div>

        {/* Filter */}
        <div className="flex gap-2">
          <button
            onClick={() => setFilter('all')}
            className={`px-4 py-2 rounded-lg font-medium ${
              filter === 'all'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200'
            }`}
          >
            All ({listedParcels.length + auctionParcels.length})
          </button>
          <button
            onClick={() => setFilter('listed')}
            className={`px-4 py-2 rounded-lg font-medium ${
              filter === 'listed'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200'
            }`}
          >
            Listed ({listedParcels.length})
          </button>
          <button
            onClick={() => setFilter('auction')}
            className={`px-4 py-2 rounded-lg font-medium ${
              filter === 'auction'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200'
            }`}
          >
            Auctions ({auctionParcels.length})
          </button>
        </div>
      </div>

      {/* Loading */}
      {isLoading && (
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600 dark:text-gray-400">Loading parcels...</p>
        </div>
      )}

      {/* Parcels Grid */}
      {!isLoading && displayParcels.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {displayParcels.map((parcel) => (
            <ParcelCard
              key={parcel.tokenId}
              parcel={parcel}
              onBuy={handleBuy}
              onPlaceBid={handleBid}
              showActions={true}
            />
          ))}
        </div>
      )}

      {/* Empty State */}
      {!isLoading && displayParcels.length === 0 && (
        <div className="text-center py-12 bg-gray-100 dark:bg-gray-800 rounded-lg">
          <p className="text-xl text-gray-600 dark:text-gray-400 font-semibold">
            No parcels currently listed for sale
          </p>
          <div className="mt-4 text-sm text-gray-600 dark:text-gray-400 space-y-2">
            <p>
              Parcels will appear here once they are minted and listed by owners.
            </p>
            <p className="text-xs text-gray-500 dark:text-gray-500">
              The HyperLand marketplace is fetching listings from the Base blockchain.
              <br />
              Your LAND balance: <span className="font-bold">{landBalance} LAND</span>
            </p>
          </div>

          {/* Show user's balance and next steps */}
          {address && parseFloat(landBalance) > 0 && (
            <div className="mt-6 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg max-w-md mx-auto">
              <p className="text-sm text-blue-800 dark:text-blue-200">
                ✅ You have {landBalance} LAND tokens ready to purchase parcels!
              </p>
              <p className="text-xs text-blue-600 dark:text-blue-300 mt-2">
                Check back soon as parcels become available for sale.
              </p>
            </div>
          )}

          {address && parseFloat(landBalance) === 0 && (
            <div className="mt-6">
              <button
                onClick={() => router.push('/buy-land')}
                className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium"
              >
                Get LAND Tokens First
              </button>
              <p className="text-xs text-gray-500 dark:text-gray-500 mt-2">
                You'll need LAND tokens to purchase parcels
              </p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
