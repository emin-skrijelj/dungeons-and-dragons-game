pragma solidity >=0.6.0 <0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";


contract Mobs is Ownable {

    constructor() Ownable(msg.sender) {

    }

    struct MobStats {
        string name;
        uint16 totalHp;
        uint16 attack;
        uint16 defense;  
        uint16 expDrop;
        uint8 mobId;    
    }

    uint8 public nextMobId = 1;

    mapping (uint8 => MobStats) public mobList;

    event mobCreated(
        string name,
        uint16 totalHp,
        uint16 attack,
        uint16 defense,
        uint16 expDrop,
        uint8 mobId
    );


    function createMob(string memory _name, uint16 _totalHp, uint16 _attack, uint16 _defense, uint16 _expDrop )  public {

        mobList[nextMobId] = MobStats({
            name: _name,
            totalHp: _totalHp,
            attack: _attack,
            defense: _defense,
            mobId: nextMobId,
            expDrop: _expDrop
        });

        emit mobCreated(
            _name,
            _totalHp,
            _attack,
            _defense,
            _expDrop,
            nextMobId
        );
        
        ++nextMobId;

    }

    function deleteMob(uint8 _mobId) public {
    
        delete mobList[_mobId];
        nextMobId--;

    }

    function checkMobs() public view returns (bool) {
        require(bytes(mobList[1].name).length > 1);
        return true;
    }

    function getMobStats(uint8 _mobId) public view returns (MobStats memory) {
        return mobList[_mobId];
    }


    




    

}