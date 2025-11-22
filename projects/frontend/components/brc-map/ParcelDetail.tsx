'use client';

import { useEffect, useState } from 'react';
import { BRCParcel, ParcelStatus } from '@/lib/brc-constants';

interface ParcelDetailProps {
  parcel: BRCParcel;
  onClose: () => void;
}

export default function ParcelDetail({ parcel, onClose }: ParcelDetailProps) {
  const [timeLeft, setTimeLeft] = useState<string>('');

  // Calculate foreclosure countdown
  useEffect(() => {
    if (parcel.status !== ParcelStatus.FORECLOSURE || !parcel.foreclosureDate) return;

    const updateCountdown = () => {
      const now = Date.now();
      const diff = parcel.foreclosureDate! - now;

      if (diff <= 0) {
        setTimeLeft('EXPIRED');
        return;
      }

      const days = Math.floor(diff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((diff % (1000 * 60)) / 1000);

      setTimeLeft(`${days}d ${hours}h ${minutes}m ${seconds}s`);
    };

    updateCountdown();
    const interval = setInterval(updateCountdown, 1000);

    return () => clearInterval(interval);
  }, [parcel]);

  const getStatusBadge = () => {
    switch (parcel.status) {
      case ParcelStatus.AVAILABLE:
        return <span className="status-available px-3 py-1 rounded-full text-sm font-semibold border">AVAILABLE</span>;
      case ParcelStatus.CLAIMED:
        return <span className="status-claimed px-3 py-1 rounded-full text-sm font-semibold border">CLAIMED</span>;
      case ParcelStatus.FORECLOSURE:
        return <span className="status-foreclosure px-3 py-1 rounded-full text-sm font-semibold border pulse">FORECLOSURE</span>;
      default:
        return null;
    }
  };

  return (
    <>
      {/* Overlay */}
      <div
        className="fixed inset-0 bg-black/50 backdrop-blur-sm z-40"
        onClick={onClose}
      />

      {/* Drawer */}
      <div className="fixed right-0 top-16 bottom-0 w-full md:w-[500px] z-50 bg-[#0a0a1e]/95 backdrop-blur-xl border-l border-white/20 overflow-y-auto animate-slide-in">
        <div className="p-6">
          {/* Header */}
          <div className="flex items-start justify-between mb-6">
            <div>
              <h2 className="font-display text-3xl font-bold text-gradient-cyan-purple mb-2">
                {parcel.id}
              </h2>
              <p className="text-white/60 text-sm">{parcel.address}</p>
            </div>
            <button
              onClick={onClose}
              className="glass-hover w-10 h-10 rounded-lg flex items-center justify-center text-xl"
            >
              ✕
            </button>
          </div>

          {/* Status Badge */}
          <div className="mb-6">
            {getStatusBadge()}
          </div>

          {/* Foreclosure Timer */}
          {parcel.status === ParcelStatus.FORECLOSURE && parcel.foreclosureDate && (
            <div className="glass rounded-lg p-4 mb-6 border-2 border-orange-500/50">
              <div className="text-orange-400 text-sm font-semibold mb-2">
                ⚠️ FORECLOSURE COUNTDOWN
              </div>
              <div className="font-mono text-2xl text-orange-300 font-bold">
                {timeLeft}
              </div>
              <div className="text-white/60 text-xs mt-2">
                Time until parcel returns to market
              </div>
            </div>
          )}

          {/* Price */}
          <div className="glass rounded-lg p-6 mb-6">
            <div className="text-white/60 text-sm mb-1">Current Price</div>
            <div className="text-4xl font-bold text-gradient-purple-pink">
              ${parcel.price.toLocaleString()}
            </div>
            {parcel.lastSalePrice && (
              <div className="text-white/40 text-sm mt-2">
                Last sale: ${parcel.lastSalePrice.toLocaleString()}
              </div>
            )}
          </div>

          {/* Location Info */}
          <div className="space-y-4 mb-6">
            <div className="glass rounded-lg p-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <div className="text-white/60 text-xs">Ring</div>
                  <div className="text-cyan-400 font-semibold">{parcel.band}</div>
                </div>
                <div>
                  <div className="text-white/60 text-xs">Sector</div>
                  <div className="text-purple-400 font-semibold">{parcel.sector}</div>
                </div>
                <div>
                  <div className="text-white/60 text-xs">Coordinates</div>
                  <div className="font-mono text-xs">{Math.round(parcel.x)}, {Math.round(parcel.y)}</div>
                </div>
                <div>
                  <div className="text-white/60 text-xs">Area</div>
                  <div className="font-mono text-xs">{Math.round(parcel.area)} sq ft</div>
                </div>
              </div>
            </div>

            <div className="glass rounded-lg p-4">
              <div className="text-white/60 text-xs mb-1">GPS Coordinates</div>
              <div className="font-mono text-xs text-white/80">
                {parcel.lat.toFixed(6)}°, {parcel.lon.toFixed(6)}°
              </div>
            </div>
          </div>

          {/* Owner Info */}
          {parcel.currentOwner && (
            <div className="glass rounded-lg p-4 mb-6">
              <div className="text-white/60 text-xs mb-2">Current Owner</div>
              <div className="font-mono text-sm text-white/80 break-all">
                {parcel.currentOwner}
              </div>
              {parcel.ownerHistory.length > 0 && (
                <div className="text-white/40 text-xs mt-2">
                  Acquired: {new Date(parcel.ownerHistory[0].acquiredDate).toLocaleDateString()}
                </div>
              )}
            </div>
          )}

          {/* Activity Score */}
          <div className="glass rounded-lg p-4 mb-6">
            <div className="text-white/60 text-xs mb-2">Activity Score</div>
            <div className="flex items-center gap-3">
              <div className="flex-1 h-2 bg-white/10 rounded-full overflow-hidden">
                <div
                  className="h-full bg-gradient-to-r from-cyan-500 to-purple-500 transition-all"
                  style={{ width: `${parcel.activityScore}%` }}
                />
              </div>
              <div className="text-lg font-bold text-white/80">
                {parcel.activityScore}
              </div>
            </div>
          </div>

          {/* Improvements */}
          {parcel.improvements && parcel.improvements.length > 0 && (
            <div className="glass rounded-lg p-4 mb-6">
              <div className="text-white/60 text-xs mb-3">Improvements</div>
              <div className="flex flex-wrap gap-2">
                {parcel.improvements.map((improvement, idx) => (
                  <span
                    key={idx}
                    className="px-3 py-1 bg-purple-500/20 border border-purple-500/50 rounded-full text-xs text-purple-300"
                  >
                    {improvement}
                  </span>
                ))}
              </div>
            </div>
          )}

          {/* Action Buttons */}
          <div className="space-y-3">
            <a
              href={parcel.playUrl}
              className="btn-primary w-full text-center block"
            >
              PLAY / TELEPORT
            </a>

            {parcel.status === ParcelStatus.AVAILABLE && (
              <button className="btn-secondary w-full">
                PURCHASE PARCEL
              </button>
            )}

            {parcel.status === ParcelStatus.FORECLOSURE && (
              <button className="btn-secondary w-full">
                CLAIM FORECLOSURE
              </button>
            )}

            <button
              onClick={() => {
                navigator.clipboard.writeText(
                  `${window.location.origin}/brc-map?parcel=${parcel.id}`
                );
                alert('Link copied to clipboard!');
              }}
              className="glass-hover w-full px-4 py-2 rounded-lg text-sm"
            >
              Share Link
            </button>
          </div>
        </div>
      </div>

      <style jsx>{`
        @keyframes slide-in {
          from {
            transform: translateX(100%);
          }
          to {
            transform: translateX(0);
          }
        }

        .animate-slide-in {
          animation: slide-in 0.3s ease-out;
        }
      `}</style>
    </>
  );
}
