---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local spell = require "scripts/lib/spell"

local storage = require "scripts/lib/storage"

local hero
local lvl
local expMax
local exp
local a = "counterblows"

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
            image         = 7,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Защитная стойка №1: Контрудары["..tostring(lvl).." уровень]",
            info          = "Вы встаёте в особую стойку, в течении времени с некоторым шансом вы отражаете удар противника обратно. Шанс отражения растёт с вашей \"скоростью\", \"удачей\" и уровнем навыка. Количество отражаемого урона растёт с уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(21-lvl-RPG.spellFast,16-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Samurai" then
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
    RPD.removeBuff(RPD.Dungeon.hero,"CounterblowsBuff")
    RPD.affectBuff(RPD.Dungeon.hero, "CounterblowsBuff",2+lvl)
 return true
   end
}
