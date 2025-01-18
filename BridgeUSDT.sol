// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract USDTBridge {
    address public admin;
    IERC20 public usdt;

    event TokensLocked(address indexed user, uint256 amount, string solanaAddress);

    constructor(address _usdtAddress) {
        admin = msg.sender;
        usdt = IERC20(_usdtAddress);
    }

    function lockTokens(uint256 amount, string memory solanaAddress) external {
        require(amount > 0, "Amount must be greater than zero");

        // Transfer USDT tokens from the user to this contract
        require(usdt.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        emit TokensLocked(msg.sender, amount, solanaAddress);
    }

    function withdraw(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin can withdraw");
        require(usdt.balanceOf(address(this)) >= amount, "Insufficient balance");

        usdt.transfer(to, amount);
    }
}
