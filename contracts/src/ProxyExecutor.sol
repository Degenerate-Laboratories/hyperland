// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IParcelSale {
    function transferCoreOwnership(address newOwner) external;
}

/**
 * @title ProxyExecutor
 * @dev Execute transferCoreOwnership on old ParcelSale (if it had the function)
 * Since it doesn't, we need to add it first or use a different approach
 */
contract ProxyExecutor {
    // Execute arbitrary call on behalf of this contract
    function execute(address target, bytes calldata data) external payable returns (bytes memory) {
        (bool success, bytes memory result) = target.call{value: msg.value}(data);
        require(success, "Execution failed");
        return result;
    }
}
