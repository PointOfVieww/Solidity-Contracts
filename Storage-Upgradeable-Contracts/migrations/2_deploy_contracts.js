var MetaCoinStorage = artifacts.require("./MetaCoinStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(MetaCoinStorage);
};
