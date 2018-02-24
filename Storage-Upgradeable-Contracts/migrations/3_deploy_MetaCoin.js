var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var MetaCoinStorage = artifacts.require("./MetaCoinStorage.sol");

module.exports = function(deployer) {
    deployer.deploy(ConvertLib);
    deployer.link(ConvertLib,MetaCoin);
    deployer.deploy(MetaCoin,MetaCoinStorage.address).
    then(() => {
        MetaCoinStorage.deployed().then(inst => {
            return inst.allowAccess(MetaCoin.address);
        });
    });
}