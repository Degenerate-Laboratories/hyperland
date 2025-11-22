// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "./LANDToken.sol";
import "./LandDeed.sol";

/**
 * @title HyperLandCore
 * @dev Main contract for HyperLand ecosystem
 * Handles marketplace, taxes, liens, and auctions
 */
contract HyperLandCore is Ownable, ReentrancyGuard, Pausable {
    // Contracts
    LANDToken public immutable landToken;
    LandDeed public immutable landDeed;

    // Configuration
    uint256 public constant BASIS_POINTS = 10000;
    uint256 public protocolFeeBP = 2000; // 20%
    uint256 public taxRateBP = 500; // 5% per cycle
    uint256 public taxCycleSeconds = 15 minutes; // PRODUCTION: 15 minutes (3-day hackathon)
    uint256 public lienGraceCycles = 3;
    uint256 public auctionDuration = 15 minutes; // PRODUCTION: 15 minutes (3-day hackathon)
    uint256 public auctionExtensionTime = 2 minutes; // Anti-sniping extension
    uint256 public auctionExtensionThreshold = 2 minutes; // Time threshold for extension
    uint256 public immutable startTimestamp;
    address public treasury;

    // Authorized minters (ParcelSale contracts, etc.)
    mapping(address => bool) public authorizedMinters;

    // Assessor registry
    struct Assessor {
        bool isActive;
        uint256 registeredAt;
        uint256 assessmentCount;
        string credentials; // IPFS hash to certification documents
    }

    struct AssessedValue {
        uint256 value;
        address assessor;
        uint256 timestamp;
        string methodology; // e.g., "comparable_sales", "auction_based", "external_oracle"
        bool approved;
    }

    mapping(address => Assessor) public approvedAssessors;
    mapping(uint256 => AssessedValue[]) public valuationHistory; // parcelId => history
    mapping(uint256 => uint256) public currentValueIndex; // parcelId => active valuation index
    mapping(uint256 => uint256) public lastValuationTime; // parcelId => timestamp (rate limiting)

    // Configuration for valuation constraints
    uint256 public maxValueIncreaseMultiplier = 5; // Max 5x increase
    uint256 public maxValueDecreaseMultiplier = 5; // Max 80% decrease (1/5)
    uint256 public minValuationInterval = 1 days; // Minimum time between valuations

    // Parcel state
    struct ParcelState {
        uint256 assessedValueLAND;
        uint256 lastTaxPaidCycle;
        uint256 lienStartCycle;
        address lienHolder;
        bool lienActive;
        bool inAuction;
    }

    mapping(uint256 => ParcelState) public parcelStates;

    // Marketplace listings
    struct Listing {
        address seller;
        uint256 priceLAND;
        bool active;
    }

    mapping(uint256 => Listing) public listings;

    // Auction state
    struct AuctionState {
        uint256 parcelId;
        address highestBidder;
        uint256 highestBid;
        uint256 endTime;
        address originalOwner;
        bool active;
    }

    mapping(uint256 => AuctionState) public auctions;

    // Events
    event ParcelInitialized(uint256 indexed parcelId, address indexed owner, uint256 assessedValue);
    event DeedListed(uint256 indexed parcelId, address indexed seller, uint256 price);
    event DeedDelisted(uint256 indexed parcelId);
    event DeedSold(uint256 indexed parcelId, address indexed from, address indexed to, uint256 price);
    event TaxesPaid(uint256 indexed parcelId, address indexed payer, uint256 amount, uint256 cycle);
    event LienStarted(uint256 indexed parcelId, address indexed lienHolder, uint256 cycle);
    event LienCleared(uint256 indexed parcelId);
    event AuctionStarted(uint256 indexed parcelId, uint256 endTime);
    event BidPlaced(uint256 indexed parcelId, address indexed bidder, uint256 amount);
    event AuctionExtended(uint256 indexed parcelId, uint256 newEndTime);
    event AuctionSettled(uint256 indexed parcelId, address indexed winner, uint256 price);
    event AuctionCancelled(uint256 indexed parcelId);
    event ProtocolFeeUpdated(uint256 oldFee, uint256 newFee);
    event TaxRateUpdated(uint256 oldRate, uint256 newRate);
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event AssessedValueUpdated(uint256 indexed parcelId, uint256 oldValue, uint256 newValue);

    // Assessor events
    event AssessorRegistered(address indexed assessor, uint256 timestamp, string credentials);
    event AssessorRevoked(address indexed assessor, uint256 timestamp);
    event ValuationSubmitted(uint256 indexed parcelId, address indexed assessor, uint256 value, uint256 timestamp, string methodology);
    event ValuationApproved(uint256 indexed parcelId, uint256 valueIndex, address indexed approver);
    event ValuationRejected(uint256 indexed parcelId, uint256 valueIndex, address indexed approver, string reason);
    event TaxesPaidInAdvance(uint256 indexed parcelId, address indexed payer, uint256 amount, uint256 cyclesPaid, uint256 paidUntilCycle);
    event TaxCycleDurationUpdated(uint256 oldDuration, uint256 newDuration);
    event AuctionDurationUpdated(uint256 oldDuration, uint256 newDuration);
    event LienGraceCyclesUpdated(uint256 oldCycles, uint256 newCycles);

    /**
     * @dev Constructor
     * @param _landToken LAND token contract address
     * @param _landDeed Land deed NFT contract address
     * @param _treasury Treasury address for fees
     * @param initialOwner Contract owner address
     */
    constructor(
        address _landToken,
        address _landDeed,
        address _treasury,
        address initialOwner
    ) Ownable(initialOwner) {
        require(_landToken != address(0), "Invalid LAND token");
        require(_landDeed != address(0), "Invalid land deed");
        require(_treasury != address(0), "Invalid treasury");

        landToken = LANDToken(_landToken);
        landDeed = LandDeed(_landDeed);
        treasury = _treasury;
        startTimestamp = block.timestamp;
    }

    // ============================================
    // PARCEL MINTING & INITIALIZATION
    // ============================================

    /**
     * @dev Mint and initialize a new parcel
     * @param to Address to mint the parcel to
     * @param x X coordinate
     * @param y Y coordinate
     * @param size Size of the parcel
     * @param assessedValue Assessed value in LAND tokens
     * @return tokenId The ID of the newly minted parcel
     */
    /**
     * @dev Authorize an address to mint parcels (e.g., ParcelSale contract)
     */
    function authorizeMinter(address minter, bool authorized) external onlyOwner {
        require(minter != address(0), "Invalid minter address");
        authorizedMinters[minter] = authorized;
    }

    /**
     * @dev Modifier to check if caller is owner or authorized minter
     */
    modifier onlyOwnerOrMinter() {
        require(
            msg.sender == owner() || authorizedMinters[msg.sender],
            "Not authorized to mint"
        );
        _;
    }

    function mintParcel(
        address to,
        uint256 x,
        uint256 y,
        uint256 size,
        uint256 assessedValue
    ) external onlyOwnerOrMinter returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");
        require(assessedValue > 0, "Assessed value must be > 0");
        require(assessedValue <= landToken.TOTAL_SUPPLY(), "Assessed value exceeds total supply");

        uint256 tokenId = landDeed.mint(to, x, y, size);

        uint256 currentCycle = getCurrentCycle();

        parcelStates[tokenId] = ParcelState({
            assessedValueLAND: assessedValue,
            lastTaxPaidCycle: currentCycle,
            lienStartCycle: 0,
            lienHolder: address(0),
            lienActive: false,
            inAuction: false
        });

        emit ParcelInitialized(tokenId, to, assessedValue);

        return tokenId;
    }

    /**
     * @dev Initialize a newly minted parcel (for separately minted parcels)
     * @param parcelId Token ID of the parcel
     * @param owner Initial owner
     * @param assessedValue Assessed value in LAND tokens
     */
    function initializeParcel(
        uint256 parcelId,
        address owner,
        uint256 assessedValue
    ) external onlyOwner {
        require(owner != address(0), "Owner cannot be zero address");
        require(landDeed.ownerOf(parcelId) == owner, "Owner mismatch");
        require(parcelStates[parcelId].assessedValueLAND == 0, "Already initialized");
        require(assessedValue > 0, "Assessed value must be > 0");
        require(assessedValue <= landToken.TOTAL_SUPPLY(), "Assessed value exceeds total supply");

        uint256 currentCycle = getCurrentCycle();

        parcelStates[parcelId] = ParcelState({
            assessedValueLAND: assessedValue,
            lastTaxPaidCycle: currentCycle,
            lienStartCycle: 0,
            lienHolder: address(0),
            lienActive: false,
            inAuction: false
        });

        emit ParcelInitialized(parcelId, owner, assessedValue);
    }

    // ============================================
    // MARKETPLACE
    // ============================================

    /**
     * @dev List a parcel for sale
     * @param parcelId Token ID to list
     * @param priceLAND Price in LAND tokens
     */
    function listDeed(uint256 parcelId, uint256 priceLAND) external nonReentrant whenNotPaused {
        require(landDeed.ownerOf(parcelId) == msg.sender, "Not owner");
        require(priceLAND > 0, "Price must be > 0");
        require(!parcelStates[parcelId].inAuction, "Parcel in auction");
        require(!listings[parcelId].active, "Already listed");

        listings[parcelId] = Listing({
            seller: msg.sender,
            priceLAND: priceLAND,
            active: true
        });

        emit DeedListed(parcelId, msg.sender, priceLAND);
    }

    /**
     * @dev Cancel a listing
     * @param parcelId Token ID to delist
     */
    function delistDeed(uint256 parcelId) external nonReentrant {
        require(listings[parcelId].seller == msg.sender, "Not seller");
        require(listings[parcelId].active, "Not listed");

        delete listings[parcelId];

        emit DeedDelisted(parcelId);
    }

    /**
     * @dev Buy a listed parcel
     * @param parcelId Token ID to buy
     */
    function buyDeed(uint256 parcelId) external nonReentrant whenNotPaused {
        Listing memory listing = listings[parcelId];
        require(listing.active, "Not listed");
        require(landDeed.ownerOf(parcelId) == listing.seller, "Seller not owner");

        uint256 totalPrice = listing.priceLAND;
        uint256 fee = (totalPrice * protocolFeeBP) / BASIS_POINTS;
        uint256 sellerProceeds = totalPrice - fee;

        // Delete listing first (CEI pattern)
        delete listings[parcelId];

        // Transfer LAND tokens
        require(
            landToken.transferFrom(msg.sender, listing.seller, sellerProceeds),
            "Seller payment failed"
        );
        require(
            landToken.transferFrom(msg.sender, treasury, fee),
            "Fee payment failed"
        );

        // Transfer NFT
        landDeed.transferFrom(listing.seller, msg.sender, parcelId);

        emit DeedSold(parcelId, listing.seller, msg.sender, totalPrice);
    }

    // ============================================
    // TAX SYSTEM
    // ============================================

    /**
     * @dev Calculate tax owed for a parcel
     * @param parcelId Token ID
     * @return Tax amount in LAND tokens
     */
    function calculateTaxOwed(uint256 parcelId) public view returns (uint256) {
        ParcelState memory state = parcelStates[parcelId];
        uint256 currentCycle = getCurrentCycle();
        uint256 cyclesPassed = currentCycle > state.lastTaxPaidCycle
            ? currentCycle - state.lastTaxPaidCycle
            : 0;

        uint256 taxOwed = (state.assessedValueLAND * taxRateBP * cyclesPassed) / BASIS_POINTS;

        // Cap accumulated tax at 2x assessed value to prevent overflow
        uint256 maxTax = state.assessedValueLAND * 2;
        return taxOwed > maxTax ? maxTax : taxOwed;
    }

    /**
     * @dev Pay taxes on a parcel (owner)
     * @param parcelId Token ID
     */
    function payTaxes(uint256 parcelId) external nonReentrant {
        require(landDeed.ownerOf(parcelId) == msg.sender, "Not owner");
        require(!parcelStates[parcelId].inAuction, "Cannot pay taxes during auction");

        uint256 taxOwed = calculateTaxOwed(parcelId);
        require(taxOwed > 0, "No taxes owed");

        // Update state first (CEI pattern)
        uint256 currentCycle = getCurrentCycle();
        parcelStates[parcelId].lastTaxPaidCycle = currentCycle;

        // Clear lien if active
        if (parcelStates[parcelId].lienActive) {
            parcelStates[parcelId].lienActive = false;
            parcelStates[parcelId].lienHolder = address(0);
            parcelStates[parcelId].lienStartCycle = 0;
            emit LienCleared(parcelId);
        }

        // Transfer LAND to treasury
        require(
            landToken.transferFrom(msg.sender, treasury, taxOwed),
            "Tax payment failed"
        );

        emit TaxesPaid(parcelId, msg.sender, taxOwed, currentCycle);
    }

    /**
     * @dev Pay taxes for another parcel (starts lien)
     * @param parcelId Token ID
     */
    function payTaxesFor(uint256 parcelId) external nonReentrant {
        address owner = landDeed.ownerOf(parcelId);
        require(msg.sender != owner, "Owner should use payTaxes");
        require(!parcelStates[parcelId].lienActive, "Lien already active");
        require(!parcelStates[parcelId].inAuction, "Cannot pay taxes during auction");

        uint256 taxOwed = calculateTaxOwed(parcelId);
        require(taxOwed > 0, "No taxes owed");

        // Update state and start lien first (CEI pattern)
        uint256 currentCycle = getCurrentCycle();
        parcelStates[parcelId].lastTaxPaidCycle = currentCycle;
        parcelStates[parcelId].lienActive = true;
        parcelStates[parcelId].lienHolder = msg.sender;
        parcelStates[parcelId].lienStartCycle = currentCycle;

        // Transfer LAND to treasury
        require(
            landToken.transferFrom(msg.sender, treasury, taxOwed),
            "Tax payment failed"
        );

        emit TaxesPaid(parcelId, msg.sender, taxOwed, currentCycle);
        emit LienStarted(parcelId, msg.sender, currentCycle);
    }

    /**
     * @dev Pay taxes in advance for multiple cycles
     * @param parcelId Token ID
     * @param cycles Number of cycles to pay in advance (1-100)
     */
    function payTaxesInAdvance(uint256 parcelId, uint256 cycles) external nonReentrant {
        require(landDeed.ownerOf(parcelId) == msg.sender, "Not owner");
        require(cycles > 0 && cycles <= 100, "Invalid cycle count");
        require(!parcelStates[parcelId].inAuction, "Cannot pay taxes during auction");

        uint256 currentCycle = getCurrentCycle();
        uint256 taxPerCycle = (parcelStates[parcelId].assessedValueLAND * taxRateBP) / BASIS_POINTS;

        // Calculate cycles to pay (including any owed)
        uint256 cyclesOwed = currentCycle > parcelStates[parcelId].lastTaxPaidCycle
            ? currentCycle - parcelStates[parcelId].lastTaxPaidCycle
            : 0;

        uint256 totalCyclesToPay = cyclesOwed + cycles;
        uint256 totalTax = taxPerCycle * totalCyclesToPay;

        // Update state first (CEI pattern)
        parcelStates[parcelId].lastTaxPaidCycle = currentCycle + cycles;

        // Clear lien if active
        if (parcelStates[parcelId].lienActive) {
            parcelStates[parcelId].lienActive = false;
            parcelStates[parcelId].lienHolder = address(0);
            parcelStates[parcelId].lienStartCycle = 0;
            emit LienCleared(parcelId);
        }

        // Transfer LAND to treasury
        require(
            landToken.transferFrom(msg.sender, treasury, totalTax),
            "Tax payment failed"
        );

        emit TaxesPaidInAdvance(parcelId, msg.sender, totalTax, totalCyclesToPay, currentCycle + cycles);
    }

    // ============================================
    // AUCTION SYSTEM
    // ============================================

    /**
     * @dev Start an auction for a parcel with unpaid lien
     * @param parcelId Token ID
     */
    function startAuction(uint256 parcelId) external nonReentrant whenNotPaused {
        ParcelState memory state = parcelStates[parcelId];
        require(state.lienActive, "No active lien");
        require(msg.sender == state.lienHolder, "Only lien holder can start auction");
        require(!state.inAuction, "Already in auction");

        uint256 currentCycle = getCurrentCycle();
        uint256 cyclesSinceLien = currentCycle - state.lienStartCycle;
        require(cyclesSinceLien > lienGraceCycles, "Grace period not expired");

        address owner = landDeed.ownerOf(parcelId);

        // Transfer NFT to contract custody for safe settlement
        landDeed.transferFrom(owner, address(this), parcelId);

        // Initialize auction
        uint256 endTime = block.timestamp + auctionDuration;
        auctions[parcelId] = AuctionState({
            parcelId: parcelId,
            highestBidder: address(0),
            highestBid: 0,
            endTime: endTime,
            originalOwner: owner,
            active: true
        });

        parcelStates[parcelId].inAuction = true;

        emit AuctionStarted(parcelId, endTime);
    }

    /**
     * @dev Place a bid on an auction
     * @param parcelId Token ID
     * @param bidAmount Bid amount in LAND tokens
     */
    function placeBid(uint256 parcelId, uint256 bidAmount) external nonReentrant whenNotPaused {
        AuctionState storage auction = auctions[parcelId];
        require(auction.active, "No active auction");
        require(block.timestamp < auction.endTime, "Auction ended");
        require(msg.sender != auction.originalOwner, "Owner cannot bid");

        // Calculate minimum bid (10% of assessed value or 1% increment)
        uint256 minBid = auction.highestBid == 0
            ? parcelStates[parcelId].assessedValueLAND / 10 // 10% of assessed value
            : auction.highestBid + (auction.highestBid / 100); // 1% increment

        require(bidAmount >= minBid, "Bid too low");

        // Store previous bidder info before state changes (CEI pattern)
        address previousBidder = auction.highestBidder;
        uint256 previousBid = auction.highestBid;

        // Update auction state BEFORE any external calls
        auction.highestBidder = msg.sender;
        auction.highestBid = bidAmount;

        // Anti-sniping: extend auction if bid placed near end
        if (auction.endTime - block.timestamp < auctionExtensionThreshold) {
            auction.endTime = block.timestamp + auctionExtensionTime;
            emit AuctionExtended(parcelId, auction.endTime);
        }

        // Transfer new bid to contract
        require(
            landToken.transferFrom(msg.sender, address(this), bidAmount),
            "Bid transfer failed"
        );

        // Refund previous bidder AFTER state update
        if (previousBidder != address(0)) {
            require(
                landToken.transfer(previousBidder, previousBid),
                "Refund failed"
            );
        }

        emit BidPlaced(parcelId, msg.sender, bidAmount);
    }

    /**
     * @dev Settle an auction after it ends
     * @param parcelId Token ID
     */
    function settleAuction(uint256 parcelId) external nonReentrant {
        AuctionState memory auction = auctions[parcelId];
        require(auction.active, "No active auction");
        require(block.timestamp >= auction.endTime, "Auction not ended");

        // Update parcel state first (CEI pattern)
        parcelStates[parcelId].inAuction = false;
        parcelStates[parcelId].lienActive = false;
        parcelStates[parcelId].lienHolder = address(0);
        parcelStates[parcelId].lienStartCycle = 0;

        // Clean up auction state
        delete auctions[parcelId];

        if (auction.highestBidder != address(0)) {
            // Auction had bids - transfer NFT to winner
            uint256 fee = (auction.highestBid * protocolFeeBP) / BASIS_POINTS;
            uint256 ownerProceeds = auction.highestBid - fee;

            // Transfer NFT from contract custody to winner
            landDeed.transferFrom(address(this), auction.highestBidder, parcelId);

            // Pay treasury fee
            require(landToken.transfer(treasury, fee), "Fee transfer failed");

            // Pay original owner
            require(
                landToken.transfer(auction.originalOwner, ownerProceeds),
                "Owner payment failed"
            );

            emit AuctionSettled(parcelId, auction.highestBidder, auction.highestBid);
        } else {
            // No bids - return NFT to original owner, clear lien
            landDeed.transferFrom(address(this), auction.originalOwner, parcelId);

            emit AuctionCancelled(parcelId);
        }
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /**
     * @dev Get current tax cycle
     * @return Current cycle number
     */
    function getCurrentCycle() public view returns (uint256) {
        return (block.timestamp - startTimestamp) / taxCycleSeconds;
    }

    /**
     * @dev Check if parcel is delinquent
     * @param parcelId Token ID
     * @return True if taxes are owed
     */
    function isDelinquent(uint256 parcelId) external view returns (bool) {
        return calculateTaxOwed(parcelId) > 0;
    }

    /**
     * @dev Check if auction can be started
     * @param parcelId Token ID
     * @return True if auction eligible
     */
    function canStartAuction(uint256 parcelId) external view returns (bool) {
        ParcelState memory state = parcelStates[parcelId];
        if (!state.lienActive || state.inAuction) return false;

        uint256 currentCycle = getCurrentCycle();
        uint256 cyclesSinceLien = currentCycle - state.lienStartCycle;
        return cyclesSinceLien >= lienGraceCycles;
    }

    /**
     * @dev Calculate taxes owed for multiple parcels (batch)
     * @param parcelIds Array of token IDs
     * @return Array of tax amounts owed for each parcel
     */
    function calculateTaxOwedBatch(uint256[] calldata parcelIds)
        external
        view
        returns (uint256[] memory)
    {
        uint256[] memory taxes = new uint256[](parcelIds.length);
        for (uint256 i = 0; i < parcelIds.length; i++) {
            taxes[i] = calculateTaxOwed(parcelIds[i]);
        }
        return taxes;
    }

    /**
     * @dev Get parcel states for multiple parcels (batch)
     * @param parcelIds Array of token IDs
     * @return Array of parcel states
     */
    function getParcelStatesBatch(uint256[] calldata parcelIds)
        external
        view
        returns (ParcelState[] memory)
    {
        ParcelState[] memory states = new ParcelState[](parcelIds.length);
        for (uint256 i = 0; i < parcelIds.length; i++) {
            states[i] = parcelStates[parcelIds[i]];
        }
        return states;
    }

    // ============================================
    // ASSESSOR REGISTRY SYSTEM
    // ============================================

    /**
     * @dev Register a new assessor (admin only)
     * @param assessor Address of the assessor
     * @param credentials IPFS hash or URI to certification documents
     */
    function registerAssessor(address assessor, string calldata credentials) external onlyOwner {
        require(assessor != address(0), "Invalid assessor address");
        require(!approvedAssessors[assessor].isActive, "Assessor already registered");
        require(bytes(credentials).length > 0, "Credentials required");

        approvedAssessors[assessor] = Assessor({
            isActive: true,
            registeredAt: block.timestamp,
            assessmentCount: 0,
            credentials: credentials
        });

        emit AssessorRegistered(assessor, block.timestamp, credentials);
    }

    /**
     * @dev Revoke an assessor's privileges (admin only)
     * @param assessor Address of the assessor to revoke
     */
    function revokeAssessor(address assessor) external onlyOwner {
        require(approvedAssessors[assessor].isActive, "Assessor not active");

        approvedAssessors[assessor].isActive = false;

        emit AssessorRevoked(assessor, block.timestamp);
    }

    /**
     * @dev Submit a property valuation (approved assessors only)
     * @param parcelId Token ID of the parcel
     * @param proposedValue Proposed assessed value in LAND tokens
     * @param methodology Description of valuation methodology used
     */
    function submitValuation(
        uint256 parcelId,
        uint256 proposedValue,
        string calldata methodology
    ) external {
        require(approvedAssessors[msg.sender].isActive, "Not an approved assessor");
        require(parcelStates[parcelId].assessedValueLAND > 0, "Parcel not initialized");
        require(proposedValue > 0, "Value must be > 0");
        require(proposedValue <= landToken.TOTAL_SUPPLY(), "Value exceeds total supply");
        require(bytes(methodology).length > 0, "Methodology required");

        // Rate limiting: prevent spam valuations (skip if first valuation)
        if (lastValuationTime[parcelId] > 0) {
            require(
                block.timestamp >= lastValuationTime[parcelId] + minValuationInterval,
                "Valuation submitted too recently"
            );
        }

        // Validate reasonable value change (prevent manipulation)
        uint256 currentValue = parcelStates[parcelId].assessedValueLAND;
        require(
            proposedValue <= currentValue * maxValueIncreaseMultiplier,
            "Value increase too large"
        );
        require(
            proposedValue >= currentValue / maxValueDecreaseMultiplier,
            "Value decrease too large"
        );

        // Store valuation in history
        valuationHistory[parcelId].push(AssessedValue({
            value: proposedValue,
            assessor: msg.sender,
            timestamp: block.timestamp,
            methodology: methodology,
            approved: false
        }));

        // Update assessor stats
        approvedAssessors[msg.sender].assessmentCount++;

        // Update rate limiting
        lastValuationTime[parcelId] = block.timestamp;

        emit ValuationSubmitted(parcelId, msg.sender, proposedValue, block.timestamp, methodology);
    }

    /**
     * @dev Approve a submitted valuation (admin only)
     * @param parcelId Token ID of the parcel
     * @param valueIndex Index in the valuation history array
     */
    function approveValuation(uint256 parcelId, uint256 valueIndex) external onlyOwner {
        require(valueIndex < valuationHistory[parcelId].length, "Invalid value index");

        AssessedValue storage valuation = valuationHistory[parcelId][valueIndex];
        require(!valuation.approved, "Valuation already approved");

        // Mark as approved
        valuation.approved = true;

        // Update current assessed value
        uint256 oldValue = parcelStates[parcelId].assessedValueLAND;
        parcelStates[parcelId].assessedValueLAND = valuation.value;
        currentValueIndex[parcelId] = valueIndex;

        emit ValuationApproved(parcelId, valueIndex, msg.sender);
        emit AssessedValueUpdated(parcelId, oldValue, valuation.value);
    }

    /**
     * @dev Reject a submitted valuation with reason (admin only)
     * @param parcelId Token ID of the parcel
     * @param valueIndex Index in the valuation history array
     * @param reason Explanation for rejection
     */
    function rejectValuation(
        uint256 parcelId,
        uint256 valueIndex,
        string calldata reason
    ) external onlyOwner {
        require(valueIndex < valuationHistory[parcelId].length, "Invalid value index");
        require(bytes(reason).length > 0, "Rejection reason required");

        AssessedValue storage valuation = valuationHistory[parcelId][valueIndex];
        require(!valuation.approved, "Cannot reject approved valuation");

        emit ValuationRejected(parcelId, valueIndex, msg.sender, reason);
    }

    /**
     * @dev Get valuation history for a parcel
     * @param parcelId Token ID of the parcel
     * @return Array of all valuations submitted for this parcel
     */
    function getValuationHistory(uint256 parcelId) external view returns (AssessedValue[] memory) {
        return valuationHistory[parcelId];
    }

    /**
     * @dev Get pending (unapproved) valuations for a parcel
     * @param parcelId Token ID of the parcel
     * @return Array of pending valuations
     */
    function getPendingValuations(uint256 parcelId) external view returns (AssessedValue[] memory) {
        AssessedValue[] memory allValuations = valuationHistory[parcelId];
        uint256 pendingCount = 0;

        // Count pending valuations
        for (uint256 i = 0; i < allValuations.length; i++) {
            if (!allValuations[i].approved) {
                pendingCount++;
            }
        }

        // Create array of pending valuations
        AssessedValue[] memory pending = new AssessedValue[](pendingCount);
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < allValuations.length; i++) {
            if (!allValuations[i].approved) {
                pending[currentIndex] = allValuations[i];
                currentIndex++;
            }
        }

        return pending;
    }

    /**
     * @dev Check if an address is an approved assessor
     * @param assessor Address to check
     * @return True if the address is an active assessor
     */
    function isApprovedAssessor(address assessor) external view returns (bool) {
        return approvedAssessors[assessor].isActive;
    }

    /**
     * @dev Get assessor information
     * @param assessor Address of the assessor
     * @return Assessor struct with details
     */
    function getAssessorInfo(address assessor) external view returns (Assessor memory) {
        return approvedAssessors[assessor];
    }

    // ============================================
    // ADMIN FUNCTIONS
    // ============================================

    /**
     * @dev Update assessed value directly (admin only, legacy method)
     * @param parcelId Token ID
     * @param newValue New assessed value
     */
    function setAssessedValue(uint256 parcelId, uint256 newValue) external onlyOwner {
        require(newValue > 0, "Value must be > 0");
        require(newValue <= landToken.TOTAL_SUPPLY(), "Value exceeds total supply");

        uint256 oldValue = parcelStates[parcelId].assessedValueLAND;
        parcelStates[parcelId].assessedValueLAND = newValue;

        emit AssessedValueUpdated(parcelId, oldValue, newValue);
    }

    /**
     * @dev Update protocol fee
     * @param newFeeBP New fee in basis points
     */
    function setProtocolFee(uint256 newFeeBP) external onlyOwner {
        require(newFeeBP <= 5000, "Fee too high"); // Max 50%

        uint256 oldFee = protocolFeeBP;
        protocolFeeBP = newFeeBP;

        emit ProtocolFeeUpdated(oldFee, newFeeBP);
    }

    /**
     * @dev Update tax rate
     * @param newRateBP New rate in basis points
     */
    function setTaxRate(uint256 newRateBP) external onlyOwner {
        require(newRateBP <= 2000, "Rate too high"); // Max 20%

        uint256 oldRate = taxRateBP;
        taxRateBP = newRateBP;

        emit TaxRateUpdated(oldRate, newRateBP);
    }

    /**
     * @dev Update treasury address
     * @param newTreasury New treasury address
     */
    function setTreasury(address newTreasury) external onlyOwner {
        require(newTreasury != address(0), "Invalid treasury");

        address oldTreasury = treasury;
        treasury = newTreasury;

        emit TreasuryUpdated(oldTreasury, newTreasury);
    }

    /**
     * @dev Update valuation constraints (admin only)
     * @param maxIncrease Maximum value increase multiplier
     * @param maxDecrease Maximum value decrease multiplier
     * @param minInterval Minimum time between valuations
     */
    function setValuationConstraints(
        uint256 maxIncrease,
        uint256 maxDecrease,
        uint256 minInterval
    ) external onlyOwner {
        require(maxIncrease >= 2 && maxIncrease <= 20, "Invalid increase multiplier");
        require(maxDecrease >= 2 && maxDecrease <= 20, "Invalid decrease multiplier");
        require(minInterval >= 1 hours && minInterval <= 30 days, "Invalid interval");

        maxValueIncreaseMultiplier = maxIncrease;
        maxValueDecreaseMultiplier = maxDecrease;
        minValuationInterval = minInterval;
    }

    /**
     * @dev Update tax cycle duration (admin only)
     * @param newDuration New cycle duration in seconds
     */
    function setTaxCycleDuration(uint256 newDuration) external onlyOwner {
        require(newDuration >= 1 hours && newDuration <= 30 days, "Invalid duration");

        uint256 oldDuration = taxCycleSeconds;
        taxCycleSeconds = newDuration;

        emit TaxCycleDurationUpdated(oldDuration, newDuration);
    }

    /**
     * @dev Update auction duration (admin only)
     * @param newDuration New auction duration in seconds
     */
    function setAuctionDuration(uint256 newDuration) external onlyOwner {
        require(newDuration >= 1 hours && newDuration <= 7 days, "Invalid duration");

        uint256 oldDuration = auctionDuration;
        auctionDuration = newDuration;

        emit AuctionDurationUpdated(oldDuration, newDuration);
    }

    /**
     * @dev Update lien grace cycles (admin only)
     * @param newCycles New number of grace cycles
     */
    function setLienGraceCycles(uint256 newCycles) external onlyOwner {
        require(newCycles >= 1 && newCycles <= 10, "Invalid cycle count");

        uint256 oldCycles = lienGraceCycles;
        lienGraceCycles = newCycles;

        emit LienGraceCyclesUpdated(oldCycles, newCycles);
    }

    /**
     * @dev Rescue NFT from contract (emergency only)
     * @param parcelId Token ID to rescue
     * @param to Address to send NFT to
     */
    function rescueNFT(uint256 parcelId, address to) external onlyOwner {
        require(to != address(0), "Invalid recipient");
        require(!auctions[parcelId].active, "Cannot rescue during auction");

        landDeed.transferFrom(address(this), to, parcelId);
    }

    /**
     * @dev Pause all contract operations (emergency only)
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause contract operations
     */
    function unpause() external onlyOwner {
        _unpause();
    }
}
