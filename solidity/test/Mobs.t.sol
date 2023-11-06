pragma solidity >=0.6.0 <0.8.21;

import "../lib/forge-std/src/Test.sol";
import "../src/Game/Mobs.sol";

contract mobsTest is Test {
    Mobs public mob;

    function setUp() public {
        mob = new Mobs();
    }

    // function testMobCreation() public {
    //     mob.createMob("goblin", 100, 100, 100);
    //     assertEq(mob.checkMobs(),true);
    // }


}