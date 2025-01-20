// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Staking.sol";

contract StakingTest is Test {
    Staking staking;
    address user = address(1);
    uint256 initialRewardRate = 1e18;

    function setUp() public {
        staking = new Staking(initialRewardRate);
    }

    function testStake() public {
        vm.deal(user, 10 ether);

        vm.startPrank(user);
        staking.stake{value: 1 ether}();
        vm.stopPrank();

        assertEq(staking.balances(user), 1 ether);
        assertEq(staking.totalStaked(), 1 ether);
    }

    function testWithdraw() public {
        vm.deal(user, 10 ether);

        vm.startPrank(user);
        staking.stake{value: 1 ether}();
        uint256 rewards = staking.calculateRewards(user);
        staking.withdraw();
        vm.stopPrank();

        assertEq(staking.balances(user), 0);
        assertEq(staking.totalStaked(), 0);
        assertEq(user.balance, 10 ether + rewards - 1 ether);
    }

    function testCalculateRewards() public {
        vm.deal(user, 10 ether);

        vm.startPrank(user);
        staking.stake{value: 1 ether}();
        vm.warp(block.timestamp + 1 days); // Simulate time passing
        uint256 rewards = staking.calculateRewards(user);
        vm.stop
