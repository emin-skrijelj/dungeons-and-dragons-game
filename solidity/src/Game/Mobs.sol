pragma solidity >=0.6.0 <0.8.21;


contract Mobs {
    struct MobStats {
        string name;
        uint256 totalHp;
        uint256 attack;
        uint256 defense;  
        uint256 mobId;    
    }
    uint256 public nextMobId = 1;
    mapping (uint256 => MobStats) public mobList;

    function createMob(string memory _name, uint256 _totalHp, uint256 _attack, uint256 _defense )  public {
        mobList[nextMobId] = MobStats({
            name: _name,
            totalHp: _totalHp,
            attack: _attack,
            defense: _defense,
            mobId: nextMobId
        });
        nextMobId++;
    }

    function deleteMob(uint256 _mobId) public {
        delete mobList[_mobId];
        nextMobId--;
    }

    function checkMobs() public view returns (bool) {
        require(bytes(mobList[1].name).length > 1);
        return true;
    }


    




    

}