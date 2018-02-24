pragma solidity ^0.4.17;

import "./ConvertLib.sol";
import './MetaCoinStorage.sol';

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	mapping (address => uint) balances;
	MetaCoinStorage metaCoinStorage;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin(address metaCoinStorageAddress) public {
		metaCoinStorage = MetaCoinStorage(metaCoinStorageAddress);
	}
	
    function sendCoin(address receiver,uint amount) public returns(bool) {
        if (metaCoinStorage.getBalance(msg.sender) < amount)
            return false;

		metaCoinStorage.setBalance(msg.sender,metaCoinStorage.getBalance(msg.sender) - amount);
		metaCoinStorage.setBalance(receiver,metaCoinStorage.getBalance(receiver) + amount);
		Transfer(msg.sender, receiver, amount);
		return true;		
    }

	function getBalanceInEth(address addr) public view returns(uint) {
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return metaCoinStorage.getBalance(addr); //for the error
	}
}
