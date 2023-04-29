const DaiToken = artifacts.require("DaiToken");
const LTCExchange = artifacts.require("LTCExchange");
var ethers = require("ethers");
const Web3 = require("web3");
const web3 = new Web3("http://localhost:7545");
const { Utils } = require("alchemy-sdk");

require("chai").use(require("chai-as-promised")).should();

function tokens(n) {
  return web3.utils.toWei(n, "ether");
}

contract("LTCExchange", async ([owner, investor]) => {
  let daiToken, tokenFarm;
  await web3.eth.accounts.wallet.create(1);
  const adminWallet = web3.eth.accounts.wallet[0];
  console.log(adminWallet);

  before(async () => {
    // Load Contracts
    daiToken = await DaiToken.new();
    tokenFarm = await LTCExchange.new(daiToken.address, "LTC Exchange");

    // Transfer all Dapp tokens to farm (1 million)
    await daiToken.transfer(tokenFarm.address, tokens("500000"));

    // Send tokens to investor
    // await daiToken.transfer(investor, tokens('100'), { from: owner })
  });

  describe("test", async () => {
    it("test basic signing from client", async () => {
      const timestamp = Date.now();
      const encoded = web3.eth.abi.encodeParameters(
        ["address", "uint"],
        [adminWallet.address, timestamp]
      );
      const messageHash = web3.utils.sha3(encoded, { encoding: "hex" });
      console.log(messageHash);

      let messageHashBinary = Utils.arrayify(messageHash);
      console.log(messageHashBinary);

      let signature = await web3.eth.accounts.sign(
        messageHashBinary.toString(),
        adminWallet.privateKey
      );
      console.log(signature);

      // await tokenFarm.connect(adminWallet).isDataValid(timestamp, signature);
      const name = await tokenFarm.name()
      const isDataValid = await tokenFarm.isDataValid(timestamp, signature.toJSON())
      console.log(name);
      console.log(isDataValid);
    });
  });
});
