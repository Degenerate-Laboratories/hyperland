/**
 * HyperLandCore Client - Main game logic
 */

import { Contract, Provider, Signer, parseEther } from 'ethers';
import { HyperLandCore_ABI } from '../abis';
import { LANDClient } from './LANDClient';
import { LandDeedClient } from './LandDeedClient';
import { CONSTANTS, calculateTax } from '../config/constants';

export interface ParcelState {
  assessedValueLAND: bigint;
  lastTaxPaidCycle: bigint;
  lienStartCycle: bigint;
  lienHolder: string;
  lienActive: boolean;
  inAuction: boolean;
}

export interface Listing {
  seller: string;
  priceLAND: bigint;
  active: boolean;
}

export interface AuctionState {
  parcelId: bigint;
  highestBidder: string;
  highestBid: bigint;
  endTime: bigint;
  originalOwner: string;
  active: boolean;
}

export interface Assessor {
  isActive: boolean;
  registeredAt: bigint;
  assessmentCount: bigint;
  credentials: string;
}

export interface AssessedValue {
  value: bigint;
  assessor: string;
  timestamp: bigint;
  methodology: string;
  approved: boolean;
}

export class HyperLandCoreClient {
  private contract: Contract;
  private readOnlyContract: Contract;

  constructor(
    public readonly address: string,
    public readonly provider: Provider,
    public readonly signer: Signer | undefined,
    public readonly landClient: LANDClient,
    public readonly deedClient: LandDeedClient
  ) {
    this.readOnlyContract = new Contract(address, HyperLandCore_ABI, provider);
    this.contract = signer
      ? new Contract(address, HyperLandCore_ABI, signer)
      : this.readOnlyContract;
  }

  // ===== Configuration =====

  async treasury(): Promise<string> {
    return await this.readOnlyContract.treasury();
  }

  async landMintRate(): Promise<bigint> {
    return await this.readOnlyContract.landMintRate();
  }

  async protocolCutBP(): Promise<bigint> {
    return await this.readOnlyContract.protocolCutBP();
  }

  async taxRateBP(): Promise<bigint> {
    return await this.readOnlyContract.taxRateBP();
  }

  async taxCycleSeconds(): Promise<bigint> {
    return await this.readOnlyContract.taxCycleSeconds();
  }

  async startTimestamp(): Promise<bigint> {
    return await this.readOnlyContract.startTimestamp();
  }

  async getCurrentCycle(): Promise<bigint> {
    return await this.readOnlyContract.getCurrentCycle();
  }

  // ===== LAND Token Operations =====

  /**
   * Buy LAND tokens with ETH
   */
  async buyLAND(ethAmount: bigint) {
    if (!this.signer) throw new Error('Signer required for buyLAND');
    const tx = await this.contract.buyLAND({ value: ethAmount });
    return await tx.wait();
  }

  /**
   * Buy LAND tokens with ETH amount as string
   */
  async buyLANDEther(ethAmountEther: string) {
    return await this.buyLAND(parseEther(ethAmountEther));
  }

  // ===== Parcel Operations =====

  /**
   * Get parcel state
   */
  async getParcel(parcelId: bigint): Promise<ParcelState> {
    const parcel = await this.readOnlyContract.parcelStates(parcelId);
    return {
      assessedValueLAND: parcel.assessedValueLAND,
      lastTaxPaidCycle: parcel.lastTaxPaidCycle,
      lienStartCycle: parcel.lienStartCycle,
      lienHolder: parcel.lienHolder,
      lienActive: parcel.lienActive,
      inAuction: parcel.inAuction,
    };
  }

  /**
   * Alias for getParcel for compatibility
   */
  async getParcelState(parcelId: bigint): Promise<ParcelState> {
    return this.getParcel(parcelId);
  }

  /**
   * Mint a new parcel (admin only)
   */
  async mintParcel(
    to: string,
    x: bigint,
    y: bigint,
    size: bigint,
    assessedValue: bigint
  ) {
    if (!this.signer) throw new Error('Signer required for mintParcel');
    const tx = await this.contract.mintParcel(to, x, y, size, assessedValue);
    return await tx.wait();
  }

  /**
   * Initialize a newly minted parcel (admin only)
   */
  async initializeParcel(
    parcelId: bigint,
    owner: string,
    assessedValue: bigint
  ) {
    if (!this.signer) throw new Error('Signer required for initializeParcel');
    const tx = await this.contract.initializeParcel(parcelId, owner, assessedValue);
    return await tx.wait();
  }

  // ===== Marketplace Operations =====

  /**
   * Get listing for parcel
   */
  async getListing(parcelId: bigint): Promise<Listing> {
    const listing = await this.readOnlyContract.listings(parcelId);
    return {
      seller: listing.seller,
      priceLAND: listing.priceLAND,
      active: listing.active,
    };
  }

  /**
   * List parcel for sale
   */
  async listDeed(parcelId: bigint, priceLAND: bigint) {
    if (!this.signer) throw new Error('Signer required for listDeed');

    // Approve NFT transfer first
    await this.deedClient.approve(this.address, parcelId);

    const tx = await this.contract.listDeed(parcelId, priceLAND);
    return await tx.wait();
  }

