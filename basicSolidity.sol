//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicSolidity {
    //Iron man profile
    string public name = 'Tony stark';
    uint256 public age = 48;
    bool public isMale = true;
    uint256 public balance = 500;
    string[] public careers = ['Playboy', 'Engineer', "avenger"];
    address private wallet;
    string[] public girl;
    //mapping basically returns zero 
    mapping(string => uint256) public milesOfCar; 
    mapping(string => bool) public isCar;
    address public owner;
    uint256 public global;
    address[] public listOfVip;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Constructor is the first function which designates the smart contract.
    constructor(uint256 _balance, address _wallet, address[] memory _listOfVip) {
        owner = msg.sender;
        balance = _balance;
        wallet = _wallet;
        listOfVip = _listOfVip;
    }

    //Push function is to append variable in array.
    function tinder(string memory _girl) public {
        girl.push(_girl);
    }
    
    // view returns(type) is to return the variable. Only owner can see it??
    function getWallet() public view onlyOwner returns(address) {
        return wallet;
    }

    // everytime we use string as parameter it need MEMORY
    // require is like if-else.
    function addCar(string memory _car, uint _miles) public {
        require(isCar[_car] == false, "Tony already have this car.");
        milesOfCar[_car] = _miles;
        isCar[_car] = true;

    }

    function getNumber(uint256 _i) public view returns(uint256) {
        uint256 local = _i;
        uint256 result = global + local;
        return result;
    }

    function transfer(uint256 _withdrawl, string memory _to) public view returns(uint256){
        require(balance > _withdrawl);
        uint256 result = balance - _withdrawl;
        return result; 
        //Tony trandfer money to somebody
        //must return current balance of Tony
        // inout should have _amount, _to
        //Use require 
    }

    function fasterCar(string memory car1, string memory car2) public view returns(string memory) {
        if (milesOfCar[car1] > milesOfCar[car2]) {
            return car1;
        } else if (milesOfCar[car1] < milesOfCar[car2]){
            return car2;
        } else {
            return "there is no faster car";
        }
    
    }
   // modifier onlyVIP {
   //     require(listOfVip);
    //    _;
    //}

    function isVIP() public view returns(string memory){
        
    }

}