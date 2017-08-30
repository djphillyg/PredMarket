var PredMarket = artifacts.require("./PredMarket.sol");

contract('PredMarket',function(accounts){

  var contract;
  var owner = accounts[0];
  var bet1 = accounts[1];

  var bet2 = accounts[2];
  var outcome = true;
  beforeEach(function() {
    return PredMarket.new(outcome)
      .then(function(instance){
        contract = instance;
      });
  });

  it("should have a correct outcome when started",function(){
    return contract.verifyOutcome()
      .then(function(ro)
      {assert.equal(outcome,ro,"contract owner is not as expected")});
  });

  it("should hold the contract owner", function() {
    return contract.getOwner()
      .then(function(own) {
        assert.strictEqual(owner,own, "contract owner should be the same")});
  });




})
