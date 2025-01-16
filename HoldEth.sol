// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EthHolder {
    // Mapping to store the balance of each user
    mapping(address => uint256) public balances;

    // Event to log deposits
    event Deposited(address indexed user, uint256 amount);

    // Event to log withdrawals
    event Withdrawn(address indexed user, uint256 amount);

    // Deposit function to allow users to send ETH to the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw function to allow users to withdraw their ETH balance
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Function to check the balance of the caller
    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
