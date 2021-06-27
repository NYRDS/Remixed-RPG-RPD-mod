local RPD = require "scripts/lib/commonClasses"

local mob = require"scripts/lib/mob"

return mob.init{
 stats = function(self)
RPD.affectBuff(self,RPD.Buffs.Roots,2)
 end
}
