/**
 * Marketplace types for HyperLand V2
 */

export interface MarketplaceListing {
  parcelId: bigint;
  seller: string;
  priceLAND: bigint;
  priceETH?: bigint; // Calculated equivalent
  listedAt: bigint;
  // Parcel details
  x: bigint;
  y: bigint;
  size: bigint;
  assessedValue: bigint;
  // Status
  active: boolean;
}

export interface SaleRecord {
  parcelId: bigint;
  from: string;
  to: string;
  priceLAND: bigint;
  priceETH?: bigint;
  timestamp: bigint;
  txHash: string;
  // Parcel snapshot
  x: bigint;
  y: bigint;
  size: bigint;
}

export interface MarketStats {
  totalListings: number;
  totalVolumeLAND: bigint;
  totalVolumeETH: bigint;
  totalSales: number;
  floorPriceLAND: bigint;
  avgPriceLAND: bigint;
  medianPriceLAND: bigint;
  last24hVolume: bigint;
  last24hSales: number;
  priceChange24h: number; // Percentage
}

export interface PriceDistribution {
  range: string; // e.g., "0-1000 LAND"
  count: number;
  percentage: number;
}

export interface ListingFilters {
  seller?: string;
  minPrice?: bigint;
  maxPrice?: bigint;
  minSize?: bigint;
  maxSize?: bigint;
  coordinates?: {
    minX: bigint;
    maxX: bigint;
    minY: bigint;
    maxY: bigint;
  };
  sortBy?: 'price' | 'size' | 'assessedValue' | 'listedAt';
  sortOrder?: 'asc' | 'desc';
  limit?: number;
  offset?: number;
}

export interface SaleFilters {
  buyer?: string;
  seller?: string;
  parcelId?: bigint;
  minPrice?: bigint;
  maxPrice?: bigint;
  fromDate?: bigint;
  toDate?: bigint;
  limit?: number;
  offset?: number;
}
