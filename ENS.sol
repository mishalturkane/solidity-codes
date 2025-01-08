// SPDX-License-Identifier: MIT
pragma solidity  0.8.26;

contract ENS{
      mapping (address => string) public users;

      function signUp(string memory userName)public {
            users[msg.sender]=userName;
      }

      function getName() public view returns (string memory){
        return users[msg.sender];

      }
      function getUserAddress()public view returns (address){
        return  msg.sender;
      }

      function getUserAddressByName(address userAddress) public view returns (string memory){
            if(msg.sender==userAddress){
                return users[msg.sender];
            }
            else {
                return "no user";
            }
      }
}
