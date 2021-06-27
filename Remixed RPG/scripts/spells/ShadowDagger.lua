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
local a = "shadowdagger"

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
            image         = 28,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Скрытный удар["..tostring(lvl).." уровень]",
            info          = "Сокрытие присутствия и крепко сжатое оружие в руках - лучшее для скрытного удара.\n\nЕсли враг находится в состоянии \"сна\", \"испуга\", \"парализованости\", \"буйства\", \"пассивности\" или вы находитесь в состоянии \"невидимости\", то наносимый урон увеличится. Урон растёт с вашей \"физической силой\" и уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
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
    
    RPD.removeBuff(RPD.Dungeon.hero,"ShadowDaggerBuff")
    RPD.permanentBuff(RPD.Dungeon.hero, "ShadowDaggerBuff")
   return true
   end
}
