--
-- User: mike
-- Date: 29.01.2019
-- Time: 20:33
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/commonClasses"
local hero=RPD.Dungeon.hero
local BulNow=BulNow
local item = require "scripts/lib/item"
return item.init{
    desc  = function (self, item)
        return {
            image         = 4,
            imageFile     = "items/materials.png",
            name          = "ПМ",
            info          = "Наградной ПМ",
            price         = 20,
            upgradable = true,
            equipable     = "left_hand"
        }
    end,
  
activate = function(self, item, hero)
    end,
    
deactivate = function(self, item, hero)
 end,
 
actions = function(self, item, hero)
if item:isEquipped(RPD.Dungeon.hero) then
return {"ВЫСТРЕЛИТЬ","ПЕРЕЗАРЯДИТЬСЯ("..tostring(BulNow).."/8)"}
else
return {"ПЕРЕЗАРЯДИТЬСЯ("..tostring(BulNow).."/8)"}
end
end,

execute = function(self, item, hero, action)
if BulNow == nil then
BulNow=0
end
        if action == "ВЫСТРЕЛИТЬ" then
        if BulNow>0 then
            item:selectCell( "ВЫСТРЕЛИТЬ" , "Выберете клетку")
            else
            RPD.glog("-- Магазин пуст")
end
end
if action == "ПЕРЕЗАРЯДИТЬСЯ("..BulNow.."/8)" then
        if item:getUser():getBelongings():getItem("bolt") ~= nil then
        if BilNow ~= 8 then
if 8-BulNow < item:getUser():getBelongings():getItem("bolt"):getQuantity() then
        for i = 0, 8-BulNow do
item:getUser():getBelongings()
:getItem("bolt"):detach(item:getUser():getBelongings()
.backpack)
end
else
        for i = 0, tonumber(item:getUser():getBelongings():getItem("bolt")) do
item:getUser():getBelongings()
:getItem("bolt"):detach(item:getUser():getBelongings()
.backpack)
end
end
BulNow=8
else
RPD.glog("** Магазин полон")
end
else
RPD.glog("-- Боеприпасов нет")
end
        end
end,

cellSelected = function(self, thisItem, action, cell)
        if action == "ВЫСТРЕЛИТЬ" then 
local enemy = RPD.Actor:findChar(cell)
  if enemy then
RPD.glog("** Сияние рассвета разряжено")
RPD.topEffect(cell,"harith_spell")
  enemy:damage(20*(item:level()+1), item:getUser())
        BulNow=BulNow-1
else
RPD.topEffect(cell,"harith_spell")
RPD.glog("** Сияние рассвета разряжено")
BulNow=BulNow-1
end
        end
        end
}
