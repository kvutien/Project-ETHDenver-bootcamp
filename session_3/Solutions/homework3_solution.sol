// SPDX-License-Identifier: None
pragma solidity 0.8.17;

contract BootcampContract {
    uint256 number;
    address public owner;
    address public deadAddress;

    constructor (){
        owner = msg.sender;
        deadAddress = 0x000000000000000000000000000000000000dEaD;
    }

    function peekAddress() external view returns(address) {
        if(msg.sender == owner) {
            return deadAddress;
        } else {
            return owner;
        }
    }
    
    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns(uint256) {
        return number;
    }
}