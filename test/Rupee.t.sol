// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Rupee.sol";

contract TestContract is Test {
    Rupee c;

    function setUp() public {
        c = new Rupee();
    }

    
}
