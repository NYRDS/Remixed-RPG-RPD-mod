---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "bloodygreed"
local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 49,
            name          = "Кровавая жадность",
            info          = "",
        }
    end,
    
    attackProc = function(self,buff,enemy,damage)
    local Spell = storage.gameGet(a) or {}
    
    buff.target:heal(damage*(0.05+0.12*buff:level()),buff.target)
    return damage
    end
}