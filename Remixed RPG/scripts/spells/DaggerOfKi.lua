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
local a = "daggerofki"

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
            image         = 27,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Высвобождение ки: Кинжал["..tostring(lvl).." уровень]",
            info          = "Ки принимает форму кинжала, которым наносится следующая автоатака, наносящая дополнительный магический урон. Если враг находится в состоянии \"сна\", \"испуга\", \"парализованости\", \"буйства\", \"пассивности\" или вы находитесь в состоянии \"невидимости\", то наносимый урон увеличится. Если на вас деуствует \"магический щит\", то следующая автоатака также подлечит вас. Урон и лечение растёт с вашей \"магической силой\" и уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 8,
            cooldown      = math.max(11-lvl-RPG.spellFast,5-math.ceil(RPG.spellFast/2)),
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
    
    RPD.removeBuff(RPD.Dungeon.hero,"DaggerOfKiBuff")
    RPD.permanentBuff(RPD.Dungeon.hero, "DaggerOfKiBuff")
   return true
   end
}
