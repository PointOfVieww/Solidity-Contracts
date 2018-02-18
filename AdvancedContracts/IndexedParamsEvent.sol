pragma solidity ^0.4.18;

contract SampleEventWithIndexedParams {
    event ShowInformation(uint256 indexed price,uint256 indexed amount);
    event ShowInfoWithStrings(string indexed name,string indexed mail);

    function showInformation(uint256 price,uint256 amount) public {
        ShowInformation(price,amount);
    }

    function showInforWithStrings(string name,string mail) public {
        ShowInfoWithStrings(name,mail);
    }
}