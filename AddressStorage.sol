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
    //checks if the creator is creating for himself or someone else
    modifier isProperPerson(address addr) {
        require(msg.sender==addr);
        _;
    }
    function AddressStorage() public {
        contractOwner = msg.sender;
    }
    function createPerson(string name,address addr,string mail) public  isProperPerson(addr) {
        Person memory currentPerson;
        currentPerson.name = name;
        currentPerson.addr = addr;
        currentPerson.mail = mail;
        persons.push(currentPerson);
    }

    function getPerson(uint256 index) isOwner() public view returns(string,address,string) {
        Person memory currPerson = persons[index];
        return (currPerson.name,currPerson.addr,currPerson.mail);
    }
}