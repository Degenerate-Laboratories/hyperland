// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";
import "../src/HyperLandCore.sol";

contract HyperLandCoreTest is Test {
    LANDToken public land;
    LandDeed public deed;
    HyperLandCore public core;

    address public admin = address(0x1);
    address public treasury = address(0x2);
    address public user1 = address(0x3);
    address public user2 = address(0x4);
    address public user3 = address(0x5);

    uint256 constant INITIAL_BALANCE = 100000 * 10**18;

    function setUp() public {
        // Deploy contracts
        land = new LANDToken(admin);
        deed = new LandDeed(admin);
        core = new HyperLandCore(address(land), address(deed), treasury, admin);

        // Transfer ownership to core
        vm.prank(admin);
        deed.transferOwnership(address(core));

        // Distribute LAND tokens
        vm.startPrank(admin);
        land.transfer(user1, INITIAL_BALANCE);
        land.transfer(user2, INITIAL_BALANCE);
        land.transfer(user3, INITIAL_BALANCE);
        vm.stopPrank();

        // Approve core to spend LAND
        vm.prank(user1);
        land.approve(address(core), type(uint256).max);

        vm.prank(user2);
        land.approve(address(core), type(uint256).max);

        vm.prank(user3);
        land.approve(address(core), type(uint256).max);
    }

    function _mintAndInitialize(address owner, uint256 assessedValue) internal returns (uint256) {
        vm.prank(admin);
        uint256 tokenId = core.mintParcel(owner, 100, 200, 50, assessedValue);
        return tokenId;
    }

    // ============================================
    // MARKETPLACE TESTS
    // ============================================

    function testListAndBuyDeed() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Approve core to transfer NFT
        vm.prank(user1);
        deed.approve(address(core), tokenId);

        // List parcel
        vm.prank(user1);
        core.listDeed(tokenId, 500 * 10**18);

        // Buy parcel
        uint256 user1BalanceBefore = land.balanceOf(user1);
        uint256 user2BalanceBefore = land.balanceOf(user2);

        vm.prank(user2);
        core.buyDeed(tokenId);

        // Verify ownership transfer
        assertEq(deed.ownerOf(tokenId), user2);

        // Verify payments (80% to seller, 20% to treasury)
        uint256 expectedSellerAmount = 400 * 10**18; // 80% of 500
        uint256 expectedFee = 100 * 10**18; // 20% of 500

        assertEq(land.balanceOf(user1), user1BalanceBefore + expectedSellerAmount);
        assertEq(land.balanceOf(user2), user2BalanceBefore - 500 * 10**18);
        assertEq(land.balanceOf(treasury), expectedFee);
    }

    function testCannotBuyUnlistedDeed() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        vm.prank(user2);
        vm.expectRevert("Not listed");
        core.buyDeed(tokenId);
    }

    function testDelistDeed() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user1);
        core.listDeed(tokenId, 500 * 10**18);

        vm.prank(user1);
        core.delistDeed(tokenId);

        vm.prank(user2);
        vm.expectRevert("Not listed");
        core.buyDeed(tokenId);
    }

    // ============================================
    // TAX SYSTEM TESTS
    // ============================================

    function testPayTaxes() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Fast forward 1 tax cycle
        vm.warp(block.timestamp + 15 minutes);

        uint256 taxOwed = core.calculateTaxOwed(tokenId);
        assertEq(taxOwed, 50 * 10**18); // 5% of 1000

        uint256 balanceBefore = land.balanceOf(user1);

        vm.prank(user1);
        core.payTaxes(tokenId);

        assertEq(land.balanceOf(user1), balanceBefore - taxOwed);
        assertEq(land.balanceOf(treasury), taxOwed);
    }

    function testPayTaxesForStartsLien() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Fast forward 1 tax cycle
        vm.warp(block.timestamp + 15 minutes);

        vm.prank(user2);
        core.payTaxesFor(tokenId);

        (, , , address lienHolder, bool lienActive, ) = core.parcelStates(tokenId);

        assertTrue(lienActive);
        assertEq(lienHolder, user2);
    }

    function testOwnerCanClearLien() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);
        uint256 startTime = block.timestamp;

        // Fast forward and create lien
        vm.warp(startTime + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);

        // Fast forward another cycle (now there are new taxes owed)
        vm.warp(startTime + 14 days);

        vm.prank(user1);
        core.payTaxes(tokenId);

        (, , , , bool lienActive, ) = core.parcelStates(tokenId);
        assertFalse(lienActive);
    }

    // ============================================
    // AUCTION SYSTEM TESTS
    // ============================================

    function testStartAuction() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Create lien
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);

        // Fast forward past grace period (>3 cycles of 15 minutes)
        vm.warp(block.timestamp + 60 minutes); // 4 cycles

        // Approve NFT transfer for auction
        vm.prank(user1);
        deed.approve(address(core), tokenId);

        // Start auction as lien holder and verify
        vm.prank(user2);
        core.startAuction(tokenId);

        (, , , , , bool inAuction) = core.parcelStates(tokenId);
        assertTrue(inAuction);

        (uint256 parcelId, , , uint256 endTime, , bool active) = core.auctions(tokenId);
        assertEq(parcelId, tokenId);
        assertTrue(active);
        // End time should be 15 minutes from now
        assertGt(endTime, block.timestamp);
        assertEq(endTime - block.timestamp, 15 minutes);
        // NFT should be in contract custody
        assertEq(deed.ownerOf(tokenId), address(core));
    }

    function testCannotStartAuctionBeforeGracePeriod() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Create lien
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);

        // Approve NFT
        vm.prank(user1);
        deed.approve(address(core), tokenId);

        // Try to start auction immediately as lien holder
        vm.prank(user2);
        vm.expectRevert("Grace period not expired");
        core.startAuction(tokenId);
    }

    function testPlaceBid() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Place bid (minimum 10% of assessed value = 100 LAND)
        uint256 bidAmount = 150 * 10**18;
        uint256 balanceBefore = land.balanceOf(user3);

        vm.prank(user3);
        core.placeBid(tokenId, bidAmount);

        // Verify bid
        (, address highestBidder, uint256 highestBid, , , ) = core.auctions(tokenId);
        assertEq(highestBidder, user3);
        assertEq(highestBid, bidAmount);
        assertEq(land.balanceOf(user3), balanceBefore - bidAmount);
    }

    function testBidRefundPreviousBidder() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // First bid (minimum 100 LAND)
        uint256 firstBid = 150 * 10**18;
        vm.prank(user2);
        core.placeBid(tokenId, firstBid);

        uint256 user2Balance = land.balanceOf(user2);

        // Second bid (must be at least 1% higher = 151.5 LAND)
        uint256 secondBid = 200 * 10**18;
        vm.prank(user3);
        core.placeBid(tokenId, secondBid);

        // Verify refund
        assertEq(land.balanceOf(user2), user2Balance + firstBid);
    }

    function testCannotBidBelowHighest() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // First bid
        vm.prank(user2);
        core.placeBid(tokenId, 150 * 10**18);

        // Try bid below 1% increment (need at least 151.5)
        vm.prank(user3);
        vm.expectRevert("Bid too low");
        core.placeBid(tokenId, 151 * 10**18);
    }

    function testOriginalOwnerCannotBid() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Owner tries to bid
        vm.prank(user1);
        vm.expectRevert("Owner cannot bid");
        core.placeBid(tokenId, 150 * 10**18);
    }

    function testSettleAuctionWithBids() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        // Approve NFT transfer
        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Place bid (minimum 100 LAND)
        uint256 bidAmount = 200 * 10**18;
        vm.prank(user3);
        core.placeBid(tokenId, bidAmount);

        // Fast forward past auction end
        vm.warp(block.timestamp + 15 minutes + 1);

        uint256 user1BalanceBefore = land.balanceOf(user1);
        uint256 treasuryBalanceBefore = land.balanceOf(treasury);

        // Settle auction
        core.settleAuction(tokenId);

        // Verify ownership transfer
        assertEq(deed.ownerOf(tokenId), user3);

        // Verify payments (80% to owner, 20% to treasury)
        uint256 expectedOwnerAmount = 160 * 10**18; // 80% of 200
        uint256 expectedFee = 40 * 10**18; // 20% of 200

        assertEq(land.balanceOf(user1), user1BalanceBefore + expectedOwnerAmount);
        assertEq(land.balanceOf(treasury), treasuryBalanceBefore + expectedFee);

        // Verify lien cleared
        (, , , , bool lienActive, bool inAuction) = core.parcelStates(tokenId);
        assertFalse(lienActive);
        assertFalse(inAuction);
    }

    function testSettleAuctionWithNoBids() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Fast forward past auction end
        vm.warp(block.timestamp + 15 minutes + 1);

        // Settle auction (no bids)
        core.settleAuction(tokenId);

        // Verify parcel returned to owner
        assertEq(deed.ownerOf(tokenId), user1);

        // Verify lien cleared
        (, , , , bool lienActive, bool inAuction) = core.parcelStates(tokenId);
        assertFalse(lienActive);
        assertFalse(inAuction);
    }

    function testCannotSettleAuctionBeforeEnd() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        // Setup auction
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 28 days);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Try to settle immediately
        vm.expectRevert("Auction not ended");
        core.settleAuction(tokenId);
    }

    // ============================================
    // VIEW FUNCTION TESTS
    // ============================================

    function testGetCurrentCycle() public {
        uint256 cycle0 = core.getCurrentCycle();
        assertEq(cycle0, 0);

        vm.warp(block.timestamp + 15 minutes);
        uint256 cycle1 = core.getCurrentCycle();
        assertEq(cycle1, 1);

        vm.warp(block.timestamp + 30 minutes); // +2 more cycles = cycle 3
        uint256 cycle3 = core.getCurrentCycle();
        assertEq(cycle3, 3);
    }

    function testIsDelinquent() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        assertFalse(core.isDelinquent(tokenId));

        vm.warp(block.timestamp + 15 minutes);

        assertTrue(core.isDelinquent(tokenId));
    }

    function testCanStartAuction() public {
        uint256 tokenId = _mintAndInitialize(user1, 1000 * 10**18);

        assertFalse(core.canStartAuction(tokenId));

        // Create lien
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);

        assertFalse(core.canStartAuction(tokenId)); // Grace period not passed

        // Past grace period
        vm.warp(block.timestamp + 60 minutes);
        assertTrue(core.canStartAuction(tokenId));
    }
}
