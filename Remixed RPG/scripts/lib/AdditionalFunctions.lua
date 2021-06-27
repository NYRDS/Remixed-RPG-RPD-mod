local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local storage = require "scripts/lib/storage"

local RPG1 = {

   addStats = function(num, stat)
    if stat == 1 then
     RPG.physicStrA = RPG.physicStrA + num
    end
    if stat == 2 then
      RPG.magicStrA = RPG.magicStrA + num
    end
    if stat == 3 then
      RPG.fastA = tonumber(RPG.fastA) + tonumber(num)
    end
    if stat == 4 then
      RPG.spRegenA = RPG.spRegenA + num
    end
    if stat == 5 then
      RPG.luckA = RPG.luckA + num
    end
 end,
 
 delStats = function(num, stat)
    if stat == 1 then
      RPG.physicStrA = RPG.physicStrA - num
    end
    if stat == 2 then
      RPG.magicStrA = RPG.magicStrA - num
    end
    if stat == 3 then
      RPG.fastA = RPG.fastA - num
    end
    if stat == 4 then
      RPG.spRegenA = RPG.spRegenA - num
    end
    if stat == 5 then
      RPG.luckA = RPG.luckA - num
   end
 end,
 
 trapChoise = function(dialog)
   local Spell = storage.gameGet("placetrap") or {}
   RPD.chooseOption(dialog,
   "Что собираетесь сделать?",
   "",
   "Поставить ловушку",
   "Улучшить ловушку ["..Spell.UP.." очков]")
 end,
 
 trapChoiseOn = function(dialog,index)
   local Spell = storage.gameGet("placetrap") or {}
   if index == 0 then
     RPD.chooseOption(dialog,
     "Ловушки",
     "",
   "Огненная ловушка ["..Spell.FT.." уровень]",
   "Взрывная ловушка ["..Spell.BT.." уровень]",
   "Калечющая ловушка ["..Spell.CT.." уровень]",
   "Замораживающая ловушка ["..Spell.IT.." уровень]",
   "Отравляющая ловушка ["..Spell.PT.." уровень]")
   else
     RPD.chooseOption(dialog,
     "Ловушки" ,
     "",
   "Огненная ловушка ["..Spell.FT.." уровень]",
   "Взрывная ловушка ["..Spell.BT.." уровень]",
   "Калечющая ловушка ["..Spell.CT.." уровень]",
   "Замораживающая ловушка ["..Spell.IT.." уровень]",
   "Отравляющая ловушка ["..Spell.PT.." уровень]","["..Spell.UP.." очков]")
   end
 end,

 statusWindow = function(dialog,states,index1)
 RPD.chooseOption( dialog,
                "Статус",
                "Сила:"..tostring(RPG.strength).." [1 очко для повышения]\n Интеллект:"..tostring(RPG.intelligence).." [1 очко для повышения]\n Ловкость:"..tostring(RPG.dexterity).." [1 очко для повышения]\n Живучесть:"..tostring(RPG.vitality).." [1 очко для повышения]\n Мудрость:"..tostring(RPG.wisdom).." [1 очко для повышения]\n Удача:"..tostring(RPG.AllLuck()).." [1 очко для повышения]\n\n Физическая сила:"..tostring(RPG.physStr()).."\n Магическая сила:"..tostring(RPG.magStr()).."\n Скорость:"..tostring(RPG.AllFast()).."\n "..tostring(RPG.AllSpRegen()).." восстановления маны в 3 хода",
                "["..tostring(states[index1]).."]",
                "Повысить характеристику["..tostring(RPG.sPoints).." очков статуса]"
        )
 end,
 
 statusWindowClass = function(dialog,states,index1)
 RPD.chooseOption( dialog,
                "Статус",
                "Сила:"..tostring(RPG.strength).." [1 очко для повышения]\n Интеллект:"..tostring(RPG.intelligence).." [1 очко для повышения]\n Ловкость:"..tostring(RPG.dexterity).." [1 очко для повышения]\n Живучесть:"..tostring(RPG.vitality).." [1 очко для повышения]\n Мудрость:"..tostring(RPG.wisdom).." [1 очко для повышения]\n Удача:"..tostring(RPG.AllLuck()).." [1 очко для повышения]\n\n Физическая сила:"..tostring(RPG.physStr()).."\n Магическая сила:"..tostring(RPG.magStr()).."\n Скорость:"..tostring(RPG.AllFast()).."\n "..tostring(RPG.AllSpRegen()).." восстановления маны в 3 хода",
                "["..tostring(states[index1]).."]",
                "Повысить характеристику["..tostring(RPG.sPoints).." очков статуса]",
                "Выбрать класс"
        )
 end,
 classWindow = function(dialog)
 RPD.chooseOption( dialog,
                "Выбор класса",
                "Выберите класс",
                "Воин(живучесть)",
                "Разбойник(ловкость)",
                "Маг(интеллект)"
        )
 end,
 
 statusWindowSubclass = function(dialog,states,index1)
 RPD.chooseOption( dialog,
                "Статус",
                "Сила:"..tostring(RPG.strength).." [1 очко для повышения]\n Интеллект:"..tostring(RPG.intelligence).." [1 очко для повышения]\n Ловкость:"..tostring(RPG.dexterity).." [1 очко для повышения]\n Живучесть:"..tostring(RPG.vitality).." [1 очко для повышения]\n Мудрость:"..tostring(RPG.wisdom).." [1 очко для повышения]\n Удача:"..tostring(RPG.AllLuck()).." [1 очко для повышения]\n\n Физическая сила:"..tostring(RPG.physStr()).."\n Магическая сила:"..tostring(RPG.magStr()).."\n Скорость:"..tostring(RPG.AllFast()).."\n "..tostring(RPG.AllSpRegen()).." восстановления маны в 3 хода",
                "["..tostring(states[index1]).."]",
                "Повысить характеристику["..tostring(RPG.sPoints).." очков статуса]",
                "Выбрать подкласс"
        )
 end,
 subclassWindow = function(dialog)
 local subclasses = {
   Warrior = {"Берсерк(живучесть, сила)","Паладин(живучестьХ2)","Клинок разума(живучесть, интеллект)","Самурай(живучесть, ловкость)"},
   Rogue = {"Лучник(ловкостьХ2)","Убийца(ловкость, сила)","Ниндзя(ловкость, интеллект)","Бандит(ловкость, удача)"},
   Mage = {"Боевой маг(интеллект, сила)","Демонолог(интеллект, живучесть)","Некромант(интеллект, удача)","Зачарователь(интеллект, мудрость)"}
   }
   local subclass = subclasses[RPG.class]
 RPD.chooseOption( dialog,
                "Выбор подкласса",
                "Выберите подкласс",
                subclass[1],
                subclass[2],
                subclass[3],
                subclass[4]
        )
 end
 
 }
return RPG1