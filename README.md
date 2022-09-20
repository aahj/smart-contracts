# Solidity | Ethereum Blockchain

## Projects | Smart Contracts
### 1) Cryptos ICO
> 
● Our ICO will be a Smart Contract that accepts ETH in exchange for our own token named
Cryptos (CRPT);
● The Cryptos token is a fully compliant ERC20 token and will be generated at the ICO time;
● Investors will send ETH to the ICO contract’s address and in return, they’ll get an amount of
Cryptos;
● There will be a deposit address (EOA account) that automatically receives the ETH sent to
the ICO contract
● The CRPT token will be tradable only after a speciﬁc time set by the admin;

### 2) Implementing ERC20 Standards
>
● ERC20 is a proposal that intends to standardize how a token contract should be
deﬁned, how we interact with such a token contract and how these contracts interact
with each other.
● ERC20 is a standard interface used by applications such as wallets, decentralized
exchanges, and so on to interact with tokens;
● A token holder has full control and complete ownership of their tokens. The token’s
contract keeps track of token ownership in the same way the Ethereum network keeps
track of who owns ETH

### 3) Crowdfunding
>
● The Admin will start a campaign for CrowdFunding with a speciﬁc monetary goal and
deadline.
● Contributors will contribute to that project by sending ETH.
● The admin has to create a Spending Request to spend money for the campaign.
● Once the spending request was created, the Contributors can start voting for that
speciﬁc Spending Request.
● If more than 50% of the total contributors voted for that request, then the admin would
have the permission to spend the amount speciﬁed in the spending request.
● The power is moved from the campaign’s admin to those that donated money.
● The contributors can request a refund if the monetary goal was not reached within the
deadline.

### 4) Auction
>
● Smart Contract for a Decentralized Auction like an eBay alternative;
● The Auction has an owner (the person who sells a good or service), a start and an end
date;
● The owner can cancel the auction if there is an emergency or can ﬁnalize the auction
after its end time;
● People are sending ETH by calling a function called placeBid(). The sender’s address
and the value sent to the auction will be stored in mapping variable called bids;
● Users are incentivized to bid the maximum they’re willing to pay, but they are not bound
to that full amount, but rather to the previous highest bid plus an increment. The
contract will automatically bid up to a given amount;
● The highestBindingBid is the selling price and the highestBidder the person who won
the auction;
● After the auction ends the owner gets the highestBindingBid and everybody else
withdraws their own amount;

### 5) Lottery
>
1. The lottery starts by accepting ETH transactions. Anyone having an Ethereum wallet can
send a ﬁxed amount of 0.1 ETH to the contract’s address.
2. The players send ETH directly to the contract address and their Ethereum address is
registered. A user can send more transactions having more chances to win.
3. There is a manager, the account that deploys and controls the contract.
4. At some point, if there are at least 3 playesrs, he can pick a random winner from the
players list. Only the manager is allowed to see the contract balance and to randomly
select the winner.
5. The contract will transfer the entire balance to the winner’s address and the lottery is
reset and ready for the next round.