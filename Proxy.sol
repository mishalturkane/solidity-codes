pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    fallback() external payable {
        // Forward the call to the implementation contract
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }
}

contract ImplementationV1 {
    uint public num;
    address public implementation;

    function setNum(uint _num) public {
        num = _num;
    }
}
