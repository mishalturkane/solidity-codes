// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EthStaking {
    struct Stake {
        uint256 amount;       // Amount of ETH staked
        uint256 startTime;    // Timestamp of when the staking started
    }

    mapping(address => Stake) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate; // Reward rate in percentage (e.g., 10 for 10%)
    address public owner;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);
    event RewardRateUpdated(uint256 newRate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(uint256 _rewardRate) {
        owner = msg.sender;
        rewardRate = _rewardRate;
    }

    // Function to allow users to stake ETH
    function stake() external payable {
        require(msg.value > 0, "Stake amount must be greater than 0");

        // Calculate and update the reward for the existing stake
        if (stakes[msg.sender].amount > 0) {
            rewards[msg.sender] += calculateReward(msg.sender);
        }

        // Update staking data
        stakes[msg.sender].amount += msg.value;
        stakes[msg.sender].startTime = block.timestamp;

        emit Staked(msg.sender, msg.value);
    }

    // Function to calculate rewards
    function calculateReward(address _staker) internal view returns (uint256) {
        Stake memory userStake = stakes[_staker];
        if (userStake.amount == 0 || userStake.startTime == 0) return 0;

        uint256 stakingDuration = block.timestamp - userStake.startTime;
        uint256 reward = (userStake.amount * rewardRate * stakingDuration) / (365 days * 100);
        return reward;
    }

    // Function to unstake ETH and claim rewards
    function unstake() external {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No ETH staked");

        uint256 reward = rewards[msg.sender] + calculateReward(msg.sender);
        uint256 totalAmount = userStake.amount + reward;

        // Reset user data
        delete stakes[msg.sender];
        delete rewards[msg.sender];

        // Transfer ETH and rewards to the user
        payable(msg.sender).transfer(totalAmount);

        emit Unstaked(msg.sender, userStake.amount, reward);
    }

    // Function to update the reward rate
    function updateRewardRate(uint256 _newRate) external onlyOwner {
        rewardRate = _newRate;
        emit RewardRateUpdated(_newRate);
    }

    // Fallback function to accept ETH sent directly to the contract
    receive() external payable {}

    // Function to withdraw contract balance (onlyOwner)
    function withdrawContractBalance() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Function to get the total rewards of a user
    function getTotalRewards(address _user) external view returns (uint256) {
        return rewards[_user] + calculateReward(_user);
    }
}
