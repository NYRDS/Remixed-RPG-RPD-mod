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
local a = "bloodaura"

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
            image         = 5,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Кроважадная аура["..tostring(lvl).." уровень]",
            info          = "Пользователь испускает ауру, полную жажды убийства. Враги находящиеся в радиусе действия ауры получают дебаффы: \"Оглушение\" и \"Страх\". Радиус увеличивается с ростом уровня навыка вплоть до 5. Продолжительность действия дебаффа \"Страх\" растёт с уровнем навыка",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 5,
            cooldown      = math.max(29-lvl-RPG.spellFast,26-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    cast = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    if hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
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
    local level = RPD.Dungeon.level
    local x = level:cellX(hero:getPos())
    local y = level:cellY(hero:getPos())
    RPD.bottomEffect(hero:getPos(),"blood_aura")
    for i = math.max(x - 4,x - lvl),math.min(x + 4, x + lvl) do
     for j = math.max(y - 4,y - lvl),math.min(y+4,y + lvl) do
      local pos = level:cell(i,j)
      local enemy = RPD.Actor:findChar(pos)
    if enemy and enemy ~= RPD.Dungeon.hero then
    RPD.affectBuff(enemy,RPD.Buffs.Paralysis,1)
     RPD.affectBuff(enemy,RPG.Buffs.Terror,1+lvl)
      end
     end
    end 
  return true
   end
}
