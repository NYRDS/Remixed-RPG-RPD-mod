---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "fastrun"
local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 53,
            name          = "Ускорение",
            info          = "",
        }
    end,
    
    speedMultiplier = function(self, buff)
    local Spell = storage.gameGet(a) or {}
    if Spell.lvl ~= nil then
        return 0.8 + RPG.AllFast()*0.2 + RPG.magStr()*0,35
    end
    end
}