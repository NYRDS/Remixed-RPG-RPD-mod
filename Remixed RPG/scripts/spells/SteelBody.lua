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
local a = "steelbody"

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
            image         = 4,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Стальные мышцы["..tostring(lvl).." уровень]",
            info          = "Вы увеличиваете прочность мышц, тем самым увеличивая свою защиту.\nПолучаемая защита увеличивается с ростом \"здоровья\" и уровня навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 3,
            cooldown      = math.max(21-lvl-RPG.spellFast,15-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    cast = function(self, spell, chr, cell)
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Paladin" and RPG.subclass ~= "Demonologist" then
      RPD.glog("-- Вы не имеете соответсвующего подкласса")
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
     expMax = expMax+5
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
    RPD.playSound("body_armor")
    RPD.removeBuff(RPD.Dungeon.hero,"SteelBodyBuff")
    RPD.affectBuff(RPD.Dungeon.hero, "SteelBodyBuff", 2+lvl)
 return true
   end
}
