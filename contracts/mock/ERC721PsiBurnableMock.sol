// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '../extension/ERC721PsiBurnable.sol';
import "hardhat/console.sol";


contract ERC721PsiBurnableMock is ERC721PsiBurnable {
    constructor(string memory name_, string memory symbol_) ERC721Psi(name_, symbol_) {}


    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    function totalMinted() public view returns(uint256) {
        return super._totalMinted();
    }

    function numberMinted(address user) public view returns(uint256) {
        return balanceOf(user);
    }

    function totalBurned() external view returns (uint256){
        return _burned();
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function safeMint(address to, uint256 quantity) public {
        _safeMint(to, quantity);
    }

    function safeMint(
        address to,
        uint256 quantity,
        bytes memory data
    ) public {
        _safeMint(to, quantity, data);
    }

    function getBatchHead(
        uint256 tokenId
    ) public view {
        _getBatchHead(tokenId);
    }

    function burn(
        uint256 tokenId
    ) public {
        if (!_exists(tokenId)) revert OwnerQueryForNonexistentToken();
        if (!_isApprovedOrOwner(_msgSenderERC721Psi(), tokenId)) {
             revert TransferCallerNotOwnerNorApproved();
        }
        _burn(tokenId);
    }

    function benchmarkOwnerOf(uint256 tokenId) public view returns (address owner) {
        uint256 gasBefore = gasleft();
        owner = ownerOf(tokenId);
        uint256 gasAfter = gasleft();
        console.log(gasBefore - gasAfter);
    }

    function burn(uint256 start, uint256 num) public {
        uint256 end = start + num;
        for(uint256 i=start;i<end;i++){
            _burn(i);
        }
    }
}