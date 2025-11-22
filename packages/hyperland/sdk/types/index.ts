/**
 * HyperLand SDK Types
 * Comprehensive type definitions for all SDK functionality
 */

// Contract types
export * from './contracts';

// Marketplace types
export * from './marketplace';

// User types
export * from './user';

// Assessor types
export * from './assessor';

// Parcel types
export * from './parcel';

// Feed types
export * from './feed';

// Common utility types
export interface Pagination {
  limit: number;
  offset: number;
  total?: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    limit: number;
    offset: number;
    total: number;
    hasMore: boolean;
  };
}

export interface SortOptions {
  sortBy: string;
  sortOrder: 'asc' | 'desc';
}

export interface BaseFilters extends Partial<Pagination>, Partial<SortOptions> {}

// Error types
export enum SDKErrorCode {
  // Network errors
  NETWORK_ERROR = 'NETWORK_ERROR',
  RPC_ERROR = 'RPC_ERROR',

  // Contract errors
  CONTRACT_ERROR = 'CONTRACT_ERROR',
  TRANSACTION_FAILED = 'TRANSACTION_FAILED',
  TRANSACTION_REVERTED = 'TRANSACTION_REVERTED',

  // Validation errors
  VALIDATION_ERROR = 'VALIDATION_ERROR',
  INVALID_ADDRESS = 'INVALID_ADDRESS',
  INVALID_AMOUNT = 'INVALID_AMOUNT',
  INVALID_COORDINATES = 'INVALID_COORDINATES',

  // Auth errors
  NO_SIGNER = 'NO_SIGNER',
  UNAUTHORIZED = 'UNAUTHORIZED',
  NOT_OWNER = 'NOT_OWNER',
  NOT_ASSESSOR = 'NOT_ASSESSOR',

  // State errors
  NOT_FOUND = 'NOT_FOUND',
  ALREADY_EXISTS = 'ALREADY_EXISTS',
  INSUFFICIENT_FUNDS = 'INSUFFICIENT_FUNDS',
  INSUFFICIENT_ALLOWANCE = 'INSUFFICIENT_ALLOWANCE',

  // Business logic errors
  PARCEL_NOT_LISTED = 'PARCEL_NOT_LISTED',
  PARCEL_IN_AUCTION = 'PARCEL_IN_AUCTION',
  AUCTION_NOT_ACTIVE = 'AUCTION_NOT_ACTIVE',
  AUCTION_NOT_ENDED = 'AUCTION_NOT_ENDED',
  LIEN_ACTIVE = 'LIEN_ACTIVE',
  GRACE_PERIOD_NOT_EXPIRED = 'GRACE_PERIOD_NOT_EXPIRED',
  VALUATION_TOO_RECENT = 'VALUATION_TOO_RECENT',
  VALUATION_OUT_OF_RANGE = 'VALUATION_OUT_OF_RANGE',
}

export class SDKError extends Error {
  constructor(
    public code: SDKErrorCode,
    message: string,
    public details?: any
  ) {
    super(message);
    this.name = 'SDKError';
  }
}

// Configuration types
export interface SDKConfig {
  // Network
  chainId: number;
  rpcUrl: string;

  // Contracts
  contracts: {
    landToken: string;
    landDeed: string;
    hyperLandCore: string;
  };

  // Optional features
  enableCache?: boolean;
  cacheOptions?: {
    ttl?: number; // Time to live in seconds
    maxSize?: number; // Max cache entries
  };

  enableRealtime?: boolean;
  realtimeOptions?: {
    pollInterval?: number; // Polling interval in ms
  };

  // API endpoints (for hybrid SDK/API approach)
  apiUrl?: string;
  apiKey?: string;
}

// Event subscription types
export interface EventSubscriptionOptions {
  fromBlock?: bigint | 'latest';
  toBlock?: bigint | 'latest';
  topics?: string[];
}

export type EventCallback<T = any> = (event: T) => void;

export interface EventSubscription {
  id: string;
  unsubscribe: () => void;
}
