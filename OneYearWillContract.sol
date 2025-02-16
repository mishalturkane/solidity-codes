
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OneYearContract {

    uint256 public startTime;
    uint256 public constant ONE_YEAR = 365 days; // 1 year in seconds
    
    // Contract events
    event ContractActivated(uint256 startTime);
    event ContractExpired(uint256 expiryTime);

    constructor() {
        // Set the start time as the deployment time
        startTime = block.timestamp;
        
        // Emit event for activation
        emit ContractActivated(startTime);
    }

    modifier onlyDuringActivePeriod() {
        // Ensure that the current time is within the 1-year period
        require(block.timestamp <= startTime + ONE_YEAR, "Contract has expired.");
        _;
    }

    modifier onlyAfterExpiration() {
        // Ensure that the current time is after the 1-year period
        require(block.timestamp > startTime + ONE_YEAR, "Contract is still active.");
        _;
    }

    // Function to check if the contract is still active
    function isContractActive() public view returns (bool) {
        return block.timestamp <= startTime + ONE_YEAR;
    }

    // Example of a function that can be used only during the active period
    function performAction() public onlyDuringActivePeriod {
        // Code that should be executed while the contract is still active
    }

    // Example of a function that can be used only after expiration
    function contractHasExpired() public view onlyAfterExpiration returns (bool) {
        return true;
    }

    // Function to retrieve the time remaining for contract expiration
    function timeRemaining() public view returns (uint256) {
        if (block.timestamp > startTime + ONE_YEAR) {
            return 0;
        }
        return (startTime + ONE_YEAR) - block.timestamp;
    }
    
    // Function to manually expire the contract (optional)
    function expireContract() public onlyAfterExpiration {
        emit ContractExpired(block.timestamp);
    }
}
