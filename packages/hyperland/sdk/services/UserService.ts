/**
 * UserService - User profile and portfolio management
 */

import { HyperLandCoreClient } from '../client/HyperLandCoreClient';
import { LandDeedClient } from '../client/LandDeedClient';
import { LANDClient } from '../client/LANDClient';
import { UserProfile, UserParcel, UserStats, UserFilters, PaginatedResponse } from '../types';

export class UserService {
  constructor(
    private readonly coreClient: HyperLandCoreClient,
    private readonly deedClient: LandDeedClient,
    private readonly landClient: LANDClient
  ) {}

  /**
   * Get user profile with portfolio and activity stats
   */
  async getProfile(address: string): Promise<UserProfile> {
    const parcels = await this.getParcels(address, {});
    const landBalance = await this.landClient.balanceOf(address);
    const isAssessor = await this.coreClient.isApprovedAssessor(address);

    let assessorInfo;
    if (isAssessor) {
      const info = await this.coreClient.getAssessorInfo(address);
      assessorInfo = {
        registeredAt: info.registeredAt,
        assessmentCount: info.assessmentCount,
        credentials: info.credentials,
      };
    }

    const totalValue = parcels.data.reduce((sum, p) => sum + p.assessedValue, 0n);
    const activeListings = parcels.data.filter((p) => p.isListed).length;

    return {
      address,
      parcelCount: parcels.pagination.total,
      totalValue,
      activeListings,
      activeBids: 0, // Requires auction tracking
      totalPurchases: 0, // Requires event indexing
      totalSales: 0,
      totalSpentLAND: 0n,
      totalEarnedLAND: 0n,
      totalTaxesPaid: 0n, // Requires event indexing
      liensHeld: 0,
      liensActive: parcels.data.filter((p) => p.hasLien).length,
      isAssessor,
      assessorInfo,
      firstActivity: 0n, // Requires event indexing
      lastActivity: 0n,
    };
  }

  /**
   * Get all parcels owned by user
   */
  async getParcels(address: string, filters: UserFilters): Promise<PaginatedResponse<UserParcel>> {
    const totalSupply = await this.deedClient.totalSupply();
    const userParcels: UserParcel[] = [];

    for (let i = 1n; i <= totalSupply; i++) {
      try {
        const owner = await this.deedClient.ownerOf(i);
        if (owner.toLowerCase() !== address.toLowerCase()) continue;

        const parcelData = await this.deedClient.getParcelData(i);
        const parcelState = await this.coreClient.getParcel(i);
        const listing = await this.coreClient.getListing(i);
        const taxOwed = await this.coreClient.calculateTaxOwed(i);

        userParcels.push({
          tokenId: i,
          x: parcelData.x,
          y: parcelData.y,
          size: parcelData.size,
          assessedValue: parcelState.assessedValueLAND,
          taxOwed,
          isListed: listing.active,
          listingPrice: listing.active ? listing.priceLAND : undefined,
          hasLien: parcelState.lienActive,
          lienHolder: parcelState.lienActive ? parcelState.lienHolder : undefined,
          inAuction: parcelState.inAuction,
          mintedAt: parcelData.mintedAt,
          acquiredAt: parcelData.mintedAt, // Would need transfer events for accurate value
        });
      } catch (error) {
        continue;
      }
    }

    // Apply filters
    if (!filters.includeDelinquent) {
      userParcels.filter((p) => p.taxOwed === 0n);
    }

    // Sort
    if (filters.sortBy) {
      userParcels.sort((a, b) => {
        let comparison = 0;
        switch (filters.sortBy) {
          case 'value':
            comparison = Number(a.assessedValue - b.assessedValue);
            break;
          case 'size':
            comparison = Number(a.size - b.size);
            break;
          case 'taxOwed':
            comparison = Number(a.taxOwed - b.taxOwed);
            break;
          case 'acquiredAt':
            comparison = Number(a.acquiredAt - b.acquiredAt);
            break;
        }
        return filters.sortOrder === 'desc' ? -comparison : comparison;
      });
    }

    return {
      data: userParcels,
      pagination: {
        limit: userParcels.length,
        offset: 0,
        total: userParcels.length,
        hasMore: false,
      },
    };
  }

  /**
   * Get user statistics
   */
  async getStats(address: string): Promise<UserStats> {
    const parcels = await this.getParcels(address, {});
    const totalValue = parcels.data.reduce((sum, p) => sum + p.assessedValue, 0n);
    const totalTaxOwed = parcels.data.reduce((sum, p) => sum + p.taxOwed, 0n);

    const avgSize =
      parcels.data.length > 0
        ? parcels.data.reduce((sum, p) => sum + p.size, 0n) / BigInt(parcels.data.length)
        : 0n;

    return {
      address,
      netWorth: totalValue - totalTaxOwed,
      roi: 0, // Requires purchase/sale tracking
      averageParcelSize: avgSize,
      averageHoldTime: 0n, // Requires transfer events
      taxEfficiency: 0, // Requires payment history
    };
  }
}
