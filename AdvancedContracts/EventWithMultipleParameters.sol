pragma solidity ^0.4.18;

contract MultipleParamEvent {
    event ShowInformation(string,address);

    function showInformation(string stringForEvent,address addrToShow) public {
        ShowInformation(stringForEvent,addrToShow);
    }
}