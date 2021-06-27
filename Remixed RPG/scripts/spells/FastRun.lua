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
local a = "fastrun"

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
            image         = 11,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Ускорение["..tostring(lvl).." уровень]",
            info          = "Вы увеличиваете свою скорость передвижения на короткий промежуток времени. Получаемое ускорение увеличивается с ростом \"магической силы\" и уровня навыка, длительность баффа растёт с уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 10,
            cooldown      = math.max(21-lvl-RPG.spellFast,18-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    cast = function(self, spell, chr, cell)
    
    local hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Enchanter" then
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
    RPD.playSound("body_armor")
    RPD.removeBuff(RPD.Dungeon.hero,"SteelBodyBuff")
    RPD.affectBuff(RPD.Dungeon.hero, "FastRunBuff", 1+1.5*lvl)
 return true
   end
}
