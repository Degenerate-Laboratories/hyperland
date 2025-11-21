/**
 * LandDeed NFT Client
 */

import { Contract, Provider, Signer } from 'ethers';
import { LandDeed_ABI } from '../abis';

export interface ParcelData {
  x: bigint;
  y: bigint;
  size: bigint;
}

export interface ParcelInfo extends ParcelData {
  tokenId: bigint;
  owner: string;
}

export class LandDeedClient {
  private contract: Contract;
  private readOnlyContract: Contract;

  constructor(
    public readonly address: string,
    public readonly provider: Provider,
    public readonly signer?: Signer
  ) {
    this.readOnlyContract = new Contract(address, LandDeed_ABI, provider);
    this.contract = signer
      ? new Contract(address, LandDeed_ABI, signer)
      : this.readOnlyContract;
  }

  /**
   * Get NFT name
   */
  async name(): Promise<string> {
    return await this.readOnlyContract.name();
  }

  /**
   * Get NFT symbol
   */
  async symbol(): Promise<string> {
    return await this.readOnlyContract.symbol();
  }

  /**
   * Get owner of token
   */
  async ownerOf(tokenId: bigint): Promise<string> {
    return await this.readOnlyContract.ownerOf(tokenId);
  }

  /**
   * Get parcel data by token ID
   */
  async getParcelData(tokenId: bigint): Promise<ParcelData> {
    const [x, y, size] = await this.readOnlyContract.getParcelData(tokenId);
    return { x, y, size };
  }

  /**
   * Get complete parcel info including ownership
   */
  async getParcelInfo(tokenId: bigint): Promise<ParcelInfo> {
    const [owner, parcelData] = await Promise.all([
      this.ownerOf(tokenId),
      this.getParcelData(tokenId),
    ]);
    return {
      tokenId,
      owner,
      ...parcelData,
    };
  }

  /**
   * Get token ID by coordinates
   */
  async getTokenIdByCoordinates(x: bigint, y: bigint): Promise<bigint> {
    return await this.readOnlyContract.getTokenIdByCoordinates(x, y);
  }

  /**
   * Check if coordinates are occupied
   */
  async isCoordinateOccupied(x: bigint, y: bigint): Promise<boolean> {
    try {
      const tokenId = await this.getTokenIdByCoordinates(x, y);
      return tokenId > 0n;
    } catch {
      return false;
    }
  }

  /**
   * Get balance of owner (number of parcels owned)
   */
  async balanceOf(owner: string): Promise<bigint> {
    return await this.readOnlyContract.balanceOf(owner);
  }

  /**
   * Transfer NFT
   */
  async transferFrom(from: string, to: string, tokenId: bigint) {
    if (!this.signer) throw new Error('Signer required for transfer');
    const tx = await this.contract.transferFrom(from, to, tokenId);
    return await tx.wait();
  }

  /**
   * Approve address to transfer token
   */
  async approve(to: string, tokenId: bigint) {
    if (!this.signer) throw new Error('Signer required for approve');
    const tx = await this.contract.approve(to, tokenId);
    return await tx.wait();
  }

  /**
   * Set approval for all tokens
   */
  async setApprovalForAll(operator: string, approved: boolean) {
    if (!this.signer) throw new Error('Signer required for setApprovalForAll');
    const tx = await this.contract.setApprovalForAll(operator, approved);
    return await tx.wait();
  }

  /**
   * Get approved address for token
   */
  async getApproved(tokenId: bigint): Promise<string> {
    return await this.readOnlyContract.getApproved(tokenId);
  }

  /**
   * Check if operator is approved for all tokens of owner
   */
  async isApprovedForAll(owner: string, operator: string): Promise<boolean> {
    return await this.readOnlyContract.isApprovedForAll(owner, operator);
  }
}
