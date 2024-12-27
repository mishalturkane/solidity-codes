// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ModifierExample {
    address public owner;

    // Constructor sets the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function restricted to the owner using the modifier
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // Public function accessible by anyone
    function getOwner() public view returns (address) {
        return owner;
    }
}
