// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract SimpleCounter {
    int public count = 0;

    function incrememtCounter() public {
        count = count + 1;
    }
    function decrememtCounter() public {
         count = count - 1;
    }
    function getCounter()public view returns(int ){
        return count;
    }
}
