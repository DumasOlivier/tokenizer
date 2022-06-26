//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract Factory {
    address[] newContracts;

    function createContract(bytes32 name) public {
        //    address newContract = new Contract(name);
        //    newContracts.push(newContract);
    }
}
