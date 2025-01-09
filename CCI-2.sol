// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
interface IMessageContract {

    function setMessage(string memory newMessage) external ;
    function getMessage()external view returns (string memory);
    
}

contract ParentContract{
    address private  contractadddress;
    constructor(address _contractaddress){
            contractadddress = _contractaddress;
    }

    function setMessageFromAnotherContract(string memory newMessage)public {
        IMessageContract(contractadddress).setMessage(newMessage);
    }
    function getMessageFromAnotheeContract()public view returns (string memory){
        return  IMessageContract(contractadddress).getMessage();
    }
}

//message 0x49E04b199586A53334CB141d29D7B0220acE6e39
