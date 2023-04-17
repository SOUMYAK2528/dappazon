require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    sepolia: {
      url:"https://eth-sepolia.g.alchemy.com/v2/yQdOFRpYTOWPnA5FgvBR0eAI1SpfPFHx",
      accounts:["0x04edb2e49ca81781f7c7e6e0bba1c880c8b891b3c6e262790180da6aef09c4b8"],
    }
  }
};
