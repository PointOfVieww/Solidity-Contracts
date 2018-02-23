pragma solidity ^0.4.18;

import "../node_modules/zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "../node_modules/zeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract SimpleToken is MintableToken,Pausable {

    string public constant NAME = "Simple Token";
    string public constant SYMBOL = "ST";
    uint8 public constant DECIMALS = 18;

    function decimals() public view returns(uint256) {
        return DECIMALS;
    }
    
    function SimpleToken() public {
        
    }
    
}