pragma solidity ^0.4.18;

contract TimedAuctionWBlocks {
    mapping (address=>uint256) private tokenBalances;
    address private owner;
    uint256 private startOfAuction;


    function TimedAuctionWBlocks() public {
        owner = msg.sender;
        tokenBalances[owner] = 1000;
        startOfAuction = block.number;
    }
    function buyTokens(uint256 amount) public {
        assert(tokenBalances[owner]>=amount);
        assert(startOfAuction + 1 <= block.number);
        
        tokenBalances[owner] -= amount;
        tokenBalances[msg.sender] += amount;
    }
    
}