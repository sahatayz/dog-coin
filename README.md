# DogCoin - Simple Token Contract

## Overview
DogCoin is a basic ERC20-like token implementation on Ethereum with fixed supply management and transaction tracking. This contract demonstrates core token functionality including transfers, supply management, and balance tracking.

## Key Features
- **Fixed Initial Supply**: 2,000,000 tokens minted on deployment
- **Controlled Supply Expansion**: Owner can increase supply by 1,000 tokens
- **Token Transfers**: Secure transfer functionality with balance checks
- **Transaction History**: Permanent record of all payments per address
- **Balance Tracking**: Public view of any address's token balance

## Contract Details
- **Solidity Version**: 0.8.28
- **License**: Unlicensed (SPDX identifier UNLICENSED)
- **Storage**: 
  - `totalSupply`: Current token supply
  - `balances`: Token balances per address
  - `paymentRecords`: Historical payment records per sender

## Functions

### Core Functions
| Function          | Description                                | Access      |
|-------------------|--------------------------------------------|-------------|
| `getTotalSupply()` | Returns current token supply               | Public view |
| `increaseSupply()` | Increases supply by 1,000 tokens           | Owner only  |
| `transfer()`      | Sends tokens to another address            | Public      |
| `getBalanceOf()`  | Returns balance of specified address       | Public view |

### Special Functionality
- **Payment Records**: Each transfer stores recipient and amount in sender's `paymentRecords`
- **Ownership Control**: Deployer automatically becomes owner with full supply

## Events
| Event              | Parameters                          | Description                     |
|--------------------|-------------------------------------|---------------------------------|
| `SupplyChanged`    | `uint256 newSupply`                 | Emitted when supply increases   |
| `Transfer`         | `address indexed to, uint256 amount`| Emitted on token transfers      |

> **About `indexed`**: The `indexed` keyword allows efficient filtering of event logs by the `to` address in blockchain explorers like Etherscan.

## Usage Example

### Deploying
```javascript
// Deploy contract (deployer becomes owner)
const DogCoin = await ethers.getContractFactory("DogCoin");
const dogCoin = await DogCoin.deploy();
```
### Transferring Tokens
```javascript
// Transfer 100 tokens
await dogCoin.transfer(recipientAddress, 100);

// Check balance
const balance = await dogCoin.getBalanceOf(userAddress);
```
### Increasing Supply (Owner Only)
```javascript
await dogCoin.increaseSupply();
const newSupply = await dogCoin.getTotalSupply();
```
### Important Notes
**Initial Distribution:** Contract deployer receives all initial tokens

**Supply Control:** Only owner can increase supply (by 1,000 tokens per call)

**Transfer Requirements:**
**-** Sender must have sufficient balance
**-** Recipient's new balance cannot exceed total supply

**Payment Records:** All transfers are permanently stored in paymentRecords mapping

**Security:** No reentrancy protection - not intended for production use
