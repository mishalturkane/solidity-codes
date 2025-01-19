// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract TokenVault is Ownable, Pausable {
    IERC20 public token;

    // Mapping to track balances
    mapping(address => uint256) public balances;

    // Events for deposit and withdrawal
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Constructor to initialize the ERC20 token address
    constructor(address _token) {
        token = IERC20(_token);
    }

    // Modifier to ensure that only the owner can withdraw
    modifier onlyOwner() {
        require(owner() == msg.sender, "You are not the owner");
        _;
    }

    // Deposit tokens into the vault
    function deposit(uint256 amount) external whenNotPaused {
        require(amount > 0, "Deposit amount must be greater than 0");

        // Transfer tokens from sender to the contract
        token.transferFrom(msg.sender, address(this), amount);
        
        // Update user's balance
        balances[msg.sender] += amount;

        // Emit deposit event
        emit Deposited(msg.sender, amount);
    }

    // Withdraw tokens from the vault (only owner can withdraw)
    function withdraw(uint256 amount) external onlyOwner whenNotPaused {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[owner()] >= amount, "Insufficient balance");

        // Reduce balance
        balances[owner()] -= amount;

        // Transfer tokens to owner
        token.transfer(owner(), amount);

        // Emit withdrawal event
        emit Withdrawn(owner(), amount);
    }

    // Emergency stop function to pause the contract (only owner can call)
    function pause() external onlyOwner {
        _pause();
    }

    // Unpause the contract
    function unpause() external onlyOwner {
        _unpause();
    }

    // View function to check the vault's token balance
    function vaultBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }
}
