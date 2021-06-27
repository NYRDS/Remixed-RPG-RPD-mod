
---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local spell = require "scripts/lib/spell"

local storage = require "scripts/lib/storage"

local trap = require"scripts/lib/trap"

local lvl
local expMax
local exp
local a = "placetrap"
local cell1

local TLvl = {
1,
1,
1,
1,
1,
UP = 1
}

local traps ={
{
kind = "Trap",
uses = 1,
trapKind = "scriptFile",
script = "scripts/traps/FTrap",
secret = true,
activatedByMob = true,
activatedByItem = true
},
{
kind = "Trap",
uses = 1,
trapKind = "scriptFile",
script = "scripts/traps/BTrap",
secret = true,
activatedByMob = true,
activatedByItem = true
} ,
{
kind = "Trap",
uses = 1,
trapKind = "scriptFile",
script = "scripts/traps/CTrap",
secret = true,
activatedByMob = true,
activatedByItem = true
} ,
{
kind = "Trap",
uses = 1,
trapKind = "scriptFile",
script = "scripts/traps/ITrap",
secret = true,
activatedByMob = true,
activatedByItem = true
} ,
{
kind = "Trap",
uses = 1,
trapKind = "scriptFile",
script = "scripts/traps/PTrap",
secret = true,
activatedByMob = true,
activatedByItem = true
}
}

local choiceDialog
local placeDialog
local upgradeDialog

choiseDialog = function(index)
  if index == 0 then
    Add.trapChoiseOn(placeDialog,0)
  else
    Add.trapChoiseOn(upgradeDialog,1)
  end
end

placeDialog = function(index)
  RPD.createLevelObject(traps[index+1], cell1)
end

upgradeDialog = function(index)
  Count = storage.gameGet(a) or {}
  if Count.UP ~= 0 then
    TLvl[index+1] = TLvl[index+1] +1
    TLvl.UP = TLvl.UP -1
    storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, FT = TLvl[1], BT = TLvl[2], CT = TLvl[3], IT = TLvl[4], PT = TLvl[5], UP = TLvl.UP})
  end
  Add.trapChoise(choiseDialog)
end

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
            image         = 31,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Установка ловушки["..tostring(lvl).." уровень]",
            info          = ".",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr,cell)
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Bandit" then
      RPD.glog("-- Вы не имеете соответсвующего подкласса")
      return false
    end
    if RPG.distance(cell) > lvl then
      RPD.glog("** Выберете место поближе")
      return false
    end
    
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
      lvl = Count.lvl
      exp = Count.exp
      expMax = Count.expMax
      TLvl[1] = Count.FT
      TLvl[2] = Count.BT
      TLvl[3] = Count.CT
      TLvl[4] = Count.IT
      TLvl[5] = Count.PT
      TLvl.UP = Count.UP
      exp = exp+1
    if exp == expMax then
      exp = 0
      expMax = expMax+6
      lvl = lvl+1
      TLvl.UP = TLvl.UP +1
      end
      storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, FT = TLvl[1], BT = TLvl[2], CT = TLvl[3], IT = TLvl[4], PT = TLvl[5], UP = TLvl.UP})
    else
      lvl = 1
      exp = 0
      expMax = 6
      storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, FT = TLvl[1], BT = TLvl[2], CT = TLvl[3], IT = TLvl[4], PT = TLvl[5], UP = TLvl.UP})
    end
    
    cell1 = cell
    local enemy = RPD.Actor:findChar(cell)
    Add.trapChoise(choiseDialog)
 return true
   end
}
