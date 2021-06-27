--
--Created by Mongol
-- VK: mongolinsult
-- 

local RPD = require "scripts/lib/commonClasses"

local RPG = require "scripts/lib/Functions"

local RPG1 = require "scripts/lib/AdditionalFunctions"

local storage = require "scripts/lib/storage"

local item = require "scripts/lib/item"
local statsMax = 6
local quanStats = 2
local stra = 12
local tier = 2
local maxDmg = 14
local minDmg = 6
local hero
local str
local stats
local statsInfo = " "

return item.init{
    desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      statsInfo = a[1]
      stats = a[2]
        return {
            imageFile     = "items.png",
            image         = 29,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats
            },
            name          = "Копьё: "..tostring(math.max(stra-item:level(),1)),
            price         = 20*2^(tier-1)+20*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end,
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = stra-item:level()
      local info = "Тонкое древко с острым маленьким наконечником.\n\nКопьё - оружие ближнего боя "..tier.." порядка. Средний урон составляет "..((maxDmg+minDmg+tier*item:level()*2)/2).." единиц за удар и, как правило, требует "..stra.." очков силы. Это довольно меткое оружие.\n\n"..self.data.sInfo
      if hero:STR() >= str then
        return info
      else
        return info.."\n Это оружие слишком тяжёлое для вас. При ношении ваша скорость и меткость будут снижены."
      end
    end,
    
    getAttackAnimationClass = function()
    return "STAFF"
    end,
    
    blockSlot = function()
      return "LEFT_HAND"
    end,
    
    getVisualName = function()
      return "Spear"
    end,
    
    damageRoll = function(self, item, user)
        return maxDmg+tier*item:level(),minDmg+tier*item:level()
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
    
    goodForMelee = function()
      return true
    end,
    
    range = function()
      return 2
    end,
    
    onSelect = function(cell,selector)
    end,
    
    accuracyFactor = function(self,item,user)
     str = stra-item:level()
     return 1 + RPG.itemStrBonus(str)
    end,
    
    attackDelayFactor = function(self,item,user)
     str = stra-item:level()
     return 0.5 + RPG.itemStrBonus(str)
    end,
    
    typicalSTR = function(self,item,user)
     return stra
    end,
    
    requiredSTR = function(self,item,user)
     str = stra-item:level()
     return str
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