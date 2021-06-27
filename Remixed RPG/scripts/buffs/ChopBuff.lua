---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "chop"
local hero = RPD.Dungeon.hero
local num = 0

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 49,
            name          = "Атака готова",
            info          = "",
        }
    end,
    
    attackProc = function(self,buff,enemy,damage)
    local Spell = storage.gameGet(a) or {}
    Spell.exp = Spell.exp+1
    if Spell.exp == Spell.expMax then
     Spell.exp = 0
     Spell.expMax = Spell.expMax+6
     Spell.lvl = Spell.lvl+1
     end
     
    local buffs = RPD.affectBuff(enemy,RPG.Buffs.Bleeding,2)
    buffs:level(math.ceil(RPG.physStr()*0.2))
    RPD.topEffect(enemy:getPos(),"bleeding_effect")
    buff:detach()
    if RPG.physicStr ~= nil then
    return damage+math.ceil(RPG.physStr()*0.2)
    else
    return
    end
    end
}