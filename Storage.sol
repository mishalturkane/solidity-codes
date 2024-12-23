// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Storgae{
    uint public number ;

    constructor(){
        number = 0;
    }

    function add()public  {
        number = number + 1;
    }
}
