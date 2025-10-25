// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

contract VendingMachine {
    address public owner;
    mapping (address => uint) public cupcakeBalances;
    string private _symbol;

    constructor(string memory symbol_) {
        owner = msg.sender;
        _symbol = symbol_;
        cupcakeBalances[address(this)] = 100;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    function balanceOf(address account) public  view virtual returns (uint256) {
        return cupcakeBalances[account];
    }

    function getVendingMachineBalance() public view returns (uint) {
        return cupcakeBalances[address(this)];
    }

    function refill(uint amount) public  {
        require(msg.sender == owner, "Only the owner can refill.");
        cupcakeBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1e9, "You must pay at least 1 GWEI per cupcake");
        require(cupcakeBalances[address(this)] >= amount, "Not enough cupcakes in stock");
        cupcakeBalances[address(this)] -= amount;
        cupcakeBalances[msg.sender] += amount;
    }
}