// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title LANDToken
 * @dev ERC-20 token for the HyperLand ecosystem
 * Fixed supply of 21,000,000 tokens issued to admin on deployment
 */
contract LANDToken is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 21_000_000 * 10**18; // 21 million tokens with 18 decimals

    /**
     * @dev Constructor mints entire supply to admin address
     * @param admin Address to receive initial token supply
     */
    constructor(address admin) ERC20("LAND Token", "LAND") Ownable(admin) {
        require(admin != address(0), "LANDToken: admin is zero address");
        _mint(admin, TOTAL_SUPPLY);
    }

    /**
     * @dev Returns the number of decimals used for token amounts
     */
    function decimals() public pure override returns (uint8) {
        return 18;
    }
}
