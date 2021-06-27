---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local trap = require"scripts/lib/trap"

local storage = require "scripts/lib/storage"

local a = "placetrap"

return trap.init(
    function (cell, char, data)
    local hero = RPD.Dungeon.hero
      Spell = storage.gameGet(a) or {}
      if char ~= hero then
        RPD.placeBlob(RPD.Blobs.Fire,cell,Spell.FT)
      end
      local enemy = RPD.Actor:findChar(cell)
      if enemy and enemy ~= hero then
      local buff = RPD.affectBuff(enemy,"BurningBuff",Spell.FT)
      buff:level(Spell.FT)
      end
    end
)
