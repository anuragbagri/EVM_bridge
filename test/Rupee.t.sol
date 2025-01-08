// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Rupee.sol";

contract Rupee is Test {
    Rupee c;
    uint256 amount = 1000;

    function setUp() public {
        c = new Rupee(msg.sender);
    }

    function testMint() public {
        vm.prank(msg.sender);
        c.mint(amount);
        assertEq(c.balanceOf(msg.sender), 1000, "ok");
    }
}
