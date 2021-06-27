---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local buff = require "scripts/lib/buff"
local a = "sealofki"
local Spell = storage.gameGet(a) or {}
local hero = RPD.Dungeon.hero
local num = 0
local shield1 = math.ceil(RPG.magStr()*0.35) + 3*Spell.lvl
local shield2 = math.ceil(RPG.magStr()*0.35) + 3*Spell.lvl

return buff.init{
    desc  = function ()
        return {
            icon          = 54,
            info          = "",
        }
    end,
name = function()
return "Магический щит "..tostring(shield1).."/"..tostring(shield2)
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
  RPD.glog("Щит поглотил урон"..tostring(shield1).."/"..tostring(shield2))
  return false
end


}
