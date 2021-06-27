---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"

local hero = RPD.Dungeon.hero
local storage = require "scripts/lib/storage"
local buff = require "scripts/lib/buff"

local a = "bloodspikes"

return buff.init{
    desc  = function ()
        return {
            icon          = 56,
            name          = "Заражение крови",
            info          = "",
        }
    end,
    
    detach = function(self,buff)
    local Spell = storage.gameGet(a) or {}
      local hero = RPD.Dungeon.hero
     hero:ht(hero:ht() +Spell.bp)
     
     storage.gamePut(a,{exp = Spell.exp, expMax = Spell.expMax, lvl = Spell.lvl, bp = Spell.bp, staks = 0})
    end
}