
local RPD = require "scripts/lib/commonClasses"

local mob = require"scripts/lib/mob"


return mob.init{
  

attackProc = function(self, enemy, dmg) -- melee attack
if math.random(1,1) == 1 then
blinkTo = function(mob, target)
        wandOfBlink:mobWandUse(mob, )
    end,
end
        return dmg
    end,
    
zapProc = function(self, enemy, dmg) -- ranged attack
       return dmg 
    end

}