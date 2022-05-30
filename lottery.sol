//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//creating a contract for lottery

contract Lottery{
    uint maxAddresses;
    mapping(uint => address) members;
    uint public count;
    uint public rand;

    //constructor to intializing the state variables
    constructor(uint _count){
        maxAddresses=_count;
        rand=_count+1;
    }

    //function to get current address
    function getAddresses() public {
        require(count < maxAddresses,"pool saturated");
        members[count]=msg.sender;
        count+=1;
    }

    //function to get the random number 
    function getRandomNumber(uint _mod)public{
        rand=random(_mod);
        while(rand<=0){
            rand=random(_mod);
        }
        
    }

    //returning the lottery winner
    function lotteryWinner() public view returns(address ){
        return members[rand];
    }
    
    //here using the random function to generate the random number
    function random(uint mod) private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,msg.sender)))%mod;
    }
}