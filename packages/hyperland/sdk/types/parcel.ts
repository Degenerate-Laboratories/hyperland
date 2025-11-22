/**
 * Parcel discovery and search types for HyperLand V2
 */

export interface ParcelDiscovery {
  tokenId: bigint | null; // null if unminted
  x: bigint;
  y: bigint;
  isMinted: boolean;
  owner?: string;
  size?: bigint;
  assessedValue?: bigint;
  isListed?: boolean;
  listingPrice?: bigint;
}

export interface ParcelSearchResult {
  tokenId: bigint;
  owner: string;
  x: bigint;
  y: bigint;
  size: bigint;
  assessedValue: bigint;
  taxOwed: bigint;
  isListed: boolean;
  listingPrice?: bigint;
  inAuction: boolean;
  hasLien: boolean;
  isDelinquent: boolean;
  // Calculated fields
  score: number; // Relevance score for search
}

export interface CoordinateBounds {
  minX: bigint;
  maxX: bigint;
  minY: bigint;
  maxY: bigint;
}

export interface ParcelFilters {
  owner?: string;
  minted?: boolean;
  listed?: boolean;
  inAuction?: boolean;
  delinquent?: boolean;
  hasLien?: boolean;
  bounds?: CoordinateBounds;
  minSize?: bigint;
  maxSize?: bigint;
  minValue?: bigint;
  maxValue?: bigint;
  minPrice?: bigint;
  maxPrice?: bigint;
  sortBy?: 'tokenId' | 'value' | 'size' | 'taxOwed' | 'price' | 'coordinates';
  sortOrder?: 'asc' | 'desc';
  limit?: number;
  offset?: number;
}

export interface ParcelNeighbor {
  tokenId: bigint;
  x: bigint;
  y: bigint;
  distance: number; // Calculated distance
  direction: 'north' | 'south' | 'east' | 'west' | 'northeast' | 'northwest' | 'southeast' | 'southwest';
  owner: string;
  size: bigint;
  assessedValue: bigint;
  isListed: boolean;
}

export interface AvailableCoordinate {
  x: bigint;
  y: bigint;
  hasNeighbors: boolean;
  neighborCount: number;
  estimatedValue?: bigint; // Based on nearby parcels
}

export interface ParcelSearchQuery {
  text?: string; // Free text search (coordinates, owner, etc.)
  coordinates?: { x: bigint; y: bigint };
  owner?: string;
  filters?: ParcelFilters;
}

export interface MapViewport {
  bounds: CoordinateBounds;
  zoom: number;
  center: { x: bigint; y: bigint };
}

export interface MapParcel {
  tokenId: bigint | null;
  x: bigint;
  y: bigint;
  isMinted: boolean;
  owner?: string;
  size?: bigint;
  // Visual metadata for map rendering
  color?: string;
  isSelected?: boolean;
  isHighlighted?: boolean;
}
