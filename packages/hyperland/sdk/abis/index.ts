/**
 * Contract ABIs
 */

import LAND_ABI_JSON from './LAND.json';
import LandDeed_ABI_JSON from './LandDeed.json';
import HyperLandCore_ABI_JSON from './HyperLandCore.json';

// Export as typed arrays
export const LAND_ABI = LAND_ABI_JSON as const;
export const LandDeed_ABI = LandDeed_ABI_JSON as const;
export const HyperLandCore_ABI = HyperLandCore_ABI_JSON as const;

// Export all ABIs as object
export const ABIS = {
  LAND: LAND_ABI,
  LandDeed: LandDeed_ABI,
  HyperLandCore: HyperLandCore_ABI,
} as const;
