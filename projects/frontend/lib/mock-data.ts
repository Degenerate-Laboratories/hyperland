/**
 * Mock/Placeholder Data
 *
 * This provides offline simulation of blockchain data
 * Useful for development without a running blockchain
 * Replicates the on-chain logic locally
 */

import { parseEther } from 'ethers';
import type { ParcelInfo, ParcelState, Listing, AuctionState } from './hyperland-sdk';

export interface MockParcel {
  tokenId: number;
  x: number;
  y: number;
  size: number;
  owner: string;
  assessedValue: string; // LAND tokens
  lastTaxPaidCycle: number;
  lienActive: boolean;
  inAuction: boolean;
  listing?: {
    price: string;
    seller: string;
  };
  auction?: {
    highestBid: string;
    highestBidder: string;
    endTime: number;
  };
}

export interface MockUserData {
  address: string;
  landBalance: string;
  ethBalance: string;
  parcelsOwned: number[];
}

// Generate grid of parcels
function generateMockParcels(count: number = 100): MockParcel[] {
  const parcels: MockParcel[] = [];
  const gridSize = Math.ceil(Math.sqrt(count));

  let tokenId = 1;
  for (let x = 0; x < gridSize; x++) {
    for (let y = 0; y < gridSize; y++) {
      if (tokenId > count) break;

      const isOwned = Math.random() > 0.3; // 70% owned
      const isListed = isOwned && Math.random() > 0.85; // 15% of owned are listed
      const inAuction = isOwned && !isListed && Math.random() > 0.95; // 5% in auction

      const parcel: MockParcel = {
        tokenId,
        x: x * 100,
        y: y * 100,
        size: 100,
        owner: isOwned ? generateRandomAddress() : '0x0000000000000000000000000000000000000000',
        assessedValue: (Math.floor(Math.random() * 5000) + 500).toString(),
        lastTaxPaidCycle: Math.floor(Date.now() / 1000 / (7 * 24 * 60 * 60)),
        lienActive: false,
        inAuction,
      };

      if (isListed) {
        parcel.listing = {
          price: (Math.floor(Math.random() * 3000) + 200).toString(),
          seller: parcel.owner,
        };
      }

      if (inAuction) {
        parcel.auction = {
          highestBid: (Math.floor(Math.random() * 2000) + 500).toString(),
          highestBidder: generateRandomAddress(),
          endTime: Date.now() + Math.floor(Math.random() * 7 * 24 * 60 * 60 * 1000),
        };
      }

      parcels.push(parcel);
      tokenId++;
    }
  }

  return parcels;
}

function generateRandomAddress(): string {
  return '0x' + Array.from({ length: 40 }, () =>
    Math.floor(Math.random() * 16).toString(16)
  ).join('');
}

// Global mock state
export class MockHyperLandState {
  private parcels: Map<number, MockParcel>;
  private users: Map<string, MockUserData>;
  private currentCycle: number;

  constructor() {
    this.parcels = new Map();
    this.users = new Map();
    this.currentCycle = Math.floor(Date.now() / 1000 / (7 * 24 * 60 * 60));

    // Initialize with mock parcels
    const mockParcels = generateMockParcels(100);
    mockParcels.forEach(p => this.parcels.set(p.tokenId, p));
  }

  // Parcel operations
  getAllParcels(): MockParcel[] {
    return Array.from(this.parcels.values());
  }

  getParcel(tokenId: number): MockParcel | undefined {
    return this.parcels.get(tokenId);
  }

  getParcelByCoordinates(x: number, y: number): MockParcel | undefined {
    return Array.from(this.parcels.values()).find(
      p => p.x === x && p.y === y
    );
  }

  getListedParcels(): MockParcel[] {
    return Array.from(this.parcels.values()).filter(p => p.listing);
  }

  getAuctionParcels(): MockParcel[] {
    return Array.from(this.parcels.values()).filter(p => p.inAuction);
  }

  getUserParcels(address: string): MockParcel[] {
    return Array.from(this.parcels.values()).filter(
      p => p.owner.toLowerCase() === address.toLowerCase()
    );
  }

  // User operations
  getUser(address: string): MockUserData {
    let user = this.users.get(address.toLowerCase());
    if (!user) {
      user = {
        address,
        landBalance: '0',
        ethBalance: '10.0',
        parcelsOwned: [],
      };
      this.users.set(address.toLowerCase(), user);
    }
    return user;
  }

