---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local hero = RPD.Dungeon.hero
local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 14,
            name          = "Слабость",
            info          = "",
        }
    end,
    
    attackProc = function(self,buff,enemy,damage)
    buff:detach()
     return damage/2
    end
}