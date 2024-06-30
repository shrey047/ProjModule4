# ERC20 SMART CONTRACT ON FUJI TESTNET

This Solidity program is a simple program that demonstrates the basic syntax and functionality of  custom tokens using erc20 contracts on the avalanche blockchain using the Solidity programming language. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to get a feel for how it works.

## Description

This program is a simple contract written in Solidity. The contract has a MULTIPLE functions. This program serves as a simple and straightforward introduction to erc20 contracts , and can be used as a stepping stone for more complex projects in the future.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., ProjModule4.sol). Copy and paste the following code into the file:

```javascript
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


```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.4" (or another compatible version), and then click on the "Compile ProjModule4.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "ProjModule4" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the mint , burn and redeem functions . Click on the "ProjModule4" contract in the left-hand sidebar, and then click on the "mint" function,"burn" function and "redeem" function. Finally, click on the "transact" button to execute the function and interaract with the contract.

## Authors

SHREY DIXIT


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
