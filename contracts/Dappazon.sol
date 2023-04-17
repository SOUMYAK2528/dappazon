// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address public owner;

    constructor(){
        owner= msg.sender;
    }

    struct item{
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;
    }
    struct order {
        uint256 time;
        item item;
    }

    mapping(uint256=>item) public items;
    mapping(address=>uint256) public orderCount;
    mapping(address => mapping(uint256 =>order)) public  orders;

    event List(string name,uint256 cost ,uint256 quantity);
    event Buy(address Buyer , uint256 orderId ,uint256 itemId);
    
    modifier onlyOwner(){
        require(owner==msg.sender);
        _;
    }
    //List products 
    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public onlyOwner {

        //create item struct 

        item memory Item= item(
            _id,
            _name,
            _category,
            _image,
            _cost,
            _rating,
            _stock
            );

        //save item struct to blockchain
        items[_id]= Item;
        //emit an event 
        emit List(_name,_cost,_stock);


    }

    //Buy products
    function buy(uint256 _id) public payable{

        //fetching item from items mapping
        item memory itm = items[_id];

        //require enough ether to buy any product
        require(msg.value>=itm.cost);
        //require item is in stock
        require(itm.stock>0);

        //create an order
        order memory ordr= order(block.timestamp , itm);
        orderCount[msg.sender]++;

        //save order to chain using mapping data structur 
        orders [msg.sender][orderCount[msg.sender]] = ordr;
        //substract stock 
        items[_id].stock= itm.stock-1;
        //Emit event

        emit Buy(msg.sender,orderCount[msg.sender],itm.id);

    }

    //Withdraw funds

    function withdraw() public onlyOwner{
        (bool success,) = owner.call{value:address(this).balance}("");
        require(success);
    }

}
