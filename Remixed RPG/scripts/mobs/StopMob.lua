
local RPD = require "scripts/lib/commonClasses"

local mob = require"scripts/lib/mob"


return mob.init{
  

attackProc = function(self, enemy, dmg) -- melee attack
        return dmg*0.25
    end,
    
zapProc = function(self, enemy, dmg) -- ranged attack
if math.random(1,2) == 1 then
RPD.affectBuff(enemy,RPD.Buffs.Slow,1)
        return dmg
        end
    end,

}