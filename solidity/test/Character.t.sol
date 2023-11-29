pragma solidity >=0.6.0 <0.8.21;


import "../lib/forge-std/src/Test.sol";
import "../src/Game/Character.sol";
import "../src/Game/Spells.sol";
import "../src/Game/Class.sol";
import "../src/Game/Items.sol";


contract charTest is Test {
  Character public characterContract;
  Items public itemsContract;
  Spells public spellsContract;
  Class public classContract;

  function setUp() public {
    characterContract = new Character();
    itemsContract = new Items();
    spellsContract = new Spells();
    classContract = new Class();
  }

  function testCharCreate() public {
      characterContract.createCharacter("TestingChar", "Warrior");
      assertEq(characterContract.checkIfCharacterExists(), true);
  }




  


}