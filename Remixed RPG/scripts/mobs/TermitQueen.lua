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
end,
        
    zapProc = function(self, cause) 
        local level = RPD.Dungeon.level
        print(self, cause)

        for i = 1,1 do
            local mob = RPD.MobFactory:mobByName("Termit")
            local pos = level:getEmptyCellNextTo(self:getPos())
            if (level:cellValid(pos)) then
                mob:setPos(pos)
                level:spawnMob(mob)
              end
        end
    end
}
