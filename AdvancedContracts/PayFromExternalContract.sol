pragma solidity ^0.4.18;

contract ExternalContract {
    address private owner;
    function ExternalContract() public {
        owner = msg.sender;
    }
    modifier isOwner() {
        require(owner==msg.sender);
        _;
    }

    function getBalance() public view isOwner() returns (uint256) {
        return this.balance;
    }
    function deposit() public payable {
        
    }
    function sendBalance(address addrToReceive) public isOwner() {

        selfdestruct(addrToReceive);
    }

}

contract NonPayable {
    address private owner;
    function NonPayable() public {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner==msg.sender);
        _;
    }

    function getBalance() isOwner() public view returns (uint256) {
        return this.balance;
    }

}