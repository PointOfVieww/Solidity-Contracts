pragma solidity ^0.4.18;

contract ExampleContract {
    address private owner;

    function ExampleContract() public {
        owner = msg.sender;
    }
    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }
    function deposit() public payable {
        
    }
    function getBalance() public view isOwner() returns(uint256) {
        return this.balance;
    }

    function sendEthers(address addrToReceive,uint256 amount) public {
        assert(amount<=this.balance);
        addrToReceive.transfer(amount);
    }
}

contract ContractToReceiveEther {
    address private owner;
    
    function ContractToReceiveEther() public {
        owner = msg.sender;
    }
    
    function getBalance() public view returns(uint256) {
        return this.balance;
    }

    //creating fallback func so we can send ether to contract
    function() public payable {
        
    }

}