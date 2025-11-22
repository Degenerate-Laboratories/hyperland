/**
 * HyperLand SDK
 * TypeScript SDK for interacting with HyperLand smart contracts
 */

// Main client
export { HyperLandClient, createHyperLandClient } from './client/HyperLandClient';
export type { HyperLandClientConfig } from './client/HyperLandClient';

// Individual clients
export { LANDClient } from './client/LANDClient';
export { LandDeedClient } from './client/LandDeedClient';
export type { ParcelData, ParcelInfo } from './client/LandDeedClient';
export { HyperLandCoreClient } from './client/HyperLandCoreClient';
export type { ParcelState, Listing, AuctionState, Assessor, AssessedValue } from './client/HyperLandCoreClient';

// Services (NEW in V2)
export { MarketplaceService, ParcelService, UserService, AssessorService } from './services';

// Types (NEW in V2)
export * from './types';

// Configuration
export { NETWORK_CONFIGS, getNetworkByChainId, validateAddresses } from './config/addresses';
export type { ContractAddresses, NetworkConfig } from './config/addresses';
export { CONSTANTS, calculateLandFromEth, calculateBuyerAmount, calculateTreasuryAmount, calculateProtocolFee, calculateSellerProceeds, calculateTax, parseEther, formatEther } from './config/constants';

// ABIs
export { LAND_ABI, LandDeed_ABI, HyperLandCore_ABI, ABIS } from './abis';

// Utilities
export * from './utils';
