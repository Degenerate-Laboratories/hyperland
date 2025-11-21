// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/LANDToken.sol";

contract LANDTokenTest is Test {
    LANDToken public land;
    address public admin = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    uint256 constant TOTAL_SUPPLY = 21_000_000 * 10**18;

    function setUp() public {
        land = new LANDToken(admin);
    }

    function testInitialSupply() public view {
        assertEq(land.totalSupply(), TOTAL_SUPPLY);
        assertEq(land.balanceOf(admin), TOTAL_SUPPLY);
    }

    function testTokenMetadata() public view {
        assertEq(land.name(), "LAND Token");
        assertEq(land.symbol(), "LAND");
        assertEq(land.decimals(), 18);
    }

    function testAdminOwnership() public view {
        assertEq(land.owner(), admin);
    }

    function testTransfer() public {
        vm.startPrank(admin);

        uint256 transferAmount = 1000 * 10**18;
        land.transfer(user1, transferAmount);

        assertEq(land.balanceOf(user1), transferAmount);
        assertEq(land.balanceOf(admin), TOTAL_SUPPLY - transferAmount);

        vm.stopPrank();
    }

    function testTransferFrom() public {
        vm.startPrank(admin);

        uint256 approvalAmount = 5000 * 10**18;
        land.approve(user1, approvalAmount);

        vm.stopPrank();

        vm.startPrank(user1);

        uint256 transferAmount = 2000 * 10**18;
        land.transferFrom(admin, user2, transferAmount);

        assertEq(land.balanceOf(user2), transferAmount);
        assertEq(land.allowance(admin, user1), approvalAmount - transferAmount);

        vm.stopPrank();
    }

    function testRevertWhenTransferInsufficientBalance() public {
        vm.startPrank(user1);
        vm.expectRevert();
        land.transfer(user2, 1000 * 10**18);
        vm.stopPrank();
    }

    function testRevertWhenTransferFromWithoutApproval() public {
        vm.startPrank(user1);
        vm.expectRevert();
        land.transferFrom(admin, user2, 1000 * 10**18);
        vm.stopPrank();
    }

    function testRevertWhenConstructorZeroAddress() public {
        vm.expectRevert();
        new LANDToken(address(0));
    }

    function testMultipleTransfers() public {
        vm.startPrank(admin);

        land.transfer(user1, 10000 * 10**18);
        land.transfer(user2, 5000 * 10**18);

        assertEq(land.balanceOf(user1), 10000 * 10**18);
        assertEq(land.balanceOf(user2), 5000 * 10**18);
        assertEq(land.balanceOf(admin), TOTAL_SUPPLY - 15000 * 10**18);

        vm.stopPrank();
    }

    function testApprove() public {
        vm.startPrank(admin);

        uint256 approvalAmount = 100000 * 10**18;
        land.approve(user1, approvalAmount);

        assertEq(land.allowance(admin, user1), approvalAmount);

        vm.stopPrank();
    }
}
