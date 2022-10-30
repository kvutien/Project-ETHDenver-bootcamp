// SPDX-License-Identifier: UNLICENSED
//  version 30 October 2022
pragma solidity ^0.8.0;
import "hardhat/console.sol";                       // use hardhat to send message to console

contract VolcanoCoin {
    uint256 totalSupply = 10000;                    // initial supply of Volcano coins
    address public owner;                           // deployer of the contract
    mapping(address => uint256) public usersBalances;  // keep track of amount of coins of each user
    event totalSupplyChanged(string, uint256);
    event amountTransferred(uint256, string, address);
    struct Payment{
        address sender;
        uint256 amount;
        address recipient;
    }
    mapping(address => Payment) public payments;        // cheat: not yet an array. Only last payment is recorded
    mapping(address => Payment[]) public paymentHistory;     // keep payments in an array
    Payment[] paymentsArray;                            // this array must be declared as global to allow push
    Payment public lastPayment;                         // used to display returned from getUserPayment

    modifier onlyOwner() {
        if(msg.sender == owner) {
            _;
        }
    }

    constructor() {
        owner = msg.sender;
        usersBalances[owner] = totalSupply;     // give owner all Volcano coins
    }

    function getTotalSupply() public view returns(uint256){
        // view number of Volcano coins
        return totalSupply;
    }

    function incrTotalSupply() public /*onlyOwner*/ {
        // beginner exercise, increment total supply by step of 1000, revert if not owner
        require(msg.sender == owner, "only owner can change total supply");
        totalSupply += 1000;
        emit totalSupplyChanged("new totalSupply =", totalSupply);
    }

    function getBalance(address user) public view returns(uint256) {
        // view the balance of a given user
        return usersBalances[user];
    }

    function recordLastPayment(uint256 _amount, address _recipient) public{
        // record the payment in the struct Payment of the payments mapping
        console.log("sender: ", msg.sender);
        payments[msg.sender].sender = /*_sender*/ msg.sender;
        payments[msg.sender].amount = _amount;
        payments[msg.sender].recipient = _recipient;
    }

    function recordPayment2(uint256 _amount, address _recipient) public{
        // retrieve from the paymentHistory mapping the payments array of sender
        paymentsArray = paymentHistory[msg.sender];
        console.log("payment array length:", paymentsArray.length);
        // make a new Payment struct
        Payment memory newPayment;
        newPayment.sender = msg.sender;
        newPayment.amount = _amount;
        newPayment.recipient = _recipient;
        // push the new struct in the array of user
        paymentsArray.push(newPayment);
        console.log("payment array length:", paymentsArray.length);
        // store the reference of the array in mapping for sender
        paymentHistory[msg.sender] = paymentsArray;
    }

    function transfer(uint256 _amount, address _recipient) public {
        // update the payments mapping, transfer coins, emit event
        require(usersBalances[msg.sender] >= _amount, "not enough balance to transfer");
        require(_recipient != address(0x00), "no transfer to a recipent with null address");
        // record the payment by updating the payments mapping
        recordLastPayment(_amount, _recipient);
        recordPayment2(_amount, _recipient);
        // do the transfer
        usersBalances[msg.sender] -= _amount;
        usersBalances[_recipient] += _amount;
        emit amountTransferred(_amount, " to ", _recipient);
    }

    function getUserLatestPayment(address _user) view public returns(uint256, address){
        require(_user != address(0x00), "this user has null address");
        // get the latest payment of an user
        return (payments[_user].amount, payments[_user].recipient);
    }

    function getUserPayment(address _user, uint256 _rank) public returns(uint256, address){
        require(_user != address(0x00), "this user has null address");
        // retrieve from the paymentHistory mapping the payments array of sender
        paymentsArray = paymentHistory[_user];
        console.log(_rank, paymentsArray.length);
        require(_rank <= paymentsArray.length, "rank of payment to retrieve exceeds payment count");
        // assign to lastPayment to view in Remix
        lastPayment.sender = _user;
        lastPayment.amount = paymentsArray[_rank-1].amount;
        lastPayment.recipient = paymentsArray[_rank-1].recipient;
        return (paymentsArray[_rank-1].amount, paymentsArray[_rank-1].recipient);
    }
}
