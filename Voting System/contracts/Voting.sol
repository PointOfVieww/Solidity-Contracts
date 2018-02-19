pragma solidity ^0.4.18;

//i think that mapping is better than using loops
contract Voting {
    mapping (bytes32=>uint256) public candidateVotes;
    mapping (bytes32=>bool) private candidates;
    
    function validCandidate(bytes32 addr) public view returns(bool) {
        if (candidates[addr]) {
            return true;
        } else {
            return false;
        }
    }

    function addCandidate(bytes32 addr) public {
        
        candidates[addr] = true;
    }

    function voteForCandidate(bytes32 addr) public {
        require(validCandidate(addr));
        candidateVotes[addr] += 1;
    }

    function totalVotes(bytes32 addr) public view returns (uint256) {
        require(validCandidate(addr));
        return candidateVotes[addr];
    }
}

// contract Voting {
  
//   mapping (bytes32 => uint8) public votesReceived;
//   bytes32[] public candidateList;

//     function addCandidate(bytes32 candidateNames) public {
//         candidateList.push(candidateNames);
//     }

//     function totalVotesFor(bytes32 candidate) view public returns (uint8) {
//         require(validCandidate(candidate));
//         return votesReceived[candidate];
//     }

//     function voteForCandidate(bytes32 candidate) public {
//         require(validCandidate(candidate));
//         votesReceived[candidate] += 1;
//     }

//     function validCandidate(bytes32 candidate) view public returns (bool) {
//         for (uint i = 0; i < candidateList.length; i++) {
//             if (candidateList[i] == candidate) {
//                 return true;
//             }
//         }
//         return false;
//     }
// }