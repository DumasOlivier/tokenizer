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

    address private artist;
    uint256 private maxNftSupply;
    string private albumURI;

    // TODO : Send Name and Symbol variables from the Factory.
    constructor(address _artist, uint256 _maxNftSupply, string memory _albumURI) ERC721("TokenizerAlbumNFT", "TKNZR") {
        artist = _artist;
        maxNftSupply = _maxNftSupply;
        albumURI = _albumURI;
    }

    // Function to mint one NFT by a Fan.
    function mintAlbumCollection(address fan)
        public
        returns (uint256)
    {
        require(_tokenIds.current() < maxNftSupply, "All the NFTs from this collection have already been minted.");
        _tokenIds.increment();

        uint256 newAlbumId = _tokenIds.current();
        _mint(fan, newAlbumId);
        _setTokenURI(newAlbumId, albumURI);

        return newAlbumId;
    }
}
