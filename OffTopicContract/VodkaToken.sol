pragma solidity ^0.4.18;

contract ERC20Basic {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract VodkaToken is ERC20Basic {
    event TokensBought(uint);

    mapping (address=>uint) balances;

    string public name = "Vodka Token";
    string public symbol = "VODKA";
    uint public decimals = 18;
    uint256 public totalSupply = 1000000000000000000000000;
    uint256 private startTime;
    uint256 private endTime;
    uint8 private rateOfTokensGivenPerEth;
    uint256 private weiAmount;


    function VodkaToken() public {
        balances[msg.sender] = 0;
        
    }

    function createTokens() internal {
        balances[this] = totalSupply;
    }

    function totalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function balanceOf(address addrToCheck) public view returns(uint) {
        require(balances[addrToCheck] != 0x0);

        return balances[addrToCheck];
    }

    function transfer(address to, uint value) public returns(bool) {
        require(balances[to] != 0x0);  
        require(balances[msg.sender] >= value);
        require(balances[msg.sender] - value < balances[msg.sender]);

        balances[msg.sender] -= value;
        balances[to] += value;

        Transfer(msg.sender,to,value);
    }

    function buyTokens() public payable {
        require(msg.value > 0);

        balances[msg.sender] += (msg.value * 1 ether) * rateOfTokensGivenPerEth;
        balances[this] -= (msg.value * 1 ether) * rateOfTokensGivenPerEth;

        TokensBought(msg.value);
    }
    
    function hasEnded() public view returns(bool) {
        return now > endTime;
    }

}