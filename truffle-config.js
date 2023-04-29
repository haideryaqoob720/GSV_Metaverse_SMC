const HDWalletProvider = require("@truffle/hdwallet-provider");

const fs = require("fs");
const accountPrivatekey = fs.readFileSync(".secret").toString().trim();
const infuraMainKey =
  "wss://mainnet.infura.io/ws/v3/f5846a03eaec47c28b102d6d01a2de16";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
    },
    main: {
      networkCheckTimeout: 1000000,
      provider: () => new HDWalletProvider(accountPrivatekey, infuraMainKey),
      // provider: () => new HDWalletProvider(mnemonic, infuraMainKey),

      network_id: 1, // Ropsten's id
      // gas: 5500000,        // Ropsten has a lower block limit than mainnet
      confirmations: 5, // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets )
    },
    bsctestnet: {
      networkCheckTimeout: 1500000,
      // from: "0x3997d3AccEBad60EbAe81B2191F81f9055b3B420",
      // provider: () => new HDWalletProvider(accountPrivatekey, `wss://data-seed-prebsc-1-s2.binance.org:8545`),
      provider: () =>
        new HDWalletProvider(
          accountPrivatekey,
          `https://data-seed-prebsc-1-s1.binance.org:8545`
        ),
      network_id: 97,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
    goerli: {
      networkCheckTimeout: 500000,
      provider: () =>
        new HDWalletProvider(
          accountPrivatekey,
          "wss://goerli.infura.io/ws/v3/a9408e5619eb436796b761bbc2e61200"
        ),
      network_id: 5, // Ropsten's id
      confirmations: 2, // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200, // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true, // Skip dry run before migrations? (default: false for public nets )
    },
    bsc: {
      networkCheckTimeout: 1000000,
      // from: "0x3997d3AccEBad60EbAe81B2191F81f9055b3B420",
      provider: () =>
        new HDWalletProvider(
          accountPrivatekey,
          `wss://bsc-ws-node.nariox.org:443`
        ),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
    mumbai_polygon: {
      provider: () =>
        new HDWalletProvider(
          accountPrivatekey,
          `https://polygon-mumbai.g.alchemy.com/v2/QJwTxuA9PB10v0nFniTosad3S6CYr8kM`
        ),
      network_id: 80001,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.3", // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {
      //   // See the solidity docs for advice about optimization and evmVersion
      //   optimizer: {
      //     enabled: false,
      //     runs: 200,
      //   },
      //   evmVersion: "byzantium",
      // },
    },
  },
};
