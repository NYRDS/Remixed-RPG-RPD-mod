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
local a = "shadowclone"

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
            image         = 2,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Техника теневого клонирования["..tostring(lvl).." уровень]",
            info          = "Древняя техника ниндзюцу, позволяющая пользователю создавать теневых клонов, а самому уходить в невидимость на время. Является базовой техникой. Клон исчезает через время. Длительность невидимости и клона растёт с уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(17-lvl-RPG.spellFast,14-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    local level = RPD.Dungeon.level
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 or RPG.distance(cell) >= math.min(lvl+1,5) then
      RPD.glog("** Вы не можете разместить там своего клона. Слишком далеко")
      return false
     else
      exp = exp+1
     end
    if exp == expMax then
     exp = 0
     expMax = expMax+7
     lvl = lvl+1
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end
    local clone = RPD.Dungeon.hero:makeClone()
    clone:setPos(cell)
    RPD.Dungeon.level:spawnMob(clone)
    RPD.affectBuff(clone,"KillClone",2+lvl)
    RPD.affectBuff(RPD.Dungeon.hero, RPD.Buffs.Invisibility ,2+lvl)
     return true
   end
}
