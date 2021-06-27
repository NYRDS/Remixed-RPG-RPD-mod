--
-- User: mike
-- Date: 25.01.2018
-- Time: 0:26
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/commonClasses"
local a = "bonegolem"
local storage = require "scripts/lib/storage"
local mob = require"scripts/lib/mob"

return mob.init{

        
  die = function(enemy, self, cell, dmg)
    local Spell = storage.gameGet(a) or {}
          storage.gamePut(a,{exp = Spell.exp, expMax = Spell.expMax, lvl = Spell.lvl, summon = Spell.summon-1, summonMax = Spell.summonMax})
    return dmg
  end
}
