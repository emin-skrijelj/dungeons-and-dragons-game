pragma solidity >=0.6.0 <0.8.21;

import "../src/Game/Items.sol";
import "../lib/forge-std/src/Test.sol";


contract charTest is Test {
  Items public item;

  function setUp() public {
    item = new Items();
  }

  function testItems() public {
    uint256 itemNums = item.totalItems();
    assertEq(itemNums >= 3, true);
  } 

  function testItemDrop() public {
    uint256 randomItem = item.rollItemDrop();
    assertEq(randomItem > 0, true);
  }
}