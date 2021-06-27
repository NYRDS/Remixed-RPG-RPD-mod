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
local summon
local summonMax
local a = "bonegolem"
local b = "gsc"
local golems = {"BoneGolem_lvl1","BoneGolem_lvl2","BoneGolem_lvl3"}

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
            image         = 9,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Призыв костяного голема["..tostring(lvl).." уровень]",
            info          = "Заклинание из разряда \"Запретных\". Оно позволяет создать голема из костей людей, животных и монстров. Голем получает дополнительное здоровье зависящее от \"магической силы\". С ростом уровня навыка голем становится сильнее. Навык имеет максимум 3 уровень.",
            magicAffinity = "Combat",
            targetingType = "cell",
            level         = 1,
            spellCost     = 15,
            cooldown      = math.max(19-lvl-RPG.spellFast,16-math.ceil(RPG.spellFast/2)),
            castTime      = 0.5
        }
    end,
    
    castOnCell = function(self, spell, chr, cell)
    local hero = RPD.Dungeon.hero
    local level = RPD.Dungeon.level
    Count = storage.gameGet(a) or {}
    if hero:lvl() <= 4 then
     RPD.glog("-- Для использования навыка вам нужен 5+ уровень")
     return false
    end
    if RPG.subclass ~= nil and RPG.subclass ~= "Necromancer" then
      RPD.glog("--Вы не имеете соответсвующего подкласса")
      return false
    end
    if Count.lvl ~= nil then
     lvl = Count.lvl
     exp = Count.exp
     expMax = Count.expMax
     summon = Count.summon
     summonMax = Count.summonMax
     if level:getTileType(cell) == 4 or level:getTileType(cell) == 12 or RPG.distance(cell) > 2 then
      RPD.glog("** Вы не можете призвать там голема.")
      return false
     else
     RPD.playSound("snd_cursed.ogg")
      exp = exp+1
     end
    if exp == expMax then
     exp = 0
     expMax = expMax+15
     if lvl ~= 3 then
      lvl = lvl+1
     end
     end
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax,})
    else
     lvl = 1
     exp = 0
     expMax = 15
     summon = 0
     summonMax = 3
     storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax})
    end
    summon = summon +1
    storage.gamePut(a,{exp = exp, expMax = expMax, lvl = lvl, summon = summon, summonMax = summonMax})
    local mob = RPD.MobFactory:mobByName(golems[lvl])
    mob:setPos(cell)
    RPD.Dungeon.level:spawnMob(RPD.Mob:makePet(mob,RPD.Dungeon.hero));
    RPD.permanentBuff(mob,"ExpShare")
    mob:ht(mob:ht()+math.ceil(RPG.magStr()*0.25) + 5*lvl)
    mob:hp(mob:ht())
  return true
   end
}
