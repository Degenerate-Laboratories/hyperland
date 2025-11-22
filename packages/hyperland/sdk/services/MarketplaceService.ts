/**
 * MarketplaceService - High-level marketplace operations
 * Aggregates data from contracts and provides filtering/sorting
 */

import { Provider } from 'ethers';
import { HyperLandCoreClient } from '../client/HyperLandCoreClient';
import { LandDeedClient } from '../client/LandDeedClient';
import {
  MarketplaceListing,
  SaleRecord,
  MarketStats,
  ListingFilters,
  SaleFilters,
  PriceDistribution,
  PaginatedResponse,
} from '../types';

export class MarketplaceService {
  constructor(
    private readonly coreClient: HyperLandCoreClient,
    private readonly deedClient: LandDeedClient,
    private readonly provider: Provider
  ) {}

  /**
   * Get all active listings with filtering and pagination
   */
  async getListings(filters?: ListingFilters): Promise<PaginatedResponse<MarketplaceListing>> {
    // Get all parcels and filter for active listings
    // This is a simplified implementation - in production, you'd use events or indexer
    const totalSupply = await this.deedClient.totalSupply();
    const listings: MarketplaceListing[] = [];

    const limit = filters?.limit || 50;
    const offset = filters?.offset || 0;

    // Scan through parcels (in production, use event logs or indexer)
    for (let i = 1n; i <= totalSupply; i++) {
      try {
        const listing = await this.coreClient.getListing(i);

        if (!listing.active) continue;

        // Apply filters
        if (filters?.seller && listing.seller.toLowerCase() !== filters.seller.toLowerCase()) {
          continue;
        }

        if (filters?.minPrice && listing.priceLAND < filters.minPrice) continue;
        if (filters?.maxPrice && listing.priceLAND > filters.maxPrice) continue;

        // Get parcel details
        const parcelData = await this.deedClient.getParcelData(i);
        const parcelState = await this.coreClient.getParcel(i);

        if (filters?.minSize && parcelData.size < filters.minSize) continue;
        if (filters?.maxSize && parcelData.size > filters.maxSize) continue;

        // Check coordinate bounds
        if (filters?.coordinates) {
          const { minX, maxX, minY, maxY } = filters.coordinates;
          if (
            parcelData.x < minX ||
            parcelData.x > maxX ||
            parcelData.y < minY ||
            parcelData.y > maxY
          ) {
            continue;
          }
        }

        // Get block timestamp for listedAt (approximate)
        const currentBlock = await this.provider.getBlock('latest');
        const listedAt = currentBlock ? BigInt(currentBlock.timestamp) : 0n;

        listings.push({
          parcelId: i,
          seller: listing.seller,
          priceLAND: listing.priceLAND,
          listedAt,
          x: parcelData.x,
          y: parcelData.y,
          size: parcelData.size,
          assessedValue: parcelState.assessedValueLAND,
          active: true,
        });
      } catch (error) {
        // Parcel doesn't exist or error fetching, continue
        continue;
      }
    }

    // Sort listings
    if (filters?.sortBy) {
      listings.sort((a, b) => {
        let comparison = 0;

        switch (filters.sortBy) {
          case 'price':
            comparison = Number(a.priceLAND - b.priceLAND);
            break;
          case 'size':
            comparison = Number(a.size - b.size);
            break;
          case 'assessedValue':
            comparison = Number(a.assessedValue - b.assessedValue);
            break;
          case 'listedAt':
            comparison = Number(a.listedAt - b.listedAt);
            break;
        }

        return filters.sortOrder === 'desc' ? -comparison : comparison;
      });
    }

    // Apply pagination
    const paginatedListings = listings.slice(Number(offset), Number(offset) + limit);

    return {
      data: paginatedListings,
      pagination: {
        limit,
        offset,
        total: listings.length,
        hasMore: offset + limit < listings.length,
      },
    };
  }

  /**
   * Get a single listing by parcel ID
   */
  async getListing(parcelId: bigint): Promise<MarketplaceListing | null> {
    const listing = await this.coreClient.getListing(parcelId);

    if (!listing.active) return null;

    const parcelData = await this.deedClient.getParcelData(parcelId);
    const parcelState = await this.coreClient.getParcel(parcelId);

    const currentBlock = await this.provider.getBlock('latest');
    const listedAt = currentBlock ? BigInt(currentBlock.timestamp) : 0n;

    return {
      parcelId,
      seller: listing.seller,
      priceLAND: listing.priceLAND,
      listedAt,
      x: parcelData.x,
      y: parcelData.y,
      size: parcelData.size,
      assessedValue: parcelState.assessedValueLAND,
      active: true,
    };
  }

  /**
   * Create a new listing
   */
  async createListing(parcelId: bigint, priceLAND: bigint) {
    return await this.coreClient.listDeed(parcelId, priceLAND);
  }

