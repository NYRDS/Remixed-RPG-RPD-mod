local RPD = require "scripts/lib/commonClasses"
local RPG = require "scripts/lib/Functions"
local Music = luajava.bindClass("com.watabou.noosa.audio.Music")

local RPG1 = {

 statusWindow = function(dialog,states,index1,strP,intP,dexP,vitP,wisP,lucP)
 RPD.chooseOption( dialog,
                "Статус",
                "Сила:"..tostring(RPG.strength).."["..tostring(strP).." очков для повышения], Интеллект:"..tostring(RPG.intelligence).."["..tostring(intP).." очков для повышения], Ловкость:"..tostring(RPG.dexterity).."["..tostring(dexP).." очков для повышения], Живучесть:"..tostring(RPG.vitality).."["..tostring(vitP).." очков для повышения], Мудрость:"..tostring(RPG.wisdom).."["..tostring(wisP).." очков для повышения], Удача:"..tostring(RPG.luck).."["..tostring(lucP).." очков для повышения], Физическая сила:"..tostring(RPG.physicStr)..", Магическая сила:"..tostring(RPG.magicStr)..", Скорость:"..tostring(RPG.fast)..", "..tostring(RPG.spRegen).." восстановления маны в 3 хода",
                "["..tostring(states[index1]).."]",
                "Повысить характеристику["..tostring(RPG.sPoints).." очков статуса]"
        )
 end,
 statusWindowClass = function(dialog,states,index1,strP,intP,dexP,vitP,wisP,lucP)
 RPD.chooseOption( dialog,
                "Статус",
                "Сила:"..tostring(RPG.strength).."["..tostring(strP).." очков для повышения], Интеллект:"..tostring(RPG.intelligence).."["..tostring(intP).." очков для повышения], Ловкость:"..tostring(RPG.dexterity).."["..tostring(dexP).." очков для повышения], Живучесть:"..tostring(RPG.vitality).."["..tostring(vitP).." очков для повышения], Мудрость:"..tostring(RPG.wisdom).."["..tostring(wisP).." очков для повышения], Удача:"..tostring(RPG.luck).."["..tostring(lucP).." очков для повышения], Физическая сила:"..tostring(RPG.physicStr)..", Магическая сила:"..tostring(RPG.magicStr)..", Скорость:"..tostring(RPG.fast)..", "..tostring(RPG.spRegen).." восстановления маны в 3 хода",
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
 end
 
 }
return RPG1