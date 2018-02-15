pragma solidity ^0.4.18;

contract PreviousInvoker {
    address private previousInvoker;

    //function PreviousInvoker() public {
    //    previousInvoker = msg.sender;
    //}

    function getPreviousInvoker() public returns (bool,address) {
        address result = previousInvoker;
        previousInvoker = msg.sender;
        return(result != 0x0,result);
    }
}