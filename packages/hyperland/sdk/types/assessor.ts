/**
 * Assessor system types for HyperLand V2
 */

export interface AssessorProfile {
  address: string;
  isActive: boolean;
  registeredAt: bigint;
  assessmentCount: bigint;
  credentials: string; // IPFS hash or URI
  // Performance metrics
  approvedCount: number;
  rejectedCount: number;
  pendingCount: number;
  approvalRate: number; // Percentage
  averageAccuracy: number; // Percentage (compared to final approved values)
  // Activity
  lastValuationAt?: bigint;
  totalEarnings?: bigint; // If assessors are compensated
}

export interface ValuationRecord {
  parcelId: bigint;
  valueIndex: bigint; // Index in valuation history
  value: bigint;
  assessor: string;
  timestamp: bigint;
  methodology: string;
  approved: boolean;
  rejectionReason?: string;
  // Parcel context
  previousValue: bigint;
  changePercentage: number;
  x: bigint;
  y: bigint;
}

export interface ValuationMethodology {
  name: string;
  description: string;
  factors: string[];
  confidence: number; // 0-100
}

export const VALUATION_METHODOLOGIES: Record<string, ValuationMethodology> = {
  comparable_sales: {
    name: 'Comparable Sales',
    description: 'Based on recent sales of similar parcels',
    factors: ['Recent sale prices', 'Location similarity', 'Size adjustment'],
    confidence: 85,
  },
  auction_based: {
    name: 'Auction-Based',
    description: 'Derived from recent auction results',
    factors: ['Auction final prices', 'Bid activity', 'Market demand'],
    confidence: 80,
  },
  external_oracle: {
    name: 'External Oracle',
    description: 'Data from external property oracles or APIs',
    factors: ['Oracle data feeds', 'Third-party valuations', 'Market indices'],
    confidence: 75,
  },
  cost_approach: {
    name: 'Cost Approach',
    description: 'Based on development and improvement costs',
    factors: ['Land cost', 'Improvement value', 'Depreciation'],
    confidence: 70,
  },
  income_approach: {
    name: 'Income Approach',
    description: 'Based on potential income generation',
    factors: ['Rental potential', 'Revenue streams', 'Capitalization rate'],
    confidence: 65,
  },
};

export interface AssessorFilters {
  active?: boolean;
  minAssessments?: number;
  minApprovalRate?: number;
  sortBy?: 'assessmentCount' | 'approvalRate' | 'registeredAt';
  sortOrder?: 'asc' | 'desc';
}

export interface ValuationFilters {
  assessor?: string;
  parcelId?: bigint;
  approved?: boolean;
  methodology?: string;
  fromDate?: bigint;
  toDate?: bigint;
  minValue?: bigint;
  maxValue?: bigint;
  limit?: number;
  offset?: number;
}

export interface ValuationSubmission {
  parcelId: bigint;
  proposedValue: bigint;
  methodology: keyof typeof VALUATION_METHODOLOGIES | string;
  notes?: string;
  supportingData?: any; // Additional data like comparables, calculations, etc.
}

export interface ValuationConstraints {
  maxIncreaseMultiplier: bigint;
  maxDecreaseMultiplier: bigint;
  minInterval: bigint;
  canSubmit: boolean;
  timeUntilNext?: bigint;
  reason?: string;
}
