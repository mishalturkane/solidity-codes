// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventExample {
    // Step 1: Declare the event
    event UserRegistered(address indexed user, uint256 timestamp);

    // Step 2: Use the event in a function
    function registerUser() external {
        // Emit the event
        emit UserRegistered(msg.sender, block.timestamp);
    }

    // Example to demonstrate multiple events
    event FundsDeposited(address indexed user, uint256 amount, uint256 timestamp);

    function depositFunds() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        emit FundsDeposited(msg.sender, msg.value, block.timestamp);
    }
}
