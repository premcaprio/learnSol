//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint256 public maxSupply;
    uint256 public circulatingSupply;
    uint256 public decimal;
    address public owner;
    mapping(address => uint256) public ledger; //collect all address involving in the system
    mapping(address => address) trust;
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _maxSupply,
        uint256 _decimal) {
            owner = msg.sender;
            name = _name;
            symbol = _symbol;
            maxSupply = _maxSupply;
            decimal = _decimal;
    } 

    function mint(uint256 _amount, address _address) public onlyOwner{
        require(circulatingSupply + _amount > maxSupply, "error");
        ledger[_address] += _amount;
        circulatingSupply += _amount;
    }

    function burn(uint256 _amount) public {
        ledger[msg.sender] -= _amount;
        circulatingSupply -= _amount;
    }

    function balance(address _address) public view returns(uint256) {
        return ledger[_address];
    }

    function transfer(address _to, uint256 _amount) public {
        ledger[msg.sender] -= _amount;
        ledger[_to] += _amount;
    }

    function approve(address _address) public {
        trust[msg.sender] = _address;
    }

    function trustClaim(address _truster) public{
        require(trust[_truster] == msg.sender, "must be trustee");
        uint256 amount = ledger[_truster];
        ledger[_truster] = 0;
        ledger[msg.sender] += amount;
    }

}