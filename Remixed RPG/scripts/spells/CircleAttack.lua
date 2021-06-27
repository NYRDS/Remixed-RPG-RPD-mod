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
local a = "circleattack"

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
            image         = 22,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Атакующая стойка №1: Круговой удар["..tostring(lvl).." уровень]",
            info          = "Круговой удар, словно ветер прорезающий облака.\nУрон растёт с вашей \"скоростью\", \"физической силой\", уроном экипированного оружия и уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 2,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    cast = function(self, spell, chr, cell)
    local level = RPD.Dungeon.level
    local hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 0 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
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
    
    RPD.topEffect(hero:getPos(),"dissection_effect")
    
     local x = level:cellX(hero:getPos())
     local y = level:cellY(hero:getPos())
     local weaponA = hero:getBelongings().weapon
     local weaponB = hero:getBelongings().leftHand
     
     for i = x-1,x+1 do
      for j = y-1,y+1 do
       local pos = level:cell(i,j)
       local enemy = RPD.Actor:findChar(pos)
       if enemy and enemy ~= RPD.Dungeon.hero then
        enemy:damage((math.ceil(RPG.physStr()*0.1 + RPG.AllFast()*0.25) + weaponA:damageRoll(hero) + weaponB:damageRoll(hero)*0.65 + 2*lvl)-enemy:dr(), RPD.Dungeon.hero)
        RPD.topEffect(pos,"bleeding_effect")
       end
     end
   end
   return true
   end
}
