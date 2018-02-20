pragma solidity ^0.4.18;

contract DocumentRegistry {
    mapping (string=>uint256) documents;
    address private owner;

    modifier isOwner() {
        require(owner==msg.sender);
        _;
    }    

    function DocumentRegistry() public {
        owner = msg.sender;
    }

    function addDocument(string hash) public isOwner() returns(uint256 dateAdded) {
        dateAdded = block.timestamp;
        documents[hash] = dateAdded;
        return dateAdded;
    }

    function verifyDocument(string hash)public view returns(uint256) {
        return documents[hash];
    }
    
}