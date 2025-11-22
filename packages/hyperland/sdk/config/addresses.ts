/**
 * Network configurations and contract addresses for HyperLand V2
 */

export interface ContractAddresses {
  LAND: string;
  LandDeed: string;
  HyperLandCore: string;
}

export interface NetworkConfig {
  name: string;
  chainId: number;
  rpcUrl: string;
  blockExplorer: string;
  contracts: ContractAddresses;
}

/**
 * Network configurations for all supported networks
 */
export const NETWORK_CONFIGS: Record<string, NetworkConfig> = {
  // Base Mainnet (PRODUCTION)
  'base-mainnet': {
    name: 'Base Mainnet',
    chainId: 8453,
    rpcUrl: 'https://mainnet.base.org',
    blockExplorer: 'https://basescan.org',
    contracts: {
      LAND: '0x919e6e2b36b6944F52605bC705Ff609AFcb7c797',
      LandDeed: '0x28f5B7A911f61e875cAaa16819211Bf25dCA0adf',
      HyperLandCore: '0xB22b072503a381A2Db8309A8dD46789366D55074',
    },
  },

  // Base Sepolia (TESTNET)
  'base-sepolia': {
    name: 'Base Sepolia',
    chainId: 84532,
    rpcUrl: 'https://sepolia.base.org',
    blockExplorer: 'https://sepolia.basescan.org',
    contracts: {
      LAND: '0xCB650697F12785376A34537114Ad6De21670252d',
      LandDeed: '0xac08a0E4c854992C58d44A1625C73f30BC91139d',
      HyperLandCore: '0x47Ef963D494DcAb8CC567b584E708Ef55C26c303',
    },
  },

  // Localhost / Anvil (DEVELOPMENT)
  'anvil': {
    name: 'Local Anvil',
    chainId: 31337,
    rpcUrl: 'http://127.0.0.1:8545',
    blockExplorer: '',
    contracts: {
      LAND: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
      LandDeed: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
      HyperLandCore: '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0',
    },
  },

  // Localhost (alternative)
  'localhost': {
    name: 'Localhost',
    chainId: 31337,
    rpcUrl: 'http://localhost:8545',
    blockExplorer: '',
    contracts: {
      LAND: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
      LandDeed: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
      HyperLandCore: '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0',
    },
  },
};

/**
 * Get network configuration by chain ID
 */
export function getNetworkByChainId(chainId: number): NetworkConfig | undefined {
  return Object.values(NETWORK_CONFIGS).find((config) => config.chainId === chainId);
}

/**
 * Validate contract addresses format
 */
export function validateAddresses(addresses: ContractAddresses): boolean {
  const addressRegex = /^0x[a-fA-F0-9]{40}$/;
  return (
    addressRegex.test(addresses.LAND) &&
    addressRegex.test(addresses.LandDeed) &&
    addressRegex.test(addresses.HyperLandCore)
  );
}

/**
 * Default network (Base Mainnet for production)
 */
export const DEFAULT_NETWORK = 'base-mainnet';

/**
 * Get default contract addresses (Base Mainnet)
 */
export function getDefaultAddresses(): ContractAddresses {
  return NETWORK_CONFIGS[DEFAULT_NETWORK].contracts;
}

/**
 * Network metadata
 */
export const NETWORK_METADATA = {
  'base-mainnet': {
    nativeCurrency: {
      name: 'Ether',
      symbol: 'ETH',
      decimals: 18,
    },
    deployed: '2025-11-21',
    status: 'production',
  },
  'base-sepolia': {
    nativeCurrency: {
      name: 'Ether',
      symbol: 'ETH',
      decimals: 18,
    },
    deployed: '2025-11-21',
    status: 'testnet',
  },
  'anvil': {
    nativeCurrency: {
      name: 'Ether',
      symbol: 'ETH',
      decimals: 18,
    },
    deployed: 'local',
    status: 'development',
  },
};
