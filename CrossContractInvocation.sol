// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract CallStorage{
   function setNumTo2(address addressAnotherContract)public {
    IStorage(addressAnotherContract).setNum(2);
   }
}
contract Storage {
    uint public number;
    function setNum(uint _number)public {
        number = _number ;
    }
   
}
interface  IStorage {
        function setNum (uint _num ) external ;
}
