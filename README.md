# NFT Collectible Smart Contract

This project is for developing, deploying NFT Collectible smart contract on ethereum and polygon network.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

## How to start

First, we will need an RPC URL that will allow us to broadcast our contract creation transaction. We will use Alchemy for this. Create an [Alchemy account](https://dashboard.alchemyapi.io/apps/yfyhjwebpu6v2c4l) and then proceed to create a free app.

Make sure that the network is set to Rinkeby.
Once you’ve created an app, go to your Alchemy dashboard and select your app. This will open a new window with a View Key button on the top right. Click on that and select the HTTP URL.
Acquire some fake Rinkeby ETH from the faucet here. For our use case, 0.5 ETH should be more than enough. Once you’ve acquired this ETH, open your Metamask extension and get the private key for the wallet containing the fake ETH (you can do this by going into Account Details in the 3-dots menu near the top-right).
Do not share your URL and private key publicly.
We will use the dotenv library to store the aforementioned variables as environment variables and will not commit them to our repository.
Create a new file called .env and store your URL and private key in the following format:

```env
API_URL = "<--YOUR ALCHEMY URL HERE-->"
PRIVATE_KEY = "<--YOUR PRIVATE KEY HERE-->"
```

We’re almost there! Run the following command:

```shell
npx hardhat run scripts/run.js --network rinkeby
```

## Verifying our smart contract using Etherscan

Let’s add this API key to our `.env` file.

```env
ETHERSCAN_API = "<--YOUR ETHERSCAN API KEY-->"
```

Now, run the following two commands:

```shell
npx hardhat clean
npx hardhat verify --network rinkeby DEPLOYED_CONTRACT_ADDRESS "BASE_TOKEN_URI"
```
