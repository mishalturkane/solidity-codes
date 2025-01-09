// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Will{
        address   owner;
        address payable   recipient;
        uint  startTime;
        uint public  tenYears;
        uint public  lastVisited;

        constructor(address payable  _recipient){
            owner = msg.sender;
            recipient = _recipient;
            startTime = block.timestamp;
            lastVisited = block.timestamp;
            tenYears = 1 minutes;
        }

        modifier onlyOwner(){
            require(msg.sender == owner);
            _;
        }
        modifier  onlyRecipient(){
            require(msg.sender == recipient);
            _;
        }

        function deposit()public payable  onlyOwner {
            lastVisited = block.timestamp;
        }

    
        function ping()public onlyOwner{
                lastVisited = block.timestamp;
        }

        function claim() external onlyRecipient{
            require(lastVisited < block.timestamp -tenYears);
            payable(recipient).transfer(address(this).balance);
        }

}

