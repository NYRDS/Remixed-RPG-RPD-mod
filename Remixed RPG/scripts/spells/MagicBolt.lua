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
local a = "magicbolt"

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
            image         = 1,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Магический выстрел["..tostring(lvl).." уровень]",
            info          = "Заклинание высвобождающее вашу ману в виде сферы по направлению руки. Урон сферы зависит от \"магической силы\" и уровня навыка,снижается с расстоянием.",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 8,
            cooldown      = math.max(15-lvl-RPG.spellFast,12-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    Count = storage.gameGet(a) or {}
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     exp = exp+1
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
 pos = RPD.Ballistica:cast(RPD.Dungeon.hero:getPos(),cell,true,true,true)
 local enemy = RPD.Actor:findChar(pos)
 RPD.zapEffect(RPD.Dungeon.hero:getPos(),pos,"magic_missile")
 if enemy and enemy ~= RPD.Dungeon.hero then
  enemy:damage(math.ceil(RPG.magStr()*0.25)+3*lvl-RPG.distance(pos) + 6-lvl,RPD.Dungeon.hero)
  return true
 else
 return true
 end
   end
}
