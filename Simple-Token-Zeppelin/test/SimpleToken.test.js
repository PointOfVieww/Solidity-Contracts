const SimpleToken = artifacts.require("./SimpleToken.sol");
const expectThrow = require('./util').expectThrow;
const timeTravel = require('./util').timeTravel;

contract('SimpleToken',function(accounts){
    let tokenInstance;
    
    const _owner = accounts[0];
    const _notOwner = accounts[1];

    const _name = "Simple Token";
    const _initialSupply = 0;
    const _decimals = 18;
    const _symbol = "ST";

    describe("creating Simple Token",() => {
        beforeEach(async function() {
            tokenInstance = await SimpleToken.new({
                from:_owner
            });
        });

        it("should set owner correctly", async function() {
            let owner = await tokenInstance.owner.call();
            assert.strictEqual(owner,_owner,"The expected owner is not set");
        });
        
        it("should have no total supply", async function(){
            var totalSupply = await tokenInstance.totalSupply;
            assert.strictEqual(totalSupply,_initialSupply,"The total supply is not correct : $(totalSupply)");
        });
        
        it("should set name correctly", async function(){
            let name = await tokenInstance.NAME.call();
            assert.strictEqual(name,_name,"The name is not correct");
        });
        
        it("should set symbol correctly", async function(){
            let symbol = await tokenInstance.SYMBOL.call();
            assert.strictEqual(symbol,_symbol,"The name is not correct : $(symbol)");
        });
        
        it("should set decimals correctly",async function() {
            var decimals = await tokenInstance.decimals();
            assert.strictEqual(decimals,_decimals,"The decimals are not correct : $(decimals)")
        });
        
        it("Can timeTravel",async function() {
            const dayInSeconds = 24*60*60;
            const timeBefore = await web3.eth.getBlock(web3.eth.blockNumber).timestamp;
            console.log(timeBefore);
            await timeTravel(web3,dayInSeconds);
            const timeAfter = await web3.eth.getBlock(web3.eth.blockNumber).timestamp;
            console.log(timeAfter);
            assert.isAtLeast(timeAfter-timeBefore,dayInSeconds,"It did not advance with a day $(timeAfter - timeBefore)");
        });
    });
});


