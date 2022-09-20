// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address payable[] public players;
    address public manager;

    constructor() {
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value == 0.1 ether, "ether should be 0.1");
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns (uint256) {
        require(msg.sender == manager, "You can not see contract balance"); //only manager can see balance
        return address(this).balance;
    }

    function random() public view returns (uint256) {
        //  keccak256 is used to process the Keccak-256 hash of the data input
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        players.length
                    )
                )
            );
    }

    function pickWinner() public {
        require(
            msg.sender == manager,
            "You are not supposed to call this function"
        );
        require(
            players.length >= 3,
            "There at least 3 members to play this game"
        );
        uint256 rand = random();
        address payable winner;
        uint256 index = rand % players.length; //getting remainder like 5 % 2 => 1
        winner = players[index];
        winner.transfer(getBalance()); //winner will get all ETH i.e. lottery
        players = new address payable[](0); //resetting the lottery
    }
}
