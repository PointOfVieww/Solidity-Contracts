pragma solidity ^0.4.18;

contract ArrayOfFacts {

    string[] private facts;
    address private contractOwner = msg.sender;

    function addFact(string factToBeAdded) public {
        require(msg.sender == contractOwner);
        facts.push(factToBeAdded);
    }

    function factsCount() public view returns(uint256) {
        return facts.length;
    }

    function getFact(uint256 index) public view returns(string) {
        return facts[index];
    }
}