/**
 * Parcel Card Component
 * Displays a land parcel with its details and actions
 */

'use client';

import { useState } from 'react';
import { formatCoordinates, shortenAddress } from '@/lib/hyperland-sdk';
import type { MockParcel } from '@/lib/mock-data';

interface ParcelCardProps {
  parcel: MockParcel;
  onBuy?: (tokenId: number) => void;
  onList?: (tokenId: number, price: string) => void;
  onPayTaxes?: (tokenId: number) => void;
  onPlaceBid?: (tokenId: number, amount: string) => void;
  isOwner?: boolean;
  showActions?: boolean;
}

export function ParcelCard({
  parcel,
  onBuy,
  onList,
  onPayTaxes,
  onPlaceBid,
  isOwner = false,
  showActions = true,
}: ParcelCardProps) {
  const [showListForm, setShowListForm] = useState(false);
  const [listPrice, setListPrice] = useState('');
  const [bidAmount, setBidAmount] = useState('');

  const isAvailable = parcel.owner === '0x0000000000000000000000000000000000000000';
  const isListed = !!parcel.listing;
  const isInAuction = parcel.inAuction;

  function handleList() {
    if (listPrice && onList) {
      onList(parcel.tokenId, listPrice);
      setShowListForm(false);
      setListPrice('');
    }
  }

  function handleBid() {
    if (bidAmount && onPlaceBid) {
      onPlaceBid(parcel.tokenId, bidAmount);
      setBidAmount('');
    }
  }

  return (
    <div className="border rounded-lg p-4 bg-white dark:bg-gray-800 hover:shadow-lg transition-shadow">
      {/* Header */}
      <div className="flex justify-between items-start mb-3">
        <div>
          <h3 className="font-bold text-lg">Parcel #{parcel.tokenId}</h3>
          <p className="text-sm text-gray-600 dark:text-gray-400">
            {formatCoordinates(parcel.x, parcel.y)}
          </p>
        </div>
        <div className="text-right">
          {isInAuction && (
            <span className="px-2 py-1 bg-orange-100 text-orange-800 text-xs rounded-full">
              🔨 Auction
            </span>
          )}
          {isListed && (
            <span className="px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">
              📦 Listed
            </span>
          )}
          {isAvailable && (
            <span className="px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full">
              ✨ Available
            </span>
          )}
        </div>
      </div>

      {/* Details */}
      <div className="space-y-2 text-sm mb-4">
        <div className="flex justify-between">
          <span className="text-gray-600 dark:text-gray-400">Size:</span>
          <span className="font-medium">{parcel.size}x{parcel.size}</span>
        </div>
        <div className="flex justify-between">
          <span className="text-gray-600 dark:text-gray-400">Assessed Value:</span>
          <span className="font-medium">{parcel.assessedValue} LAND</span>
        </div>
        {!isAvailable && (
          <div className="flex justify-between">
            <span className="text-gray-600 dark:text-gray-400">Owner:</span>
            <span className="font-medium">{shortenAddress(parcel.owner)}</span>
          </div>
        )}

        {isListed && parcel.listing && (
          <div className="flex justify-between border-t pt-2 mt-2">
            <span className="text-gray-600 dark:text-gray-400">List Price:</span>
            <span className="font-bold text-green-600">{parcel.listing.price} LAND</span>
          </div>
        )}

        {isInAuction && parcel.auction && (
          <>
            <div className="flex justify-between border-t pt-2 mt-2">
              <span className="text-gray-600 dark:text-gray-400">Highest Bid:</span>
              <span className="font-bold text-orange-600">{parcel.auction.highestBid} LAND</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">Ends:</span>
              <span className="text-sm">
                {new Date(parcel.auction.endTime).toLocaleDateString()}
              </span>
            </div>
          </>
        )}
      </div>

      {/* Actions */}
      {showActions && (
        <div className="space-y-2">
          {/* Listed parcel - can buy */}
          {isListed && !isOwner && parcel.listing && (
            <button
              onClick={() => onBuy?.(parcel.tokenId)}
              className="w-full bg-green-600 hover:bg-green-700 text-white py-2 rounded-lg font-medium"
            >
              Buy for {parcel.listing.price} LAND
            </button>
          )}

          {/* Auction parcel - can bid */}
          {isInAuction && !isOwner && (
            <div className="space-y-2">
              <input
                type="number"
                value={bidAmount}
                onChange={(e) => setBidAmount(e.target.value)}
                placeholder="Bid amount (LAND)"
                className="w-full border rounded-lg px-3 py-2 text-sm"
              />
              <button
                onClick={handleBid}
                disabled={!bidAmount}
                className="w-full bg-orange-600 hover:bg-orange-700 disabled:bg-gray-400 text-white py-2 rounded-lg font-medium"
              >
                Place Bid
              </button>
            </div>
          )}

          {/* Owner actions */}
          {isOwner && !isListed && !isInAuction && (
            <>
              {showListForm ? (
                <div className="space-y-2">
                  <input
                    type="number"
                    value={listPrice}
                    onChange={(e) => setListPrice(e.target.value)}
                    placeholder="Price in LAND"
                    className="w-full border rounded-lg px-3 py-2 text-sm"
                  />
                  <div className="flex gap-2">
                    <button
                      onClick={handleList}
                      disabled={!listPrice}
                      className="flex-1 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 text-white py-2 rounded-lg text-sm font-medium"
                    >
                      Confirm
                    </button>
                    <button
                      onClick={() => setShowListForm(false)}
                      className="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 rounded-lg text-sm font-medium"
                    >
                      Cancel
                    </button>
                  </div>
                </div>
              ) : (
                <div className="grid grid-cols-2 gap-2">
                  <button
                    onClick={() => setShowListForm(true)}
                    className="bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-lg text-sm font-medium"
                  >
                    List for Sale
                  </button>
                  <button
                    onClick={() => onPayTaxes?.(parcel.tokenId)}
                    className="bg-purple-600 hover:bg-purple-700 text-white py-2 rounded-lg text-sm font-medium"
                  >
                    Pay Taxes
                  </button>
                </div>
              )}
            </>
          )}
        </div>
      )}
    </div>
  );
}
