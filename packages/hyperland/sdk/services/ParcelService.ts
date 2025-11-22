/**
 * ParcelService - Parcel discovery, search, and availability
 */

import { HyperLandCoreClient } from '../client/HyperLandCoreClient';
import { LandDeedClient } from '../client/LandDeedClient';
import {
  ParcelDiscovery,
  ParcelSearchResult,
  ParcelFilters,
  ParcelNeighbor,
  AvailableCoordinate,
  ParcelSearchQuery,
  CoordinateBounds,
  MapParcel,
  PaginatedResponse,
} from '../types';

export class ParcelService {
  constructor(
    private readonly coreClient: HyperLandCoreClient,
    private readonly deedClient: LandDeedClient
  ) {}

  /**
   * List all parcels with filtering and pagination
   */
  async listParcels(filters?: ParcelFilters): Promise<PaginatedResponse<ParcelSearchResult>> {
    const totalSupply = await this.deedClient.totalSupply();
    const parcels: ParcelSearchResult[] = [];

    const limit = filters?.limit || 50;
    const offset = filters?.offset || 0;

    // Scan through minted parcels
    for (let i = 1n; i <= totalSupply; i++) {
      try {
        const owner = await this.deedClient.ownerOf(i);
        const parcelData = await this.deedClient.getParcelData(i);
        const parcelState = await this.coreClient.getParcel(i);
        const listing = await this.coreClient.getListing(i);
        const taxOwed = await this.coreClient.calculateTaxOwed(i);

        // Apply filters
        if (filters?.owner && owner.toLowerCase() !== filters.owner.toLowerCase()) {
          continue;
        }

        if (filters?.listed !== undefined && listing.active !== filters.listed) {
          continue;
        }

        if (filters?.inAuction !== undefined && parcelState.inAuction !== filters.inAuction) {
          continue;
        }

        if (filters?.delinquent !== undefined) {
          const isDelinquent = taxOwed > 0n;
          if (isDelinquent !== filters.delinquent) continue;
        }

        if (filters?.hasLien !== undefined && parcelState.lienActive !== filters.hasLien) {
          continue;
        }

        if (filters?.minSize && parcelData.size < filters.minSize) continue;
        if (filters?.maxSize && parcelData.size > filters.maxSize) continue;

        if (filters?.minValue && parcelState.assessedValueLAND < filters.minValue) continue;
        if (filters?.maxValue && parcelState.assessedValueLAND > filters.maxValue) continue;

        if (filters?.bounds) {
          const { minX, maxX, minY, maxY } = filters.bounds;
          if (
            parcelData.x < minX ||
            parcelData.x > maxX ||
            parcelData.y < minY ||
            parcelData.y > maxY
          ) {
            continue;
          }
        }

        parcels.push({
          tokenId: i,
          owner,
          x: parcelData.x,
          y: parcelData.y,
          size: parcelData.size,
          assessedValue: parcelState.assessedValueLAND,
          taxOwed,
          isListed: listing.active,
          listingPrice: listing.active ? listing.priceLAND : undefined,
          inAuction: parcelState.inAuction,
          hasLien: parcelState.lienActive,
          isDelinquent: taxOwed > 0n,
          score: 0, // Will be calculated for search results
        });
      } catch (error) {
        continue;
      }
    }

    // Sort parcels
    if (filters?.sortBy) {
      parcels.sort((a, b) => {
        let comparison = 0;

        switch (filters.sortBy) {
          case 'tokenId':
            comparison = Number(a.tokenId - b.tokenId);
            break;
          case 'value':
            comparison = Number(a.assessedValue - b.assessedValue);
            break;
          case 'size':
            comparison = Number(a.size - b.size);
            break;
          case 'taxOwed':
            comparison = Number(a.taxOwed - b.taxOwed);
            break;
          case 'price':
            comparison = Number((a.listingPrice || 0n) - (b.listingPrice || 0n));
            break;
          case 'coordinates':
            comparison = Number(a.x - b.x) || Number(a.y - b.y);
            break;
        }

        return filters.sortOrder === 'desc' ? -comparison : comparison;
      });
    }

    // Apply pagination
    const paginatedParcels = parcels.slice(Number(offset), Number(offset) + limit);

    return {
      data: paginatedParcels,
      pagination: {
        limit,
        offset,
        total: parcels.length,
        hasMore: offset + limit < parcels.length,
      },
    };
  }

