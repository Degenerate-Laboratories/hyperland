// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IOwnable {
    function transferOwnership(address newOwner) external;
    function owner() external view returns (address);
}

/**
 * @title OwnershipHelper
 * @dev Simple helper to transfer ownership of HyperLandCore from old ParcelSale to new one
 */
contract OwnershipHelper {
    function transferOwnership(address target, address newOwner) external {
        IOwnable(target).transferOwnership(newOwner);
    }
}
