---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local a = "bloodshield"
local Spell = storage.gameGet(a) or {}
local hero = RPD.Dungeon.hero
local num = 0
local shield1 = math.ceil(5+3*Spell.lvl+(hero:ht()-hero:hp())*0.15)
local shield2 = math.ceil(5+3*Spell.lvl+(hero:ht()-hero:hp())*0.15)

return buff.init{
    desc  = function ()
        return {
            icon          = 52,
            info          = "",
        }
    end,
name = function()
return "Кровавый щит "..tostring(shield1).."/"..tostring(shield2)
end,

defenceProc = function(self, buff, enemy, damage)
 hero = RPD.Dungeon.hero
 shield1 = shield1 - damage
 if shield1 <= 0 then
  buff:detach()
  return shield1
 end
  RPD.playSound("body_armor")
  hero:getSprite():showStatus(0xffff00,"поглотил")
  RPD.glog("Щит поглотил урон"..tostring(shield1).."/"..tostring(shield2)
)
  return false
end


}
