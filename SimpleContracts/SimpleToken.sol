pragma solidity ^0.4.18;

contract SimpleToken {
    mapping (address=>uint256) public balanceOf;
    
    function SimpleToken(uint256 initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
    }
    
    //if balanceOf is private
    //function getBalance(address addr) public view returns(uint256) {
      //  return balanceOf[addr];
    //}
    
    function sendToken(address receiver,uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        require(balanceOf[receiver] + amount >= balanceOf[receiver]);
        balanceOf[msg.sender] -= amount;
        balanceOf[receiver] += amount;
        
    }
}