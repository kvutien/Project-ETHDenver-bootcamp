# Session 6, Project-ETHDenver-bootcamp
25 October 2022
# Zoom session

* 131 attendants,
* The zoom recording of 25th October: https://youtu.be/DbwziFc9b0U
* Session 6 useful links:


# Homework
## Assignment: Team Treasure Hunt
**Part 1**
To prepare for the treasure hunt you need to deploy a contract on Goerli test net.
1.	Take the contract and interface from this gist: https://gist.github.com/letsgitcracking/239306ea9f08d7e270f9d7e5245bdd2b
2.	Deploy the contract to Goerli test net and note the address it was deployed to. Address as deployed by the team: 0x555825393E6100aE07D4d6310Cb7605D6aF090A2

**Part 2**
Register your team name, team number with your team wallet here (site is locked after the game ends): https://gist.github.com/letsgitcracking/239306ea9f08d7e270f9d7e5245bdd2b
Look for clues in the transaction. Team's transaction hash: 0x6d22c5bcb382275bf0f9f8aa87c776c74430d9cc13a56be98b1e5023b0cd79df

This site may help you: https://www.rapidtables.com/convert/number/.

**Part 3**
The treasure contract looks like this: https://gist.github.com/letsgitcracking/a7d3d62df2d4a13f6b1cf9991da795d9.

Once you have found it on the test net, you need to
1. Call it from your interface contract with your team wallet
2. If successful - you should see the event in TreasureChest.sol

## Solution
To be done

### Full Code of the TreasureChest contract
```
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/* 
Congratulations you have found the Treasure Chest contract.
You now need to make an interface contract to interact with the 
getTreasure method in this contract. Please look at the gist given 
during lesson for an example of an interface.
*/

interface ITeamRegistration {
	function registeredList(address) external view returns (bool);
}

contract TreasureChest {

    address immutable _owner;
    address TeamRegistrationContract;

	event InterfaceAddressedSet();
    event TreasureClaimed(address indexed, uint256 indexed, string indexed);
    
    modifier onlyAdmin() {
		require(msg.sender == _owner, "Not owner");
		_;
	}
    constructor() {
        _owner = msg.sender;
    }

    function setInterfaceAddress(address _address) external onlyAdmin {
        TeamRegistrationContract = _address;
		emit InterfaceAddressedSet();
    }

    function GetTreasure(address sender) external {
		require(ITeamRegistration(TeamRegistrationContract).registeredList(sender), "EOA is not registered!");
        emit TreasureClaimed(msg.sender, block.timestamp, "Well done!!");
    }
}
```
