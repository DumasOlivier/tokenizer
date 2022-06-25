//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

string constant name = 'TokenizerAlbumNFT';
string constant symbol = 'TKNZR';

contract TokenizerAlbumNFT is ERC721Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public ERC721Full(name, symbol) {}

    function mintAlbumCollection(address musician, string memory tokenURI) public returns (uint256) {
        // TODO : Make sure that musician exists.
        _tokenIds.increment();

        uint256 newAlbumId = _tokenIds.current();
        _mint(musician, newAlbumId);
        _setTokenURI(newAlbumId, tokenURI);

        return newAlbumId;
    }
}
