pragma solidity ^0.4.18;

// import 'github.com/oraclize/ethereum-api/oraclizeAPI.sol';

contract Capitol {
    event GamesStarted(uint currentTime,uint timeToFight);
    event GamesFinished(uint currentTime);
    event PersonAddedForGames(uint currentTime,uint age,string gender);
    struct Person {
        uint8 age;
        string gender;
    }
    Person[] peopleToBeChosen;
    Person[] public peopleFighting;

    uint256 nonce;
    uint256 timeToFight = 3 minutes;
    uint256 startTimer;

    modifier hungerGamesOver() {
        require(startTimer + timeToFight > block.timestamp);
        _;
    }
    //random should be changed so that you dont write on the blockchain
    function random(uint256 min,uint256 max) private returns(uint256) {
        nonce++;
        return uint256(keccak256(nonce+block.timestamp))%(min+max)-min;
    }

    function addPerson(uint8 _age,string _gender) public {
        Person memory personToAdd;
        personToAdd.age = _age;
        personToAdd.gender = _gender;
        peopleToBeChosen.push(personToAdd);
        PersonAddedForGames(block.timestamp,_age,_gender);
    }

    function peopleCount() public view returns(uint256) {
        return peopleToBeChosen.length;
    }

    //select only 2 people different in gender
    function selectPeopleForFight() public  returns(string) {
        if (startTimer > 0) {
            require(startTimer + timeToFight > block.timestamp);
        }
        Person memory maleToSelect;
        Person memory femaleToSelect;
        uint256 maxLength = peopleToBeChosen.length;
        uint256 randomNum = random(0,maxLength);
        uint8 selectedPeople = 0;
        uint256 counterMale = 0;
        uint256 counterFemale = 0;
        uint256 counter;

        while (selectedPeople < 2) {
            if (counter <= maxLength) {
                if (peopleToBeChosen[randomNum].age >= 12 && peopleToBeChosen[randomNum].age <= 18) {
                    if (keccak256(peopleToBeChosen[randomNum].gender) == keccak256("male")) {
                        if (counterMale == 0) {
                            maleToSelect = peopleToBeChosen[randomNum];
                            selectedPeople += 1;
                            
                        }
                        counterMale += 1;
                    } else {
                        if (counterFemale == 0) {
                            femaleToSelect = peopleToBeChosen[randomNum];
                            selectedPeople += 1;
                        }
                        counterFemale += 1;
                    }
                    counter++;
                }
            } else {
                break;
            }
            randomNum = random(0,peopleToBeChosen.length);
        }
        if (selectedPeople < 2) {
            return "Not Enough People";
        } else {
            peopleFighting.push(maleToSelect);
            peopleFighting.push(femaleToSelect);
            startTimer = now;
            GamesStarted(startTimer,timeToFight);
            return "Games Started";
        }
    }

    function checkIfFightersAreDead() public hungerGamesOver() returns(uint256,uint256) {
        uint256 maleFighter = random(0,1);
        uint256 femaleFighter = random(0,1);
        GamesFinished(block.timestamp);
        return (maleFighter,femaleFighter);
    }
}