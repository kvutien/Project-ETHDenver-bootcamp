# Session 8, Project-ETHDenver-bootcamp
27 October 2022
# Zoom session
* 123 attendants, DAO exploit
  * solution to the homework
  * contract deployment tools: Remix, Hardhat, Foundry, Truffle and others
* The zoom recording of 26th October: 
* Session 8 useful links:
    - •	https://github.com/wighawag/hardhat-deploy: script engine to automate Hardhat deployment steps
    - https://book.getfoundry.sh/: Foundry documentation homepage

# Homework
## Assignment: Deploy & test VolcanoCoin
Using your choice of Hardhat, Foundry or Truffle
1. Create a project for your Volcano coin
2. Write unit tests for your Volcano coin contract

The tests should show that
1. The total supply is initially 10000
2. That the total supply can be increased in 1000 token steps
3. Only the owner of the contract can increase the supply.

For help with the syntax for unit tests see
- Hardhat:https://hardhat.org/guides/waffle-testing.html
- Foundry : https://book.getfoundry.sh/forge/tests
- Truffle: https://trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript.html

You can use the gitpod workspace (not populated by Encode yet):
- https://github.com/ExtropyIO/SolidityBootcamp


## Solution using Hardhat - Create a project for your Volcano coin
### Install Hardhat
I check my versions of nodeJS and npm.
```sh
kvutien@MBP21VTK ~ % node --version
v16.15.1
kvutien@MBP21VTK ~ % npm --version
8.11.0
```
I install Hardhat locally inside the folder *Project-ETHDenver-bootcamp* managed by git. For this doing, I create the folder, I move to it, I install a `npm` environment and I install Hardhat in this `npm`:
```sh
kvutien@MBP21VTK ~ % cd /Users/kvutien/develop/hackhathons/ETHDenver_2022\ bootcamp/Bootcamp_repo/Project-ETHDenver-bootcamp
kvutien@MBP21VTK Project-ETHDenver-bootcamp % mkdir volcanocoin && cd volcanocoin
kvutien@MBP21VTK volcanocoin % npm init --yes
kvutien@MBP21VTK volcanocoin % npm install --save-dev hardhat
```
I create a default Hardhat project (I hit "enter" to all questions): 
```sh
kvutien@MBP21VTK volcanocoin % npx hardhat
```
VScode shows us the current folder content:
![screen shot of Remix](Solutions/homework8_solution.png)

Because we installed Hardhat specifically today, the latest Solidity compiler is in the `hardhat.config.js`
```js
require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
};
```
### Create the smart contract code and compile
The folder of the Hardhat project has by default a `contracts` folder with a sample Solidity program `Lock.sol` that we will replace by our tutorial program `VolcanoCoin.sol`. Copy-paste the code we had from Remix in the browser.

**Note:** You may see a VSCode red wiggle on the instruction import `hardhat/console.sol`; and a tooltip box saying "Source "*hardhat/console.sol" not found: File import callback not supported*". As we'll see below, Hardhat compiles it perfectly.

To compile the contract run `npx hardhat compile` in your terminal. The compile task is one of the Hardhat built-in tasks.
```sh
kvutien@MBP21VTK volcanocoin% npx hardhat compile
Downloading compiler 0.8.17
Compiled 3 Solidity files successfully
```
## Solution using Hardhat - Create VolcanoCoin test script
*Write unit tests for your Volcano coin contract. The tests should show that:*
1.	*The total supply is initially 10000*
2.	*That the total supply can be increased in 1000 token steps*
3.	*Only the owner of the contract can increase the supply.*

For this we're going to use `hardhat-network-helper` to interact with Hardhat Network, a local Ethereum blockchain network designed for development that is built-in and the default network in Hardhat. You don't need to setup anything to use it. In our tests we're going to use `ethers.js` to interact with the Ethereum contract we built in the previous section, and Mocha as our test runner.

Our Hardhat project has also by default a `test` folder with a test program `Lock.js` that we see later. Let's create our test program `Volcanocoin-test.js`.

Let's start with the code below. We'll explain it next, but for now paste this into `Volcanocoin-test.js`:
```js
// Hardhat test script of VolcanoCoin contract, Oct 2022
// ETHDenver Solidity Bootcamp - Vu Tien Khang, Machu Picchu

const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("Test VolcanoCoin contract", function () {

  /* We define a fixture to reuse the same setup in every test.
     We use loadFixture to run this setup once, snapshot that state,
     and reset Hardhat Network blockchain to that snapshot in every test.
     -volcanoCoin:  address of the deployed contract VolcanoCoin
     -owner:        private key of the deployer account
     -otherAccount  private key of a test account
  */
  async function deployVolcanoCoinFixture (){
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    // Obtain the descriptor (ABI etc.) of the VolcanoCoin contract
    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcanoCoin = await VolcanoCoin.deploy();
    // return contract address and private key of other account than owner
    return {volcanoCoin, owner, otherAccount};
  }

  // Tests starts here
  describe("Initial supply of Volcano coins", function(){
  // test that initial supply is 10000
    it("Should have 10000 as initial supply", async function(){
      const {volcanoCoin} = await loadFixture(deployVolcanoCoinFixture);
      // console.log(volcanoCoin);
      expect(await volcanoCoin.totalSupply()).to.equal(10000);
    });
  });

  describe("Increment initial supply of Volcano coins", function(){
    // test that total supply can be incremented by steps of 1000
    it("should increment oldValue by 1000 for newValue", async function(){
      const {volcanoCoin} = await loadFixture(deployVolcanoCoinFixture);
      // ethers.js returns a BigNumber that needs to be casted to a number
      value = Number(await volcanoCoin.totalSupply());
      value += 1000;
      volcanoCoin.incrTotalSupply();
      expect(Number(await volcanoCoin.totalSupply())).to.equal(value);
    });

  // test that the "require" condition reverts the transaction
    it("should fail if other account increments total supply", async function(){
      const {volcanoCoin, owner, otherAccount} = await loadFixture(deployVolcanoCoinFixture);
      // change signer of transaction to otherAccount by connect(otherAccount)
      expect(volcanoCoin.connect(otherAccount).incrTotalSupply()).to.be.revertedWith(
        "only owner can change total supply"
        );
    });
  });
});
```
To run the test, on your terminal run `npx hardhat test`. You should see the following output:
```sh
kvutien@MBP21VTK volcanocoin % npx hardhat test
  Test VolcanoCoin contract
    Initial supply of Volcano coins
      ✔ Should have 10000 as initial supply (784ms)
    Increment initial supply of Volcano coins
      ✔ should increment oldValue by 1000 for newValue (39ms)
      ✔ should fail if other account increments total supply

  3 passing (826ms)
```

## Detailed Explanation of Code 
... ***more to be done***