  /**
   * Buy listed parcel
   */
  async buyDeed(parcelId: bigint) {
    if (!this.signer) throw new Error('Signer required for buyDeed');

    const listing = await this.getListing(parcelId);
    if (!listing.active) throw new Error('Parcel not listed');

    // Approve LAND tokens first
    await this.landClient.approve(this.address, listing.priceLAND);

    const tx = await this.contract.buyDeed(parcelId);
    return await tx.wait();
  }

  // ===== Tax Operations =====

  /**
   * Calculate tax owed for parcel
   */
  async calculateTaxOwed(parcelId: bigint): Promise<bigint> {
    return await this.readOnlyContract.calculateTaxOwed(parcelId);
  }

  /**
   * Pay taxes on parcel
   */
  async payTaxes(parcelId: bigint) {
    if (!this.signer) throw new Error('Signer required for payTaxes');

    const taxOwed = await this.calculateTaxOwed(parcelId);

    // Approve LAND tokens first
    await this.landClient.approve(this.address, taxOwed);

    const tx = await this.contract.payTaxes(parcelId);
    return await tx.wait();
  }

  /**
   * Pay taxes for another user (starts lien)
   */
  async payTaxesFor(parcelId: bigint) {
    if (!this.signer) throw new Error('Signer required for payTaxesFor');

    const taxOwed = await this.calculateTaxOwed(parcelId);

    // Approve LAND tokens first
    await this.landClient.approve(this.address, taxOwed);

    const tx = await this.contract.payTaxesFor(parcelId);
    return await tx.wait();
  }

  /**
   * Pay taxes in advance for multiple cycles
   */
  async payTaxesInAdvance(parcelId: bigint, cycles: bigint) {
    if (!this.signer) throw new Error('Signer required for payTaxesInAdvance');

    // Calculate total tax for advance payment
    const parcelState = await this.getParcelState(parcelId);
    const taxRateBP = await this.taxRateBP();
    const currentCycle = await this.getCurrentCycle();

    const cyclesOwed = currentCycle > parcelState.lastTaxPaidCycle
      ? currentCycle - parcelState.lastTaxPaidCycle
      : 0n;

    const totalCyclesToPay = cyclesOwed + cycles;
    const taxPerCycle = (parcelState.assessedValueLAND * taxRateBP) / 10000n;
    const totalTax = taxPerCycle * totalCyclesToPay;

    // Approve LAND tokens first
    await this.landClient.approve(this.address, totalTax);

    const tx = await this.contract.payTaxesInAdvance(parcelId, cycles);
    return await tx.wait();
  }

  /**
   * Calculate taxes owed for multiple parcels (batch)
   */
  async calculateTaxOwedBatch(parcelIds: bigint[]): Promise<bigint[]> {
    return await this.readOnlyContract.calculateTaxOwedBatch(parcelIds);
  }

  /**
   * Get parcel states for multiple parcels (batch)
   */
  async getParcelStatesBatch(parcelIds: bigint[]): Promise<ParcelState[]> {
    const states = await this.readOnlyContract.getParcelStatesBatch(parcelIds);
    return states.map((state: any) => ({
      assessedValueLAND: state.assessedValueLAND,
      lastTaxPaidCycle: state.lastTaxPaidCycle,
      lienStartCycle: state.lienStartCycle,
      lienHolder: state.lienHolder,
      lienActive: state.lienActive,
      inAuction: state.inAuction,
    }));
  }

  // ===== Assessor Registry System =====

  /**
   * Register a new assessor (admin only)
   */
  async registerAssessor(assessorAddress: string, credentials: string) {
    if (!this.signer) throw new Error('Signer required for registerAssessor');
    const tx = await this.contract.registerAssessor(assessorAddress, credentials);
    return await tx.wait();
  }

  /**
   * Revoke an assessor's privileges (admin only)
   */
  async revokeAssessor(assessorAddress: string) {
    if (!this.signer) throw new Error('Signer required for revokeAssessor');
    const tx = await this.contract.revokeAssessor(assessorAddress);
    return await tx.wait();
  }

  /**
   * Submit a property valuation (approved assessors only)
   */
  async submitValuation(parcelId: bigint, proposedValue: bigint, methodology: string) {
    if (!this.signer) throw new Error('Signer required for submitValuation');
    const tx = await this.contract.submitValuation(parcelId, proposedValue, methodology);
    return await tx.wait();
  }

  /**
   * Approve a submitted valuation (admin only)
   */
  async approveValuation(parcelId: bigint, valueIndex: bigint) {
    if (!this.signer) throw new Error('Signer required for approveValuation');
    const tx = await this.contract.approveValuation(parcelId, valueIndex);
    return await tx.wait();
  }

