// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Demo is Ownable {
    uint256 private number;

    constructor() Ownable(msg.sender) {
        number = 0;
    }

    function add(uint _number) public  onlyOwner{
        number +=_number;
    }
    function getNumber()public view returns(uint){
        return number;
    }
}
