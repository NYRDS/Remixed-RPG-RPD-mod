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
local a = "horattack"
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
            image         = 23,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Атакующая стойка №2: Вертикальный удар["..tostring(lvl).." уровень]",
            info          = "Мягкий, но тяжёлый удар, сопоставимый с потоком водопада.\nНавык отправляет в выбраном направлении ударную волну. Дальность удара растёт с уровнем навыка, вплоть до 5. Урон растёт с ростом \"скорости\", \"физической силы\", урона оружия и уровня навыка",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
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
     
    local weaponA = hero:getBelongings().weapon
    local heroPos = hero:getPos()
    moveTo = RPD.Ballistica:cast(heroPos,cell,true,false,false)
    RPD.zapEffect(heroPos, moveTo, "horattack_effect")
    for i = 0, math.min( math.min(2+lvl, 5), RPD.Ballistica.distance ) do
      enemy = RPD.Actor:findChar(RPD.Ballistica.trace[i])
      if enemy and enemy ~= hero then
        enemy:damage( math.ceil( 2*lvl + RPG.physStr()*0.15 + RPG.AllFast()*0.4 + weaponA:damageRoll(hero)*0.75 ) - enemy:dr() - i, hero)
        RPD.topEffect(enemy:getPos(),"bleeding_effect")
        end
      end
     return true
   end
}