  /**
   * Reject a submitted valuation with reason (admin only)
   */
  async rejectValuation(parcelId: bigint, valueIndex: bigint, reason: string) {
    if (!this.signer) throw new Error('Signer required for rejectValuation');
    const tx = await this.contract.rejectValuation(parcelId, valueIndex, reason);
    return await tx.wait();
  }

  /**
   * Get valuation history for a parcel
   */
  async getValuationHistory(parcelId: bigint): Promise<AssessedValue[]> {
    const valuations = await this.readOnlyContract.getValuationHistory(parcelId);
    return valuations.map((val: any) => ({
      value: val.value,
      assessor: val.assessor,
      timestamp: val.timestamp,
      methodology: val.methodology,
      approved: val.approved,
    }));
  }

  /**
   * Get pending (unapproved) valuations for a parcel
   */
  async getPendingValuations(parcelId: bigint): Promise<AssessedValue[]> {
    const valuations = await this.readOnlyContract.getPendingValuations(parcelId);
    return valuations.map((val: any) => ({
      value: val.value,
      assessor: val.assessor,
      timestamp: val.timestamp,
      methodology: val.methodology,
      approved: val.approved,
    }));
  }

  /**
   * Check if an address is an approved assessor
   */
  async isApprovedAssessor(assessorAddress: string): Promise<boolean> {
    return await this.readOnlyContract.isApprovedAssessor(assessorAddress);
  }

  /**
   * Get assessor information
   */
  async getAssessorInfo(assessorAddress: string): Promise<Assessor> {
    const info = await this.readOnlyContract.getAssessorInfo(assessorAddress);
    return {
      isActive: info.isActive,
      registeredAt: info.registeredAt,
      assessmentCount: info.assessmentCount,
      credentials: info.credentials,
    };
  }

  /**
   * Get approved assessors (requires mapping through approvedAssessors)
   */
  async approvedAssessors(assessorAddress: string): Promise<Assessor> {
    const assessor = await this.readOnlyContract.approvedAssessors(assessorAddress);
    return {
      isActive: assessor.isActive,
      registeredAt: assessor.registeredAt,
      assessmentCount: assessor.assessmentCount,
      credentials: assessor.credentials,
    };
  }

  // ===== Auction Operations =====

  /**
   * Get auction state for parcel
   */
  async getAuction(parcelId: bigint): Promise<AuctionState> {
    const auction = await this.readOnlyContract.auctions(parcelId);
    return {
      parcelId: auction.parcelId,
      highestBidder: auction.highestBidder,
      highestBid: auction.highestBid,
      endTime: auction.endTime,
      originalOwner: auction.originalOwner,
      active: auction.active,
    };
  }

  /**
   * Check if auction can be started for a parcel
   */
  async canStartAuction(parcelId: bigint): Promise<boolean> {
    return await this.readOnlyContract.canStartAuction(parcelId);
  }

  /**
   * Check if parcel is delinquent (has unpaid taxes)
   */
  async isDelinquent(parcelId: bigint): Promise<boolean> {
    return await this.readOnlyContract.isDelinquent(parcelId);
  }

  /**
   * Start auction for delinquent parcel
   */
  async startAuction(parcelId: bigint) {
    if (!this.signer) throw new Error('Signer required for startAuction');
    const tx = await this.contract.startAuction(parcelId);
    return await tx.wait();
  }

  /**
   * Place bid in auction
   */
  async placeBid(parcelId: bigint, bidAmount: bigint) {
    if (!this.signer) throw new Error('Signer required for placeBid');

    // Approve LAND tokens first
    await this.landClient.approve(this.address, bidAmount);

    const tx = await this.contract.placeBid(parcelId, bidAmount);
    return await tx.wait();
  }

  /**
   * Settle auction
   */
  async settleAuction(parcelId: bigint) {
    if (!this.signer) throw new Error('Signer required for settleAuction');
    const tx = await this.contract.settleAuction(parcelId);
    return await tx.wait();
  }

  // ===== Utility Functions =====

  /**
   * Check if parcel is delinquent and eligible for lien
   */
  async isParcelDelinquent(parcelId: bigint): Promise<boolean> {
    const taxOwed = await this.calculateTaxOwed(parcelId);
    return taxOwed > 0n;
  }

  /**
   * Check if parcel is eligible for auction
   */
  async isEligibleForAuction(parcelId: bigint): Promise<boolean> {
    const parcel = await this.getParcel(parcelId);
    if (!parcel.lienActive) return false;

    const currentCycle = await this.getCurrentCycle();
    return currentCycle >= parcel.lienStartCycle + CONSTANTS.LIEN_GRACE_CYCLES;
  }

  /**
   * Get complete parcel information
   */
  async getCompleteParcelInfo(parcelId: bigint) {
    const [parcel, deedData, listing, auction, taxOwed] = await Promise.all([
      this.getParcel(parcelId),
      this.deedClient.getParcelData(parcelId),
      this.getListing(parcelId),
      this.getAuction(parcelId),
      this.calculateTaxOwed(parcelId),
    ]);

    return {
      tokenId: parcelId,
      ...parcel,
      ...deedData,
      listing,
      auction,
      taxOwed,
    };
  }
}
