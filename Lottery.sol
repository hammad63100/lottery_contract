// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address public manager;
    address payable [] public  participants;
    
    constructor() {
        manager=msg.sender;  //global variable 

    }

    receive() external payable {

        // participants.push(msg.sender);
        require(msg.value==1 ether);
        // require(msg.sender !=manager);
        participants.push(payable(msg.sender));

    }

    function getBalance() public view returns(uint ){
        require(msg.sender == manager);
        return address(this).balance;   //address(this)==address(Lottery)
    }

    function random() public view  returns(uint) {
        uint result = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp,participants.length)));

        return result;
    }

    function selectWinner() public {
        require(msg.sender == manager);
        require(participants.length>=3);
        uint r=random();
        address payable  winner;
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(getBalance());

        participants=new address payable[](0);

    } 
    
     


}