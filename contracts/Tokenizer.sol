//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Tokenizer {
    uint16 public constant maxNftSupplyPerAlbum = 10000;
    uint256 public musiciansCounter = 0;
    string public registerFee = '0.01';
    struct Musician {
        string name;
    }
    mapping(address => Musician) public addressToMusician;
    struct Album {
        string title;
        uint16 maxNftSupply;
    }
    mapping(uint256 => Album) public albumToMusician;

    constructor() {}

    function registerMusician(string memory _name) public {
        // Require musician to have paid the register fee.
        // Save a musician address into the musicians array.
        addressToMusician[msg.sender] = Musician(_name);
        musiciansCounter++;
    }

    function updateRegisterFee() public {
        // Only accessible by the owner of this contract.
    }

    function getMusician(address _musicianAddress) public view returns(Musician memory){
        return addressToMusician[_musicianAddress];
    }
}
