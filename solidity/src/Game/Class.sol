pragma solidity >=0.6.0 <0.8.21;


contract Class{

    constructor() {
        createClass("Warrior", "Strength", 100, 50, 0, 30, 10, 1, "Berserk");
    }
    
    struct ClassStat{
        string class;
        string mainStat;
        uint16 mana;
        uint16 armor;
        uint16 strength;
        uint16 intellect;
        uint16 spirit;
        uint16 defaultItemId;
        string defaultSpell;
    }


    mapping (string => ClassStat) public classes;
    mapping (bytes32 => ClassStat) public classesByte;
    function getClassStats(string memory _class)public view returns(ClassStat memory){
        return classes[_class];
    }

    function createClass(
        string memory _class,
        string memory _mainStat,
        uint16 _mana,
        uint16 _strength,
        uint16 _intellect,
        uint16 _armor,
        uint16 _spirit,
        uint16 _defaultItemId,
        string memory _defaultSpell
    )
         public 
    {
        // bytes32 inBytesClass = keccak256(bytes(_class));
        classes[_class] = ClassStat({
            class: _class,
            mainStat: _mainStat,
            mana: _mana,
            strength: _strength,
            intellect: _intellect,
            armor: _armor,
            spirit: _spirit,
            defaultItemId: _defaultItemId,
            defaultSpell: _defaultSpell
        });
        
    }


}