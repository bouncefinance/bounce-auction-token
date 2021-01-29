// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";

contract BounceAuctionToken is ERC20Capped {
    using SafeMath for uint;

    address internal constant DeadAddress = 0x000000000000000000000000000000000000dEaD;
    address immutable private _botToken;

    event Swapped(address indexed sender, uint amountBot, uint amountAuction);

    constructor (address botToken) ERC20Capped(10000000e18) ERC20("Bounce Token", "Auction") public {
        _botToken = botToken;
    }

    function swap(uint amountBot) external {
        uint amountAuction = amountBot.mul(100);
        ERC20(_botToken).transferFrom(msg.sender, DeadAddress, amountBot);
        _mint(msg.sender, amountAuction);
        emit Swapped(msg.sender, amountBot, amountAuction);
    }
}
