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
local a = "shadowdash"
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
            image         = 15,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Теневой рывок["..tostring(lvl).." уровень]",
            info          = "Рывок вперёд, наносящий урон всем на пути. Если в конце рывка кто нибудь есть, то вы отпрыгните от него на случайную свободную клетку рядом с ним. Дальность рывка растёт с уровнем навыка, вплоть до 4. Урон растёт с ростом \"физической силы\" и уровня навыка",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 8,
            cooldown      = math.max(21-lvl-RPG.spellFast,15-math.ceil(RPG.spellFast/2)),
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
    if RPG.subclass ~= nil and RPG.subclass ~= "Assassin" then
      RPD.glog("-- Вы не имеете соответсвующего подкласса")
      return false
    end
    
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 or RPG.distance(cell) >= math.min(lvl+1,4) then
      RPD.glog("** Вы не можете сделать рывок так далеко, или в стену!")
      return false
     else
      exp = exp+1
     end
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

    local heroPos = hero:getPos()
    moveTo = RPD.Ballistica:cast(heroPos,cell,true,false,false)
    for i = 1, RPD.Ballistica.distance do
    if RPD.Ballistica.trace[i] == cell then
     moveTo = cell
    end
    end
    enemy = RPD.Actor:findChar(moveTo) 
    if enemy and enemy ~= hero then
     enemy:damage(2*lvl + math.ceil(RPG.physStr()*0.15),hero)
     RPD.topEffect(moveTo,"bleeding_effect")
     if level:cellValid(level:getEmptyCellNextTo(enemy:getPos())) then
      moveTo = level:getEmptyCellNextTo(enemy:getPos())
     end
    end
    hero:getSprite():dash(hero:getPos(),moveTo)
    hero:move(moveTo)
        
    pos = RPD.Ballistica:cast(heroPos,cell,true,false,false)
    for i = 1, RPD.Ballistica.distance do
    if RPD.Ballistica.trace[i] == cell then
     stop = true
    end
    if stop ~= true then
    enemy = RPD.Actor:findChar(RPD.Ballistica.trace[i])
    if enemy and enemy ~= hero then
     enemy:damage(2*lvl + math.ceil(RPG.physStr()*0.15),hero)
     RPD.topEffect(enemy:getPos(),"bleeding_effect")
    end
    end
    end
    stop = false
     return true
   end
}
