pragma solidity ^0.4.11;


contract PredMarket {

    address public owner;

    Oracle public myOracle;

    struct Oracle {
        bool outcome;
    }
    struct Customer {
        address _owner;
        uint _amount;
        bool _outcome;
    }



    Customer[] customers;
    uint numElements = 0;

    modifier isOwner(address _sender) {
        require(owner == _sender);
        _;
    }


    function verifyOutcome() public constant returns(bool) {
      return myOracle.outcome;
    }

    function PredMarket(bool getOutcome) public {
        owner = msg.sender;
        myOracle.outcome = getOutcome;

    }

    function getOwner() public constant returns(address) {
      return owner;
    }


    function makeBet(bool outcome) public payable {
        require(msg.value>0);

        Customer memory newCustomer;
        newCustomer._owner = msg.sender;
        newCustomer._amount = msg.value;
        newCustomer._outcome = outcome;
        customers[numElements++] = newCustomer;

    }

    function settleBet()   {
        require(customers.length>0);
         bool outcome = myOracle.outcome;
        //maybe all of them are winners
        Customer[] memory winners = new Customer[](customers.length);
        uint wElements = 0;
        var i = 0;
        uint totalPayout;
        while(i<numElements){
            if(outcome == customers[i]._outcome){
                winners[wElements++] = customers[i];
            }
            totalPayout+=customers[i]._amount;
           i++;
        }

        uint indPayout = totalPayout/wElements;
         i = 0;
         while(i<wElements){
             customers[i]._owner.transfer(indPayout);
         }

    }

    function getBalance() returns (uint256) {
        return owner.balance;
    }

    function clear() {
        numElements = 0;
    }




}
