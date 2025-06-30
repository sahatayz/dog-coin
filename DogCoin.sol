// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.28;

contract DogCoin {
    uint256 totalSupply = 2_000_000;
    event SupplyChanged(uint256 newSupply);
    event Transfer(address indexed to, uint256 amount); //what is 'indexed'?
    address owner;
    mapping(address => uint256) public balances;
    mapping(address => Payment[]) public paymentRecords;

    struct Payment{
        address recipient;
        uint256 amount;
    }

    modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }

    constructor() { 
        owner = msg.sender;
        balances[owner] = totalSupply;
    }
    
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function increaseSupply() public onlyOwner{
        totalSupply += 1000;
        emit SupplyChanged(totalSupply);
    }

    function transfer(address _recipient, uint256 _amount) public{
        require(_amount <= balances[msg.sender]);
        require(balances[_recipient] + _amount <= totalSupply);
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_recipient, _amount);
        Payment(_recipient, _amount);
        paymentRecords[msg.sender].push(Payment(_recipient, _amount));
    }
    
    function getBalanceOf(address _user) public view returns (uint256){
        return balances[_user];
    }
}