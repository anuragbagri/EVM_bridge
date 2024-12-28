// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
 

// interface for rupee coin but we only need functiond from erc20 contract which has predefined interface.
import {IERC20}  from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract BridgeETH is Ownable {
    address tokenContractAddress ;
    mapping(address => uint256 ) public pendingBalance;
    
    event Deposit (address indexed  depositer , uint256 amount);

    constructor (address _tokenAddress) Ownable(msg.sender) {
       tokenContractAddress  = _tokenAddress;
    }

    function lock(address _tokenAddress , uint256 _amount) public {
      require(_tokenAddress == tokenContractAddress , "token address is invalid");
      require(IERC20(_tokenAddress).allowance(msg.sender, address(this)) >= _amount );   // this checks whether the swapper is allowed to deposit the amount in this contract 
      require(IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount));
      emit Deposit(msg.sender , _amount);
    }

    function unlock(address _tokenAddress , uint256 _amount) public {
       require(address(IERC20(_tokenAddress)) == tokenContractAddress);  // this checks that the token qualifies for erc-20 standards
       require(pendingBalance[msg.sender] >= _amount);
       pendingBalance[msg.sender] -= _amount;
       IERC20(_tokenAddress).transferFrom(address(this), msg.sender, _amount);
    }

    function burnedOnOtherSide(uint256 _amount) public onlyOwner {
      pendingBalance[msg.sender] += _amount ;
    }
}
