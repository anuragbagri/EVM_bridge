// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

interface IRUP is IERC20 {
    function mint(uint256 _amount) external ;
    function burn(address _from , uint256 _amount) external ;
}


contract BrigdeBase is Ownable {


    address tokenContractAddress ;
    mapping(address => uint256 ) pendingBalance ;


    event Burn(address indexed burner , uint256 amount);


    constructor(address _tokenAddress) Ownable(msg.sender) {
       tokenContractAddress = _tokenAddress ;
    }


    function Burn(address _tokenAddress , uint256 _amount) public {
        require(address(IRUP(_tokenAddress)) == tokenContractAddress );
        IRUP(_tokenAddress).burn(msg.sender , _amount);
        emit Burn(msg.sender , _amount);
    }


     function withdraw(address _tokenAddress, uint256 _amount) public {
        require(address(IRUP(_tokenAddress)) == tokenContractAddress );
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.mint( _amount);
    }


    function depositHappenOnOtherSide(uint256 _amount) public onlyOwner {
       pendingBalance += _amount;
    }
}