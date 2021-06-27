---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local Add = require "scripts/lib/AdditionalFunctions"

local Que = require "scripts/lib/Queue"

local storage = require "scripts/lib/storage"

local hero = RPD.Dungeon.hero

local spell = require "scripts/lib/spell"

local stats = ""

local sList = "spelllist"

local Spells

local sMas

local states = {
"Сила",
"Интеллект",
"Ловкость",
"Живучесть",
"Мудрость",
"Удача"
}

local index1 = 1

local dialog
local classDialog
local subclassDialog

subclassDialog = function(index)
if RPG.class == "Warrior" then
 if index == 0 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","BloodShield","Dissection","RageDash"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "Berserk"
 end
 if index == 1 then
   sMas= {"Stats","MagicBolt","ShadowClone","Chop","FlameShield","FlameAttacks","SteelBody"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "Paladin"
 end
 if index == 2 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","SoulsTormentor","SoulsAbsorbing","ChaosOfMind"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "BladeOfMind"
 end
 if index == 3 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","HorAttack","CircleAttack","Counterblows"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "Samurai"
 end
end
 
if RPG.class == "Rogue" then
 if index == 0 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","FlurryArrows","RainOfArrows","Rebound"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "Archer"
 end
 if index == 1 then
   sMas= {"Stats","MagicBolt","ShadowClone","Chop","ShadowDash","ShadowDagger", "KnifeThrow"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "Assassin"
 end
 if index == 2 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","DaggerOfKi","SealOfKi","BraidOfKi"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "Ninja"
 end
 if index == 3 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop", "BloodyGreed", "PlaceTrap", "Disguise"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "Bandit"
 end
end
 
if RPG.class == "Mage" then
 if index == 0 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","Lightning","DaggerOfKi","Dissection"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "BattleMage"
 end
 if index == 1 then
   sMas= {"Stats","MagicBolt","ShadowClone","Chop","BloodSpikes", "SteelBody","BloodShield"}
   Que.pushMas(sList,sMas)
   RPG.subclass = "Demonologist"
 end
 if index == 2 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","SummonBoneGolem","Lightning","SealOfKi"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "Necromancer"
 end
 if index == 3 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","FastRun","DaggerOfKi","Lightning"}
    Que.pushMas(sList,sMas)
    RPG.subclass = "Enchanter"
 end
end

 storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class, subclass = RPG.subclass})
end

classDialog = function(index)
 if index == 0 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","SteelBody","Dissection","SoulsTormentor","Counterblows"}
   Que.pushMas(sList,sMas)
   RPG.class = "Warrior"
 end
 if index == 1 then
   sMas= {"Stats","MagicBolt","ShadowClone","Chop","SealOfKi","PlaceTrap","ShadowDash","Rebound"}
   Que.pushMas(sList,sMas)
   RPG.class = "Rogue"
 end
 if index == 2 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","BloodSpikes","SummonBoneGolem","Lightning","FastRun"}
    Que.pushMas(sList,sMas)
    RPG.class = "Mage"
 end

 storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class,subclass = RPG.subclass})
end

