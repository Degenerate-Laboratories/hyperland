/**
 * AssessorService - Assessor operations and valuation management
 */

import { HyperLandCoreClient } from '../client/HyperLandCoreClient';
import { LandDeedClient } from '../client/LandDeedClient';
import {
  AssessorProfile,
  ValuationRecord,
  ValuationFilters,
  ValuationSubmission,
  ValuationConstraints,
  PaginatedResponse,
} from '../types';

export class AssessorService {
  constructor(
    private readonly coreClient: HyperLandCoreClient,
    private readonly deedClient: LandDeedClient
  ) {}

  /**
   * Get assessor profile
   */
  async getAssessor(address: string): Promise<AssessorProfile | null> {
    const isActive = await this.coreClient.isApprovedAssessor(address);
    if (!isActive) return null;

    const info = await this.coreClient.getAssessorInfo(address);

    return {
      address,
      isActive: info.isActive,
      registeredAt: info.registeredAt,
      assessmentCount: info.assessmentCount,
      credentials: info.credentials,
      approvedCount: 0, // Requires event indexing
      rejectedCount: 0,
      pendingCount: 0,
      approvalRate: 0,
      averageAccuracy: 0,
    };
  }

  /**
   * List all active assessors
   */
  async listAssessors(): Promise<AssessorProfile[]> {
    // Note: In production, maintain an off-chain index of assessor addresses
    // For now, return empty array as we can't enumerate on-chain
    return [];
  }

  /**
   * Submit a valuation for a parcel
   */
  async submitValuation(submission: ValuationSubmission) {
    return await this.coreClient.submitValuation(
      submission.parcelId,
      submission.proposedValue,
      submission.methodology
    );
  }

  /**
   * Get valuation history for a parcel
   */
  async getValuationHistory(
    parcelId: bigint,
    filters?: ValuationFilters
  ): Promise<PaginatedResponse<ValuationRecord>> {
    const history = await this.coreClient.getValuationHistory(parcelId);
    const parcelData = await this.deedClient.getParcelData(parcelId);

    const records: ValuationRecord[] = [];

    for (let i = 0; i < history.length; i++) {
      const val = history[i];

      // Apply filters
      if (filters?.assessor && val.assessor.toLowerCase() !== filters.assessor.toLowerCase()) {
        continue;
      }

      if (filters?.approved !== undefined && val.approved !== filters.approved) {
        continue;
      }

      if (filters?.methodology && val.methodology !== filters.methodology) {
        continue;
      }

      if (filters?.minValue && val.value < filters.minValue) continue;
      if (filters?.maxValue && val.value > filters.maxValue) continue;

      const previousValue = i > 0 ? history[i - 1].value : 0n;
      const changePercentage =
        previousValue > 0n ? Number(((val.value - previousValue) * 100n) / previousValue) : 0;

      records.push({
        parcelId,
        valueIndex: BigInt(i),
        value: val.value,
        assessor: val.assessor,
        timestamp: val.timestamp,
        methodology: val.methodology,
        approved: val.approved,
        previousValue,
        changePercentage,
        x: parcelData.x,
        y: parcelData.y,
      });
    }

    return {
      data: records,
      pagination: {
        limit: records.length,
        offset: 0,
        total: records.length,
        hasMore: false,
      },
    };
  }

  /**
   * Get pending valuations for a parcel
   */
  async getPendingValuations(parcelId: bigint): Promise<ValuationRecord[]> {
    const pending = await this.coreClient.getPendingValuations(parcelId);
    const parcelData = await this.deedClient.getParcelData(parcelId);

    return pending.map((val, i) => ({
      parcelId,
      valueIndex: BigInt(i),
      value: val.value,
      assessor: val.assessor,
      timestamp: val.timestamp,
      methodology: val.methodology,
      approved: false,
      previousValue: 0n,
      changePercentage: 0,
      x: parcelData.x,
      y: parcelData.y,
    }));
  }

  /**
   * Approve a valuation (admin only)
   */
  async approveValuation(parcelId: bigint, valueIndex: bigint) {
    return await this.coreClient.approveValuation(parcelId, valueIndex);
  }

  /**
   * Reject a valuation (admin only)
   */
  async rejectValuation(parcelId: bigint, valueIndex: bigint, reason: string) {
    return await this.coreClient.rejectValuation(parcelId, valueIndex, reason);
  }

  /**
   * Check if user can submit valuation for parcel
   */
  async checkValuationConstraints(parcelId: bigint): Promise<ValuationConstraints> {
    try {
      // Get current parcel state
      const parcelState = await this.coreClient.getParcel(parcelId);

      if (parcelState.assessedValueLAND === 0n) {
        return {
          maxIncreaseMultiplier: 0n,
          maxDecreaseMultiplier: 0n,
          minInterval: 0n,
          canSubmit: false,
          reason: 'Parcel not initialized',
        };
      }

      // Note: Would need to read these from contract config
      const maxIncreaseMultiplier = 5n;
      const maxDecreaseMultiplier = 5n;
      const minInterval = 86400n; // 1 day

      return {
        maxIncreaseMultiplier,
        maxDecreaseMultiplier,
        minInterval,
        canSubmit: true,
      };
    } catch (error) {
      return {
        maxIncreaseMultiplier: 0n,
        maxDecreaseMultiplier: 0n,
        minInterval: 0n,
        canSubmit: false,
        reason: 'Error checking constraints',
      };
    }
  }

  /**
   * Estimate valuation based on comparable parcels
   */
  async estimateValuation(parcelId: bigint, comparableIds: bigint[]): Promise<bigint> {
    if (comparableIds.length === 0) {
      throw new Error('No comparables provided');
    }

    const states = await this.coreClient.getParcelStatesBatch(comparableIds);
    const totalValue = states.reduce((sum, state) => sum + state.assessedValueLAND, 0n);

    return totalValue / BigInt(states.length);
  }
}
