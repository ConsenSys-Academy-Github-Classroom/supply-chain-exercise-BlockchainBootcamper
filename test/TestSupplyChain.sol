// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {
    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests

    /* Notes to course people: 
       I tried to implement tests here but...
       - the core of the problem is that calls to buyItem() always fail when it hits an Ether transfer in the SupplyChain.sol
       - with the technique shown on https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-solidity#testing-for-exceptions (using abi.encodeWithSignature() instead of abi.encodePacked() because buyItem() has parameters, 
         as explained on https://solidity-by-example.org/call/), there seems to be no way to know what error occured
            => the "test for failure if user does not send enough funds" can't be designed in a way that it actually tests that condition, because buyItem() fails even when enough value is sent, leading to false-passes
            => all other tests suppose to bring an Item into a state which can't be reached since buyItems() fails
       - the URL provided above leads to a 404 error page
       - the truffle test engine always says that no events were emitted which makes it impossible to get any feedback on the internal contract state
        ----    code I tried ---
            SupplyChain supplychain = SupplyChain(DeployedAddresses.SupplyChain());
            supplychain.addItem('Dark horse NFT', 10);
            supplychain.buyItem{value: 15}(0);          //  <= fails on Ether transfer to the seller
        --------
        but it still says no events were emitted, albeit we know that addItem() has succeded and that it emits a LogForSale event. Also tried to emit events in this test contract but they don't appear neither
    
    // buyItem
    // test for failure if user does not send enough funds
    uint public initialBalance = 20 ether;
    event OwnAddress(address addr);
    function testBuyItemRevertIfFundsInsufficient() public {
        emit OwnAddress(address(this));
        SupplyChain supplychain = SupplyChain(DeployedAddresses.SupplyChain());
        supplychain.addItem('Dark horse NFT', 10);
        bool r;
        (r, ) = DeployedAddresses.SupplyChain().call{value: 20}(abi.encodeWithSignature('buyItem(uint)', 0));
        Assert.isFalse(r, "buyItem() doesn't revert when an insufficient of amount of Ether is sent");
    }
    // test for purchasing an item that is not for Sale
    function testBuyItemRevertIfItemIsNotForSale() public {

    }*/

    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

}
