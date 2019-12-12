pragma solidity ^0.5.14;

contract Inheritance{
    
    /*
    function paisaaDoo(uint a,uint b) public pure returns (uint sum, uint product){
        sum = a + b;
        product = a * b;
    }*/
    
    address owner;
    bool deceased;
    uint money;
    
    constructor() public payable {
        owner = msg.sender;
        money = msg.value;
        deceased = false;
    }
    
    
    modifier oneOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier isDeceased {
        require(deceased == true);
        _;
    }
    
   
    
    address payable[] wallets;
    
    mapping(address => uint) inheritance;
    
    function setup(address payable _wallet, uint _inheritance) public oneOwner {
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
    }
    
    function moneyPaid() private isDeceased {
        for(uint i=0; i<wallets.length; i++){
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }
    
    function died() public oneOwner {
        deceased = true;
        moneyPaid();
    }
    
}