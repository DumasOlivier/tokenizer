//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

// @newbieDev The MyNFT contract derives from both ERC721 and ERC721URIStorage. But the ERC721URIStorage also derives
// from the ERC721. Since Solidity doesn't have a dependency injection mechanism, it imports the ERC721 for the second time.
// This causes the _burn() and other methods to be redefined without the override keyword.
// https://stackoverflow.com/a/70148032/11824966
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Variables to send here :
// maxNFTSupply
// address of the musician
contract TokenizerAlbumNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // TODO : Send Name and Symbol variables from the Factory.
    constructor() ERC721("TokenizerAlbumNFT", "TKNZR") {}

    function mintAlbumCollection(address musician, string memory tokenURI)
        public
        returns (uint256)
    {
        // TODO : Make sure that musician exists.
        _tokenIds.increment();

        uint256 newAlbumId = _tokenIds.current();
        _mint(musician, newAlbumId);
        _setTokenURI(newAlbumId, tokenURI);

        return newAlbumId;
    }
}
