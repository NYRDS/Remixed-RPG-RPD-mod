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
local a = "soulsabsorbing"
local chars = 0

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
            image         = 16,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Духовное насыщение["..tostring(lvl).." уровень]",
            info          = "Забирая по кусочку души всех близлежащих врагов, вы чувствуете прилив сил.\n\nНакладывает на ближайших врагов дебафф \"слабость\", а также увеличивает вашу скорость атаки. Усиление растёт с количеством задетых врагов и уровнем навыка, а длительность с уровнем навыка и половиной количества задетых врагов. Площадь применения зависит лишь от уровня навыка.",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = 15,
            cooldown      = math.max(16-lvl-RPG.spellFast,13-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    cast = function(caster, spell, chr, cell)
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
    if exp == expMax then
     exp = 0
     expMax = expMax+5
     lvl = lvl+1
     end
    else
     lvl = 1
     exp = 0
     expMax = 4
    end
    local level = RPD.Dungeon.level
    local x = level:cellX(hero:getPos())
    local y = level:cellY(hero:getPos())
    for i = math.max(x - 4,x - lvl),math.min(x + 4, x + lvl) do
     for j = math.max(y - 4,y - lvl),math.min(y + 4,y + lvl) do
      local pos = level:cell(i,j)
      local enemy = RPD.Actor:findChar(pos)
    if enemy and enemy ~= RPD.Dungeon.hero then
      chars = chars +1
      RPD.affectBuff(enemy,"LowAttack",lvl)
      RPD.zapEffect(pos, RPD.Dungeon.hero:getPos(), "soulabsorbing_effect")
      end
     end
    end 
    if chars ~= 1 then
      exp = exp +1
    end
    RPD.removeBuff(hero,"FastAttacks")
    local buff = RPD.affectBuff(hero,"FastAttacks" ,lvl + chars/2)
    buff:level(chars + lvl)
    
    storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl})
  return true
   end
}
