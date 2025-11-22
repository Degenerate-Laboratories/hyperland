// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/HyperLandCore.sol";
import "../src/LANDToken.sol";
import "../src/LandDeed.sol";

/**
 * @title AssessorRegistryTest
 * @dev Comprehensive tests for the assessor registry and valuation system
 */
contract AssessorRegistryTest is Test {
    HyperLandCore public core;
    LANDToken public land;
    LandDeed public deed;

    address public admin = address(1);
    address public treasury = address(2);
    address public assessor1 = address(3);
    address public assessor2 = address(4);
    address public user = address(5);

    uint256 public constant INITIAL_VALUE = 1000 * 10**18; // 1000 LAND

    function setUp() public {
        vm.startPrank(admin);

        // Deploy contracts
        land = new LANDToken(admin);
        deed = new LandDeed(admin);
        core = new HyperLandCore(address(land), address(deed), treasury, admin);

        // Transfer deed ownership to core
        deed.transferOwnership(address(core));

        // Mint initial parcel
        core.mintParcel(user, 0, 0, 100, INITIAL_VALUE);

        vm.stopPrank();
    }

    // ============================================
    // ASSESSOR REGISTRATION TESTS
    // ============================================

    function test_RegisterAssessor() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        assertTrue(core.isApprovedAssessor(assessor1));

        HyperLandCore.Assessor memory info = core.getAssessorInfo(assessor1);
        assertEq(info.isActive, true);
        assertEq(info.assessmentCount, 0);
        assertEq(info.credentials, "ipfs://QmTest123");
    }

    function test_RegisterAssessorEmitsEvent() public {
        vm.expectEmit(true, false, false, true);
        emit HyperLandCore.AssessorRegistered(assessor1, block.timestamp, "ipfs://QmTest123");

        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");
    }

    function test_RevertWhen_NonAdminRegistersAssessor() public {
        vm.prank(user);
        vm.expectRevert();
        core.registerAssessor(assessor1, "ipfs://QmTest123");
    }

    function test_RevertWhen_RegisteringZeroAddress() public {
        vm.prank(admin);
        vm.expectRevert("Invalid assessor address");
        core.registerAssessor(address(0), "ipfs://QmTest123");
    }

    function test_RevertWhen_RegisteringDuplicateAssessor() public {
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.expectRevert("Assessor already registered");
        core.registerAssessor(assessor1, "ipfs://QmTest456");
        vm.stopPrank();
    }

    function test_RevertWhen_RegisteringWithEmptyCredentials() public {
        vm.prank(admin);
        vm.expectRevert("Credentials required");
        core.registerAssessor(assessor1, "");
    }

    // ============================================
    // ASSESSOR REVOCATION TESTS
    // ============================================

    function test_RevokeAssessor() public {
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");
        assertTrue(core.isApprovedAssessor(assessor1));

        core.revokeAssessor(assessor1);
        assertFalse(core.isApprovedAssessor(assessor1));
        vm.stopPrank();
    }

    function test_RevokeAssessorEmitsEvent() public {
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.expectEmit(true, false, false, true);
        emit HyperLandCore.AssessorRevoked(assessor1, block.timestamp);

        core.revokeAssessor(assessor1);
        vm.stopPrank();
    }

    function test_RevertWhen_NonAdminRevokesAssessor() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(user);
        vm.expectRevert();
        core.revokeAssessor(assessor1);
    }

    function test_RevertWhen_RevokingNonActiveAssessor() public {
        vm.prank(admin);
        vm.expectRevert("Assessor not active");
        core.revokeAssessor(assessor1);
    }

    // ============================================
    // VALUATION SUBMISSION TESTS
    // ============================================

    function test_SubmitValuation() public {
        // Register assessor
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // Submit valuation
        uint256 newValue = 1200 * 10**18;
        vm.prank(assessor1);
        core.submitValuation(1, newValue, "comparable_sales");

        // Check valuation history
        HyperLandCore.AssessedValue[] memory history = core.getValuationHistory(1);
        assertEq(history.length, 1);
        assertEq(history[0].value, newValue);
        assertEq(history[0].assessor, assessor1);
        assertEq(history[0].methodology, "comparable_sales");
        assertFalse(history[0].approved);

        // Check assessor stats updated
        HyperLandCore.Assessor memory info = core.getAssessorInfo(assessor1);
        assertEq(info.assessmentCount, 1);
    }

    function test_SubmitValuationEmitsEvent() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        uint256 newValue = 1200 * 10**18;

        vm.expectEmit(true, true, false, true);
        emit HyperLandCore.ValuationSubmitted(1, assessor1, newValue, block.timestamp, "comparable_sales");

        vm.prank(assessor1);
        core.submitValuation(1, newValue, "comparable_sales");
    }

    function test_RevertWhen_NonAssessorSubmitsValuation() public {
        uint256 newValue = 1200 * 10**18;

        vm.prank(user);
        vm.expectRevert("Not an approved assessor");
        core.submitValuation(1, newValue, "comparable_sales");
    }

    function test_RevertWhen_RevokedAssessorSubmitsValuation() public {
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");
        core.revokeAssessor(assessor1);
        vm.stopPrank();

        uint256 newValue = 1200 * 10**18;

        vm.prank(assessor1);
        vm.expectRevert("Not an approved assessor");
        core.submitValuation(1, newValue, "comparable_sales");
    }

    function test_RevertWhen_SubmittingForUninitializedParcel() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        vm.expectRevert("Parcel not initialized");
        core.submitValuation(999, 1200 * 10**18, "comparable_sales");
    }

    function test_RevertWhen_SubmittingZeroValue() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        vm.expectRevert("Value must be > 0");
        core.submitValuation(1, 0, "comparable_sales");
    }

    function test_RevertWhen_SubmittingValueExceedingSupply() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        uint256 tooHigh = land.TOTAL_SUPPLY() + 1;

        vm.prank(assessor1);
        vm.expectRevert("Value exceeds total supply");
        core.submitValuation(1, tooHigh, "comparable_sales");
    }

    function test_RevertWhen_SubmittingWithEmptyMethodology() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        vm.expectRevert("Methodology required");
        core.submitValuation(1, 1200 * 10**18, "");
    }

    function test_RevertWhen_ValueIncreaseTooLarge() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // Default max increase is 5x
        uint256 tooHigh = INITIAL_VALUE * 6;

        vm.prank(assessor1);
        vm.expectRevert("Value increase too large");
        core.submitValuation(1, tooHigh, "comparable_sales");
    }

    function test_RevertWhen_ValueDecreaseTooLarge() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // Default max decrease is 1/5 (80% drop)
        uint256 tooLow = INITIAL_VALUE / 6;

        vm.prank(assessor1);
        vm.expectRevert("Value decrease too large");
        core.submitValuation(1, tooLow, "comparable_sales");
    }

    function test_RevertWhen_SubmittingTooFrequently() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // First valuation succeeds
        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        // Second immediate valuation fails (default interval is 1 day)
        vm.prank(assessor1);
        vm.expectRevert("Valuation submitted too recently");
        core.submitValuation(1, 1300 * 10**18, "comparable_sales");

        // After 1 day, succeeds
        vm.warp(block.timestamp + 1 days);
        vm.prank(assessor1);
        core.submitValuation(1, 1300 * 10**18, "comparable_sales");
    }

    // ============================================
    // VALUATION APPROVAL TESTS
    // ============================================

    function test_ApproveValuation() public {
        // Setup: register assessor and submit valuation
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        uint256 newValue = 1200 * 10**18;
        vm.prank(assessor1);
        core.submitValuation(1, newValue, "comparable_sales");

        // Approve valuation
        vm.prank(admin);
        core.approveValuation(1, 0);

        // Check valuation is approved
        HyperLandCore.AssessedValue[] memory history = core.getValuationHistory(1);
        assertTrue(history[0].approved);

        // Check parcel state updated
        (uint256 assessedValue,,,,, ) = core.parcelStates(1);
        assertEq(assessedValue, newValue);

        // Check current value index
        assertEq(core.currentValueIndex(1), 0);
    }

    function test_ApproveValuationEmitsEvents() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        uint256 newValue = 1200 * 10**18;
        vm.prank(assessor1);
        core.submitValuation(1, newValue, "comparable_sales");

        vm.expectEmit(true, false, false, true);
        emit HyperLandCore.ValuationApproved(1, 0, admin);

        vm.expectEmit(true, false, false, true);
        emit HyperLandCore.AssessedValueUpdated(1, INITIAL_VALUE, newValue);

        vm.prank(admin);
        core.approveValuation(1, 0);
    }

    function test_RevertWhen_NonAdminApprovesValuation() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.prank(user);
        vm.expectRevert();
        core.approveValuation(1, 0);
    }

    function test_RevertWhen_ApprovingInvalidIndex() public {
        vm.prank(admin);
        vm.expectRevert("Invalid value index");
        core.approveValuation(1, 0);
    }

    function test_RevertWhen_ApprovingAlreadyApproved() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.startPrank(admin);
        core.approveValuation(1, 0);

        vm.expectRevert("Valuation already approved");
        core.approveValuation(1, 0);
        vm.stopPrank();
    }

    // ============================================
    // VALUATION REJECTION TESTS
    // ============================================

    function test_RejectValuation() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.expectEmit(true, false, false, true);
        emit HyperLandCore.ValuationRejected(1, 0, admin, "Methodology not sound");

        vm.prank(admin);
        core.rejectValuation(1, 0, "Methodology not sound");
    }

    function test_RevertWhen_RejectingWithEmptyReason() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.prank(admin);
        vm.expectRevert("Rejection reason required");
        core.rejectValuation(1, 0, "");
    }

    function test_RevertWhen_RejectingApprovedValuation() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.startPrank(admin);
        core.approveValuation(1, 0);

        vm.expectRevert("Cannot reject approved valuation");
        core.rejectValuation(1, 0, "Too late");
        vm.stopPrank();
    }

    // ============================================
    // VIEW FUNCTION TESTS
    // ============================================

    function test_GetValuationHistory() public {
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // Submit multiple valuations
        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.warp(block.timestamp + 1 days);
        vm.prank(assessor1);
        core.submitValuation(1, 1300 * 10**18, "auction_based");

        HyperLandCore.AssessedValue[] memory history = core.getValuationHistory(1);
        assertEq(history.length, 2);
        assertEq(history[0].value, 1200 * 10**18);
        assertEq(history[1].value, 1300 * 10**18);
    }

    function test_GetPendingValuations() public {
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");
        core.registerAssessor(assessor2, "ipfs://QmAssessor2");

        // Mint a second parcel for multiple assessments
        core.mintParcel(user, 1, 0, 100, INITIAL_VALUE);
        vm.stopPrank();

        // Submit valuations for different parcels (no rate limit cross-parcels)
        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.prank(assessor2);
        core.submitValuation(2, 1300 * 10**18, "auction_based");

        // Wait 1 day and submit another for parcel 1
        vm.warp(block.timestamp + 1 days + 1);
        vm.prank(assessor1);
        core.submitValuation(1, 1400 * 10**18, "external_oracle");

        // Approve first one only
        vm.prank(admin);
        core.approveValuation(1, 0);

        // Get pending for parcel 1 (should be 1 - the second submission)
        HyperLandCore.AssessedValue[] memory pending = core.getPendingValuations(1);
        assertEq(pending.length, 1);
        assertEq(pending[0].value, 1400 * 10**18);

        // Parcel 2 should have 1 pending
        HyperLandCore.AssessedValue[] memory pending2 = core.getPendingValuations(2);
        assertEq(pending2.length, 1);
        assertEq(pending2[0].value, 1300 * 10**18);
    }

    function test_GetPendingValuations_EmptyArray() public {
        HyperLandCore.AssessedValue[] memory pending = core.getPendingValuations(1);
        assertEq(pending.length, 0);
    }

    // ============================================
    // VALUATION CONSTRAINTS CONFIGURATION
    // ============================================

    function test_SetValuationConstraints() public {
        vm.prank(admin);
        core.setValuationConstraints(10, 10, 2 days);

        // Test with new constraints
        vm.prank(admin);
        core.registerAssessor(assessor1, "ipfs://QmTest123");

        // Can now do 10x increase
        uint256 newValue = INITIAL_VALUE * 10;
        vm.prank(assessor1);
        core.submitValuation(1, newValue, "comparable_sales");

        HyperLandCore.AssessedValue[] memory history = core.getValuationHistory(1);
        assertEq(history.length, 1);
        assertEq(history[0].value, newValue);
    }

    function test_RevertWhen_SettingInvalidConstraints() public {
        vm.startPrank(admin);

        // Too low increase multiplier
        vm.expectRevert("Invalid increase multiplier");
        core.setValuationConstraints(1, 5, 1 days);

        // Too high increase multiplier
        vm.expectRevert("Invalid increase multiplier");
        core.setValuationConstraints(21, 5, 1 days);

        // Invalid interval (too short)
        vm.expectRevert("Invalid interval");
        core.setValuationConstraints(5, 5, 30 minutes);

        // Invalid interval (too long)
        vm.expectRevert("Invalid interval");
        core.setValuationConstraints(5, 5, 31 days);

        vm.stopPrank();
    }

    // ============================================
    // INTEGRATION TESTS
    // ============================================

    function test_MultipleAssessorsSubmittingValuations() public {
        // Register two assessors
        vm.startPrank(admin);
        core.registerAssessor(assessor1, "ipfs://QmAssessor1");
        core.registerAssessor(assessor2, "ipfs://QmAssessor2");
        vm.stopPrank();

        // Both submit valuations
        vm.prank(assessor1);
        core.submitValuation(1, 1200 * 10**18, "comparable_sales");

        vm.warp(block.timestamp + 1 days);
        vm.prank(assessor2);
        core.submitValuation(1, 1250 * 10**18, "auction_based");

        // Check history has both
        HyperLandCore.AssessedValue[] memory history = core.getValuationHistory(1);
        assertEq(history.length, 2);
        assertEq(history[0].assessor, assessor1);
        assertEq(history[1].assessor, assessor2);

        // Admin approves second valuation
        vm.prank(admin);
        core.approveValuation(1, 1);

        (uint256 assessedValue,,,,, ) = core.parcelStates(1);
        assertEq(assessedValue, 1250 * 10**18);
    }

    function test_LegacySetAssessedValueStillWorks() public {
        uint256 newValue = 2000 * 10**18;

        vm.prank(admin);
        core.setAssessedValue(1, newValue);

        (uint256 assessedValue,,,,, ) = core.parcelStates(1);
        assertEq(assessedValue, newValue);
    }
}
