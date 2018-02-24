pragma solidity ^0.4.18;

contract MetaCoinStorage {
    mapping (address => uint) balances;

    mapping (address => bool) accessAllowed;

    function MetaCoinStorage() public {
        accessAllowed[msg.sender] = true;
        balances[tx.origin] = 10000;
    }

    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }

    function allowAddress(address _address) public platform() {
        accessAllowed[_address] = true;
    }

    function denyAccess(address _address) public platform() {
        accessAllowed[_address] = false;
    }

    function getBalance(address _address) public view returns(uint256) {
        return balances[_address];
    }

    function setBalance(address _address,uint balance) public platform() {
        balances[_address] = balance;
    }
}