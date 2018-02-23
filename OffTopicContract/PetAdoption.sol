pragma solidity ^0.4.18;

contract PetAdoption {
    enum Animals { ZeroEnum,Fish,Cat,Dog,Rabbit,Parrot }
    event AnimalAdopted(string);
    event AnimalAddedInSanctuary(string);
    event AnimalReturnedFromAdoption(string);
    address private contractOwner;
    mapping (address=>uint) public adopters;
    mapping (uint=>uint) public animalsInSanctuary;
    mapping (address=>uint) startTimers;

    uint private startTimer;
    uint private duration = 5 minutes;

    modifier isOwner() {
        require(msg.sender==contractOwner);
        _;
    }

    modifier isNotAnAdopter() {
        require(adopters[msg.sender] == 0);
        _;
    }

    modifier isNotZeroEnum(string zeroEnum) {
        require(getEnumValueByKey(zeroEnum) != 0);
        _;
    }

    modifier isGivingBackAnimalPossible() {
        require(startTimers[msg.sender] > 0);
        require(startTimers[msg.sender] + duration > block.timestamp);
        _;
    }

    //string to enum,if string is not correct enum revert transaction

    function getEnumValueByKey(string animalEnum) private pure returns(uint) {
        if (keccak256(animalEnum) == keccak256("Fish")) 
            return 1;
        if (keccak256(animalEnum) == keccak256("Cat")) 
            return 2;
        if (keccak256(animalEnum) == keccak256("Dog")) 
            return 3;
        if (keccak256(animalEnum) == keccak256("Rabbit")) 
            return 4;
        if (keccak256(animalEnum) == keccak256("Parrot")) 
            return 5;
        revert();
    }

    function PetAdoption() public {
        contractOwner = msg.sender;
    }

    function addAnimal(string animal,uint amountOfAnimalsToAdd) public isOwner() isNotZeroEnum(animal) {
        animalsInSanctuary[getEnumValueByKey(animal)] = amountOfAnimalsToAdd;

        AnimalAddedInSanctuary(animal);
    }
    function buyAnimal(uint8 personAge,string personGender,string animalKind) public isNotAnAdopter() isNotZeroEnum(animalKind) {
        require(keccak256(personGender) == keccak256("male") || keccak256(personGender) == keccak256("female"));

        if (keccak256(personGender) == keccak256("male") &&
            !(getEnumValueByKey(animalKind) == uint(Animals.Fish) || getEnumValueByKey(animalKind) == uint(Animals.Dog))) 
                revert();

        if (keccak256(personGender) == keccak256("female") && personAge > 40 && getEnumValueByKey(animalKind) == uint(Animals.Cat)) 
            revert();

        adopters[msg.sender] = getEnumValueByKey(animalKind);
        animalsInSanctuary[getEnumValueByKey(animalKind)] -= 1;

        startTimers[msg.sender] = block.timestamp;

        AnimalAdopted(animalKind);
    }
    function giveBackAnimal(string animalKind) public isNotZeroEnum(animalKind) isGivingBackAnimalPossible() {
        //if not adopter throw/revert
        require(adopters[msg.sender] != 0);

        adopters[msg.sender] = 0;
        startTimers[msg.sender] = 0;
        animalsInSanctuary[getEnumValueByKey(animalKind)] += 1;
        AnimalReturnedFromAdoption(animalKind);
    }
}