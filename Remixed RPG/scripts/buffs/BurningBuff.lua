---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero
local a = "placetrap"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = -1,
            name          = "",
            info          = "",
        }
    end,
    
    charAct = function(self,buff)
      local Spell = storage.gameGet(a) or {}
      buff.target:damage(buff:level(), RPD.Dungeon.hero)
    end
}