// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LockCoin {
    address public owner;

    struct LockInfo {
        uint256 amount;
        address receiver;
        bool released;
    }

    mapping(address => LockInfo[]) public lockedFunds;

    event Locked(address indexed sender, address indexed receiver, uint256 amount);
    event Released(address indexed receiver, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to lock coins
    function lock(address _receiver) external payable {
        require(msg.value > 0, "Must lock a positive amount");
        
        lockedFunds[msg.sender].push(LockInfo({
            amount: msg.value,
            receiver: _receiver,
            released: false
        }));

        emit Locked(msg.sender, _receiver, msg.value);
    }

    // Function to release locked coins (only owner can call this)
    function release(address _sender, uint256 _index) external onlyOwner {
        LockInfo storage lockInfo = lockedFunds[_sender][_index];
        require(!lockInfo.released, "Already released");

        lockInfo.released = true;
        payable(lockInfo.receiver).transfer(lockInfo.amount);

        emit Released(lockInfo.receiver, lockInfo.amount);
    }

    // Function to get details of locked funds
    function getLockedFunds(address _sender) external view returns (LockInfo[] memory) {
        return lockedFunds[_sender];
    }

    // Owner-only function to withdraw accidental contract balance
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        payable(owner).transfer(balance);
    }
}