dialog = function(index)
 hero = RPD.Dungeon.hero
 if index == 0 then
   if index1 ~= 6 then
     index1 = index1+1
   else
     index1 = 1
    end
   hero = RPD.Dungeon.hero
   if RPG.class == nil and hero:lvl() >= 5 then
     Add.statusWindowClass(dialog,states,index1)
   else
     if RPG.class ~= nil and hero:lvl() >= 10 and RPG.subclass == nil then
       Add.statusWindowSubclass(dialog,states,index1)
     else
       Add.statusWindow(dialog,states,index1)
     end
   end
   end
 
 if index == 1 then
 
  if index1-1 == 0 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      RPG.strength = RPG.strength+1
      RPG.physicStr = RPG.physicStr+1
      if RPG.strength%2 == 0 and (RPG.subclass == "Berserk" or RPG.subclass == "BattleMage" or RPG.subclass == "Assassin") then
        RPG.physicStr = RPG.physicStr+1
      end
      if RPG.strength%10 == 0 then
        hero:STR(hero:STR()+1)
      end
    end
  end
  
  if index1-1 == 1 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      RPG.intelligence = RPG.intelligence+1
      hero:setMaxSkillPoints(hero:getSkillPointsMax()+1)
      hero:setSkillPoints(hero:getSkillPoints()+1)
      RPG.magicStr = RPG.magicStr+1
      if (RPG.intelligence%2) == 0 and (RPG.class == "Mage" or RPG.subclass == "BladeOfMind" or RPG.subclass == "Ninja") then
        RPG.magicStr = RPG.magicStr+1
        hero:setMaxSkillPoints(hero:getSkillPointsMax()+1)
        hero:setSkillPoints(hero:getSkillPoints()+1)
      end
      if RPG.intelligence%20 == 0 then
        RPG.spRegen = RPG.spRegen+1
      end
    end
  end
  
  if index1-1 == 2 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      RPG.dexterity = RPG.dexterity+1
      RPG.fast = RPG.fast+1
      if RPG.dexterity%2 == 0 and (RPG.class == "Rogue" or RPG.subclass == "Samurai") then
        RPG.fast = RPG.fast+1
      end
    end
  end
  
  if index1-1 == 3 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      RPG.vitality = RPG.vitality+1
      hero:ht(hero:ht()+1)
      hero:heal(1,hero)
      if RPG.vitality%2 == 0 then
        hero:ht(hero:ht()+1)
        hero:heal(1,hero)
        if RPG.class == "Warrior" or RPG.subclass == "Demonologist" then
          hero:ht(hero:ht()+1)
          hero:heal(1,hero)
        end
      end
      if RPG.vitality%5 == 0 and RPG.subclass == "Paladin" then
        hero:ht(hero:ht()+1)
        hero:heal(1,hero)
      end
    end
  end
  
  if index1-1 == 4 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      if RPG.wisdom%2 == 0 then
        RPG.spRegen = RPG.spRegen+1
      end
      if RPG.wisdom%5 == 0 and RPG.subclass == "Enchanter" then
        RPG.spRegen = RPG.spRegen +1
      end
      RPG.wisdom = RPG.wisdom+1
      end
    end
  
  if index1-1 == 5 then
    if RPG.sPoints ~= 0 then
      RPG.sPoints = RPG.sPoints-1
      RPG.luck = RPG.luck+1
    end
  end
  
  if RPG.class == nil and hero:lvl() >= 5 then
     Add.statusWindowClass(dialog,states,index1)
   else
     if RPG.class ~= nil and hero:lvl() >= 10 and RPG.subclass == nil then
       Add.statusWindowSubclass(dialog,states,index1)
     else
       Add.statusWindow(dialog,states,index1)
     end
   end
  
     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class, subclass = RPG.subclass})
 end
 
 if index == 2 then
 if RPG.class == nil then
    Add.classWindow(classDialog)
  else
    Add.subclassWindow(subclassDialog)
  end
 end
 
 end

return spell.init{
    desc  = function ()
        return {
            image         = 0,
            imageFile     = "spellsIcons/spellicons.png",
            name          = "Окно статуса",
            info          = "Открывает окно статуса персонажа",
            magicAffinity = "Combat",
            targetingType = "self",
            level         = 1,
            spellCost     = -1,
            cooldown      = 0,
            castTime      = 0
        }
    end,
    cast = function(self, spell, caster, cell)
    local Stats = storage.gameGet(stats) or {}
    Spells = require "scripts/spells/CustomSpellsList"
    if Stats.str ~= nil then
     RPD.glog("True")
     
     if RPG.strength == nil then
     RPG.strength = Stats.str
     RPG.intelligence = Stats.int
     RPG.dexterity = Stats.dex
     RPG.vitality = Stats.vit
     RPG.wisdom = Stats.wis
     RPG.luck = Stats.luc
     
     RPG.sPoints = Stats.sP
     RPG.spRegen = Stats.spR
     RPG.physicStr = Stats.phyS
     RPG.magicStr = Stats.magS
     RPG.fast = Stats.fast
     RPG.lvlToUp = Stats.lvlT
     RPG.class = Stats.class
     RPG.subclass = Stats.subclass
     
     end

     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class, subclass = RPG.subclass})
     
    else
     RPD.glog("False")
     
     Que.new(sList)
     sMas = {"Stats","MagicBolt","ShadowClone","Chop"}
     Que.pushMas(sList,sMas)
     
     RPD.permanentBuff(hero,"RPGbuff")
     
     RPG.sPoints = 20
     RPG.spRegen = 1
     RPG.physicStr = 1
     RPG.magicStr = 1
     RPG.fast = 1
     RPG.lvlToUp = 1

     RPG.strength = 1
     RPG.intelligence = 1
     RPG.dexterity = 1
     RPG.vitality = 1
     RPG.wisdom = 1
     RPG.luck = 1

     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class, subclass = RPG.subclass})
    end
    
    hero = RPD.Dungeon.hero
    if RPG.class == nil and hero:lvl() >= 5 then
     Add.statusWindowClass(dialog,states,index1)
   else
     if hero:lvl() >= 10 and RPG.subclass == nil then
       Add.statusWindowSubclass(dialog,states,index1)
     else
       Add.statusWindow(dialog,states,index1)
     end
   end
    hero:setSkillPoints(hero:getSkillPoints()-1)
    
        return true
    end
}
