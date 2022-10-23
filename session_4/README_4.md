# Session 4, Project-ETHDenver-bootcamp
20 October 2022
# Zoom session

* 137 attendants, Solidity theory
* Inheritance, Internal functions,
*  Variable types bytes, string. Operator string compare, string concat, bytes concat
*  Variable types enum, constant, immutable
*  Keywords: require, assert, revert
*  Blocks try, catch. Keyword error (Solidity 0.8.4) to define error types for lisibility
*  How to import code from github and npm into Remix. Also imported from Hardhat is logging to console

* The zoom recording of 20th October: https://youtu.be/u0HPyGODIg4
* Session 4 useful links: https://github.com/fravoll/solidity-patterns

# Homework
## Assignment: VolcanoCoin contract
At each point where you change your contract you should re deploy to the JavascriptVM
and test your changes.
1. In Remix, create a new file called `VolcanoCoin.sol`.
2. Define the pragma compiler version to `^0.8.0`.
3. Before the pragma version, add a license identifer  `// SPDX-License-Identifier: UNLICENSED`
4. Create a contract called `VolcanoCoin`.
5. Create a variable to hold the total supply of 10000.
6. Make a public function that returns the total supply.
7. Make a public function that can increase the total supply. Inside the function, add 1000
to the current total supply.
8. We probably want users to be aware of functions in the contract for greater
transparency, but to make them all public will create some security risks (e.g. we don't
want users to be able to change the total supply).
Declare an address variable called `owner`
9. Next, create a `modifier` which only allows an owner to execute certain functions.
10. Make your change total supply function `public`, but add your modifier so that only
the owner can execute it.
11. The contract owner's address should only be updatable in one place. Create a
`constructor` and within the constructor, store the owner's address.
12. It would be useful to broadcast a change in the total supply. Create an `event` that emits
the new value whenever the total supply changes. When the supply changes, emit this
event
13. In order to keep track of user balances, we need to associate a user's address with the
balance that they have.
    * What is the best data structure to hold this association?
    * Using your choice of data structure, set up a variable called `balances` to keep
track of the number of volcano coins that a user has.
14. We want to allow the `balances` variable to be read from the contract, there are 2 ways
to do this.
    * What are those ways?
- Use one of the ways to make your `balances` variable visible to users of the contract.
15. Now change the constructor, to give all of the total supply to the owner of the
contract.
16. Now add a public function called `transfer` to allow a user to transfer their tokens to
another address. This function should have 2 parameters :
* the amount to transfer and
* the recipient address.
    * Why do we not need the sender's address here ?
    * What would be the implication of having the sender's address as a parameter ?
17. Add an event to the `transfer` function to indicate that a transfer has taken place, it
should log the amount and the recipient address.
18. We want to keep a record for each user's transfers. Create a `struct` called `Payment`
that stores the transfer amount and the recipient's address
19. We want to have a payments array for each user sending the payment. Create a
`mapping` which returns an array of Payment structs when given this user's address.

_**Resources:**_
- Official Solidity Documentation: https://docs.soliditylang.org/en/latest/
- Globally Available Variables: https://docs.soliditylang.org/en/v0.8.6/units-and-global-variables.html


## Solution
_**In Remix, create a new file. Define the pragma compiler version. Before the pragma version, add a license identifer . Create a contract called VolcanoCoin. Create a variable to hold the total supply of 10000. Make a public function that returns the total supply. Make a public function that can increase the total supply. Inside the function, add 1000 to the current total supply.**_

![screen shot of Remix](Solutions/homework4_solution1c.png)

_**Write an external function to return address `0x000000000000000000000000000000000000dEaD` if called by the deployer, otherwise the deployer's address**_

![screen shot of Remix](Solutions/homework4_solution2a.png)

_**It would be useful to broadcast a change in the total supply. Create an `event` that emits the new value whenever the total supply changes. When the supply changes, emit this event**_

- Event emitted as logged

```
[
	{
		"from": "0x5FD6eB55D12E759a21C09eF703fe0CBa1DC9d88D",
		"topic": "0xb1b0d26955e375136ca55bac4ef6b90b41a617dc655cca6436931ba3a836e769",
		"event": "totalSupplyChanged",
		"args": {
			"0": "new totalSupply =",
			"1": "11000"
		}
	}
]
```

- Code at this stage
```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint256 totalSupply = 10000;
    address public owner;
    address public user;
    event totalSupplyChanged(string, uint256);

    modifier onlyOwner() {
        if(msg.sender == owner) {
            _;
        }
    }

    constructor() {
        owner = msg.sender;
    }

    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function setUser() public {
        user = msg.sender;
    }

    function incrTotalSupply() public onlyOwner{
        totalSupply += 1000;
        emit totalSupplyChanged("new totalSupply =", totalSupply);
    }
}
```
_**In order to keep track of user balances, we need to associate a user's address with the balance that they have. What is the best data structure to hold this association? Using your choice of data structure, set up a variable called `balances` to keep track of the number of volcano coins that a user has.**_

- _**Answer**_: use a `mapping`. Like this
  ```
  mapping(address => uint256) public usersBalances;
  ```
_**We want to allow the `balances` variable to be read from the contract, there are 2 ways to do this. What are those ways? Use one of the ways to make your `balances` variable visible to users of the contract.**_

- _**Answer**_: in the contract, add a getter function, or make the mapping public, for Solidity to insert automatically a getter function.

_**Now change the constructor, to give all of the total supply to the owner of the contract.**_
  ```
constructor() {
    owner = msg.sender;
    usersBalances[owner] = totalSupply;
}
  ```
_**Now add a public function called `transfer` to allow a user to transfer their tokens to another address. This function should have 2 parameters: the amount to transfer and the recipient address.**_

_**Why do we not need the sender's address here?**_

- Because the sender's address is already a Solidity construct.

_**What would be the implication of having the sender's address as a parameter?**_

- Anybody knowing the sender's address could pretend to be the sender and transfer the coins.

_**Add an event to the transfer function to indicate that a transfer has taken place, it should log the amount and the recipient address. We want to keep a record for each user's transfers. Create a struct called `Payment` that stores the transfer amount and the recipient's address**_
  ```
    event amountTransferred(uint256, address);
    struct Payment{
        uint256 amount;
        address recipient;
    };
  ```
_**We want to have a payments array for each user sending the payment. Create a `mapping` which returns an array of Payment structs when given this user's address.**_
  ```
    mapping(address => Payment) payments;
  ```

## Complete Code and results
![screen shot of Remix](Solutions/homework4_solution3.png)

  ```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Encode Club bootcamp homework - 4
contract VolcanoCoin {
    uint256 totalSupply = 10000;    // initial supply of Volcano coins
    address public owner;           // deployer of the contract
    mapping(address => uint256) public usersBalances;  // keep track of amount of coins of each user
    event totalSupplyChanged(string, uint256);
    event amountTransferred(uint256, address indexed, address indexed);
    struct Payment{
        uint256 amount;
        address recipient;
    }
    mapping(address => Payment) payments;

    modifier onlyOwner() {
        if(msg.sender == owner) {
            _;
        }
    }

    constructor() {
        owner = msg.sender;                 // set deployer to be owner
        usersBalances[owner] = totalSupply; // assign all available coins to owner
    }

    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function incrTotalSupply() public onlyOwner{ // only the owner can increase total supply of coins
        totalSupply += 1000;
        emit totalSupplyChanged("new totalSupply =", totalSupply);
        usersBalances[owner] += 1000;   // assign new minted coins to owner
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
