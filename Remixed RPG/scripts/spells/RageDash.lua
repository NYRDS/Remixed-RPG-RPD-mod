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
local a = "ragedash"
local pos
local moveTo
local enemy
local stop = false

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
            image         = 19,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Свирепый рывок["..tostring(lvl).." уровень]",
            info          = "Рывок вперёд, наносящий урон всем на пути. Если в конце рывка кто нибудь есть, то вы отпрыгните от него на случайную свободную клетку рядом с ним. Дальность рывка растёт с уровнем навыка, вплоть до 4. Урон растёт с ростом \"физической силы\" и уровня навыка",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 3,
            cooldown      = math.max(21-lvl-RPG.spellFast,16-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    
    castOnCell = function(self, spell, chr, cell, caster)
    local level = RPD.Dungeon.level
    local hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    
    if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 or RPG.distance(cell) > math.min(lvl+1,4) then
      RPD.glog("** Вы не можете сделать рывок так далеко, или в стену")
        return false
      end
      
    Count = storage.gameGet(a) or {}
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
    
    if exp == expMax then
       exp = 0
       expMax = expMax+5
       lvl = lvl+1
     else
       exp = exp+1
     end

    local heroPos = hero:getPos()
    moveTo = RPD.Ballistica:cast(heroPos,cell,true,true,false)
      enemy = RPD.Actor:findChar(moveTo)
      if enemy and enemy ~= hero and RPG.distance(moveTo) <= math.min(lvl+1,4) then
         RPD.affectBuff(enemy,RPD.Buffs.Paralysis,2+0.5*lvl)
         moveTo = RPD.Ballistica.trace[RPD.Ballistica.distance-1]
      else
        moveTo = RPD.Ballistica.trace[math.min(lvl+2,RPD.Ballistica.distance)]
      end
    hero:getSprite():dash(hero:getPos(),moveTo)
    hero:move(moveTo)
     return true
   end
}
