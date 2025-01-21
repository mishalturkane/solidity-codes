// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenBridge {
    address public admin;
    address public token;

    event TokensLocked(address indexed user, uint256 amount, string targetAddress);

    constructor(address _token) {
        admin = msg.sender;
        token = _token;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function lockTokens(uint256 amount, string memory targetAddress) external {
        require(amount > 0, "Amount must be greater than zero");

        // Transfer the tokens from the user to the contract
        IERC20(token).transferFrom(msg.sender, address(this), amount);

        // Emit an event for the relayer to pick up
        emit TokensLocked(msg.sender, amount, targetAddress);
    }

    function withdrawTokens(uint256 amount, address recipient) external onlyAdmin {
        require(amount > 0, "Amount must be greater than zero");

        // Transfer the tokens from the contract to the recipient
        IERC20(token).transfer(recipient, amount);
    }
}

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount) external returns (bool);
}
