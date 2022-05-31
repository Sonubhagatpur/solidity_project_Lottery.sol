// SPDX-License-Identufier: UNLICENSED
Pragma solidity>=0.7.0<9.9.0;

Contract Lottery {
     address public owner;
     address payable[] public players;

     Constructor() {
         owner=msg.sender;
     }
     receive() external payable {
     require(msg.value>=500 Wei,"you can't participate with low balance");
     players.push(payable(msg.sender));
     }
     function getBalance() public view returns(uint) {
         require(msg.sender==owner,"you are not the owner of the Lottery");
         return address(this).balance;
     }
     function random() public view returns(uint) {
         return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
     }
     function selectwinner() public {
         require(msg.sender==owner,"you are not the owner of the Lottery");
         require(players.length>=3,"players must be at least 3 or greater");
         address payable winner;
         uint r = random();
         uint index = r%players.length;
         winner = players[index];
         winner.transfer(getBalance());
         players = new address payable[](0);
     }
}


      
