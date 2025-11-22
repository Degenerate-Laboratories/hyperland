'use client';

import { useState, useEffect } from 'react';
import { BRCParcel } from '@/lib/brc-constants';
import BRCMap2D from '@/components/brc-map/BRCMap2D';
import ParcelDetail from '@/components/brc-map/ParcelDetail';

interface MapData {
  parcels: BRCParcel[];
  statistics: {
    totalParcels: number;
    claimedParcels: number;
    availableParcels: number;
    foreclosureParcels: number;
    avgPrice: number;
    uniqueOwners: number;
  };
}

export default function BRCMapPage() {
  const [mapData, setMapData] = useState<MapData | null>(null);
  const [selectedParcel, setSelectedParcel] = useState<BRCParcel | null>(null);
  const [filters, setFilters] = useState({
    band: '',
    status: '',
    minPrice: 0,
    maxPrice: 10000
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchMapData();
  }, [filters]);

  const fetchMapData = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams({
        limit: '99999',
        ...(filters.band && { band: filters.band }),
        ...(filters.status && { status: filters.status }),
      });

      const response = await fetch(`/api/brc-map?${params}`);
      const data = await response.json();

      setMapData({
        parcels: data.parcels,
        statistics: data.statistics
      });
    } catch (error) {
      console.error('Failed to fetch map data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleParcelClick = (parcel: BRCParcel) => {
    setSelectedParcel(parcel);
  };

  const handleCloseDetail = () => {
    setSelectedParcel(null);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="spinner mx-auto mb-4"></div>
          <p className="text-xl text-gradient-cyan-purple">Loading Hyperland...</p>
          <p className="text-sm text-white/60 mt-2">Generating 1,200 parcels</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col h-screen">
      {/* Map Canvas */}
      <div className="flex-1 mt-16">
        <BRCMap2D
          parcels={mapData?.parcels || []}
          onParcelClick={handleParcelClick}
          selectedParcel={selectedParcel}
        />
      </div>

      {/* Parcel Detail Drawer */}
      {selectedParcel && (
        <ParcelDetail
          parcel={selectedParcel}
          onClose={handleCloseDetail}
        />
      )}

      {/* Bottom Stats Bar */}
      <div className="fixed bottom-0 left-0 right-0 h-16 bg-black border-t border-white/10 z-40">
        <div className="container mx-auto h-full px-8 flex items-center justify-between">
          {/* Left: Stats */}
          <div className="flex items-center gap-8">
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-cyan-400"></div>
              <span className="text-xs text-gray-400">Claimed</span>
              <span className="text-sm font-semibold text-white">{mapData?.statistics.claimedParcels}</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-purple-400"></div>
              <span className="text-xs text-gray-400">Available</span>
              <span className="text-sm font-semibold text-white">{mapData?.statistics.availableParcels}</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-orange-400"></div>
              <span className="text-xs text-gray-400">Foreclosure</span>
              <span className="text-sm font-semibold text-white">{mapData?.statistics.foreclosureParcels}</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-pink-400"></div>
              <span className="text-xs text-gray-400">Owners</span>
              <span className="text-sm font-semibold text-white">{mapData?.statistics.uniqueOwners}</span>
            </div>
          </div>

          {/* Right: Legend */}
          <div className="flex items-center gap-5">
            <div className="flex items-center gap-1.5">
              <div className="w-3 h-3 rounded" style={{ background: 'rgba(6, 182, 212, 0.75)' }}></div>
              <span className="text-xs text-gray-400">Esplanade</span>
            </div>
            <div className="flex items-center gap-1.5">
              <div className="w-3 h-3 rounded" style={{ background: 'rgba(59, 130, 246, 0.75)' }}></div>
              <span className="text-xs text-gray-400">Afanc</span>
            </div>
            <div className="flex items-center gap-1.5">
              <div className="w-3 h-3 rounded" style={{ background: 'rgba(168, 85, 247, 0.75)' }}></div>
              <span className="text-xs text-gray-400">MidCity</span>
            </div>
            <div className="flex items-center gap-1.5">
              <div className="w-3 h-3 rounded" style={{ background: 'rgba(249, 115, 22, 0.75)' }}></div>
              <span className="text-xs text-gray-400">Igopogo</span>
            </div>
            <div className="flex items-center gap-1.5">
              <div className="w-3 h-3 rounded" style={{ background: 'rgba(236, 72, 153, 0.75)' }}></div>
              <span className="text-xs text-gray-400">Kraken</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
