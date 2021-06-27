--
-- User: mike
-- Date: 25.01.2018
-- Time: 0:26
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/commonClasses"
local mob = require"scripts/lib/mob"

return mob.init{

        
        die = function(enemy, self, cell, dmg)
RPD.GameScene:flash(0xFFFFFF)
RPD.GameScene:bossSlain()
RPD.playSound("snd_boss.mp3")
        local level = RPD.Dungeon.level
local item = RPD.ItemFactory:itemByName("SkeletonKey")
level:drop(item,self:getPos())
end,
        
    attackProc = function(self, enemy, dmg) -- melee attack
if math.random(1,4)==1 then

local level=RPD.Dungeon.level
print(self, cause)

for i = 1,2 do
            local monster = RPD.MobFactory:mobByName("CandyGolem")
            local pos = level:getEmptyCellNextTo(self:getPos())
            if (level:cellValid(pos)) then
                monster:setPos(pos)
                level:spawnMob(monster)
            end
            
        end
end
        return dmg
    end
}
