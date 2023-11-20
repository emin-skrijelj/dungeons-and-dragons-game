pragma solidity >=0.6.0 <0.8.21;

import "../src/Game/Class.sol";
import "../lib/forge-std/src/Test.sol";


contract classTest is Test {
  Class public klasa;

  function setUp() public {
    klasa = new Class();
  }

  function testKlase() public {
    klasa.createClass("Warrior", "Strength", 100, 50, 0, 30, 10, 1, "Berserk");

  } 


}