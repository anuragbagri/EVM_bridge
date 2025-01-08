// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Wrupee.sol";

contract Wrupee is Test {
    Wrupee c;

    function setUp() public {
        c = new Wrupee(msg.sender);
    }

    function testMint() public {
        c.mint(100);
        assertEq(c.balanceOf(msg.sender), 100, "ok");
    }

    function testBurn() public {
        c.burn(msg.sender, 100);
        assertEq(c.balanceOf(msg.sender), 0, "ok");
    }
}
