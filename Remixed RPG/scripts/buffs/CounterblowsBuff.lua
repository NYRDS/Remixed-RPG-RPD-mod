---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local a = "counterblows"
local hero = RPD.Dungeon.hero
local num = 0

return buff.init{
    desc  = function ()
        return {
            icon          = 52,
            name          = "Стойка контрударов",
            info          = "",
        }
    end,

defenceProc = function(self, buff, enemy, damage)
 local Spell = storage.gameGet(a) or {}
 hero = RPD.Dungeon.hero
 if math.random(1,math.ceil(enemy:attackSkill()*1.2)) <= math.ceil(RPG.AllFast()*0.25 + RPG.AllLuck()*0.4 + hero:attackSkill()*0.4) then
 local dmg = damage/10 * Spell.lvl
 if dmg - enemy:dr() <= 0 then
  dmg = enemy:dr()+2
 end
  RPD.playSound("body_armor")
  hero:getSprite():showStatus(0xffff00,"отразил")
  RPD.glog("Вы отразили удар!")
  enemy:damage(dmg - enemy:dr(), RPD.Dungeon.hero)
  return 0
  else
  return damage
 end
end


}
