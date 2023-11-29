pragma solidity >=0.6.0 <0.8.21;

import "./Character.sol";
import "./Items.sol";
import "./Spells.sol";

contract Game is Character {


  // constructor(){
  // }
  modifier hasCharacter {
    require(checkIfCharacterExists(), "User does not have character");
    _;
  }

  mapping (address => uint16) public killCount;

  event spellUsed(string spellName, uint16 damageDealt);
  event ItemAddedToBag(address usersAddress,string itemName, uint16 _itemId);

  function itemPickUp(uint16 _itemId) public {

    (string memory name, uint16 totalHp, uint16 strength, uint16 armor, uint16 intellect, uint16 totalMana, uint16 spirit ,) = itemsContract.itemsList(_itemId);
    characters[msg.sender].bag.push(_itemId);
    characters[msg.sender].health += totalHp;
    characters[msg.sender].strength += strength;
    characters[msg.sender].armor += armor;
    characters[msg.sender].intellect += intellect;
    characters[msg.sender].mana += totalMana;
    characters[msg.sender].spirit += spirit;

    emit ItemAddedToBag(msg.sender, name, _itemId);

  }

    
  function useSpell(string memory _spellName) public returns(uint16) {
     if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Strength"))) {
        uint16 damage = characters[msg.sender].level * 2 + characters[msg.sender].strength;
        uint16 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    } else if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Spirit"))) {
        uint16 damage = characters[msg.sender].level * 2 + characters[msg.sender].spirit;
        uint16 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    } else if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Intellect"))) {
        uint16 damage = characters[msg.sender].level * 2 + characters[msg.sender].intellect;
        uint16 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    }
    return 0;
  }

  // function addKillCount() public {
  //   characters.killCount[msg.sender]++;
  // }

  
}
