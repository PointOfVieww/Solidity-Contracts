pragma solidity ^0.4.18;

contract EventContract {
    event ShowAddress(address);
    address private owner;

    function EventContract() public {
        owner = msg.sender;
    }

    function showAddress() public {
        ShowAddress(owner);
    }
}