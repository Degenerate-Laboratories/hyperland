// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title LandDeed
 * @dev ERC-721 NFT representing land parcels in HyperLand
 * Each token represents a unique parcel with coordinates and size
 */
contract LandDeed is ERC721, Ownable {
    // Parcel metadata
    struct ParcelData {
        uint256 x;           // X coordinate
        uint256 y;           // Y coordinate
        uint256 size;        // Parcel size (e.g., 100 = 100x100)
        uint256 mintedAt;    // Timestamp when parcel was minted
    }

    // Mapping from token ID to parcel data
    mapping(uint256 => ParcelData) public parcels;

    // Mapping from coordinates to token ID (for coordinate uniqueness)
    mapping(uint256 => mapping(uint256 => uint256)) private coordinateToTokenId;

    // Counter for token IDs
    uint256 private _nextTokenId = 1;

    // Events
    event ParcelMinted(
        uint256 indexed tokenId,
        address indexed owner,
        uint256 x,
        uint256 y,
        uint256 size
    );

    /**
     * @dev Constructor sets the initial owner
     * @param initialOwner Address that will own the contract
     */
    constructor(address initialOwner)
        ERC721("HyperLand Deed", "DEED")
        Ownable(initialOwner)
    {
        require(initialOwner != address(0), "LandDeed: owner is zero address");
    }

    /**
     * @dev Mint a new land parcel
     * @param to Address to mint the parcel to
     * @param x X coordinate
     * @param y Y coordinate
     * @param size Size of the parcel
     * @return tokenId The ID of the newly minted parcel
     */
    function mint(
        address to,
        uint256 x,
        uint256 y,
        uint256 size
    ) external onlyOwner returns (uint256) {
        require(to != address(0), "LandDeed: mint to zero address");
        require(size > 0, "LandDeed: size must be greater than 0");
        require(
            coordinateToTokenId[x][y] == 0,
            "LandDeed: parcel already exists at coordinates"
        );

        uint256 tokenId = _nextTokenId++;

        // Store parcel data
        parcels[tokenId] = ParcelData({
            x: x,
            y: y,
            size: size,
            mintedAt: block.timestamp
        });

        // Map coordinates to token ID
        coordinateToTokenId[x][y] = tokenId;

        // Mint the NFT
        _safeMint(to, tokenId);

        emit ParcelMinted(tokenId, to, x, y, size);

        return tokenId;
    }

    /**
     * @dev Get parcel data for a token ID
     * @param tokenId The token ID to query
     * @return ParcelData struct containing x, y, size, and mintedAt
     */
    function getParcel(uint256 tokenId) external view returns (ParcelData memory) {
        require(ownerOf(tokenId) != address(0), "LandDeed: parcel does not exist");
        return parcels[tokenId];
    }

    /**
     * @dev Get token ID by coordinates
     * @param x X coordinate
     * @param y Y coordinate
     * @return tokenId The token ID at the coordinates (0 if none exists)
     */
    function getTokenIdByCoordinates(uint256 x, uint256 y) external view returns (uint256) {
        return coordinateToTokenId[x][y];
    }

    /**
     * @dev Check if a parcel exists at given coordinates
     * @param x X coordinate
     * @param y Y coordinate
     * @return bool True if parcel exists
     */
    function parcelExistsAt(uint256 x, uint256 y) external view returns (bool) {
        return coordinateToTokenId[x][y] != 0;
    }

    /**
     * @dev Get the next token ID that will be minted
     * @return uint256 The next token ID
     */
    function nextTokenId() external view returns (uint256) {
        return _nextTokenId;
    }

    /**
     * @dev Get total number of parcels minted
     * @return uint256 Total parcels
     */
    function totalSupply() external view returns (uint256) {
        return _nextTokenId - 1;
    }

    /**
     * @dev Override to return token URI with parcel metadata
     * @param tokenId Token ID to get URI for
     * @return string Token URI
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "LandDeed: URI query for nonexistent token");

        // In production, this would point to metadata API
        // For now, return a placeholder
        return string(abi.encodePacked("https://hyperland.io/parcel/", _toString(tokenId)));
    }

    /**
     * @dev Convert uint256 to string
     * @param value Value to convert
     * @return string String representation
     */
    function _toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
