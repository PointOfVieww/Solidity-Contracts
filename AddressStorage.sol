pragma solidity ^0.4.18;

contract AddressStorage {
    address private contractOwner;
    Person[] persons;

    struct Person {
        string name;
        address addr;
        string mail;
    }
    modifier isOwner() {
        require(msg.sender==contractOwner);
        _;
    }
    modifier isProperPerson(address addr) {
        require(msg.sender==addr);
        _;
    }
    function AddressStorage() public {
        contractOwner = msg.sender;
    }
    function createPerson(string name,address addr,string mail) public  isProperPerson(addr) {
        Person memory currentPerson;
        
        
    }
    

    
    


}