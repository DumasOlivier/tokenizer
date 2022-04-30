require('@nomiclabs/hardhat-waffle');
require('dotenv').config({ path: '.env' });

const { ALCHEMY_API_KEY_URL, RINKEBY_PRIVATE_KEY } = process.env;

module.exports = {
  solidity: '0.8.4',
  networks: {
    rinkeby: {
      url: ALCHEMY_API_KEY_URL,
      accounts: [RINKEBY_PRIVATE_KEY],
    },
  },
};
