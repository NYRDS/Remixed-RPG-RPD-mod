---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local a = "flameshield"
local Spell = storage.gameGet(a) or {}
local hero = RPD.Dungeon.hero
local shield = math.ceil(1+1.5*Spell.lvl+hero:ht()*(0.3 + Spell.lvl*0.1))
local shield2 = shield
local debuffs = {"Burning"}

local level

return buff.init{
    desc  = function ()
        return {
            icon          = 54,
            info          = "",
        }
    end,
name = function()
return "Пламенный щит "..tostring(shield).."/"..tostring(shield2)
end,

immunities = function(self,buff)
  return debuffs
end,

charAct = function(self,buff)
  hero = RPD.Dungeon.hero
  level = RPD.Dungeon.level
  local x = level:cellX(hero:getPos())
  local y = level:cellY(hero:getPos())
  for i = x-1, x+1 do
    for j = y-1, y+1 do
      local c = level:cell(i,j)
      local tile = level:getTileType(c)
      if c ~= hero:getPos() and tile ~= 4 and tile ~= 12 then
        RPD.placeBlob(RPD.Blobs.Fire,c,1)
        local enemy = RPD.Actor:findChar(c)
        if enemy and enemy ~= hero then
          RPD.removeBuff(enemy,"FlameMark")
    RPD.affectBuff(enemy, "FlameMark", 2+Spell.lvl)
        end
      end
    end
  end
end,

defenceProc = function(self, buff, enemy, damage)
 shield = shield - damage
 if shield <= 0 then
  buff:detach()
  return shield
 end
  RPD.playSound("body_armor")
  hero:getSprite():showStatus(0xffff00,"поглотил")
  RPD.glog("Щит поглотил урон"..tostring(shield).."/"..tostring(shield2))
  return false
end


}
