const hre = require('hardhat');
const { utils } = require('ethers');

async function main() {
  const baseTokenURI = 'ipfs://QmZbWNKJPAjxXuNFSEaksCJVd1M6DaKQViJBYPK2BdpDEP/';

  const [owner] = await hre.ethers.getSigners();

  const NFTCollectible = await hre.ethers.getContractFactory('NFTCollectible');
  const contract = await NFTCollectible.deploy(baseTokenURI);

  await contract.deployed();

  console.log('NFTCollectible deployed to:', contract.address);

  let txn = await contract.reserveNFTs();
  await txn.wait();
  console.log('10 NFTs have been reserved.');

  txn = await contract.mintNFTs(3, { value: utils.parseEther('0.03') });
  await txn.wait();

  let tokens = await contract.tokensOfOwner(owner.address);
  console.log('Owner has tokens: ', tokens);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
