// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract RandomNameWinner {
    string[] private namePool = ["Alice", "Bob", "Charlie", "David", "Eve"];
    mapping(address => string) public participants;
    address[] private participantAddresses;

    address public owner;
    string public winnerName;
    address public winnerAddress;

    constructor() {
        owner = msg.sender;
    }

    // Join the game and get a random name
    function joinGame() public {
        require(bytes(participants[msg.sender]).length == 0, "You have already joined!");
        
        // Generate random index for name
        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, participantAddresses.length))) % namePool.length;
        string memory assignedName = namePool[randomIndex];
        
        participants[msg.sender] = assignedName;
        participantAddresses.push(msg.sender);
    }

    // Pick a winner (only owner can call this)
    function pickWinner() public {
        require(msg.sender == owner, "Only the owner can pick the winner");
        require(participantAddresses.length > 0, "No participants to pick a winner");

        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, participantAddresses.length))) % participantAddresses.length;
        winnerAddress = participantAddresses[randomIndex];
        winnerName = participants[winnerAddress];
    }

    // Get participant's assigned name
    function getMyName() public view returns (string memory) {
        require(bytes(participants[msg.sender]).length > 0, "You have not joined the game");
        return participants[msg.sender];
    }

    // Get total participants count
    function getTotalParticipants() public view returns (uint) {
        return participantAddresses.length;
    }
}
