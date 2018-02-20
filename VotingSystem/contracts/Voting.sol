pragma solidity ^0.4.18;

//i think that mapping is better than using loops
contract Voting {
    mapping (bytes32=>uint256) public candidateVotes;
    mapping (bytes32=>bool) private candidates;
    
    function validCandidate(bytes32 name) public view returns(bool) {
        if (candidates[name]) {
            return true;
        } else {
            return false;
        }
    }

    function addCandidate(bytes32 name) public {
        
        candidates[name] = true;
    }

    function voteForCandidate(bytes32 name) public {
        require(validCandidate(name));
        candidateVotes[name] += 1;
    }

    function totalVotes(bytes32 name) public view returns (uint256) {
        require(validCandidate(name));
        return candidateVotes[name];
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