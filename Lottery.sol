// SPDX-License-Identifier:MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Lottery{
    address public owner;
    address payable[] public players;

    constructor(){
        owner = msg.sender;
    }
    receive() external payable{
        require(msg.value>=1 ether,"you can't participate with low balance");
        players.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint){
        require(msg.sender==owner,"you are not the owner of the lottery");
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));

    }
    function selectWinner() public{
        require(msg.sender==owner,"you are not the owner of the lottery");
        require(players.length>=3,"players must be at least 3 or greater");
        address payable winner;
        uint callrandom = random();
        uint index = callrandom%players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0);

    }
    
}
