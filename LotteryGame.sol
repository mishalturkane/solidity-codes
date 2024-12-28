// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LotteryGame {
    address public manager; // The manager who can control the lottery
    address[] public players; // List of players participating in the lottery

    // Event to announce the winner
    event WinnerAnnounced(address winner, uint amount);

    constructor() {
        manager = msg.sender; // The creator of the contract becomes the manager
    }

    // Modifier to restrict access to the manager
    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can call this function.");
        _;
    }

    // Function to join the lottery (payable to accept Ether)
    function enter() public payable {
        require(msg.value == 0.01 ether, "Entry fee is 0.01 Ether.");

        players.push(msg.sender); // Add the sender to the list of players
    }

    // Function to get the total number of players
    function getPlayersCount() public view returns (uint) {
        return players.length;
    }
function pickWinner() public onlyManager {
    require(players.length > 0, "No players in the lottery.");

    // Generate a pseudo-random index
    uint randomIndex = random() % players.length;
    address winner = players[randomIndex];

    // Transfer the total Ether balance to the winner
    uint prize = address(this).balance;
    payable(winner).transfer(prize);

    // Emit the winner announcement event
    emit WinnerAnnounced(winner, prize);

    // Reset the players array for the next round
}

    // Function to generate a pseudo-random number (not secure for production)
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players)));
    }

    // Function to get the contract's Ether balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to withdraw any remaining funds (only manager can call)
    function withdraw() public onlyManager {
        require(address(this).balance > 0, "No funds to withdraw.");
        payable(manager).transfer(address(this).balance);
    }
}
