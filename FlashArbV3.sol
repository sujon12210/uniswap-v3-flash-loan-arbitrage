// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@uniswap/v3-core/contracts/interfaces/callback/IUniswapV3FlashCallback.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlashArbV3 is IUniswapV3FlashCallback {
    address public immutable factory;
    address public owner;

    constructor(address _factory) {
        factory = _factory;
        owner = msg.sender;
    }

    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address payer;
    }

    function initiateFlashLoan(
        address pool,
        uint256 amount0,
        uint256 amount1
    ) external {
        IUniswapV3Pool(pool).flash(
            address(this),
            amount0,
            amount1,
            abi.encode(FlashCallbackData({
                amount0: amount0,
                amount1: amount1,
                payer: msg.sender
            }))
        );
    }

    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external override {
        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));

        // ARBITRAGE LOGIC GOES HERE
        // Example: Swap borrowed Token0 for Token1 on another DEX
        // Ensure you have enough to cover (principal + fee)

        if (decoded.amount0 > 0) {
            uint256 amountToRepay = decoded.amount0 + fee0;
            IERC20(IUniswapV3Pool(msg.sender).token0()).transfer(msg.sender, amountToRepay);
        }
        if (decoded.amount1 > 0) {
            uint256 amountToRepay = decoded.amount1 + fee1;
            IERC20(IUniswapV3Pool(msg.sender).token1()).transfer(msg.sender, amountToRepay);
        }
    }
}
