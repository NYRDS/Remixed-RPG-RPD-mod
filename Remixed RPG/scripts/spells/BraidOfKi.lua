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
local a = "braidofki"

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
            image         = 26,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Высвобождение ки: Коса["..tostring(lvl).." уровень]",
            info          = "Ки принимает форму косы, несущую разрушения.\n\nНаносит урон выбранному врагу рядом с вами, накладывает на него \"метку ки\" на 3 хода, а также наносит урон вокруг вас. Если на выбранном враге уже действует \"метка ки\", то вы получаете \"невидимость\" на 3 хода. Урон растёт с вашей \"магической силой\" и уровнем навыка.",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 12,
            cooldown      = math.max(16-lvl-RPG.spellFast,10-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    local level = RPD.Dungeon.level
    local hero = RPD.Dungeon.hero
    
    if RPD.Dungeon.hero:lvl() <= 0 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.distance(cell) ~= 0 then
      RPD.glog("-- Слишком далеко")
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

    local enemy1 = RPD.Actor:findChar(cell)
    
    if enemy1 and enemy1 ~= hero and enemy1:buffLevel("KiMark") == 1 then
      RPD.affectBuff(hero,RPD.Buffs.Invisibility, 4)
    end
    
    if enemy1 and enemy1 ~= RPD.Dungeon.hero then
      enemy1:damage(math.ceil(RPG.magStr()*0.35 + 0.5*lvl),hero)
      RPD.affectBuff(enemy1,"KiMark",4)
    end
    
    RPD.topEffect(hero:getPos(),"braidofki1_effect")
    RPD.topEffect(cell,"braidofki2_effect")
    
     local x = level:cellX(hero:getPos())
     local y = level:cellY(hero:getPos())
     
     for i = x-1,x+1 do
      for j = y-1,y+1 do
       local pos = level:cell(i,j)
       local enemy2 = RPD.Actor:findChar(pos)
       if enemy2 and enemy2 ~= hero then
        enemy2:damage(math.ceil(RPG.magStr()*0.15 + 0.2*lvl), hero)
       end
     end
   end
   return true
   end
}
