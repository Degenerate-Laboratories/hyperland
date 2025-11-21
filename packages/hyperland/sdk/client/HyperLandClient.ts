/**
 * Main HyperLand SDK Client
 */

import { ethers, Provider, Signer, Contract } from 'ethers';
import { NETWORK_CONFIGS, NetworkConfig } from '../config/addresses';
import { LAND_ABI, LandDeed_ABI, HyperLandCore_ABI } from '../abis';
import { LANDClient } from './LANDClient';
import { LandDeedClient } from './LandDeedClient';
import { HyperLandCoreClient } from './HyperLandCoreClient';

export interface HyperLandClientConfig {
  network?: string;
  provider?: Provider;
  signer?: Signer;
  addresses?: {
    LAND?: string;
    LandDeed?: string;
    HyperLandCore?: string;
  };
}

/**
 * Main entry point for HyperLand SDK
 */
export class HyperLandClient {
  public readonly provider: Provider;
  public readonly signer?: Signer;
  public readonly network: NetworkConfig;

  public readonly land: LANDClient;
  public readonly deed: LandDeedClient;
  public readonly core: HyperLandCoreClient;

  constructor(config: HyperLandClientConfig = {}) {
    // Setup provider
    if (config.provider) {
      this.provider = config.provider;
    } else {
      const networkName = config.network || 'anvil';
      const networkConfig = NETWORK_CONFIGS[networkName];
      if (!networkConfig) {
        throw new Error(`Unknown network: ${networkName}`);
      }
      this.provider = new ethers.JsonRpcProvider(networkConfig.rpcUrl);
    }

    this.signer = config.signer;

    // Get network config
    const networkName = config.network || 'anvil';
    this.network = NETWORK_CONFIGS[networkName];
    if (!this.network) {
      throw new Error(`Unknown network: ${networkName}`);
    }

    // Override addresses if provided
    if (config.addresses) {
      if (config.addresses.LAND) this.network.contracts.LAND = config.addresses.LAND;
      if (config.addresses.LandDeed) this.network.contracts.LandDeed = config.addresses.LandDeed;
      if (config.addresses.HyperLandCore) this.network.contracts.HyperLandCore = config.addresses.HyperLandCore;
    }

    // Initialize clients
    this.land = new LANDClient(
      this.network.contracts.LAND,
      this.provider,
      this.signer
    );

    this.deed = new LandDeedClient(
      this.network.contracts.LandDeed,
      this.provider,
      this.signer
    );

    this.core = new HyperLandCoreClient(
      this.network.contracts.HyperLandCore,
      this.provider,
      this.signer,
      this.land,
      this.deed
    );
  }

  /**
   * Connect a signer to enable transactions
   */
  connect(signer: Signer): HyperLandClient {
    return new HyperLandClient({
      network: this.network.name.toLowerCase().replace(' ', '-'),
      provider: this.provider,
      signer,
    });
  }

  /**
   * Get the current network
   */
  async getNetwork(): Promise<ethers.Network> {
    return await this.provider.getNetwork();
  }

  /**
   * Get current block number
   */
  async getBlockNumber(): Promise<number> {
    return await this.provider.getBlockNumber();
  }

  /**
   * Wait for transaction confirmation
   */
  async waitForTransaction(txHash: string, confirmations: number = 1) {
    return await this.provider.waitForTransaction(txHash, confirmations);
  }
}

/**
 * Create a HyperLand client instance
 */
export function createHyperLandClient(config?: HyperLandClientConfig): HyperLandClient {
  return new HyperLandClient(config);
}
