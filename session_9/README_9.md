# Session 9, Project-ETHDenver-bootcamp
31 October 2022
# Zoom session
* 120 attendants, ethers.js
  * explanation of ethers.js: getSigners, deploy, connect
  * how to fork mainnet for involved tests
  * solution of homework 8 on Remix using gitpod
* The zoom recording of 26th October: https://youtu.be/ziHRj6kNDhs
* Session 9 useful links:
    - https://gitpod.io/workspaces/: *(homework 8)* gitpod page
    - https://remix-ide.readthedocs.io/en/latest/unittesting_examples.html: *(homework 8)* documentation Remix test
    - https://www.youtube.com/watch?v=p7yjjynRJAQ&t=199s: (homework 8) YouTube demo of Remix testing
    - https://www.youtube.com/watch?v=ngxWWS3Qr3Q: explanation of ERC 1155, multi-tokens, fungible and non-fungible
    - https://docs.openzeppelin.com/contracts/2.x/api/token/erc721: *(homework 9)* Open Zeppelin documentation of the library ERC721 that is used to manage NFTs
    - https://coinsbench.com/how-to-write-a-simple-nft-erc-721-contract-with-open-zeppelin-9b47b44803a9: *(homework 9)* examples of NFT code with Open Zeppelin libraries
    - https://ethereum.stackexchange.com/questions/97186/what-is-the-reason-behind-writing-using-counters-for-counters-counters-when-us: *(homework 9)* explanation of a special instruction (using Counters for Counters.Counter) in Open Zeppelin.


# Homework
## Assignment: Deploy & test VolcanoCoin
We now want to create an NFT. We will use the Open Zeppelin libraries to help with this.
1.	Create a new project in the IDE of your choice called `NFTProject`
2.	Create a `VolcanoNFT` contract. This should inherit from any ERC721 implementation from the Open Zeppelin standard libraries
3.	Give your NFT a name and a symbol.

Write unit tests to check that you can
1.	Mint new NFTs
2.	Transfer an NFT
3.	Deploy your contract to Goerli and send some NFTs to your colleagues.

## Solution 
*Create a new project in the IDE of your choice, create a VolcanoNFT contract from the Open Zeppelin standard libraries, give your NFT a name and a symbol.*

-	The solution of this can be derived from the blog https://coinsbench.com/how-to-write-a-simple-nft-erc-721-contract-with-open-zeppelin-9b47b44803a9. We use Remix for the solution, in a new file named `VolcanoNFT.sol`.
```solidity
  // SPDX-License-Identifier: UNLICENSED
  pragma solidity ^0.8.0;
```
-	We import two Open Zeppelin libraries Ownable and ERC721. The Ownable library gives the owner (deployer of the contract) special privileges. The ERC721 library includes the basic functions and interfaces for a contract that is compliant ERC-721 standard.
```solidity
  import “https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
  import “https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

  contract VolcanoNFT is Ownable, ERC721("Volcano token", "VNFT"){}
```
*Write unit tests to check that you can mint new NFTs, transfer an NFT, deploy your contract to Goerli and send some NFTs to your colleagues.*
-	The code is
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is Ownable, ERC721("Volcano token", "VNFT"){
    uint256 tokenId;
    struct tokenMetadata{uint256 tokenId;}
    mapping (address => tokenMetadata) public ownershipRecord;
    event myEvent(uint256);

    function mintToken(address recipient) onlyOwner public{
        require(owner() != recipient, "owner can't mint for oneself");
        _safeMint(recipient, tokenId);
        ownershipRecord[recipient] = tokenMetadata(tokenId);
        emit myEvent(ownershipRecord[recipient].tokenId);
        tokenId += 1;
    }
    // TODO: transfer NFT, deploy on Goerli, send NFT to colleague
}
```



... ***To be continued*** Transfer NFT, deploy on Goerli, send NFT to colleague