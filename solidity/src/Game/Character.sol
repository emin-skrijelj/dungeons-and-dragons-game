pragma solidity ^0.8.20;

import "./Class.sol";
import "./Items.sol";
import "./Spells.sol";

contract Character is Class {
    Items public itemsContract;
    Spells public spellsContract;

    struct CharacterData {
        string name;
        string charClass;
        string mainStat;
        uint256 level;
        uint256 experience;
        uint256 killCount;
        uint256 health;
        uint256 mana;
        uint256 strength;
        uint256 intellect;
        uint256 armor;
        uint256 spirit;
        uint256[] bag;
        string[] spells;
    }

    event characterCreated(
        string name,
        string charClass,
        string mainStat,
        uint256 level,
        uint256 experience,
        uint256 health,
        uint256 mana,
        uint256 strength,
        uint256 intellect,
        uint256 armor,
        uint256 spirit
    );
    
    mapping (address => CharacterData) public characters;

    function createCharacter (string memory _name, string memory _class) public {
        
        ClassStat memory classStats = getClassStats(_class);        
        characters[msg.sender] = CharacterData({
            name: _name,
            charClass: classStats.class,
            mainStat: classStats.mainStat,
            level: 1,
            experience: 0,
            killCount: 0,
            health: 100,
            mana: classStats.mana,
            strength: classStats.strength,
            intellect: classStats.intellect,
            armor: classStats.armor,
            spirit: classStats.spirit,
            bag: new uint256[](0),
            spells: new string[](0)
        });
        characters[msg.sender].bag.push(classStats.defaultItemId);
        
        characters[msg.sender].spells.push(classStats.defaultSpell);

        emit characterCreated(
            _name,
            classStats.class,
            classStats.mainStat,
            1,
            0,
            100,
            classStats.mana,
            classStats.strength,
            classStats.intellect,
            classStats.armor,
            classStats.spirit
        );
    }

    function characterDelete(address addy) public {
        delete characters[addy];
    }

    function characterInfo () public view returns(CharacterData memory) {
        return characters[msg.sender];
    }

    function checkIfCharacterExists() public view returns (bool) {
        require(bytes(characters[msg.sender].name).length > 0, "User does not have a Character");
        return true;
    }

    function setExp(uint256 newExp) public {
        characters[msg.sender].experience += newExp;
    }

    function useMana(uint256 newMana) public {
        characters[msg.sender].mana = newMana;
    }

    function setHp(uint256 newHealth) public {
        characters[msg.sender].health = newHealth;
    }
    
    function setIntellect(uint256 newIntellect) public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Intellect")),"You can not add this item on your class");
        characters[msg.sender].intellect = newIntellect;
    }

    function setStrength(uint256 newStrength) public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Strength")),"You can not add this item on your class");
        characters[msg.sender].strength = newStrength;
    }

    function setSpirit(uint256 newSpirit) public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Spirit")),"You can not add this item on your class");
        characters[msg.sender].spirit = newSpirit;
    }

    function setLevel(uint256 newLevel) public {
        characters[msg.sender].level = newLevel;
    }

    function setArmor(uint256 newArmor) public {
        require(keccak256(abi.encodePacked(characters[msg.sender].charClass)) == keccak256(abi.encodePacked("Warrior")),"You can not add this item on your class");
        characters[msg.sender].armor = newArmor;
    }

    function addItem(uint256 newItemId) public {
        characters[msg.sender].bag.push(newItemId);
    }

    function checkKillCount() public view returns(uint256){
        return characters.killCount[msg.sender];
    }

    
}