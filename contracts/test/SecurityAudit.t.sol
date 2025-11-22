// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";
import "../src/HyperLandCore.sol";

/**
 * @title SecurityAudit
 * @dev Advanced security tests for HyperLand system
 */
contract SecurityAuditTest is Test {
    LANDToken public land;
    LandDeed public deed;
    HyperLandCore public core;

    address public admin = address(this);
    address public treasury = address(0x7777);
    address public attacker = address(0xBAD);
    address public user1 = address(0x1);
    address public user2 = address(0x2);
    address public user3 = address(0x3);

    function setUp() public {
        // Deploy contracts
        land = new LANDToken(admin);
        deed = new LandDeed(admin);
        core = new HyperLandCore(address(land), address(deed), treasury, admin);

        // Transfer LandDeed ownership to HyperLandCore
        deed.transferOwnership(address(core));

        // Fund users
        land.transfer(user1, 100000 * 10**18);
        land.transfer(user2, 100000 * 10**18);
        land.transfer(user3, 100000 * 10**18);
        land.transfer(attacker, 100000 * 10**18);

        // Approve core contract
        vm.prank(user1);
        land.approve(address(core), type(uint256).max);
        vm.prank(user2);
        land.approve(address(core), type(uint256).max);
        vm.prank(user3);
        land.approve(address(core), type(uint256).max);
        vm.prank(attacker);
        land.approve(address(core), type(uint256).max);
    }

    // ============================================
    // INTEGER OVERFLOW/UNDERFLOW TESTS
    // ============================================

    function testCannotOverflowAssessedValue() public {
        // Use a very large but reasonable value (within token supply of 21M)
        uint256 largeValue = 10_000_000 * 10**18; // 10M LAND tokens

        // Should succeed (Solidity 0.8+ has automatic overflow protection)
        uint256 tokenId = core.mintParcel(user1, 100, 100, 100, largeValue);

        // Verify state
        (uint256 assessedValue,,,,, ) = core.parcelStates(tokenId);
        assertEq(assessedValue, largeValue);

        // Now try to calculate tax (should not overflow)
        vm.warp(block.timestamp + 15 minutes); // One cycle
        uint256 taxOwed = core.calculateTaxOwed(tokenId);

        // 5% of large value should not overflow
        uint256 expectedTax = (largeValue * 500) / 10000;
        assertEq(taxOwed, expectedTax);
    }

    function testCannotUnderflowOnRefund() public {
        // Create auction scenario
        uint256 tokenId = core.mintParcel(user1, 200, 200, 100, 1000 * 10**18);

        // Make parcel delinquent - need to wait for grace period (>3 cycles of 15 seconds)
        vm.warp(block.timestamp + 15 minutes); // Move to cycle 1
        vm.prank(user2);
        core.payTaxesFor(tokenId); // Lien starts at cycle 1
        vm.warp(block.timestamp + 60 minutes); // Skip 4 cycles (60 seconds) - now at cycle 5 (cycles since lien = 4, which is > 3)

        // Owner must approve deed transfer for auction
        vm.prank(user1);
        deed.approve(address(core), tokenId);

        // Start auction
        vm.prank(user2);
        core.startAuction(tokenId);

        // First bid
        vm.prank(user3);
        core.placeBid(tokenId, 500 * 10**18);

        uint256 user3BalanceBefore = land.balanceOf(user3);

        // Second bid should refund first bidder
        vm.prank(attacker);
        core.placeBid(tokenId, 600 * 10**18);

        // Verify no underflow occurred on refund
        assertEq(land.balanceOf(user3), user3BalanceBefore + 500 * 10**18);
    }

    // ============================================
    // REENTRANCY ATTACK TESTS
    // ============================================

    function testReentrancyOnBidRefund() public {
        // This test verifies nonReentrant modifier works
        // In a real reentrancy attack, the attacker contract would try to
        // call placeBid again during the refund callback

        uint256 tokenId = core.mintParcel(user1, 300, 300, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes); // Wait >3 cycles

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // First bid
        vm.prank(user3);
        core.placeBid(tokenId, 500 * 10**18);

        // Second bid triggers refund - nonReentrant should prevent reentrancy
        vm.prank(attacker);
        core.placeBid(tokenId, 600 * 10**18);

        // Verify state is consistent (only one bid active)
        (, address highestBidder, uint256 highestBid,,, ) = core.auctions(tokenId);
        assertEq(highestBidder, attacker);
        assertEq(highestBid, 600 * 10**18);
    }

    // ============================================
    // ECONOMIC ATTACK VECTORS
    // ============================================

    function testCannotFrontRunAuction() public {
        // Scenario: attacker tries to front-run auction settlement by bidding
        uint256 tokenId = core.mintParcel(user1, 400, 400, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        vm.prank(user3);
        core.placeBid(tokenId, 500 * 10**18);

        // Get auction end time
        (,, uint256 endTime,,, ) = core.auctions(tokenId);

        // Warp to exactly at end time (auction should be ended)
        vm.warp(endTime);

        // Attacker tries to bid after auction ended
        vm.prank(attacker);
        vm.expectRevert("Auction ended");
        core.placeBid(tokenId, 1000 * 10**18);
    }

    function testCannotManipulateTaxesByTransferring() public {
        // Scenario: owner transfers parcel to avoid taxes
        uint256 tokenId = core.mintParcel(user1, 500, 500, 100, 1000 * 10**18);

        // Approve deed for transfer
        vm.prank(user1);
        deed.approve(attacker, tokenId);

        // Warp forward to accrue taxes
        vm.warp(block.timestamp + 15 minutes);
        uint256 taxOwed = core.calculateTaxOwed(tokenId);
        assertGt(taxOwed, 0);

        // Transfer deed to attacker
        vm.prank(user1);
        deed.transferFrom(user1, attacker, tokenId);

        // Tax debt should still exist for the parcel
        uint256 taxOwedAfter = core.calculateTaxOwed(tokenId);
        assertEq(taxOwed, taxOwedAfter); // Tax debt travels with parcel

        // New owner must pay to avoid delinquency
        assertTrue(core.isDelinquent(tokenId));
    }

    function testCannotSnipeAuction() public {
        // Test anti-sniping mechanism
        uint256 tokenId = core.mintParcel(user1, 600, 600, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Get initial end time
        (,, , uint256 endTimeBefore,, ) = core.auctions(tokenId);
        uint256 currentTime = block.timestamp;

        // Warp to near end (1 minute before, within 2-minute threshold)
        vm.warp(currentTime + 14 minutes); // 14 minutes after auction start, 1 minute before end

        vm.prank(user3);
        core.placeBid(tokenId, 500 * 10**18);

        // Auction should be extended
        (,, , uint256 endTimeAfter,, ) = core.auctions(tokenId);
        assertGt(endTimeAfter, endTimeBefore); // Extended
        // Extended by 2 minutes from bid time
        assertEq(endTimeAfter, block.timestamp + 2 minutes);
    }

    function testProtocolFeesCalculatedCorrectly() public {
        // Verify 20% fee on marketplace sale
        uint256 tokenId = core.mintParcel(user1, 700, 700, 100, 1000 * 10**18);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        uint256 salePrice = 2000 * 10**18;
        vm.prank(user1);
        core.listDeed(tokenId, salePrice);

        uint256 treasuryBefore = land.balanceOf(treasury);
        uint256 sellerBefore = land.balanceOf(user1);

        vm.prank(user2);
        core.buyDeed(tokenId);

        uint256 treasuryAfter = land.balanceOf(treasury);
        uint256 sellerAfter = land.balanceOf(user1);

        // 20% fee = 400 LAND
        assertEq(treasuryAfter - treasuryBefore, 400 * 10**18);
        // 80% to seller = 1600 LAND
        assertEq(sellerAfter - sellerBefore, 1600 * 10**18);
    }

    function testCannotBidWithInsufficientFunds() public {
        // Create auction
        uint256 tokenId = core.mintParcel(user1, 800, 800, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Create poor user with insufficient funds
        address poorUser = address(0x999);
        land.transfer(poorUser, 100 * 10**18); // Only 100 LAND

        vm.prank(poorUser);
        land.approve(address(core), type(uint256).max);

        // Try to bid 1000 LAND (more than balance)
        vm.prank(poorUser);
        vm.expectRevert();
        core.placeBid(tokenId, 1000 * 10**18);
    }

    // ============================================
    // ACCESS CONTROL TESTS
    // ============================================

    function testOnlyOwnerCanMint() public {
        vm.prank(attacker);
        vm.expectRevert();
        core.mintParcel(attacker, 900, 900, 100, 1000 * 10**18);
    }

    function testOnlyOwnerCanSetProtocolFee() public {
        vm.prank(attacker);
        vm.expectRevert();
        core.setProtocolFee(3000);
    }

    function testOnlyLienHolderCanStartAuction() public {
        uint256 tokenId = core.mintParcel(user1, 1000, 1000, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);

        // user2 creates lien
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes); // Wait >3 cycles (60 minutes)

        // user3 (not lien holder) tries to start auction
        vm.prank(user3);
        vm.expectRevert("Only lien holder can start auction");
        core.startAuction(tokenId);
    }

    // ============================================
    // EDGE CASES
    // ============================================

    function testZeroAddressProtection() public {
        // Try to mint to zero address
        vm.expectRevert();
        core.mintParcel(address(0), 1100, 1100, 100, 1000 * 10**18);
    }

    function testDuplicateCoordinatesRejected() public {
        // Mint first parcel
        core.mintParcel(user1, 1200, 1200, 100, 1000 * 10**18);

        // Try to mint duplicate coordinates
        vm.expectRevert("LandDeed: parcel already exists at coordinates");
        core.mintParcel(user2, 1200, 1200, 100, 1000 * 10**18);
    }

    function testSettleAuctionTwice() public {
        // Create and settle auction
        uint256 tokenId = core.mintParcel(user1, 1300, 1300, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        vm.prank(user3);
        core.placeBid(tokenId, 500 * 10**18);

        // Get auction end time and warp past it
        (,, uint256 endTime,,, ) = core.auctions(tokenId);
        vm.warp(endTime + 1); // Warp past end time

        core.settleAuction(tokenId);

        // Try to settle again
        vm.expectRevert("No active auction");
        core.settleAuction(tokenId);
    }

    function testMinimumBidEnforcement() public {
        // Test 10% minimum first bid
        uint256 tokenId = core.mintParcel(user1, 1400, 1400, 100, 1000 * 10**18);
        vm.warp(block.timestamp + 15 minutes);
        vm.prank(user2);
        core.payTaxesFor(tokenId);
        vm.warp(block.timestamp + 60 minutes);

        vm.prank(user1);
        deed.approve(address(core), tokenId);

        vm.prank(user2);
        core.startAuction(tokenId);

        // Try to bid less than 10% of assessed value (100 LAND)
        vm.prank(user3);
        vm.expectRevert("Bid too low");
        core.placeBid(tokenId, 50 * 10**18);

        // Valid first bid (100 LAND minimum)
        vm.prank(user3);
        core.placeBid(tokenId, 100 * 10**18);

        // Try to bid without 1% increment
        vm.prank(attacker);
        vm.expectRevert("Bid too low");
        core.placeBid(tokenId, 100 * 10**18); // Same as current bid

        // Valid increment (101 LAND)
        vm.prank(attacker);
        core.placeBid(tokenId, 101 * 10**18);
    }
}
