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
local a = "rainofarrows"

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
            image         = 25,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Дождь стрел["..tostring(lvl).." уровень]",
            info          = "Дождь, что обрушивает на врагов страдания, в лице тысячи стрел.\nУрон растёт с вашей \"физической силой\", \"скоростью\" и уровнем навыка. Дальность действия растёт с уровнем навыка",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(21-lvl-RPG.spellFast,15-math.ceil(RPG.spellFast/2)),
            castTime      = 1
        }
    end,
    castOnCell = function(self, spell, chr, cell)
    local level = RPD.Dungeon.level
    local hero = RPD.Dungeon.hero
    local weapon = hero:getBelongings().weapon
    if RPD.Dungeon.hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    
      if weapon:goodForMelee() == true or weapon:getClassName() == "DummyItem" then
        RPD.glog("-- Навык \"Дождь стрел\" используется только с луком")
        return false
      end
      
    if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 then
      RPD.glog("-- Вы не можете использовать навык на стену!")
      return false
    end
    if RPG.distance(cell) >= math.min(1+lvl,4) then
      RPD.glog("-- Вы не можете использовать навык так далеко!")
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
    
     local x = level:cellX(cell)
     local y = level:cellY(cell)
     
     for i = x-1,x+1 do
      for j = y-1,y+1 do
       local pos = level:cell(i,j)
       local enemy = RPD.Actor:findChar(pos)
       local level = RPD.Dungeon.level
       if (level:getTileType(pos) ~= 4 and level:getTileType(pos) ~= 12 and level:getTileType(pos) ~= 13 and level:getTileType(pos) ~= 25 and level:getTileType(pos) ~= 26 and level:getTileType(pos) ~= 45 and level:getTileType(pos) ~= 41 and level:getTileType(pos) ~= 43 and level:getTileType(pos) ~= 44) and enemy ~= RPD.Dungeon.hero then
         RPD.topEffect(pos, "rainofarrows_effect")
       end
       if enemy and enemy ~= RPD.Dungeon.hero then
        enemy:damage(math.ceil(RPG.physStr()*0.1 + RPG.AllFast()*0.2)+ 5*lvl, RPD.Dungeon.hero)
       end
     end
   end
   return true
   end
}
