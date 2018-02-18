pragma solidity ^0.4.18;

contract Incrementor {
    
    uint256 private valueToBeIncremented;

    function incrementValue(uint256 value) public {
        valueToBeIncremented += value;
    }

    function getIncrementedValue() public view returns (uint256) {
        return valueToBeIncremented;
    }
}