  /**
   * Get parcel by ID
   */
  async getParcel(tokenId: bigint): Promise<ParcelSearchResult> {
    const owner = await this.deedClient.ownerOf(tokenId);
    const parcelData = await this.deedClient.getParcelData(tokenId);
    const parcelState = await this.coreClient.getParcel(tokenId);
    const listing = await this.coreClient.getListing(tokenId);
    const taxOwed = await this.coreClient.calculateTaxOwed(tokenId);

    return {
      tokenId,
      owner,
      x: parcelData.x,
      y: parcelData.y,
      size: parcelData.size,
      assessedValue: parcelState.assessedValueLAND,
      taxOwed,
      isListed: listing.active,
      listingPrice: listing.active ? listing.priceLAND : undefined,
      inAuction: parcelState.inAuction,
      hasLien: parcelState.lienActive,
      isDelinquent: taxOwed > 0n,
      score: 0,
    };
  }

  /**
   * Get parcel by coordinates
   */
  async getParcelByCoordinates(x: bigint, y: bigint): Promise<ParcelDiscovery> {
    const tokenId = await this.deedClient.getTokenIdByCoordinates(x, y);

    if (tokenId === 0n) {
      return {
        tokenId: null,
        x,
        y,
        isMinted: false,
      };
    }

    const owner = await this.deedClient.ownerOf(tokenId);
    const parcelData = await this.deedClient.getParcelData(tokenId);
    const parcelState = await this.coreClient.getParcel(tokenId);
    const listing = await this.coreClient.getListing(tokenId);

    return {
      tokenId,
      x,
      y,
      isMinted: true,
      owner,
      size: parcelData.size,
      assessedValue: parcelState.assessedValueLAND,
      isListed: listing.active,
      listingPrice: listing.active ? listing.priceLAND : undefined,
    };
  }

  /**
   * Check if a coordinate is available for minting
   */
  async isCoordinateAvailable(x: bigint, y: bigint): Promise<boolean> {
    return await this.deedClient.parcelExistsAt(x, y).then((exists) => !exists);
  }

  /**
   * Get available coordinates in a bounding box
   */
  async getAvailableCoordinates(bounds?: CoordinateBounds): Promise<AvailableCoordinate[]> {
    const { minX = -100n, maxX = 100n, minY = -100n, maxY = 100n } = bounds || {};

    const available: AvailableCoordinate[] = [];

    // Scan grid for available coordinates
    // In production, this would be optimized with better data structures
    for (let x = minX; x <= maxX; x++) {
      for (let y = minY; y <= maxY; y++) {
        const isAvailable = await this.isCoordinateAvailable(x, y);

        if (isAvailable) {
          // Check for neighbors
          const neighbors = await this.checkNeighbors(x, y);

          available.push({
            x,
            y,
            hasNeighbors: neighbors > 0,
            neighborCount: neighbors,
          });
        }

        // Limit results to prevent infinite loops
        if (available.length >= 100) break;
      }
      if (available.length >= 100) break;
    }

    return available;
  }

  /**
   * Get nearby parcels within a radius
   */
  async getNearbyParcels(x: bigint, y: bigint, radius: number = 5): Promise<ParcelNeighbor[]> {
    const neighbors: ParcelNeighbor[] = [];

    const radiusBig = BigInt(radius);

    for (let dx = -radiusBig; dx <= radiusBig; dx++) {
      for (let dy = -radiusBig; dy <= radiusBig; dy++) {
        if (dx === 0n && dy === 0n) continue; // Skip center

        const neighborX = x + dx;
        const neighborY = y + dy;

        const tokenId = await this.deedClient.getTokenIdByCoordinates(neighborX, neighborY);

        if (tokenId > 0n) {
          try {
            const owner = await this.deedClient.ownerOf(tokenId);
            const parcelData = await this.deedClient.getParcelData(tokenId);
            const parcelState = await this.coreClient.getParcel(tokenId);
            const listing = await this.coreClient.getListing(tokenId);

            const distance = Math.sqrt(Number(dx * dx + dy * dy));
            const direction = this.getDirection(dx, dy);

            neighbors.push({
              tokenId,
              x: neighborX,
              y: neighborY,
              distance,
              direction,
              owner,
              size: parcelData.size,
              assessedValue: parcelState.assessedValueLAND,
              isListed: listing.active,
            });
          } catch (error) {
            continue;
          }
        }
      }
    }

    // Sort by distance
    neighbors.sort((a, b) => a.distance - b.distance);

    return neighbors;
  }

