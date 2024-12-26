// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol"


contract Rupee is ERC20 {
    address private owner;

    constructor(address _address) is ERC20("Rupee" , "RU") {
        owner = _address;
    }

    function mint(uint256 _amount) public {
        require(owner == msg.sender);
        _mint(msg.sender , _amount);
    }
 }
