pragma solidity >=0.6.0 <0.8.21;

import "../Game/Character.sol";
import "../Game/Class.sol";

contract Spells {
  Character public characterContract;
  Class public classContract;

  struct Spell {
    string name;
    string class;
    uint256 damage;
    uint256 manaCost;
    uint256 healing;
    uint256 manaRegen;
  }

  event spellCreated(
    string name,
    string class,
    uint256 damage,
    uint256 manaCost,
    uint256 healing,
    uint256 manaRegen
  );
  mapping (string => Spell) public spellList;



  function createSpell(
    string memory _name,
    string memory _class,
    uint256 Dmg,
    uint256 _manaCost,
    uint256 _healing,
    uint256 _manaRegen
    ) 
        public 
    {
        Spell memory spellStats = Spell({
          name: _name,
          class: _class,
          damage: Dmg,
          manaCost: _manaCost,
          healing: _healing,
          manaRegen: _manaRegen
        });
        spellList[_name] = spellStats;
        emit spellCreated(_name,_class,Dmg,_manaCost,_healing,_manaRegen);
    }

  function getSpellDamage(string memory _name, uint256 _damage) public view returns (uint256) {
      return spellList[_name].damage + _damage; 
  } 

  function deleteSpell(string memory _name) public {
    delete spellList[_name];
  }
}