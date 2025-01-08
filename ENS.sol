// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ENS {
    mapping(address => string) public users;

    function signUp(string memory userName) public {
        require(bytes(users[msg.sender]).length == 0, "Username already set");
        require(bytes(userName).length > 0, "Username cannot be empty");
        users[msg.sender] = userName;
    }

    function getName() public view returns (string memory) {
        require(bytes(users[msg.sender]).length > 0, "No username found");
        return users[msg.sender];
    }

    function getUserAddressByName(address userAddress) public view returns (string memory) {
        if (bytes(users[userAddress]).length > 0) {
            return users[userAddress];
        } else {
            return "No user found";
        }
    }
}
