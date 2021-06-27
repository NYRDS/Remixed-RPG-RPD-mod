---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local spell = require "scripts/lib/spell"

local storage = require "scripts/lib/storage"

local lvl
local expMax
local exp
local a = "flurryarrows"

return spell.init{
    desc  = function ()
    local Count = storage.gameGet(a) or {}

     if Count.lvl == nil then
  lvl = 1
  else
   if lvl == nil then
    lvl = Count.lvl
   end
  end
        return {
            image         = 24,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Шквал стрел["..tostring(lvl).." уровень]",
            info          = "Атака несколькими стрелами в одну цель.\nКоличество выпускаемых стрел растёт с уровнем.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 2,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
    RPD.removeBuff(RPD.Dungeon.hero,"FlurryArrowsBuff")
    RPD.permanentBuff(RPD.Dungeon.hero, "FlurryArrowsBuff")
 return true
   end
}
