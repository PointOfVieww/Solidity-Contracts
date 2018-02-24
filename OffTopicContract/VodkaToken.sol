pragma solidity ^0.4.18;

contract ERC20Basic {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract VodkaToken is ERC20Basic {
    event TokensBought(uint);
    event TokenSaleCreation(uint);

    mapping (address=>uint) balances;

    string private name = "Vodka Token";
    string private symbol = "VODKA";
    uint private decimals = 18;
    uint256 public totalSupply = 1000000;
    uint256 private startTime;
    uint256 private endTime;
    uint8 private rateOfTokensGivenPerEth;
    uint256 private weiAmount;

    modifier tokenSaleStarted(){
        require(startTime < block.timestamp);
        _;
    }
    modifier tokenSaleOver(){
        require(block.timestamp > endTime);
        _;
    }

    function VodkaToken(uint _startTime,uint _endTime) public {
        balances[msg.sender] = 0;
        
        rateOfTokensGivenPerEth = 2;
        startTime = _startTime;
        endTime = _endTime;
        
        createTokens();
        TokenSaleCreation(startTime);
    }

    function createTokens() internal {
        balances[this] = totalSupply;
    }

    function showtotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function balanceOf(address addrToCheck) public view returns(uint) {
        return balances[addrToCheck];
    }

    function transfer(address to, uint value) public tokenSaleStarted tokenSaleOver returns(bool) {
        require(balances[to] != 0x0);  
        require(balances[msg.sender] >= value);
        require(balances[msg.sender] - value < balances[msg.sender]);

        balances[msg.sender] -= value;
        balances[to] += value;

        Transfer(msg.sender,to,value);
    }

    function buyTokens() public payable tokenSaleStarted tokenSaleOver {
        require(msg.value > 0);

        weiAmount += msg.value;
        
        uint256 tokens = msg.value * rateOfTokensGivenPerEth;  
        balances[msg.sender] += tokens; //add tokens to senders balance
        balances[this] -= tokens;
        TokensBought(msg.value);
    }
    
    function hasEnded() public view returns(bool) {
        return now > endTime;
    }

}