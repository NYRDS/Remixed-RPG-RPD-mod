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
    local x = level:cellX(cell)
    local y = level:cellY(cell)
      Spell = storage.gameGet(a) or {}
      for i = x -1, x +1 do
          for j = y -1, y +1 do
          level = RPD.Dungeon.level
          local enemy = RPD.Actor:findChar(level:cell(i,j))
            if enemy and level:cell(i,j) ~= cell then
            if enemy then
              enemy:damage(math.ceil(RPG.physStr()*(0.11*Spell.BT)),hero)
              end
              
              else
              if enemy then
              enemy:damage(math.ceil(RPG.physStr()*(0.15*Spell.BT)),hero)
              end
              
            end
          end
        end
    end
)
