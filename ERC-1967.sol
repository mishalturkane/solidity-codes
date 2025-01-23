// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/StorageSlot.sol";

contract StorageProxy {
    uint public num;
    uint public num2;
    bytes32 internal constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;


    constructor(address _implementation) {
        setImplementation(_implementation);
    }

    fallback() external {
        
        (bool success, ) = getImplementation().delegatecall(msg.data);

        if (!success) {
            revert();
        }
    }

    function getImplementation() internal view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function setImplementation(address _implementation) public {
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }
}

contract ImplementationV1 {
    uint public num;
    address implementation; // 1919191919191
    uint public num2;

    function setNum(uint _num) public {
        num = _num;
    }
}

contract ImplementationV2 {
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }

    function putNum(uint _num) public {
        num = 2 * _num;
    }
}

contract ImplementationV3 {
    uint public num;

    function setNum(uint _num) public {
        num = _num;
    }

    function putNum(uint _num) public {
        num = 2 * _num;
    }

    function deleteNum(uint _num) public {
        num = 2 * _num;
    }
}
