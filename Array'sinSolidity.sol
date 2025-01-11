// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayContract {
    // Fixed-size array
    uint[3] public fixedArray = [1, 2, 3];

    // Dynamic-size array
    uint[] public dynamicArray;

    // Function to get an element from the fixed array
    function getFixedElement(uint index) public view returns (uint) {
        require(index < fixedArray.length, "Index out of bounds");
        return fixedArray[index];
    }

    // Function to add an element to the dynamic array
    function addToDynamicArray(uint num) public {
        dynamicArray.push(num);
    }

    // Function to remove the last element from the dynamic array
    function removeLastFromDynamicArray() public {
        require(dynamicArray.length > 0, "Dynamic array is empty");
        dynamicArray.pop();
    }

    // Function to get the size of the dynamic array
    function getDynamicArraySize() public view returns (uint) {
        return dynamicArray.length;
    }

    // Function to delete an element from the dynamic array (sets to default value)
    function deleteDynamicElement(uint index) public {
        require(index < dynamicArray.length, "Index out of bounds");
        delete dynamicArray[index];
    }

    // Example function to use memory array
    function createAndReturnMemoryArray() public pure returns (uint[] memory) {
        uint; // Create a memory array of size 3
        tempArray[0] = 10;
        tempArray[1] = 20;
        tempArray[2] = 30;
        return tempArray; // Return the memory array
    }
}
