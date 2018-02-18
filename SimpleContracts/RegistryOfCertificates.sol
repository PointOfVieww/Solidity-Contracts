pragma solidity ^0.4.18;

contract RegistryOfCertificates {
    address private contractOwner = msg.sender;
    mapping (string=>uint256) cetrificateHashes;

    //hash is old type for now bytes32
    
    function addCertificate(string hashToAdd) public {
        require(msg.sender == contractOwner);
        cetrificateHashes[hashToAdd] = 1;
    }
    function verifyCertificate(string hashToVerify)public view returns (bool) {
        return cetrificateHashes[hashToVerify]!=0;
    }
}   