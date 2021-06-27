--
-- Created by Mongol
-- VK: mongolinsult
-- 

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 12
local quanStats = 5
local stra = 22
local tier = 7
local maxDmg = 40
local minDmg = 32
local str 
local stats
local hero 
local statsInfo

return item.init{
    desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
      
        return {
            imageFile     = "rpgitems.png",
            image         = 4,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = "Рюй Джингу(Копия): "..tostring(math.max(stra-item:level(),1)),
            price         = 20*2^(tier-1)+100*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end,
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = stra-item:level()
      local info = "На вид чуть больше боевого посоха, но не ожидаемо тяжелый. А также металл, из которого он был изготовлен, вам не знаком.\n\nРюй Джингу(Копия) - оружие ближнего боя "..tier.." порядка. Средний урон составляет "..((maxDmg+minDmg+tier*item:level()*2)/2).." единиц за удар и, как правило, требует "..stra.." очков силы. Это довольно быстрое и меткое оружие.\n\n"..self.data.sInfo
      if hero:STR() >= str then
        return info
      else
        return info.."\n Это оружие слишком тяжёлое для вас. При ношении ваша скорость и меткость будут снижены."
      end
    end,
    
    getAttackAnimationClass = function(self,item)
      return "STAFF"
    end,
    
    blockSlot = function()
      return "LEFT_HAND"
    end,
    
    activate = function(self)
      hero = RPD.Dungeon.hero
      if self.data.activationCount == 0 or RPG.luck == nil then
        for i = 1,5 do
          RPG1.addStats(self.data.dstats[i], i)
        end
      end
      if self.data.activationCount == 0 then
        hero:ht(hero:ht() + self.data.dstats[6])
        hero:setMaxSkillPoints(hero:getSkillPointsMax() + self.data.dstats[7])
      end
      self.data.activationCount = 1
    end,
    
    deactivate = function(self)
      hero = RPD.Dungeon.hero
        self.data.activationCount = 0
        for i = 1,5 do
          RPG1.delStats(self.data.dstats[i], i)
        end
        hero:ht(hero:ht() - self.data.dstats[6])
        if hero:hp() > hero:ht() then
          hero:hp(hero:ht())
        end
        hero:setMaxSkillPoints(hero:getSkillPointsMax() - self.data.dstats[7])
        if hero:getSkillPoints() > hero:getSkillPointsMax() then
          hero:setSkillPoints(hero:getSkillPointsMax())
        end
    end,
    
    damageRoll = function (self, item, user)
        return maxDmg+tier*item:level(),minDmg+tier*item:level()
    end,
    
    accuracyFactor = function(self,item,user)
     str = stra-item:level()
     return 2 + RPG.itemStrBonus(str)
    end,
    
    attackDelayFactor = function(self,item,user)
     str = stra-item:level()
     return 2 + RPG.itemStrBonus(str)
    end,
    
    typicalSTR = function(self,item,user)
     return stra
    end,
    
    requiredSTR = function(self,item,user)
     str = stra-item:level()
     return str
    end,
    
    goodForMelee = function()
      return true
    end,
    
    range = function()
      return 2
    end,
    
    onSelect = function(cell,selector)
    end,
    
    attackProc = function(self,item,hero,enemy,dmg)
      local hero = RPD.Dungeon.hero
      return dmg
    end,
    
    actions = function(self, item, hero)
     return {}
    end,

    execute = function(self, item, hero, action)
    end,
    
    isIdentified = function(self)
      return false
    end

}
