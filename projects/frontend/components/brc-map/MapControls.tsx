'use client';

import { ParcelStatus, RingName } from '@/lib/brc-constants';

interface MapControlsProps {
  filters: {
    band: string;
    status: string;
    minPrice: number;
    maxPrice: number;
  };
  onFiltersChange: (filters: any) => void;
  view3D: boolean;
  onToggleView: () => void;
}

const RINGS: RingName[] = ['Esplanade', 'Afanc', 'MidCity', 'Igopogo', 'Kraken'];
const STATUSES = [
  { value: ParcelStatus.AVAILABLE, label: 'Available' },
  { value: ParcelStatus.CLAIMED, label: 'Claimed' },
  { value: ParcelStatus.FORECLOSURE, label: 'Foreclosure' },
];

export default function MapControls({ filters, onFiltersChange, view3D, onToggleView }: MapControlsProps) {
  return (
    <div className="border-b border-white/10 bg-black/20 backdrop-blur-sm">
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex flex-wrap items-center gap-4">
          {/* Ring Filter */}
          <div className="flex items-center gap-2">
            <label className="text-white/60 text-sm">Ring:</label>
            <select
              value={filters.band}
              onChange={(e) => onFiltersChange({ ...filters, band: e.target.value })}
              className="glass px-3 py-2 rounded-lg text-sm border border-white/20 focus:border-cyan-500 outline-none"
            >
              <option value="">All Rings</option>
              {RINGS.map(ring => (
                <option key={ring} value={ring}>{ring}</option>
              ))}
            </select>
          </div>

          {/* Status Filter */}
          <div className="flex items-center gap-2">
            <label className="text-white/60 text-sm">Status:</label>
            <select
              value={filters.status}
              onChange={(e) => onFiltersChange({ ...filters, status: e.target.value })}
              className="glass px-3 py-2 rounded-lg text-sm border border-white/20 focus:border-cyan-500 outline-none"
            >
              <option value="">All Status</option>
              {STATUSES.map(status => (
                <option key={status.value} value={status.value}>{status.label}</option>
              ))}
            </select>
          </div>

          {/* View Toggle */}
          <div className="ml-auto flex items-center gap-2">
            <button
              onClick={onToggleView}
              className={`px-4 py-2 rounded-lg text-sm font-semibold transition-all ${
                !view3D
                  ? 'bg-gradient-to-r from-purple-500 to-cyan-500 text-white'
                  : 'glass-hover'
              }`}
            >
              2D
            </button>
            <button
              onClick={onToggleView}
              className={`px-4 py-2 rounded-lg text-sm font-semibold transition-all ${
                view3D
                  ? 'bg-gradient-to-r from-purple-500 to-cyan-500 text-white'
                  : 'glass-hover'
              }`}
            >
              3D
            </button>
          </div>

          {/* Legend */}
          <div className="flex items-center gap-4 text-xs">
            <div className="flex items-center gap-2">
              <div className="w-3 h-3 rounded-full bg-cyan-500"></div>
              <span className="text-white/60">Available</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-3 h-3 rounded-full bg-purple-500"></div>
              <span className="text-white/60">Claimed</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-3 h-3 rounded-full bg-orange-500 pulse"></div>
              <span className="text-white/60">Foreclosure</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
