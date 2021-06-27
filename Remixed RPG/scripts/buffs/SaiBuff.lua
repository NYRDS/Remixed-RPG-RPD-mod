---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = -1,
            name          = "",
            info          = "",
        }
    end,
    drBonus = function(self,buff)
     return math.ceil(1+buff:level())
    end
}