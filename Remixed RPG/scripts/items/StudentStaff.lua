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
local stra = 10
local addMag = 15
local magAsLevel = 4
local attackBonus = 0.08
local hero
local str
local stats
local statsInfo = " "

return item.init{
    desc  = function (self, item)
      local a = RPG.getItemStats(quanStats,statsMax)
      stats = a[2]
      stats[2] = stats[2] + addMag
      statsInfo = RPG.setItemStats(stats)
        return {
            imageFile     = "rpgitems.png",
            image         = 18,
            data          = {
            activationCount = 0,
            sInfo = statsInfo,
            dstats = stats,
            level = stra
            },
            name          = "Посох ученика: "..tostring(math.max(stra-item:level(),1)),
            price         = 40+20*item:level(),
            stackable     = false,
            upgradable    = true,
            equipable     ="weapon"
        }
    end,
    info = function(self,item)
      hero = RPD.Dungeon.hero
      str = stra-item:level()
      local info = "Посох, сделанный умелым мастером. Такие выдаются магам-ученикам.\n\nПосох ученика - оружие дальнего боя 2 порядка. Дальность атаки - 3 клетки. Средний урон составляет 5 + 8% от магической силы единиц за удар и, как правило, требует "..stra.." очков силы.\n\n"..self.data.sInfo
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
    
    damageRoll = function(self, item, user)
        return 6+item:level()+math.ceil(RPG.magStr()*attackBonus),4+item:level()+math.ceil(RPG.magStr()*attackBonus)
    end,
    
    activate = function(self,item)
      hero = RPD.Dungeon.hero
      str = stra-item:level()
      for i = 1, self.data.level - str do
        self.data.dstats[2] = self.data.dstats[2] + magAsLevel
      end
      self.data.level = str
      if self.data.activationCount == 0 or RPG.luck == nil then
        for i = 1,5 do
          RPG1.addStats(self.data.dstats[i], i)
        end
      end
      self.data.sInfo = RPG.setItemStats(self.data.dstats)
      if self.data.activationCount == 0 then
        hero:ht(hero:ht() + self.data.dstats[6])
        hero:setMaxSkillPoints(hero:getSkillPointsMax() + self.data.dstats[7])
      end
      self.data.activationCount = 1
    end,
    
    deactivate = function(self,item)
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
      return 3
    end,
    
    onSelect = function(cell,selector)
    end,
    
    accuracyFactor = function(self,item,user)
     str = stra-item:level()
     return 1 + RPG.itemStrBonus(str)
    end,
    
    attackDelayFactor = function(self,item,user)
     str = stra-item:level()
     return 1 + RPG.itemStrBonus(str)
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
    end
}
