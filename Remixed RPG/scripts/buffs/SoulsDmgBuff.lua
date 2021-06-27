---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "soulstormentor"
local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 51,
            name          = "Терзающие души удары",
            info          = "",
        }
    end,
    
    attackProc = function(self,buff,enemy,damage)
    local Count = storage.gameGet(a) or {}
    num = num+1
    if num == 2 then
     enemy:damage(math.ceil(RPG.magStr()*0.25 + enemy:ht()*(0.05+Count.lvl/100)),RPD.Dungeon.hero)
     enemy:getSprite():showStatus(0xffff00,"терзание")
     num = 0
    end
    return damage
    end
}