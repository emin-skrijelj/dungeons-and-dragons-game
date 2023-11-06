pragma solidity >=0.6.0 <0.8.21;

import "../lib/forge-std/src/Test.sol";
import "../src/Game/Spells.sol";

contract mobsTest is Test {
    Spells public spell;

    function setUp() public {
        spell = new Spells();
    }

    function testSpellCreation() public {
      spell.createSpell("spellName","Warrior",10,30,30,30);
      assertEq(spell.getSpellDamage("spellName",10) == 20, true);
    }

}
