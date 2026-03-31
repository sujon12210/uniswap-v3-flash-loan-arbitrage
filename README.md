# Uniswap V3 Flash Loan Arbitrage

A professional-grade implementation for executing Flash Loans on Uniswap V3. Unlike V2, V3 allows for "Flash Swaps" and direct Flash Loans from specific price ticks, offering superior gas efficiency and access to concentrated liquidity for high-slippage trades.

## Core Features
* **Concentrated Liquidity Access:** Borrow any ERC-20 asset directly from a V3 Pool.
* **Callback Security:** Implements `IUniswapV3FlashCallback` to ensure atomic execution.
* **Arbitrage Logic:** Placeholder for executing swaps on a second DEX (e.g., SushiSwap) before repaying the loan.
* **Flat Architecture:** Single-directory layout for easy deployment and testing.

## Workflow
1. **Request:** Call `initiateFlashLoan` on the contract.
2. **Receive:** The Uniswap V3 Pool sends the requested tokens to this contract.
3. **Execute:** The `uniswapV3FlashCallback` function is triggered. Perform your trade here.
4. **Repay:** The contract automatically calculates the fee and repays the pool.

## Setup
1. `npm install`
2. Deploy `FlashArbV3.sol` with the Uniswap V3 Factory address.
