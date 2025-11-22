/**
 * Activity feed and notification types for HyperLand V2
 */

export type ActivityType =
  | 'parcel_minted'
  | 'parcel_transferred'
  | 'listing_created'
  | 'listing_cancelled'
  | 'sale_completed'
  | 'tax_paid'
  | 'tax_paid_advance'
  | 'lien_started'
  | 'lien_cleared'
  | 'auction_started'
  | 'bid_placed'
  | 'auction_extended'
  | 'auction_settled'
  | 'auction_cancelled'
  | 'valuation_submitted'
  | 'valuation_approved'
  | 'valuation_rejected'
  | 'assessor_registered'
  | 'assessor_revoked';

export interface ActivityEvent {
  id: string; // Unique event ID
  type: ActivityType;
  timestamp: bigint;
  blockNumber: bigint;
  txHash: string;
  // Primary actors
  actor: string; // Address that initiated the action
  target?: string; // Address that was affected (buyer, new owner, etc.)
  // Related entities
  parcelId?: bigint;
  // Type-specific data
  data: Record<string, any>;
}

export interface ParcelMintedEvent extends ActivityEvent {
  type: 'parcel_minted';
  data: {
    owner: string;
    x: bigint;
    y: bigint;
    size: bigint;
    assessedValue: bigint;
  };
}

export interface SaleCompletedEvent extends ActivityEvent {
  type: 'sale_completed';
  data: {
    from: string;
    to: string;
    priceLAND: bigint;
    protocolFee: bigint;
  };
}

export interface ValuationSubmittedEvent extends ActivityEvent {
  type: 'valuation_submitted';
  data: {
    assessor: string;
    value: bigint;
    methodology: string;
    previousValue: bigint;
  };
}

export interface AuctionEvent extends ActivityEvent {
  type: 'auction_started' | 'bid_placed' | 'auction_settled' | 'auction_cancelled';
  data: {
    highestBidder?: string;
    highestBid?: bigint;
    endTime?: bigint;
  };
}

export interface FeedFilters {
  types?: ActivityType[];
  actor?: string;
  target?: string;
  parcelId?: bigint;
  fromBlock?: bigint;
  toBlock?: bigint;
  fromDate?: bigint;
  toDate?: bigint;
  limit?: number;
  offset?: number;
}

export interface FeedSubscription {
  id: string;
  filters: FeedFilters;
  callback: (event: ActivityEvent) => void;
}

export interface GlobalStats {
  totalParcels: bigint;
  totalMinted: bigint;
  totalListings: number;
  totalActiveAuctions: number;
  total24hVolume: bigint;
  total24hSales: number;
  totalTaxCollected: bigint;
  totalAssessors: number;
  lastUpdated: bigint;
}

export interface TrendingParcel {
  tokenId: bigint;
  x: bigint;
  y: bigint;
  size: bigint;
  recentActivity: number; // Count of recent events
  priceChange24h: number; // Percentage
  currentPrice?: bigint;
  trending: 'up' | 'down' | 'hot' | 'new';
}
