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
local a = "bloodshield"

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
            image         = 18,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Крик жизни["..tostring(lvl).." уровень]",
            info          = "Крик, вырывающийся от нежеланья слишком рано покидать этот мир.\n\nНакладывает на героя щит, размер которого растёт от недостающего здоровья.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(16-lvl-RPG.spellFast,13-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    cast = function(self, spell, chr, cell)
    if RPD.Dungeon.hero:lvl() <= 5 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
    if exp == expMax then
     exp = 0
     expMax = expMax+6
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
    
     RPD.affectBuff(RPD.Dungeon.hero,"BloodShieldBuff",2+lvl)
 return true
   end
}
