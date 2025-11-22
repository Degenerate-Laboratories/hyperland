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
    <div className="glass rounded-lg p-4 hover:border-cyan-400 hover:shadow-cyan transition-all duration-300 border border-white/20">
      {/* Header */}
      <div className="flex justify-between items-start mb-3">
        <div>
          <h3 className="font-bold text-lg text-white">Parcel #{parcel.tokenId}</h3>
          <p className="text-sm text-white/80">
            {formatCoordinates(parcel.x, parcel.y)}
          </p>
        </div>
        <div className="text-right">
          {isInAuction && (
            <span className="px-2 py-1 bg-orange-500/20 text-orange-300 text-xs rounded-full border border-orange-400/30">
              Auction
            </span>
          )}
          {isListed && (
            <span className="px-2 py-1 bg-green-500/20 text-green-300 text-xs rounded-full border border-green-400/30">
              Listed
            </span>
          )}
          {isAvailable && (
            <span className="px-2 py-1 bg-blue-500/20 text-blue-300 text-xs rounded-full border border-blue-400/30">
              Available
            </span>
          )}
        </div>
      </div>

      {/* Details */}
      <div className="space-y-2 text-sm mb-4">
        <div className="flex justify-between">
          <span className="text-white/80">Size:</span>
          <span className="font-medium text-white">{parcel.size}x{parcel.size}</span>
        </div>
        <div className="flex justify-between">
          <span className="text-white/80">Assessed Value:</span>
          <span className="font-medium text-white">{parcel.assessedValue} LAND</span>
        </div>
        {!isAvailable && (
          <div className="flex justify-between">
            <span className="text-white/80">Owner:</span>
            <span className="font-medium text-white">{shortenAddress(parcel.owner)}</span>
          </div>
        )}

        {isListed && parcel.listing && (
          <div className="flex justify-between border-t border-white/10 pt-2 mt-2">
            <span className="text-white/80">List Price:</span>
            <span className="font-bold text-green-400">{parcel.listing.price} LAND</span>
          </div>
        )}

        {isInAuction && parcel.auction && (
          <>
            <div className="flex justify-between border-t border-white/10 pt-2 mt-2">
              <span className="text-white/80">Highest Bid:</span>
              <span className="font-bold text-orange-400">{parcel.auction.highestBid} LAND</span>
            </div>
            <div className="flex justify-between">
              <span className="text-white/80">Ends:</span>
              <span className="text-sm text-white">
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
              className="w-full bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white py-2 rounded-lg font-medium transition-all duration-200"
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
                className="w-full border border-white/20 bg-white/10 rounded-lg px-3 py-2 text-sm text-white placeholder-white/50"
              />
              <button
                onClick={handleBid}
                disabled={!bidAmount}
                className="w-full bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 disabled:opacity-50 disabled:cursor-not-allowed text-white py-2 rounded-lg font-medium transition-all duration-200"
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
                    className="w-full border border-white/20 bg-white/10 rounded-lg px-3 py-2 text-sm text-white placeholder-white/50"
                  />
                  <div className="flex gap-2">
                    <button
                      onClick={handleList}
                      disabled={!listPrice}
                      className="flex-1 bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 disabled:opacity-50 disabled:cursor-not-allowed text-white py-2 rounded-lg text-sm font-medium transition-all duration-200"
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
                    className="bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white py-2 rounded-lg text-sm font-medium transition-all duration-200"
                  >
                    List for Sale
                  </button>
                  <button
                    onClick={() => onPayTaxes?.(parcel.tokenId)}
                    className="bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white py-2 rounded-lg text-sm font-medium transition-all duration-200"
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
