/**
 * Core contract types for HyperLand V2
 */

export interface ParcelState {
  assessedValueLAND: bigint;
  lastTaxPaidCycle: bigint;
  lienStartCycle: bigint;
  lienHolder: string;
  lienActive: boolean;
  inAuction: boolean;
}

export interface Listing {
  seller: string;
  priceLAND: bigint;
  active: boolean;
}

export interface AuctionState {
  parcelId: bigint;
  highestBidder: string;
  highestBid: bigint;
  endTime: bigint;
  originalOwner: string;
  active: boolean;
}

export interface Assessor {
  isActive: boolean;
  registeredAt: bigint;
  assessmentCount: bigint;
  credentials: string;
}

export interface AssessedValue {
  value: bigint;
  assessor: string;
  timestamp: bigint;
  methodology: string;
  approved: boolean;
}

export interface ParcelData {
  x: bigint;
  y: bigint;
  size: bigint;
  mintedAt: bigint;
}

export interface CompleteParcelInfo {
  tokenId: bigint;
  owner: string;
  // Parcel state
  assessedValueLAND: bigint;
  lastTaxPaidCycle: bigint;
  lienStartCycle: bigint;
  lienHolder: string;
  lienActive: boolean;
  inAuction: boolean;
  // Deed data
  x: bigint;
  y: bigint;
  size: bigint;
  mintedAt: bigint;
  // Associated data
  listing: Listing;
  auction: AuctionState;
  taxOwed: bigint;
}

export interface TaxInfo {
  parcelId: bigint;
  assessedValue: bigint;
  taxRateBP: bigint;
  currentCycle: bigint;
  lastTaxPaidCycle: bigint;
  cyclesOwed: bigint;
  taxOwed: bigint;
  isDelinquent: boolean;
  lienActive: boolean;
  lienHolder: string | null;
  cyclesUntilAuction: bigint | null;
}
