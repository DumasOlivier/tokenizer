//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Tokenizer {
    uint16 public constant maxNftSupplyPerAlbum = 10000;
    string public registerFee = '0.01'; // TODO : This must be updatable by Owner.
    struct Musician {
        string name;
        address wallet;
    }
    Musician[] public musicians;
    struct Album {
        string title;
        uint16 maxNftSupply;
    }
    mapping(uint256 => Album) public albumToArtist;

    constructor() {}

    function registerMusician(string memory _name, address _musicianAddress) public {
        // Require musician to have paid the register fee.
        // Save a musician address into the musicians array.
        musicians.push(Musician(_name, _musicianAddress));
    }

    function updateRegisterFee() public {
        // Only accessible by the owner of this contract.
    }

    function getMusiciansCount() public view returns(uint){
        return musicians.length;
    }

    function getMusician(uint256 _index) public view returns(Musician memory){
        return musicians[_index];
    }
}
