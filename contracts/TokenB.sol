// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./tokenContract.sol";

contract TokenB is TokenContract {
    constructor() TokenContract("Token B", "TKB") {}
}