  /**
   * Get direct neighbors (adjacent parcels)
   */
  async getParcelNeighbors(tokenId: bigint): Promise<ParcelNeighbor[]> {
    const parcelData = await this.deedClient.getParcelData(tokenId);
    return await this.getNearbyParcels(parcelData.x, parcelData.y, 1);
  }

  /**
   * Search parcels by query
   */
  async searchParcels(query: ParcelSearchQuery): Promise<ParcelSearchResult[]> {
    let results: ParcelSearchResult[] = [];

    // Search by coordinates
    if (query.coordinates) {
      try {
        const discovery = await this.getParcelByCoordinates(query.coordinates.x, query.coordinates.y);
        if (discovery.isMinted && discovery.tokenId) {
          const parcel = await this.getParcel(discovery.tokenId);
          parcel.score = 100;
          results.push(parcel);
        }
      } catch (error) {
        // Not found
      }
    }

    // Search by owner
    if (query.owner) {
      const ownerParcels = await this.listParcels({
        owner: query.owner,
        ...query.filters,
        limit: 1000,
      });
      ownerParcels.data.forEach((p) => (p.score = 90));
      results.push(...ownerParcels.data);
    }

    // Free text search
    if (query.text) {
      const allParcels = await this.listParcels({ ...query.filters, limit: 1000 });

      const lowerText = query.text.toLowerCase();

      allParcels.data.forEach((parcel) => {
        let score = 0;

        // Match token ID
        if (parcel.tokenId.toString().includes(lowerText)) score += 80;

        // Match coordinates
        if (`${parcel.x},${parcel.y}`.includes(lowerText)) score += 70;

        // Match owner address
        if (parcel.owner.toLowerCase().includes(lowerText)) score += 60;

        if (score > 0) {
          parcel.score = score;
          results.push(parcel);
        }
      });
    }

    // Remove duplicates
    const uniqueResults = Array.from(
      new Map(results.map((p) => [p.tokenId.toString(), p])).values()
    );

    // Sort by score
    uniqueResults.sort((a, b) => b.score - a.score);

    return uniqueResults;
  }

  /**
   * Get parcels for map rendering
   */
  async getMapParcels(bounds: CoordinateBounds): Promise<MapParcel[]> {
    const mapParcels: MapParcel[] = [];

    const { minX, maxX, minY, maxY } = bounds;

    for (let x = minX; x <= maxX; x++) {
      for (let y = minY; y <= maxY; y++) {
        const discovery = await this.getParcelByCoordinates(x, y);

        mapParcels.push({
          tokenId: discovery.tokenId,
          x,
          y,
          isMinted: discovery.isMinted,
          owner: discovery.owner,
          size: discovery.size,
        });

        // Limit to prevent excessive queries
        if (mapParcels.length >= 1000) break;
      }
      if (mapParcels.length >= 1000) break;
    }

    return mapParcels;
  }

  /**
   * Helper: Check number of neighbors at coordinates
   */
  private async checkNeighbors(x: bigint, y: bigint): Promise<number> {
    const directions = [
      [0n, 1n],
      [0n, -1n],
      [1n, 0n],
      [-1n, 0n],
    ];

    let count = 0;

    for (const [dx, dy] of directions) {
      const exists = await this.deedClient
        .parcelExistsAt(x + dx, y + dy)
        .catch(() => false);
      if (exists) count++;
    }

    return count;
  }

  /**
   * Helper: Get direction from offset
   */
  private getDirection(
    dx: bigint,
    dy: bigint
  ): 'north' | 'south' | 'east' | 'west' | 'northeast' | 'northwest' | 'southeast' | 'southwest' {
    if (dx === 0n && dy > 0n) return 'north';
    if (dx === 0n && dy < 0n) return 'south';
    if (dx > 0n && dy === 0n) return 'east';
    if (dx < 0n && dy === 0n) return 'west';
    if (dx > 0n && dy > 0n) return 'northeast';
    if (dx < 0n && dy > 0n) return 'northwest';
    if (dx > 0n && dy < 0n) return 'southeast';
    return 'southwest';
  }
}
