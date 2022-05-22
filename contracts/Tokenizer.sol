//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Tokenizer {
    uint256 public constant maxNftSupplyPerAlbum = 10000;
    uint256 public musiciansCounter = 0;
    uint256 public albumsCounter = 0;
    string public registerFee = '0.01';
    struct Musician {
        string name;
        uint256 albumsCounter;
    }
    mapping(address => Musician) public addressToMusician;
    struct Album {
        string title;
        uint256 maxNftSupply;
    }
    mapping(address => Album[]) public addressToAlbums;

    // Events
    event RegisterMusician(address indexed _from, string _name);
    event CreateAlbum(address indexed _from, string _title, uint256 _maxNftSupply);

    constructor() {}

    function createAlbum(string memory _title, uint256 _maxNftSupply) public {
        // TODO: Require that the musician is registered.
        require(_maxNftSupply <= maxNftSupplyPerAlbum);

        addressToAlbums[msg.sender].push(Album(_title, _maxNftSupply));
        addressToMusician[msg.sender].albumsCounter ++;
        albumsCounter++;
        emit CreateAlbum(msg.sender, _title, _maxNftSupply);
    }

    function registerMusician(string memory _name) public {
        require(bytes(addressToMusician[msg.sender].name).length == 0, "You have already created a musician.");

        addressToMusician[msg.sender] = Musician(_name, 0);
        musiciansCounter++;
        emit RegisterMusician(msg.sender, _name);
    }

    function updateRegisterFee() public {
        // Only accessible by the owner of this contract.
    }

    function getMusician(address _musicianAddress) public view returns(Musician memory){
        return addressToMusician[_musicianAddress];
    }
}
