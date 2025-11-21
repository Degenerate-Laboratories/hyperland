/**
 * HyperLandCore Client - Main game logic
 */

import { Contract, Provider, Signer, parseEther } from 'ethers';
import { HyperLandCore_ABI } from '../abis';
import { LANDClient } from './LANDClient';
import { LandDeedClient } from './LandDeedClient';
import { CONSTANTS, calculateTax } from '../config/constants';

export interface ParcelState {
  owner: string;
  assessedValueLAND: bigint;
  lastTaxPaidCycle: bigint;
  lienStartCycle: bigint;
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
  active: boolean;
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
    const parcel = await this.readOnlyContract.parcels(parcelId);
    return {
      owner: parcel.owner,
      assessedValueLAND: parcel.assessedValueLAND,
      lastTaxPaidCycle: parcel.lastTaxPaidCycle,
      lienStartCycle: parcel.lienStartCycle,
      lienActive: parcel.lienActive,
      inAuction: parcel.inAuction,
    };
  }

  /**
   * Mint initial parcel (admin only)
   */
  async mintInitialParcel(
    to: string,
    x: bigint,
    y: bigint,
    size: bigint,
    assessedValue: bigint
  ) {
    if (!this.signer) throw new Error('Signer required for mintInitialParcel');
    const tx = await this.contract.mintInitialParcel(to, x, y, size, assessedValue);
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
      active: auction.active,
    };
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
