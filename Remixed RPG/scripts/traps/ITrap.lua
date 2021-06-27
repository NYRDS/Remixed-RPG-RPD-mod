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
    local level = RPD.Dungeon.level
      Spell = storage.gameGet(a) or {}
      for i = level:cellX(cell) -Spell.IT, level:cellX(cell) +Spell.IT do
          for j = level:cellY(cell) -Spell.IT, level:cellY(cell) +Spell.IT do
          level = RPD.Dungeon.level
              RPD.placePseudoBlob(RPD.PseudoBlobs.Freezing,level:cell(i,j))
              local enemy = RPD.Actor:findChar(level:cell(i,j))
            if enemy then
              enemy:damage(math.ceil(RPG.magStr()*(0.1*Spell.IT)),hero)
              end
          end
        end
    end
)
