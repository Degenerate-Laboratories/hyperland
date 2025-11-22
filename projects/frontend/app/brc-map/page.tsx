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
    <div className="flex flex-col h-screen overflow-hidden">
      {/* Header Section */}
      <div className="fixed top-16 left-0 right-0 z-30 glass border-b border-white/10 backdrop-blur-xl">
        <div className="container mx-auto px-4 md:px-8 py-3 md:py-4">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-3 md:gap-0">
            <div className="flex-1">
              <h1 className="text-lg md:text-2xl font-display font-bold text-gradient-cyan-purple mb-0.5 md:mb-1">
                Hyperland Territory Map
              </h1>
              <p className="text-[10px] md:text-sm text-white/60">
                <span className="hidden md:inline">Explore 1,200 parcels across 5 rings • Click any parcel to view details</span>
                <span className="md:hidden">1,200 parcels • 5 rings</span>
              </p>
            </div>
            <div className="flex items-center gap-2 md:gap-3">
              <div className="glass-hover px-3 py-1.5 md:px-4 md:py-2 rounded-md md:rounded-lg border border-white/20 flex-1 md:flex-initial">
                <div className="text-[9px] md:text-xs text-white/60">Total Parcels</div>
                <div className="text-sm md:text-xl font-bold text-gradient-purple-pink">{mapData?.statistics.totalParcels || 0}</div>
              </div>
              <div className="glass-hover px-3 py-1.5 md:px-4 md:py-2 rounded-md md:rounded-lg border border-white/20 flex-1 md:flex-initial">
                <div className="text-[9px] md:text-xs text-white/60">Avg Price</div>
                <div className="text-sm md:text-xl font-bold text-gradient-cyan-purple">${mapData?.statistics.avgPrice.toFixed(0) || 0}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Map Canvas */}
      <div className="flex-1 mt-16 pt-[100px] md:pt-[120px] pb-[70px] md:pb-[80px]">
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

      {/* Bottom Stats Bar - Enhanced */}
      <div className="fixed bottom-0 left-0 right-0 glass border-t border-white/20 backdrop-blur-xl z-40">
        <div className="container mx-auto h-full px-2 md:px-8 py-2 md:py-0 md:flex md:items-center md:justify-between">
          {/* Stats - Scrollable on mobile */}
          <div className="flex items-center gap-2 md:gap-6 overflow-x-auto scrollbar-hide pb-2 md:pb-0">
            <div className="glass-hover px-2 md:px-4 py-1.5 md:py-2 rounded-md md:rounded-lg border border-cyan-500/30 flex items-center gap-2 md:gap-3 flex-shrink-0">
              <div className="w-2 h-2 md:w-3 md:h-3 rounded-full bg-cyan-400 glow-cyan"></div>
              <div>
                <div className="text-[9px] md:text-xs text-white/60">Claimed</div>
                <div className="text-sm md:text-lg font-bold text-cyan-400">{mapData?.statistics.claimedParcels}</div>
              </div>
            </div>
            <div className="glass-hover px-2 md:px-4 py-1.5 md:py-2 rounded-md md:rounded-lg border border-purple-500/30 flex items-center gap-2 md:gap-3 flex-shrink-0">
              <div className="w-2 h-2 md:w-3 md:h-3 rounded-full bg-purple-400 glow-purple"></div>
              <div>
                <div className="text-[9px] md:text-xs text-white/60">Available</div>
                <div className="text-sm md:text-lg font-bold text-purple-400">{mapData?.statistics.availableParcels}</div>
              </div>
            </div>
            <div className="glass-hover px-2 md:px-4 py-1.5 md:py-2 rounded-md md:rounded-lg border border-orange-500/30 flex items-center gap-2 md:gap-3 flex-shrink-0">
              <div className="w-2 h-2 md:w-3 md:h-3 rounded-full bg-orange-400" style={{ boxShadow: '0 0 10px rgba(249, 115, 22, 0.5)' }}></div>
              <div>
                <div className="text-[9px] md:text-xs text-white/60">Foreclosure</div>
                <div className="text-sm md:text-lg font-bold text-orange-400">{mapData?.statistics.foreclosureParcels}</div>
              </div>
            </div>
            <div className="glass-hover px-2 md:px-4 py-1.5 md:py-2 rounded-md md:rounded-lg border border-pink-500/30 flex items-center gap-2 md:gap-3 flex-shrink-0">
              <div className="w-2 h-2 md:w-3 md:h-3 rounded-full bg-pink-400" style={{ boxShadow: '0 0 10px rgba(236, 72, 153, 0.5)' }}></div>
              <div>
                <div className="text-[9px] md:text-xs text-white/60">Unique Owners</div>
                <div className="text-sm md:text-lg font-bold text-pink-400">{mapData?.statistics.uniqueOwners}</div>
              </div>
            </div>

            {/* Territory Rings - Show in scroll on mobile */}
            <div className="glass px-2 md:px-4 py-1.5 md:py-2 rounded-md md:rounded-lg border border-white/20 flex-shrink-0">
              <div className="text-[9px] md:text-xs text-white/60 mb-1 md:mb-2 font-semibold">TERRITORY</div>
              <div className="flex items-center gap-2 md:gap-4">
                <div className="flex items-center gap-1 md:gap-2">
                  <div className="w-3 h-3 md:w-4 md:h-4 rounded border border-cyan-400/50" style={{ background: 'rgba(6, 182, 212, 0.75)', boxShadow: '0 0 8px rgba(6, 182, 212, 0.3)' }}></div>
                  <span className="text-[9px] md:text-xs text-white/80 font-medium hidden md:inline">Esplanade</span>
                  <span className="text-[9px] text-white/80 font-medium md:hidden">Esp</span>
                </div>
                <div className="flex items-center gap-1 md:gap-2">
                  <div className="w-3 h-3 md:w-4 md:h-4 rounded border border-blue-400/50" style={{ background: 'rgba(59, 130, 246, 0.75)', boxShadow: '0 0 8px rgba(59, 130, 246, 0.3)' }}></div>
                  <span className="text-[9px] md:text-xs text-white/80 font-medium hidden md:inline">Afanc</span>
                  <span className="text-[9px] text-white/80 font-medium md:hidden">Afa</span>
                </div>
                <div className="flex items-center gap-1 md:gap-2">
                  <div className="w-3 h-3 md:w-4 md:h-4 rounded border border-purple-400/50" style={{ background: 'rgba(168, 85, 247, 0.75)', boxShadow: '0 0 8px rgba(168, 85, 247, 0.3)' }}></div>
                  <span className="text-[9px] md:text-xs text-white/80 font-medium hidden md:inline">MidCity</span>
                  <span className="text-[9px] text-white/80 font-medium md:hidden">Mid</span>
                </div>
                <div className="flex items-center gap-1 md:gap-2">
                  <div className="w-3 h-3 md:w-4 md:h-4 rounded border border-orange-400/50" style={{ background: 'rgba(249, 115, 22, 0.75)', boxShadow: '0 0 8px rgba(249, 115, 22, 0.3)' }}></div>
                  <span className="text-[9px] md:text-xs text-white/80 font-medium hidden md:inline">Igopogo</span>
                  <span className="text-[9px] text-white/80 font-medium md:hidden">Igo</span>
                </div>
                <div className="flex items-center gap-1 md:gap-2">
                  <div className="w-3 h-3 md:w-4 md:h-4 rounded border border-pink-400/50" style={{ background: 'rgba(236, 72, 153, 0.75)', boxShadow: '0 0 8px rgba(236, 72, 153, 0.3)' }}></div>
                  <span className="text-[9px] md:text-xs text-white/80 font-medium hidden md:inline">Kraken</span>
                  <span className="text-[9px] text-white/80 font-medium md:hidden">Kra</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
