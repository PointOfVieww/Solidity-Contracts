pragma solidity ^0.4.18;

contract PayableContract {

    address private owner;
    function PayableContract() public {
        owner = msg.sender;
    }
    
    function depositToContract() public payable {
        
    }

    function getBalanceOfContract() public view returns (uint256) {
        require(owner==msg.sender);
        return this.balance;
    }
}