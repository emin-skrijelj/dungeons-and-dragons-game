pragma solidity >=0.6.0 <0.8.21;

import "./Character.sol";
contract Items {
    constructor() {
      createItem("Axe",1,5,3,0,0,0,90);
      createItem("Wooden Stick",2,0,0,8,5,0,5);
      createItem("Necklace",3,0,0,0,5,5,5);
    }


    struct Item {
      string name;
      uint16 totalHp;
      uint16 strength;
      uint16 armor;
      uint16 intellect;
      uint16 totalMana;
      uint16 spirit;
      uint16 dropPercent;
    }

    mapping (uint16 => Item) public itemsList;
    uint16 public totalItems;
    uint16 public nextItemId = 1;
    

    function createItem(
        string memory _name, 
        uint16 _totalHp, 
        uint16 _strength, 
        uint16 _armor, 
        uint16 _intellect, 
        uint16 _totalMana, 
        uint16 _spirit, 
        uint16 _dropPercent
    ) public {
        itemsList[nextItemId] = Item({
            name: _name,
            totalHp: _totalHp,
            strength: _strength,
            armor: _armor,
            intellect: _intellect,
            totalMana: _totalMana,
            spirit: _spirit,
            dropPercent: _dropPercent
        });
        ++totalItems;
        ++nextItemId;
    }
    
    function rollItemDrop() public view returns (uint16) {
        uint256 choice = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
        // not using oracle here, should use it but if imake the project further will add it
        // not a real security issue since there is no point in knowing what number is chosen here
        uint16 cumulativeChance = 0;
        for (uint16 i = 1; i <= nextItemId-1; ++i) {
            cumulativeChance += itemsList[i].dropPercent;
            if (choice < cumulativeChance) {
                return i;
            }
        }

        return 0; // If no item is selected
    }

    function simulateItemDrop() public view returns (uint16) {
        return rollItemDrop();
    }

    function getItem(uint16 _itemId) public view returns (Item memory) {
        return itemsList[_itemId];
    }

    function deleteItem(uint16 _itemId) public {
      delete itemsList[_itemId];
    }


    // function addDefaultItems() public {
    //   createItem("Axe",1,5,3,0,0,0,5);
    //   createItem("Wooden Stick",2,0,0,8,5,0,5);
    //   createItem("Necklace",3,0,0,0,5,5,5);
    // }

     function getItemAttributes(uint16 _itemId) public view returns (
        string memory name,
        uint16 totalHp,
        uint16 strength,
        uint16 armor,
        uint16 intellect,
        uint16 totalMana,
        uint16 spirit
    ) {
        Item memory item = itemsList[_itemId];
        return (
            item.name,
            item.totalHp,
            item.strength,
            item.armor,
            item.intellect,
            item.totalMana,
            item.spirit
        );
    }



}