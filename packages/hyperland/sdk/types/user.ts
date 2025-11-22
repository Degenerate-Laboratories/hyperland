/**
 * User profile and portfolio types for HyperLand V2
 */

export interface UserProfile {
  address: string;
  // Portfolio stats
  parcelCount: number;
  totalValue: bigint; // Total assessed value of all parcels
  activeListings: number;
  activeBids: number;
  // Activity stats
  totalPurchases: number;
  totalSales: number;
  totalSpentLAND: bigint;
  totalEarnedLAND: bigint;
  // Tax stats
  totalTaxesPaid: bigint;
  liensHeld: number;
  liensActive: number;
  // Assessor info (if applicable)
  isAssessor: boolean;
  assessorInfo?: {
    registeredAt: bigint;
    assessmentCount: bigint;
    credentials: string;
  };
  // Timestamps
  firstActivity: bigint;
  lastActivity: bigint;
}

export interface UserParcel {
  tokenId: bigint;
  x: bigint;
  y: bigint;
  size: bigint;
  assessedValue: bigint;
  taxOwed: bigint;
  isListed: boolean;
  listingPrice?: bigint;
  hasLien: boolean;
  lienHolder?: string;
  inAuction: boolean;
  mintedAt: bigint;
  acquiredAt: bigint;
}

export interface UserListing {
  parcelId: bigint;
  priceLAND: bigint;
  listedAt: bigint;
  x: bigint;
  y: bigint;
  size: bigint;
  assessedValue: bigint;
}

export interface UserBid {
  parcelId: bigint;
  bidAmount: bigint;
  bidAt: bigint;
  auctionEndTime: bigint;
  isHighestBid: boolean;
  x: bigint;
  y: bigint;
  size: bigint;
}

export interface UserActivity {
  type: 'purchase' | 'sale' | 'listing' | 'delisting' | 'tax_payment' | 'lien_start' | 'lien_clear' | 'bid' | 'auction_won' | 'valuation';
  parcelId?: bigint;
  timestamp: bigint;
  txHash: string;
  details: any; // Type-specific details
}

export interface UserStats {
  address: string;
  netWorth: bigint; // Total value - total tax owed
  roi: number; // Return on investment percentage
  averageParcelSize: bigint;
  averageHoldTime: bigint; // In seconds
  taxEfficiency: number; // Percentage of on-time tax payments
}

export interface UserFilters {
  includeHistoricalParcels?: boolean; // Include sold parcels
  includeDelinquent?: boolean; // Include parcels with unpaid taxes
  sortBy?: 'value' | 'size' | 'taxOwed' | 'acquiredAt';
  sortOrder?: 'asc' | 'desc';
}

export interface ActivityFilters {
  type?: UserActivity['type'] | UserActivity['type'][];
  fromDate?: bigint;
  toDate?: bigint;
  limit?: number;
  offset?: number;
}
