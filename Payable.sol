// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayableExample {
    uint256 public totalAmount;

    function deposit() public payable {
        totalAmount += msg.value;
    }

    function drain(address payable _address) public {
        payable(_address).transfer(totalAmount);
    }
}
