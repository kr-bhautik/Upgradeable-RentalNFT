// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./ERC4907.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract RentalNFTUpgraded is Initializable, ERC4907Upgradable, OwnableUpgradeable {
    
    function initialize(string memory _name, string memory _symbol) public initializer{
        // ERC4907Upgradable.initialize(_name, _symbol);
        __ERC721_init(_name, _symbol);
        __Ownable_init(msg.sender);
    }

    event Minted(address indexed user, uint256 tokenId);

    function mint(uint256 _tokenId, address _to) public onlyOwner {
        _mint(_to, _tokenId);
        emit Minted(_to, _tokenId);
    }

    function supportsInterface(bytes4 _interfaceId)
        public
        view
        override
        returns (bool)
    {
        return super.supportsInterface(_interfaceId);
    }

    // Upgraded functionality.
    function transferFrom(address from, address to, uint256 tokenId) public override {
        require(users[tokenId].expires <= block.timestamp, "Tokens are on Rent. Can't transfer.");
        super.transferFrom(from, to, tokenId);
        delete users[tokenId];
        emit UpdateUser(tokenId, users[tokenId].user, uint64(users[tokenId].expires));
    }
}