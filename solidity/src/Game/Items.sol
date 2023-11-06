pragma solidity >=0.6.0 <0.8.21;

import "./Character.sol";
contract Items {
    struct Item {
      string name;
      uint256 totalHp;
      uint256 strength;
      uint256 armor;
      uint256 intellect;
      uint256 totalMana;
      uint256 spirit;
      uint256 dropPercent;
    }

    mapping (uint256 => Item) public itemsList;
    uint256 public totalItems;
    uint256 public nextItemId = 1;
    

    function createItem(
        string memory _name, 
        uint256 _totalHp, 
        uint256 _strength, 
        uint256 _armor, 
        uint256 _intellect, 
        uint256 _totalMana, 
        uint256 _spirit, 
        uint256 _dropPercent
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
        totalItems++;
        nextItemId++;
    }
    constructor() {
      createItem("Axe",1,5,3,0,0,0,0);
      createItem("Wooden Stick",2,0,0,8,5,0,0);
      createItem("Necklace",3,0,0,0,5,5,0);
    }
      function rollItemDrop() public view returns (uint256) {
        uint256 choice = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
        // not using oracle here, should use it but if imake the project further will add it
        // not a real security issue since there is no point in knowing what number is chosen here
        uint256 cumulativeChance = 0;
        for (uint256 i = 1; i <= totalItems; i++) {
            cumulativeChance += itemsList[i].dropPercent;
            if (choice < cumulativeChance) {
                return i;
            }
        }

        return 0; // If no item is selected
    }

    function simulateItemDrop() public view returns (uint256) {
        return rollItemDrop();
    }

    function getItem(uint256 _itemId) public view returns (Item memory) {
        return itemsList[_itemId];
    }

    function deleteItem(uint256 _itemId) public {
      delete itemsList[_itemId];
    }


    // function addDefaultItems() public {
    //   createItem("Axe",1,5,3,0,0,0,5);
    //   createItem("Wooden Stick",2,0,0,8,5,0,5);
    //   createItem("Necklace",3,0,0,0,5,5,5);
    // }

     function getItemAttributes(uint256 _itemId) public view returns (
        string memory name,
        uint256 totalHp,
        uint256 strength,
        uint256 armor,
        uint256 intellect,
        uint256 totalMana,
        uint256 spirit
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