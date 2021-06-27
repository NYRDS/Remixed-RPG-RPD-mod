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
            icon          = -1,
            name          = "",
            info          = "",
        }
    end,
    
    detach = function(self,buff)
     buff.target:die(buff.target)
    end
}