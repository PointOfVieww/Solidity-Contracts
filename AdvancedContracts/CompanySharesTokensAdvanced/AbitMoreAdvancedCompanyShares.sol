pragma solidity ^0.4.18;

contract CompanySharesAdvanced {
    address private owner;
    uint256 private price;
    uint256 private dividend;
    mapping (address=>bool) private addressesAllowedToWithdraw;
    mapping (address=>uint256) private addressesWithShares;
    address[] shareholders;
    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }
    modifier isAllowedToWithdraw() {
        require(addressesAllowedToWithdraw[msg.sender] == true);
        _;
    }

    function CompanySharesAdvanced(uint256 initialSupply,uint256 pricePerShare,uint256 _dividend) public {
        owner = msg.sender;
        addressesWithShares[owner] = initialSupply;
        addressesAllowedToWithdraw[owner] = true;
        price = pricePerShare * 1 wei;
        dividend = _dividend * 1 wei;

        //owner should be in shareholders
        shareholders.push(owner);
    }

    function deposit() public payable isOwner() { }

    function getBalance() public view returns(uint256) {
        return this.balance;
    }

    function allowWithdrawal(address addr) public isOwner() {
        addressesAllowedToWithdraw[addr] = true;
    }
    function getAllShareHolders() public view isOwner() returns(address[]) {
        return shareholders;
    }

    function buyShares(uint256 amount) public payable {
         assert(addressesWithShares[owner] >= amount);
         assert(addressesWithShares[msg.sender] + amount >= addressesWithShares[msg.sender]);
         assert(msg.value == amount * price);

         addressesWithShares[owner] -= amount;
         addressesWithShares[msg.sender] += amount;
         shareholders.push(msg.sender);
    }

    function withdraw() public isAllowedToWithdraw() {

        require(addressesWithShares[msg.sender] > 0);
        require(this.balance >= addressesWithShares[msg.sender] * price);
        msg.sender.transfer(addressesWithShares[msg.sender] * dividend);
        addressesAllowedToWithdraw[msg.sender] = false;
    }

}