pragma solidity >=0.6.0 <0.8.21;

import "../Game/Character.sol";
import "../Game/Class.sol";

contract Spells {
  Character public characterContract;
  Class public classContract;

  struct Spell {
    string name;
    string class;
    uint16 damage;
    uint16 manaCost;
    uint16 healing;
    uint16 manaRegen;
  }

  event spellCreated(
    string name,
    string class,
    uint16 damage,
    uint16 manaCost,
    uint16 healing,
    uint16 manaRegen
  );
  mapping (string => Spell) public spellList;



  function createSpell(
    string memory _name,
    string memory _class,
    uint16 _dmg,
    uint16 _manaCost,
    uint16 _healing,
    uint16 _manaRegen
    ) 
        public 
    {
        Spell memory spellStats = Spell({
          name: _name,
          class: _class,
          damage: _dmg,
          manaCost: _manaCost,
          healing: _healing,
          manaRegen: _manaRegen
        });
        spellList[_name] = spellStats;
        emit spellCreated(_name,_class,_dmg,_manaCost,_healing,_manaRegen);
    }

  function getSpellDamage(string memory _name, uint16 _damage) public view returns (uint16) {
      return spellList[_name].damage + _damage; 
  } 

  function deleteSpell(string memory _name) public {
    delete spellList[_name];
  }
}