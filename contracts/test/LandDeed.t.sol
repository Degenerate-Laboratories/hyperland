// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/LandDeed.sol";

contract LandDeedTest is Test {
    LandDeed public deed;
    address public owner = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    function setUp() public {
        deed = new LandDeed(owner);
    }

    function testMintParcel() public {
        vm.startPrank(owner);

        uint256 tokenId = deed.mint(user1, 100, 200, 50);

        assertEq(tokenId, 1);
        assertEq(deed.ownerOf(tokenId), user1);

        LandDeed.ParcelData memory parcel = deed.getParcel(tokenId);
        assertEq(parcel.x, 100);
        assertEq(parcel.y, 200);
        assertEq(parcel.size, 50);

        vm.stopPrank();
    }

    function testCannotMintDuplicateCoordinates() public {
        vm.startPrank(owner);

        deed.mint(user1, 100, 200, 50);

        vm.expectRevert("LandDeed: parcel already exists at coordinates");
        deed.mint(user2, 100, 200, 50);

        vm.stopPrank();
    }

    function testGetTokenIdByCoordinates() public {
        vm.startPrank(owner);

        uint256 tokenId = deed.mint(user1, 100, 200, 50);
        uint256 foundTokenId = deed.getTokenIdByCoordinates(100, 200);

        assertEq(foundTokenId, tokenId);

        vm.stopPrank();
    }

    function testParcelExistsAt() public {
        vm.startPrank(owner);

        assertFalse(deed.parcelExistsAt(100, 200));

        deed.mint(user1, 100, 200, 50);

        assertTrue(deed.parcelExistsAt(100, 200));

        vm.stopPrank();
    }

    function testOnlyOwnerCanMint() public {
        vm.startPrank(user1);

        vm.expectRevert();
        deed.mint(user2, 100, 200, 50);

        vm.stopPrank();
    }

    function testTransferParcel() public {
        vm.prank(owner);
        uint256 tokenId = deed.mint(user1, 100, 200, 50);

        vm.startPrank(user1);
        deed.transferFrom(user1, user2, tokenId);
        vm.stopPrank();

        assertEq(deed.ownerOf(tokenId), user2);
    }

    function testTotalSupply() public {
        vm.startPrank(owner);

        assertEq(deed.totalSupply(), 0);

        deed.mint(user1, 100, 200, 50);
        assertEq(deed.totalSupply(), 1);

        deed.mint(user1, 200, 300, 75);
        assertEq(deed.totalSupply(), 2);

        vm.stopPrank();
    }
}
