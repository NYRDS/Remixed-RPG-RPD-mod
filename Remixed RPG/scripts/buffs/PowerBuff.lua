---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local a = "flameshield"
local Spell = storage.gameGet(a) or {}
local hero = RPD.Dungeon.hero
local depth = RPD.Dungeon.depth

local level

return buff.init{
    desc  = function ()
        return {
            icon          = 1,
            info          = "",
        }
    end,
    
attackProc = function(self,buff,enemy,damage)
  depth = RPD.Dungeon.depth
  return damage + math.ceil(0.35*depth)
end,

drBonus = function(self,buff)
  depth = RPD.Dungeon.depth
  return buff.target:dr() + math.ceil(0.5*depth)
end,

speedMultiplier = function(self,buff)
  depth = RPD.Dungeon.depth
  return 1
end
}
