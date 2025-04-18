// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "../interfaces/IERC4907.sol";

abstract contract ERC4907Upgradable is ERC721Upgradeable, IERC4907 {
    struct UserInfo {
        address user;
        uint256 expires;
    }
    mapping(uint256 => UserInfo) internal users;

    // constructor(
    //     string memory _name,
    //     string memory _symbol
    // ) ERC721(_name, _symbol) {}

    function _isApprovedOrOwner(
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner ||
            isApprovedForAll(owner, spender) ||
            getApproved(tokenId) == spender);
    }

    function setUser(uint256 tokenId, address _user, uint64 expires) external {
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "ERC4907: transfer caller is not owner nor approved"
        );
        UserInfo storage info = users[tokenId];
        info.user = _user;
        info.expires = block.timestamp + expires;
        emit UpdateUser(tokenId, _user, expires);
    }

    function userOf(uint256 _tokenId) public view returns (address) {
        if (block.timestamp <= users[_tokenId].expires) {
            return users[_tokenId].user;
        }
        return address(0);
    }

    function userExpires(uint256 _tokenId) public view returns (uint256) {
        return users[_tokenId].expires;
    }

    function supportInterface(bytes4 _interfaceId) public view returns (bool) {
        return
            (_interfaceId == 0xad092b5c) ||
            super.supportsInterface(_interfaceId);
    }
}
