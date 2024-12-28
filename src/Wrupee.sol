// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Wrupee is ERC20 {
    address private owner;

    constructor(address _address) ERC20("Wrupee" , "WRU") {
        owner = _address;
    }

    function mint(uint256 _amount) public {
        require(owner == msg.sender);
        _mint(msg.sender , _amount);
    }

    function burn(address _from , uint256 _amount) public {
        require(owner == msg.sender);
        _burn(_from , _amount);
    }
 }
