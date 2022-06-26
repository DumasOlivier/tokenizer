//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "./TokenizerAlbumNFT.sol";

contract Tokenizer is Ownable {
    uint256 public constant maxNftSupplyPerAlbum = 10000;
    uint256 public musiciansCounter = 0;
    uint256 public albumsCounter = 0;
    string public registerFee = '0.01';
    struct Musician {
        string name;
        uint256 albumsCounter;
    }
    mapping(address => Musician) public addressToMusician;
    address[] public musiciansAddresses;
    struct Album {
        string title;
        uint256 maxNftSupply;
        address nftCollection;
    }
    mapping(address => Album[]) public addressToAlbums;

    // Events
    event RegisterMusician(address indexed _from, string _name);
    event CreateAlbum(address indexed _from, string _title, uint256 _maxNftSupply, address newTokenizerAlbumNFTContract);

    constructor() {}

    function createAlbum(string memory _title, uint256 _maxNftSupply, string memory albumURI) public {
        // TODO: Require that the musician is registered.
        require(bytes(addressToMusician[msg.sender].name).length > 0, "This musician does not exist.");
        require(_maxNftSupply <= maxNftSupplyPerAlbum);
        addressToMusician[msg.sender].albumsCounter++;
        albumsCounter++;

        // Deploy the associated NFT contract for this NFT collection.
        address newTokenizerAlbumNFTContract = address(new TokenizerAlbumNFT(msg.sender, _maxNftSupply, albumURI));
        // TODO: Create the album page from the front-end
        // Add the albums' metadata to the NFTs from the front-end.
        addressToAlbums[msg.sender].push(Album(_title, _maxNftSupply, newTokenizerAlbumNFTContract));
        emit CreateAlbum(msg.sender, _title, _maxNftSupply, newTokenizerAlbumNFTContract);
    }

    function registerMusician(string memory _name) public {
        require(bytes(addressToMusician[msg.sender].name).length == 0, "You have already created a musician.");
        musiciansCounter++;

        addressToMusician[msg.sender] = Musician(_name, 0);
        musiciansAddresses.push(msg.sender);
        emit RegisterMusician(msg.sender, _name);
    }

    function updateRegisterFee() public onlyOwner() {
        // Only accessible by the owner of this contract.
    }

    function getMusician(address _musicianAddress) public view returns(Musician memory){
        return addressToMusician[_musicianAddress];
    }
}
