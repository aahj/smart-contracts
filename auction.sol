// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Auction {
    address payable public owner;
    uint256 public startBlock;
    uint256 public endBlock;
    string public ipfsHash;
    enum State {
        Started,
        Running,
        Ended,
        Cancelled
    }
    State public auctionState;
    uint256 public highestBindingBid;
    address payable public highestBidder;
    mapping(address => uint256) public bids;
    uint256 bidIncrement;
    uint256 constant numOfSecondsInWeek = 60 * 60 * 24 * 7;
    uint256 constant blockCreatedAfterSeconds = 50; //after 50sec new block creates
    uint256 constant numOfBlocksInWeek =
        numOfSecondsInWeek / blockCreatedAfterSeconds;

    constructor(address EOA) {
        owner = payable(EOA);
        auctionState = State.Running;
        startBlock = block.number; // block.number is the current block number
        // endBlock = startBlock +  numOfBlocksInWeek;
        endBlock = startBlock + 3; //aution ends after 3 transaction
        ipfsHash = "";
        // bidIncrement =100;
        bidIncrement = 1000000000000000000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You must to be owner first");
        _;
    }
    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot place bids");
        _;
    }
    modifier afterStart() {
        require(block.number >= startBlock);
        _;
    }
    modifier beforeEnd() {
        require(block.number <= endBlock);
        _;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a <= b) return a;
        return b;
    }

    function placeBid() public payable notOwner afterStart beforeEnd {
        require(auctionState == State.Running);
        require(msg.value >= 100, "Bid should be >=100 wei"); //100 wei
        uint256 currentBid = bids[msg.sender] + msg.value;
        require(currentBid > highestBindingBid);
        bids[msg.sender] = currentBid;
        if (currentBid <= bids[highestBidder]) {
            highestBindingBid = min(
                currentBid + bidIncrement,
                bids[highestBidder]
            );
        } else {
            highestBindingBid = min(
                currentBid,
                bids[highestBidder] + bidIncrement
            );
            highestBidder = payable(msg.sender);
        }
    }

    function cancelAuction() public onlyOwner {
        auctionState = State.Cancelled;
    }

    function finalizeAuction() public {
        require(auctionState == State.Cancelled || block.number > endBlock); //block.number > endBlock means aution ended
        require(msg.sender == owner || bids[msg.sender] > 0);
        address payable recepient;
        uint256 value;
        if (auctionState == State.Cancelled) {
            //aution was cancelled
            recepient = payable(msg.sender);
            value = bids[msg.sender];
        } else {
            //auction ended(not cancelled)
            if (msg.sender == owner) {
                recepient = owner;
                value = highestBindingBid;
            } else {
                //this is bidder
                if (msg.sender == highestBidder) {
                    recepient = highestBidder;
                    value = bids[highestBidder] - highestBindingBid;
                } else {
                    //this is nethier owner nor highestBidder
                    recepient = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }
        // resetting the bids of the recepient to zero
        bids[recepient] = 0;
        recepient.transfer(value);
    }
}

// this AuctionCreator deploys actual Auction Contract to serve multi-auction purpose;
contract AuctionCreator {
    Auction[] public auctions;

    function createAuction() public {
        Auction newAuction = new Auction(msg.sender);
        auctions.push(newAuction);
    }
}
