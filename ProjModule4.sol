// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    uint256 public greenGemPrice = 1 ether; // Price of green gem in tokens
    uint256 public blueGemPrice = 2 ether;  // Price of blue gem in tokens
    uint256 public redGemPrice = 3 ether;   // Price of red gem in tokens

    // Constructor to initialize the token with name and symbol
    constructor() ERC20("Degen Gaming Token", "DGT") Ownable(msg.sender) {}

    // Function to mint new tokens, only the owner can call this function
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to redeem tokens for items in the in-game store
    // This function burns the tokens from the player's balance
    function redeemTokens(uint256 amount, uint256 gemType) public {
        require(gemType >= 0 && gemType <= 2, "Invalid gem type"); // Ensure gemType is within valid range

        uint256 gemPrice;

        if (gemType == 0) {
            gemPrice = greenGemPrice;
        } else if (gemType == 1) {
            gemPrice = blueGemPrice;
        } else if (gemType == 2) {
            gemPrice = redGemPrice;
        }

        require(amount >= gemPrice, "Insufficient tokens to redeem this gem");

        _burn(msg.sender, gemPrice);
        
        // Add logic to handle the redemption, e.g., transfer items to the player
        emit TokensRedeemed(msg.sender, gemType, gemPrice);
    }

    // Function to burn tokens, anyone can burn their own tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Event emitted when tokens are redeemed
    event TokensRedeemed(address indexed player, uint256 gemType, uint256 amount);

    // Function to transfer tokens
    function transferTokens(address to, uint256 amount) public returns (bool) {
        return transfer(to, amount);
    }

    // Function to check token balance
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Owner functions to set gem prices
    function setGreenGemPrice(uint256 price) public onlyOwner {
        greenGemPrice = price;
    }

    function setBlueGemPrice(uint256 price) public onlyOwner {
        blueGemPrice = price;
    }

    function setRedGemPrice(uint256 price) public onlyOwner {
        redGemPrice = price;
    }
}
