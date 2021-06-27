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

local strPrice 
local intPrice 
local dexPrice 
local vitPrice 
local wisPrice 
local lucPrice 
local strLvl 
local intLvl 
local dexLvl 
local vitLvl 
local wisLvl 
local lucLvl
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

classDialog = function(index)
 if index == 0 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","SteelBody","BloodAura","SoulsTormentor","Counterblows"}
   Que.pushMas(sList,sMas)
   RPG.class = "Warrior"
 end
 if index == 1 then
   sMas= {"Stats","MagicBolt","ShadowClone","Chop","MagicSeal","Disguise","ShadowDash","Rebound"}
   Que.pushMas(sList,sMas)
   RPG.class = "Rogue"
 end
 if index == 2 then
   sMas = {"Stats","MagicBolt","ShadowClone","Chop","BloodSpikes","SummonBoneGolem","Lightning","FastRun"}
    Que.pushMas(sList,sMas)
    RPG.class = "Mage"
 end

 storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, strP = strPrice, intP = intPrice, dexP = dexPrice, vitP = vitPrice, wisP = wisPrice, lucP = lucPrice, strL = strLvl, intL = intLvl, dexL = dexLvl, vitL = vitLvl, wisL = wisLvl, lucL = lucLvl, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class})
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
     Add.statusWindowClass(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
    else
     Add.statusWindow(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
     end
 end
 
 if index == 1 then
 
  if index1-1 == 0 then
  if RPG.sPoints >= strPrice then
   RPG.sPoints = RPG.sPoints-strPrice
   
   RPG.strength = RPG.strength+1
   RPG.physicStr = RPG.physicStr+1
   if RPG.strength%2 == 0 and RPG.subclass == "Berserk" or RPG.subclass == "BattleMage" or RPG.subclass == "Reaper" then
    RPG.physicStr = RPG.physicStr+1
   end
   if RPG.strength%5 == 0 then
   hero:STR(hero:STR()+1)
   end
   end
  end
  
  if index1-1 == 1 then
   if RPG.sPoints >= intPrice then
   RPG.sPoints = RPG.sPoints-intPrice
   
   RPG.intelligence = RPG.intelligence+1
   hero:setMaxSkillPoints(hero:getSkillPointsMax()+1)
   hero:setSkillPoints(hero:getSkillPoints()+1)
   RPG.magicStr = RPG.magicStr+1
   if RPG.intelligence%2 == 0 and RPG.class == "Mage" or RPG.subclass == "BladeMind" or RPD.subclass == "Ninja" then
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
   if RPG.sPoints >= dexPrice then
   RPG.sPoints = RPG.sPoints-dexPrice
   RPG.fast = RPG.fast+1
   RPG.dexterity = RPG.dexterity+1
   if RPG.dexterity%2 == 0 and RPG.class == "Rogue" or RPG.subclass == "Samurai" then
   RPG.fast = RPG.fast+1
   end
   end
  end
  
  if index1-1 == 3 then
   if RPG.sPoints >= vitPrice then
   RPG.sPoints = RPG.sPoints-vitPrice
   
   RPG.vitality = RPG.vitality+1
   hero:ht(hero:ht()+1)
   hero:heal(1,hero)
   if RPG.vitality%2 == 0 then
     hero:ht(hero:ht()+1)
     hero:heal(1,hero)
     if RPG.class == "Warrior" or RPD.subclass == "Demonologist" then
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
   if RPG.sPoints >= wisPrice then
   RPG.sPoints = RPG.sPoints-wisPrice
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
   if RPG.sPoints >= lucPrice then
   RPG.sPoints = RPG.sPoints-lucPrice
   RPG.luck = RPG.luck+1
   end
  end
  
  if RPG.strength == strLvl then
   strPrice = strPrice+1
   strLvl = strLvl+35
  end
  if RPG.intelligence == intLvl then
   intPrice = intPrice+1
   intLvl = intLvl+35
  end
  if RPG.dexterity == dexLvl then
   dexPrice = dexPrice+1
   dexLvl = dexLvl+35
  end
  if RPG.vitality == vitLvl then
   vitPrice = vitPrice+1
   vitLvl = vitLvl+35
  end
  if RPG.wisdom == wisLvl then
   wisPrice = wisPrice+1
   wisLvl = wisLvl+35
  end
  if RPG.luck == lucLvl then
   lucPrice = lucPrice+1
   lucLvl = lucLvl+35
  end
  
  if RPG.class == nil and hero:lvl() >= 5 then
     Add.statusWindowClass(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
    else
     Add.statusWindow(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
 end
  
     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, strP = strPrice, intP = intPrice, dexP = dexPrice, vitP = vitPrice, wisP = wisPrice, lucP = lucPrice, strL = strLvl, intL = intLvl, dexL = dexLvl, vitL = vitLvl, wisL = wisLvl, lucL = lucLvl, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class})
 end
 
 if index == 2 then
  Add.classWindow(classDialog)
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
     end

     strPrice = Stats.strP
     intPrice = Stats.intP
     dexPrice = Stats.dexP
     vitPrice = Stats.vitP
     wisPrice = Stats.wisP
     lucPrice = Stats.lucP
     strLvl = Stats.strL
     intLvl = Stats.intL
     dexLvl = Stats.dexL
     vitLvl = Stats.vitL
     wisLvl = Stats.wisL
     lucLvl = Stats.lucL
     
     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, strP = strPrice, intP = intPrice, dexP = dexPrice, vitP = vitPrice, wisP = wisPrice, lucP = lucPrice, strL = strLvl, intL = intLvl, dexL = dexLvl, vitL = vitLvl, wisL = wisLvl, lucL = lucLvl, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class})
     
    else
     RPD.glog("False")
     
     Que.new(sList)
     sMas = {"Stats","MagicBolt","ShadowClone","Chop"}
     Que.pushMas(sList,sMas)
     
     RPD.permanentBuff(hero,"RPGbuff")
     
     RPG.sPoints = 15
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

     strPrice = 1
     intPrice = 1
     dexPrice = 1
     vitPrice = 1
     wisPrice = 1
     lucPrice = 1
     strLvl = 35
     intLvl = 35
     dexLvl = 35
     vitLvl = 35
     wisLvl = 35
     lucLvl = 35
     
     storage.gamePut(stats, {str = RPG.strength, int = RPG.intelligence, dex = RPG.dexterity, vit = RPG.vitality, wis = RPG.wisdom, luc = RPG.luck, strP = strPrice, intP = intPrice, dexP = dexPrice, vitP = vitPrice, wisP = wisPrice, lucP = lucPrice, strL = strLvl, intL = intLvl, dexL = dexLvl, vitL = vitLvl, wisL = wisLvl, lucL = lucLvl, lvlT = RPG.lvlToUp, magS = RPG.magicStr, phyS = RPG.physicStr, fast = RPG.fast, sP = RPG.sPoints, spR = RPG.spRegen, class = RPG.class})
    end
    RPD.glog(RPG.class)
    
    hero = RPD.Dungeon.hero
    if RPG.class == nil and hero:lvl() >= 5 then
     Add.statusWindowClass(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
    else
     Add.statusWindow(dialog,states,index1,strPrice,intPrice,dexPrice,vitPrice,wisPrice,lucPrice)
     end
    hero:setSkillPoints(hero:getSkillPoints()-1)
    
        return true
    end
}
