// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {IERC20} from "./interfaces/IERC20.sol";
import {Events} from "./lib/events.sol";

contract TokenSwap {
    address public tokenA;
    address public tokenB;

    uint256 public rateAB;
    uint256 public rateBA;

    constructor(
        address _tokenA,
        address _tokenB,
        uint256 _rateAB,
        uint256 _rateBA
    ) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        rateAB = _rateAB;
        rateBA = _rateBA;
    }

    function swapAtoB(uint256 _amountA) external {
        require(_amountA > 0, "Amount must be greater than 0");

        uint256 _amountB = (_amountA * rateAB) / 100;

        require(
            IERC20(tokenB).balanceOf(address(this)) >= _amountB,
            "Insufficient tokenB liquidity"
        );

        require(
            IERC20(tokenA).transferFrom(msg.sender, address(this), _amountA),
            "TokenA transfer failed"
        );

        require(
            IERC20(tokenB).transfer(msg.sender, _amountB),
            "TokenB transfer failed"
        );

        emit Events.Swap(tokenA, tokenB, msg.sender, _amountA);
    }

    function swapBtoA(uint256 _amountB) external {
        require(_amountB > 0, "Amount must be greater than 0");

        uint256 _amountA = (_amountB * rateBA) / 100;

        require(
            IERC20(tokenA).balanceOf(address(this)) >= _amountA,
            "Insufficient tokenA liquidity"
        );

        require(
            IERC20(tokenB).transferFrom(msg.sender, address(this), _amountB),
            "TokenB transfer failed"
        );

        require(
            IERC20(tokenA).transfer(msg.sender, _amountA),
            "TokenA transfer failed"
        );

        emit Events.Swap(tokenB, tokenA, msg.sender, _amountB);
    }

    function balanceOfA(
        address _accountAddress
    ) external view returns (uint256) {
        address target = _accountAddress == address(0)
            ? msg.sender
            : _accountAddress;
        return IERC20(tokenA).balanceOf(target);
    }

    function balanceOfB(
        address _accountAddress
    ) external view returns (uint256) {
        address target = _accountAddress == address(0)
            ? msg.sender
            : _accountAddress;
        return IERC20(tokenB).balanceOf(target);
    }

    function contractBalances()
        external
        view
        returns (uint256 balanceA, uint256 balanceB)
    {
        balanceA = IERC20(tokenA).balanceOf(address(this));
        balanceB = IERC20(tokenB).balanceOf(address(this));
    }
}
