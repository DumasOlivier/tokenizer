const { ethers } = require('hardhat');

async function main() {
  const tokenizerContract = await ethers.getContractFactory('Tokenizer');
  const deployedTokenizerContract = await tokenizerContract.deploy();

  await deployedTokenizerContract.deployed();

  console.log('Tokenizer Contract Address:', deployedTokenizerContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
