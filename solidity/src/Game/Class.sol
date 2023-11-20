pragma solidity >=0.6.0 <0.8.21;


contract Class{
    
    struct ClassStat{
        string class;
        string mainStat;
        uint256 mana;
        uint256 armor;
        uint256 strength;
        uint256 intellect;
        uint256 spirit;
        string defaultSpell;
        uint256 defaultItemId;
    }

    mapping (string => ClassStat) public classes;
    mapping (bytes32 => ClassStat) public classesByte;
    function getClassStats(string memory _class)public view returns(ClassStat memory){
        return classes[_class];
    }

    function createClass(
        string memory _class,
        string memory _mainStat,
        uint256 _mana,
        uint256 _strength,
        uint256 _intellect,
        uint256 _armor,
        uint256 _spirit,
        uint256 _defaultItemId,
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

    function addInitialClasses() public {
        createClass("Warrior", "Strength", 100, 50, 0, 30, 10, 1, "Berserk");
        // createClass("Mage", "Intellect", 100,0,60,10,0,2,"Fireball");
        // createClass("Priest", "Spirit", 100,0,0,15,40,3,"Smite");
    }

}