pragma solidity ^0.8.20;

import "./Class.sol";
import "./Items.sol";
import "./Spells.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Character is Class, Ownable {
    constructor() Ownable(msg.sender) {
        require(msg.sender != address(0), "Invalid initial owner");
        address initialOwner = msg.sender;
    }

    Items public itemsContract;
    Spells public spellsContract;

    struct CharacterData {
        string name;
        string charClass;
        string mainStat;
        uint32 experience;
        uint8 level;
        uint16 killCount;
        uint16 health;
        uint16 mana;
        uint16 strength;
        uint16 intellect; 
        uint16 armor;
        uint16 spirit;
        uint16[] bag;
        string[] spells;
    }

    event characterCreated(
        string name,
        string charClass,
        string mainStat,
        uint16 level,
        uint32 experience,
        uint16 health,
        uint16 mana,
        uint16 strength,
        uint16 intellect,
        uint16 armor,
        uint16 spirit
    );
    
    mapping (address => CharacterData) public characters;
    function createCharacter (string memory _name, string memory _class) public {
        require(checkIfCharacterExists() != true);
        require(bytes(_name).length < 15);

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
            bag: new uint16[](0),
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

    function characterDelete(address addy) onlyOwner public {
        delete characters[addy];
    }

    function characterInfo () public view returns(CharacterData memory) {
        return characters[msg.sender];
    }

    function checkIfCharacterExists() public view returns (bool) {
        return bytes(characters[msg.sender].name).length > 0;
    }


    function setExp(uint16 newExp) onlyOwner public {
        characters[msg.sender].experience += newExp;
    }

    function useMana(uint16 newMana) onlyOwner public {
        characters[msg.sender].mana = newMana;
    }

    function setHp(uint16 newHealth) onlyOwner public {
        characters[msg.sender].health = newHealth;
    }
    
    function setIntellect(uint16 newIntellect) onlyOwner public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Intellect")),"You can not add this item on your class");
        characters[msg.sender].intellect = newIntellect;
    }

    function setStrength(uint16 newStrength) onlyOwner public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Strength")),"You can not add this item on your class");
        characters[msg.sender].strength = newStrength;
    }

    function setSpirit(uint16 newSpirit) onlyOwner public {
        require(keccak256(abi.encodePacked(characters[msg.sender].mainStat)) == keccak256(abi.encodePacked("Spirit")),"You can not add this item on your class");
        characters[msg.sender].spirit = newSpirit;
    }

    function setLevel(uint8 newLevel) onlyOwner public {
        characters[msg.sender].level = newLevel;
    }

    function setArmor(uint16 newArmor) onlyOwner public {
        require(keccak256(abi.encodePacked(characters[msg.sender].charClass)) == keccak256(abi.encodePacked("Warrior")),"You can not add this item on your class");
        characters[msg.sender].armor = newArmor;
    }

    function addItem(uint16 newItemId)onlyOwner onlyOwner public {
        characters[msg.sender].bag.push(newItemId);
    }

    function checkKillCount() public view returns(uint16){
        uint16 kills = characters[msg.sender].killCount;
        return kills;
    }


    
}