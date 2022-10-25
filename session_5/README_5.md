# Session 5, Project-ETHDenver-bootcamp
24 October 2022
# Zoom session

* 131 attendants,

* The zoom recording of 24th October: https://youtu.be/Tl1uQrG6A8w
* Session 5 useful links:

https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

https://docs.openzeppelin.com/contracts/2.x/access-control

# Homework
## Assignment: 
1. Install a browser wallet such as Metamask
- Connect to the Goerli Test network
- Set up a wallet that will be used by your team for the team games
- If you need some test ETH, lets us know and we can send some to your team
2. Update your Volcano coin contract to inherit from the Open Zeppelin Ownable contract and use this to replace the owner functionality in your contract.

## Solution
Assignment 1 done separately.

Assignment 2:
_Update your Volcano coin contract to inherit from the Open Zeppelin Ownable contract and use this to replace the owner functionality in your contract._
- Import Open Zeppelin

```
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
```
- Comment out the `modifier` code, the code is already in `Ownable.sol`
- The local variable `owner` clashes with the function `owner` of `Ownable.sol`, so replace it with `localOwner`.

### Full Code
```
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
// modif Homework 5
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// Encode Club bootcamp homework - 5
contract VolcanoCoin is Ownable{
    uint256 totalSupply = 10000;    // initial supply of Volcano coins
// modif Homework 5 to avoid collision of name owner with function owner in Ownable.sol
    address public localOwner;           // deployer of the contract
    mapping(address => uint256) public usersBalances;  // keep track of amount of coins of each user
    event totalSupplyChanged(string, uint256);
    event amountTransferred(uint256, address indexed, address indexed);
    struct Payment{
        uint256 amount;
        address recipient;
    }
    mapping(address => Payment) payments;

    // modifier onlyOwner() {
    //     if(msg.sender == owner) {
    //         _;
    //     }
    // }

    constructor() {
// modif Homework 5
        localOwner = msg.sender;                 // set deployer to be owner
// modif Homework 5
        usersBalances[localOwner] = totalSupply; // assign all available coins to owner
    }

    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function incrTotalSupply() public onlyOwner{ // only the owner can increase total supply of coins
        totalSupply += 1000;
        emit totalSupplyChanged("new totalSupply =", totalSupply);
// modif Homework 5
        usersBalances[localOwner] += 1000;   // assign new minted coins to owner
    }

    function getBalance(address user) public view returns(uint256) {
        // get the balance of a given user
        return usersBalances[user];
    }

    function transfer(uint256 _amount, address recipient) public {
        // xfer _amount coins from msg.sender to recipient
        require(usersBalances[msg.sender] >= _amount, "not enough balance to transfer");
        usersBalances[msg.sender] -= _amount;
        usersBalances[recipient] += _amount;
        emit amountTransferred(_amount, msg.sender, recipient);
    }
}
```
