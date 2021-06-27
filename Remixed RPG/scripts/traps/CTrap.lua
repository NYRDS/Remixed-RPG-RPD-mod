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
      local enemy = RPD.Actor:findChar(cell)
      if enemy and enemy ~= hero then
      enemy:damage(RPG.physStr()*(0.1*Spell.CT),hero)
      local buff = RPD.affectBuff(enemy,RPD.Buffs.Cripple,Spell.CT+1)
      buff:level(Spell.CT)
      end
    end
)
