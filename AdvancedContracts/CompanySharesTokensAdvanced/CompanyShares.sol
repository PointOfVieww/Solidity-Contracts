pragma solidity ^0.4.18;

contract CompanyShares {
    mapping (address=>bool) private addressesAllowedToWithdraw;
    mapping (address=>uint256) private addressesWithShares;
    address private owner;
    uint256 private pricePerShare;
    uint256 private dividend;
    address[] shareholders;

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier isAllowedToWithdraw() {
        require(addressesAllowedToWithdraw[msg.sender] == true);
        _;
    }

    function CompanyShares(uint256 initialSupply,uint256 _pricePerShare,uint256 _dividend) public {
        owner = msg.sender;
        addressesWithShares[owner] = initialSupply;
        pricePerShare = _pricePerShare * 1 ether;
        dividend = _dividend * 1 ether;

        //you can remove those depending on your logic
        addressesAllowedToWithdraw[owner] = true;
        shareholders.push(owner);
    }

    function getPricePerShare() public view returns(uint256) {
        return pricePerShare / 1 ether;
    }

    function calculateTransactionShare(uint256 amount) public view returns(uint256) {
        return (amount * pricePerShare) / 1 ether;
    }

    function buyShare(uint256 amount) public payable {
         assert(addressesWithShares[owner] >= amount);
         assert(addressesWithShares[msg.sender] + amount >= addressesWithShares[msg.sender]);
         assert(msg.value == amount * pricePerShare);

         addressesWithShares[owner] -= amount;
         addressesWithShares[msg.sender] += amount;
         shareholders.push(msg.sender);
    }

    function getShareholders() public view isOwner() returns(address[]) {
        return shareholders;
    }

    function allowToWithdraw(address addr) public isOwner() {
        addressesAllowedToWithdraw[addr] = true;
    }

    function depositEarnings() public payable isOwner() { }

    function getBalance() public view isOwner() returns(uint256) { return this.balance; }

    function getNumberOfShares(address addr) public view returns(uint256) {
        require(msg.sender == addr || msg.sender == owner);
        return addressesWithShares[addr];
    }

    function withdraw() public isAllowedToWithdraw() {
        require(addressesWithShares[msg.sender] > 0);
        require(this.balance >= addressesWithShares[msg.sender] * pricePerShare);
        msg.sender.transfer(addressesWithShares[msg.sender] * dividend);
        addressesAllowedToWithdraw[msg.sender] = false;
    }
}