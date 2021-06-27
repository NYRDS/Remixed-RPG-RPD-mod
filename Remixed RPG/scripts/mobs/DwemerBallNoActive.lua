local RPD = require "scripts/lib/commonClasses"

local mob = require"scripts/lib/mob"

return mob.init{
 stats = function(self)
local myBuff = RPD.permanentBuff(self,"Test")
 end
}
