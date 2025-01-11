// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    uint256 public myNumber;

    // Constructor to initialize the state variable
    constructor(uint256 _initialNumber) {
        myNumber = _initialNumber;
    }

    // View function: Reads the state variable 'myNumber'
    function getMyNumber() public view returns (uint256) {
        return myNumber; // Reads state variable
    }

    // Pure function: Does not read or modify the state, performs a mathematical operation
    function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b; // No state access
    }
}
