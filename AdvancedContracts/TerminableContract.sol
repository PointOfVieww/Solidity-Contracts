pragma solidity ^0.4.18;

contract MainContract {
    address internal owner;
    
    modifier isOwner() {
        require(owner==msg.sender);
        _;
    }
    function MainContract() public {
        owner = msg.sender;
    }
    function deposit() public payable {
        
    }
    function getBalance() public view returns(uint256) {
        return this.balance;
    }
}

contract TerminableContract is MainContract {
    function killContract() public isOwner() {
        selfdestruct(msg.sender);
    }
}