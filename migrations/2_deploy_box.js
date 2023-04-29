// migrations/2_deploy_box.js
const GSVToken = artifacts.require("GSVToken");
const GSVMetaverse = artifacts.require("GSVMetaverse");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');

module.exports = async function (deployer) {
    console.log("2_deploy_box");
    // Deploy Mock DAI Token
    await deployer.deploy(GSVToken);
    const gSVToken = await GSVToken.deployed();
    let gsvTokenTotalSupply = await gSVToken.totalSupply();


   let gSVMetaverse = await deployProxy(GSVMetaverse, [
        //bsc mainnet
        gSVToken.address,
        "GSV Metaverse",
        gsvTokenTotalSupply
    ], { deployer, initializer: 'storeConstructor' });

  await gSVToken.transfer(gSVMetaverse.address, gsvTokenTotalSupply);
};