  // Transaction simulations
  buyLAND(address: string, ethAmount: string): void {
    const user = this.getUser(address);
    const ethValue = parseFloat(ethAmount);
    const currentEth = parseFloat(user.ethBalance);

    // Validate sufficient ETH balance
    if (ethValue > currentEth) {
      throw new Error(`Insufficient ETH balance. You have ${currentEth} ETH but need ${ethValue} ETH`);
    }

    if (ethValue <= 0) {
      throw new Error('ETH amount must be greater than 0');
    }

    const landAmount = ethValue * 1000 * 0.8; // 80% to buyer
    user.landBalance = (parseFloat(user.landBalance) + landAmount).toString();
    user.ethBalance = (currentEth - ethValue).toFixed(4);
  }

  listParcel(tokenId: number, price: string, seller: string): void {
    const parcel = this.parcels.get(tokenId);
    if (parcel && parcel.owner.toLowerCase() === seller.toLowerCase()) {
      parcel.listing = { price, seller };
    }
  }

  buyParcel(tokenId: number, buyer: string): void {
    const parcel = this.parcels.get(tokenId);
    if (!parcel) {
      throw new Error(`Parcel ${tokenId} not found`);
    }

    if (!parcel.listing) {
      throw new Error(`Parcel ${tokenId} is not listed for sale`);
    }

    const buyerData = this.getUser(buyer);
    const sellerData = this.getUser(parcel.owner);

    const price = parseFloat(parcel.listing.price);
    const buyerBalance = parseFloat(buyerData.landBalance);

    // Validate sufficient LAND balance
    if (buyerBalance < price) {
      throw new Error(`Insufficient LAND tokens. You have ${buyerBalance} LAND but need ${price} LAND`);
    }

    const fee = price * 0.2;
    const sellerProceeds = price - fee;

    // Update balances
    buyerData.landBalance = (buyerBalance - price).toString();
    sellerData.landBalance = (parseFloat(sellerData.landBalance) + sellerProceeds).toString();

    // Transfer ownership
    parcel.owner = buyer;
    parcel.listing = undefined;
  }

  payTaxes(tokenId: number, payer: string): void {
    const parcel = this.parcels.get(tokenId);
    if (!parcel) return;

    const user = this.getUser(payer);
    const cyclesPassed = this.currentCycle - parcel.lastTaxPaidCycle;
    const taxOwed = parseFloat(parcel.assessedValue) * 0.05 * cyclesPassed;

    user.landBalance = (parseFloat(user.landBalance) - taxOwed).toString();
    parcel.lastTaxPaidCycle = this.currentCycle;

    if (payer.toLowerCase() !== parcel.owner.toLowerCase()) {
      parcel.lienActive = true;
    }
  }

  placeBid(tokenId: number, bidder: string, amount: string): void {
    const parcel = this.parcels.get(tokenId);
    if (!parcel) {
      throw new Error(`Parcel ${tokenId} not found`);
    }

    if (!parcel.inAuction || !parcel.auction) {
      throw new Error(`Parcel ${tokenId} is not in auction`);
    }

    const user = this.getUser(bidder);
    const bidAmount = parseFloat(amount);
    const userBalance = parseFloat(user.landBalance);

    // Validate sufficient LAND balance
    if (userBalance < bidAmount) {
      throw new Error(`Insufficient LAND tokens. You have ${userBalance} LAND but need ${bidAmount} LAND`);
    }

    // Validate bid is higher than current highest bid
    const currentHighestBid = parseFloat(parcel.auction.highestBid);
    if (bidAmount <= currentHighestBid) {
      throw new Error(`Bid must be higher than current highest bid of ${currentHighestBid} LAND`);
    }

    user.landBalance = (userBalance - bidAmount).toString();

    // Refund previous bidder
    if (parcel.auction.highestBidder !== '0x0000000000000000000000000000000000000000') {
      const prevBidder = this.getUser(parcel.auction.highestBidder);
      prevBidder.landBalance = (parseFloat(prevBidder.landBalance) + currentHighestBid).toString();
    }

    parcel.auction.highestBid = amount;
    parcel.auction.highestBidder = bidder;
  }

  // Stats
  getStats() {
    const parcels = this.getAllParcels();
    return {
      totalParcels: parcels.length,
      ownedParcels: parcels.filter(p => p.owner !== '0x0000000000000000000000000000000000000000').length,
      listedParcels: parcels.filter(p => p.listing).length,
      auctionParcels: parcels.filter(p => p.inAuction).length,
      activeOwners: new Set(parcels.map(p => p.owner)).size - 1, // -1 for zero address
    };
  }
}

// Singleton instance
export const mockState = new MockHyperLandState();

// Helper to check if we should use mock data
export function useMockData(): boolean {
  // Explicit disable - never use mock data if explicitly set to false
  if (process.env.NEXT_PUBLIC_USE_MOCK_DATA === 'false') {
    return false;
  }
  // Only use mock if explicitly enabled
  return process.env.NEXT_PUBLIC_USE_MOCK_DATA === 'true';
}
