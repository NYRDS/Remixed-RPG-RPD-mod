---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "shadowdagger"
local hero = RPD.Dungeon.hero
local state         = {}
state["PASSIVE"]     = true
state["SLEEPING"]    = true
state["FLEEING"]     = true
state["HORRIFIED"]   = true
state["RUNNINGAMOK"] = true

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 49,
            name          = "Кинжал готов",
            info          = "",
        }
    end,
    
    stealthBonus = function(self,buff)
        local Spell = storage.gameGet(a) or {}
        return (math.ceil(RPG.AllFast()*0.8) + 2*Spell.lvl)
    end,
    
    attackProc = function(self,buff,enemy,damage)
     local Spell = storage.gameGet(a) or {}
     Spell.exp = Spell.exp+1
     if Spell.exp == Spell.expMax then
      Spell.exp = 0
      Spell.expMax = Spell.expMax+6
      Spell.lvl = Spell.lvl+1
     end
     
     if buff.target:buffLevel("Invisibility") == 1 or state[enemy:getState():getTag()] or enemy:isParalysed() then
      enemy:damage(math.ceil(RPG.physStr()*0.35 + 0.5*Spell.lvl), buff.target)
     else
      enemy:damage( math.ceil(RPG.physStr()*0.15 + 0.2*Spell.lvl), buff.target)
     end
     RPD.topEffect(enemy:getPos(),"bleeding_effect")
     buff:detach()
     return damage
    end
}