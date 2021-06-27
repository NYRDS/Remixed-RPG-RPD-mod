---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "flurryarrows"

local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 49,
            name          = "Шквал стрел",
            info          = "",
        }
    end,
    
    attackProc = function(self,buff,enemy,damage)
      local hero = RPD.Dungeon.hero
      local Spell = storage.gameGet(a) or {}
      local weapon = hero:getBelongings().weapon
      if weapon:goodForMelee() ~= true and weapon:getClassName() ~= "DummyItem" and RPG.distance(enemy:getPos()) >= 1 then
        Spell.exp = Spell.exp+1
        if Spell.exp == Spell.expMax then
          Spell.exp = 0
          Spell.expMax = Spell.expMax+6
          Spell.lvl = Spell.lvl+1
         end
        enemy:damage(math.random(damage,damage+math.ceil(RPG.physStr()*0.1 + RPG.AllFast()*0.1)),hero)
      RPD.zapEffect(RPD.Dungeon.hero:getPos(),enemy:getPos(),"CommonArrow")
        buff:detach()
      else
        RPD.glog("-- \"Шквал стрел\" используется только с оружием дальнего боя!")
        buff:detach()
      end
      return damage
    end
}