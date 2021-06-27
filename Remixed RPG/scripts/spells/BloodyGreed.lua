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
local a = "bloodygreed"

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
            image         = 30,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Кровавая жадность["..tostring(lvl).." уровень]",
            info          = "Неимоверная алчность, бурлящая в вашем сердце, питает вас.\n\nПри активации автоатаки лечат от части нанесённого урона. Длительность и количество лечения растёт с уровнем навыка",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(21-lvl-RPG.spellFast,16-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    cast = function(self, spell, chr, cell)
    Count = storage.gameGet(a) or {}
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    
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
    
    RPD.removeBuff(RPD.Dungeon.hero,"BloodyGreedBuff")
    local buff = RPD.affectBuff(RPD.Dungeon.hero, "BloodyGreedBuff", 1+2*lvl)
    buff:level(lvl)
   return true
   end
}