  /**
   * Cancel an existing listing
   */
  async cancelListing(parcelId: bigint) {
    const listing = await this.coreClient.getListing(parcelId);
    if (!listing.active) {
      throw new Error('Listing not active');
    }

    // Note: V2 contract has delistDeed method
    const tx = await this.coreClient.contract.delistDeed(parcelId);
    return await tx.wait();
  }

  /**
   * Buy a listed parcel
   */
  async buyListing(parcelId: bigint) {
    return await this.coreClient.buyDeed(parcelId);
  }

  /**
   * Get sales history with filtering
   * NOTE: This requires event indexing - placeholder implementation
   */
  async getSalesHistory(filters?: SaleFilters): Promise<PaginatedResponse<SaleRecord>> {
    // In production, query event logs for DeedSold events
    // For now, return empty array
    const sales: SaleRecord[] = [];

    return {
      data: sales,
      pagination: {
        limit: filters?.limit || 50,
        offset: filters?.offset || 0,
        total: 0,
        hasMore: false,
      },
    };
  }

  /**
   * Get recent sales (last N sales)
   */
  async getRecentSales(limit: number = 10): Promise<SaleRecord[]> {
    const result = await this.getSalesHistory({ limit, offset: 0 });
    return result.data;
  }

  /**
   * Get marketplace statistics
   */
  async getMarketStats(): Promise<MarketStats> {
    const listings = await this.getListings({ limit: 1000 });

    if (listings.data.length === 0) {
      return {
        totalListings: 0,
        totalVolumeLAND: 0n,
        totalVolumeETH: 0n,
        totalSales: 0,
        floorPriceLAND: 0n,
        avgPriceLAND: 0n,
        medianPriceLAND: 0n,
        last24hVolume: 0n,
        last24hSales: 0,
        priceChange24h: 0,
      };
    }

    // Calculate floor price
    const prices = listings.data.map((l) => l.priceLAND).sort((a, b) => Number(a - b));
    const floorPriceLAND = prices[0];

    // Calculate average
    const totalPrice = prices.reduce((sum, price) => sum + price, 0n);
    const avgPriceLAND = totalPrice / BigInt(prices.length);

    // Calculate median
    const medianIndex = Math.floor(prices.length / 2);
    const medianPriceLAND = prices[medianIndex];

    return {
      totalListings: listings.data.length,
      totalVolumeLAND: 0n, // Requires sales history
      totalVolumeETH: 0n,
      totalSales: 0, // Requires sales history
      floorPriceLAND,
      avgPriceLAND,
      medianPriceLAND,
      last24hVolume: 0n, // Requires time-filtered sales
      last24hSales: 0,
      priceChange24h: 0,
    };
  }

  /**
   * Get floor price (cheapest listing)
   */
  async getFloorPrice(): Promise<bigint> {
    const stats = await this.getMarketStats();
    return stats.floorPriceLAND;
  }

  /**
   * Get price distribution (grouping listings by price ranges)
   */
  async getPriceDistribution(): Promise<PriceDistribution[]> {
    const listings = await this.getListings({ limit: 1000 });

    if (listings.data.length === 0) return [];

    // Define price ranges (in LAND tokens)
    const ranges = [
      { min: 0n, max: 1000n, label: '0-1000 LAND' },
      { min: 1000n, max: 5000n, label: '1K-5K LAND' },
      { min: 5000n, max: 10000n, label: '5K-10K LAND' },
      { min: 10000n, max: 50000n, label: '10K-50K LAND' },
      { min: 50000n, max: 100000n, label: '50K-100K LAND' },
      { min: 100000n, max: 999999999n, label: '100K+ LAND' },
    ];

    const distribution: PriceDistribution[] = ranges.map((range) => {
      const count = listings.data.filter(
        (l) => l.priceLAND >= range.min && l.priceLAND < range.max
      ).length;

      return {
        range: range.label,
        count,
        percentage: (count / listings.data.length) * 100,
      };
    });

    return distribution.filter((d) => d.count > 0);
  }

  /**
   * Search listings by various criteria
   */
  async searchListings(query: string): Promise<MarketplaceListing[]> {
    // Parse query for coordinates, seller address, etc.
    const listings = await this.getListings({ limit: 1000 });

    // Simple search implementation
    const lowerQuery = query.toLowerCase();

    return listings.data.filter((listing) => {
      return (
        listing.seller.toLowerCase().includes(lowerQuery) ||
        listing.parcelId.toString().includes(lowerQuery) ||
        `${listing.x},${listing.y}`.includes(lowerQuery)
      );
    });
  }

  /**
   * Get listings by seller address
   */
  async getListingsBySeller(seller: string): Promise<MarketplaceListing[]> {
    const result = await this.getListings({ seller, limit: 1000 });
    return result.data;
  }

  /**
   * Get cheapest listings in a coordinate range
   */
  async getCheapestInArea(bounds: {
    minX: bigint;
    maxX: bigint;
    minY: bigint;
    maxY: bigint;
  }): Promise<MarketplaceListing[]> {
    const result = await this.getListings({
      coordinates: bounds,
      sortBy: 'price',
      sortOrder: 'asc',
      limit: 10,
    });

    return result.data;
  }
}
