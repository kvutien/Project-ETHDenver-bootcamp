// Hardhat test script of VolcanoCoin contract, 6 Nov 2022
//    I'm using console.log to test the tests :)
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
    console.log("       -owner ==>", owner.address);
    console.log("       -otherAccount==>", otherAccount.address);
    // obtain the descriptor (ABI etc.) of the VolcanoCoin contract
    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    // deploy the contract
    const volcanoCoin = await VolcanoCoin.deploy();
    // return contract address and private key of other account than owner
    return {volcanoCoin, owner, otherAccount};
  }

  // Tests starts here
  describe("Initial supply of Volcano coins", function(){
  // test that initial supply is 10000
    it("Should have 10000 as initial supply", async function(){
      const {volcanoCoin} = await loadFixture(deployVolcanoCoinFixture);
      const totalSupply = await volcanoCoin.totalSupply();
      expect(await volcanoCoin.totalSupply()).to.equal(10000);
      // cross-check the test
      console.log("       -totalSupply ==>", Number(totalSupply));
    });
  });

  describe("Increment initial supply of Volcano coins", function(){
    // test that total supply can be incremented by steps of 1000
    it("should increment oldValue by 1000 for newValue", async function(){
      const {volcanoCoin, owner, otherAccount} = await loadFixture(deployVolcanoCoinFixture);
      // ethers.js returns a BigNumber that needs to be transformed to a Number
      value = Number(await volcanoCoin.totalSupply());
      value += 1000;
      volcanoCoin.incrTotalSupply();
      expect(Number(await volcanoCoin.totalSupply())).to.equal(value);
    });

  // test that the "require" condition reverts the transaction
    it("should revert if other account increments total supply", async function(){
      const {volcanoCoin, owner, otherAccount} = await loadFixture(deployVolcanoCoinFixture);
      // change signer of transaction to otherAccount by connect(otherAccount)
      expect(volcanoCoin.connect(otherAccount).incrTotalSupply()).to.be.revertedWith(
        "only owner can change total supply"
        );
      console.log("       -owner ==>", owner.address);
      console.log("       -otherAccount==>", otherAccount.address);
      });
  });
});
