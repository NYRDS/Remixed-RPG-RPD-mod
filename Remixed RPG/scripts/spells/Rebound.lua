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
local a = "rebound"
local line
local moveTo
local enemy

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
            image         = 12,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Отскок["..tostring(lvl).." уровень]",
            info          = "Отскок от врага на некоторое расстояние и отталкивание врага на клетку от вас. Дальность отскока растёт с уровнем навыка вплоть до 3. Навык имеет максимум 3 уровень.",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(28-lvl-RPG.spellFast,24-math.ceil(RPG.spellFast/2)),
            castTime      = 0
        }
    end,
    
    castOnCell = function(self, spell, chr, cell, caster)
    local level = RPD.Dungeon.level
    local hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    
    if RPG.subclass ~= nil and RPG.subclass ~= "Archer" then
      RPD.glog("-- Вы не имеете соответсвующего подкласса")
      return false
    end
    
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     if RPG.distance(cell) ~= 0 or cell == hero:getPos() or RPD.Actor:findChar(cell) == Nil then
      RPD.glog("** Вы можете сделать отскок лишь вплотную с врагом")
      return false
     else
      exp = exp+1
     end
    if exp == expMax then
     exp = 0
     expMax = expMax+5
     if lvl ~= 3 then
      lvl = lvl+1
     end
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    else
     lvl = 1
     exp = 0
     expMax = 4
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
    end

    local heroPos = hero:getPos()
    enemy = RPD.Actor:findChar(cell)
    if enemy and enemy ~= hero then
     line = RPD.Ballistica:cast(enemy:getPos(),heroPos,true,false,false)
     moveTo = RPD.Ballistica.trace[math.min(2+lvl,RPD.Ballistica.distance)]
     hero:getSprite():dash(hero:getPos(),moveTo)
     hero:move(moveTo)
     line = RPD.Ballistica:cast(heroPos,enemy:getPos(),true,false,false)
     moveTo = RPD.Ballistica.trace[math.min(3,RPD.Ballistica.distance)]
     enemy:placeTo(moveTo)
     enemy:updateSprite()
    end
     return true
   end
}
