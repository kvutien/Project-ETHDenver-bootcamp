# Session 13, Project-ETHDenver-bootcamp
7 November 2022
# Zoom session
* 92 attendants, gas optimization game
* •	No course materials today because the gas optimization game continues
* The zoom recording of 3rd November: https://youtu.be/RkHCl0rWKtY
* Session 13 useful links: see solution below

# Homework
## Assignment: Prepare tomorrow
Discuss with your team secure random values in contracts

## Solution 
-	Chainlink VRF distributed random oracle: https://docs.chain.link/docs/chainlink-vrf.
-	League of Entropy distributed random number generator: https://www.cloudflare.com/leagueofentropy/.
- Example of code using Chainlink VRF: https://ethereum.stackexchange.com/questions/191/how-can-i-securely-generate-a-random-number-in-my-smart-contract

```js
pragma solidity 0.6.2;

import "https://raw.githubusercontent.com/smartcontractkit/chainlink/develop/contracts/src/v0.6/VRFConsumerBase.sol";

contract Verifiable6SidedDiceRoll is VRFConsumerBase {
    using SafeMath for uint;
    
    bytes32 internal keyHash;
    uint256 internal fee;
    
    event RequestRandomness(
        bytes32 indexed requestId,
        bytes32 keyHash,
        uint256 seed
    );
    
    event RequestRandomnessFulfilled(
        bytes32 indexed requestId,
        uint256 randomness
    );
    
    /**
     * @notice Constructor inherits VRFConsumerBase
     * @dev Ropsten deployment params:
     * @dev   _vrfCoordinator: 0xf720CF1B963e0e7bE9F58fd471EFa67e7bF00cfb
     * @dev   _link:           0x20fE562d797A42Dcb3399062AE9546cd06f63280
     */
    constructor(address _vrfCoordinator, address _link)
        VRFConsumerBase(_vrfCoordinator, _link) public
    {
        vrfCoordinator = _vrfCoordinator;
        LINK = LinkTokenInterface(_link);
        keyHash = 0xced103054e349b8dfb51352f0f8fa9b5d20dde3d06f9f43cb2b85bc64b238205; // hard-coded for Ropsten
        fee = 10 ** 18; // 1 LINK hard-coded for Ropsten
    }
    
    /** 
     * @notice Requests randomness from a user-provided seed
     * @dev The user-provided seed is hashed with the current blockhash as an additional precaution.
     * @dev   1. In case of block re-orgs, the revealed answers will not be re-used again.
     * @dev   2. In case of predictable user-provided seeds, the seed is mixed with the less predictable blockhash.
     * @dev This is only an example implementation and not necessarily suitable for mainnet.
     * @dev You must review your implementation details with extreme care.
     */
    function rollDice(uint256 userProvidedSeed) public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) > fee, "Not enough LINK - fill contract with faucet");
        uint256 seed = uint256(keccak256(abi.encode(userProvidedSeed, blockhash(block.number)))); // Hash user seed and blockhash
        bytes32 _requestId = requestRandomness(keyHash, fee, seed);
        emit RequestRandomness(_requestId, keyHash, seed);
        return _requestId;
    }
    
    function fulfillRandomness(bytes32 requestId, uint256 randomness) external override {
        uint256 d6Result = randomness.mod(6).add(1);
        emit RequestRandomnessFulfilled(requestId, randomness);
    }
    
}
```