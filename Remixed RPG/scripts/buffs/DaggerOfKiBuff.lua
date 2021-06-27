---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"
local RPG  = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local a = "daggerofki"
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
    
    attackProc = function(self,buff,enemy,damage)
     local Spell = storage.gameGet(a) or {}
     Spell.exp = Spell.exp+1
     if Spell.exp == Spell.expMax then
      Spell.exp = 0
      Spell.expMax = Spell.expMax+6
      Spell.lvl = Spell.lvl+1
     end
     
     if buff.target:buffLevel("Invisibility") == 1 or state[enemy:getState():getTag()] or enemy:isParalysed() then
      enemy:damage(math.ceil(RPG.magStr()*0.35 + 0.5*Spell.lvl), buff.target)
     else
      enemy:damage( math.ceil(RPG.magStr()*0.15 + 0.2*Spell.lvl), buff.target)
     end
     
     if buff.target:buffLevel("SealShield") == 1 then
      buff.target:heal( math.ceil(RPG.magStr()*0.2 + 0.3*Spell.lvl), buff.target)
      RPD.Sfx.CellEmitter:get(buff.target:getPos()):burst(RPD.Sfx.Speck:factory(RPD.Sfx.Speck.HEALING ), 3)
     end
     
     buff:detach()
     return damage
    end
}