pragma solidity >=0.6.0 <0.8.21;

import "./Character.sol";
import "./Items.sol";
import "./Spells.sol";

contract Game is Character {
  event spellUsed(string spellName, uint256 damageDealt);
  event ItemAddedToBag(address usersAddress,string itemName, uint256 _itemId);
  // constructor(){
  // }
  modifier hasCharacter {
    require(checkIfCharacterExists(), "User does not have character");
    _;
  }

  mapping (address => uint256) public killCount;

  function itemPickUp(uint256 _itemId) public {

    (string memory name, uint256 totalHp, uint256 strength, uint256 armor, uint256 intellect, uint256 totalMana, uint256 spirit ,) = itemsContract.itemsList(_itemId);
    characters[msg.sender].bag.push(_itemId);
    characters[msg.sender].health += totalHp;
    characters[msg.sender].strength += strength;
    characters[msg.sender].armor += armor;
    characters[msg.sender].intellect += intellect;
    characters[msg.sender].mana += totalMana;
    characters[msg.sender].spirit += spirit;

    emit ItemAddedToBag(msg.sender, name, _itemId);

  }

    
  function useSpell(string memory _spellName) public returns(uint256) {
     if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Strength"))) {
        uint256 damage = characters[msg.sender].level * 2 + characters[msg.sender].strength;
        uint256 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    } else if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Spirit"))) {
        uint256 damage = characters[msg.sender].level * 2 + characters[msg.sender].spirit;
        uint256 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    } else if (keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Intellect"))) {
        uint256 damage = characters[msg.sender].level * 2 + characters[msg.sender].intellect;
        uint256 addedDmg = spellsContract.getSpellDamage(_spellName,damage);
        emit spellUsed(_spellName, addedDmg);
        return addedDmg;
    }
    return 0;
  }

  // function addKillCount() public {
  //   characters.killCount[msg.sender]++;
  // }

  
}
