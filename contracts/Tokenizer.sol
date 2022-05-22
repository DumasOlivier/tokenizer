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
    mapping(address => Musician) public addressToMusicians;
    struct Album {
        string title;
        uint16 maxNftSupply;
    }
    mapping(uint256 => Album) public albumToMusician;

    // Events
    event RegisterMusician(address indexed _from, string name);

    constructor() {}

    function registerMusician(string memory _name) public {
        require(bytes(addressToMusicians[msg.sender].name).length == 0, "You have already created a musician.");
        // TODO : Require musician to have paid the register fee.
        addressToMusicians[msg.sender] = Musician(_name);
        musiciansCounter++;
        emit RegisterMusician(msg.sender, _name);
    }

    function updateRegisterFee() public {
        // Only accessible by the owner of this contract.
    }

    function getMusician(address _musicianAddress) public view returns(Musician memory){
        return addressToMusicians[_musicianAddress];
    }
}
