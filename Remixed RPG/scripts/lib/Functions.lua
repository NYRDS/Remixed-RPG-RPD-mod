local RPD = require "scripts/lib/commonClasses"
local Music = luajava.bindClass("com.watabou.noosa.audio.Music")
local Stylus = luajava.bindClass("com.watabou.pixeldungeon.items.Stylus")
local GameScene = luajava.bindClass("com.watabou.pixeldungeon.scenes.GameScene")
local RPG

 RPG = {
 Buffs = {
  Bleeding       = luajava.bindClass("com.watabou.pixeldungeon.actors.buffs.Bleeding"),
  Terror       = luajava.bindClass("com.watabou.pixeldungeon.actors.buffs.Terror"),
  Shadows         = luajava.bindClass("com.watabou.pixeldungeon.actors.buffs.Shadows"),
  Amok            = luajava.bindClass("com.watabou.pixeldungeon.actors.buffs.Amok")
 },

 strength = strength,
 intelligence = intelligence,
 dexterity = dexterity,
 vitality = vitality,
 wisdom = wisdom,
 luck = luck,
 luckA = 0,
 physicStr = physicStr,
 physicStrA = 0,
 physicStrB = 0,
 magicStr = magicStr,
 magicStrA = 0,
 fast = fast,
 fastA = 0,
 spRegen = spRegen,
 spRegenA = 0,
 spellFast = 0,
 sPoints = sPoints,
 lvlToUp = lvlToUp,
 triger = triger,
 class = class,
 subClass = subClass,
 boneId = boneId,
 
 physStr = function()
   return (RPG.physicStr or 1)+(RPG.physicStrB or 0)+(RPG.physicStrA or 0)
 end,
 
 magStr = function()
   return (RPG.magicStr or 1)+(RPG.magicStrA or 0)
 end,
 
 AllFast = function()
   return (RPG.fast or 1)+(RPG.fastA or 0)
 end,
 
 AllSpRegen = function()
   return (RPG.spRegen or 1)+(RPG.spRegenA or 0)
 end,
 
 AllLuck = function()
   return (RPG.luck or 1) + (RPG.luckA  or 0)
 end,
 
 itemStrBonus = function(str)
   local hero = RPD.Dungeon.hero
   return (hero:STR()-str)*0.2
 end,
 
 getItemStats = function(cycles, statMax)
   local statsList = {0, 0, 0, 0, 0, 0, 0, 0}
   local stats = {0, 0, 0, 0, 0, 0, 0, 0}
  local ran
  local itStInfo = ""
  local statsNames = {
  "Физическая сила",
  "Магическая сила",
  "Скорость",
  "Востановление маны",
  "Удача",
  "Здоровье",
  "Мана"}
  for i = 1, cycles do
    ran = math.random(1,7)
    statsList[ran] = statsList[ran] +1 
  end
 
   for i = 1,7 do
     for j = 1,statsList[i] do
       stats[i] = stats[i] + math.random(1,statMax)
     end
     if statsList[i] ~= 0 then
       itStInfo = itStInfo.." "..statsNames[i].." : +"..tostring(stats[i]).."\n"
     end
   end
   return {itStInfo,stats}
 end,
 
 setItemStats = function(stats)
   local itStInfo = ""
   local statsNames = {
  "Физическая сила",
  "Магическая сила",
  "Скорость",
  "Востановление маны",
  "Удача",
  "Здоровье",
  "Мана"}
   for i = 1,7 do
     if stats[i] ~= 0 then
       itStInfo = itStInfo.." "..statsNames[i].." : +"..tostring(stats[i]).."\n"
     end
   end
   return itStInfo
 end,
 
 createItem = function(name, cell, count)
   for i = 1, count do
          local itemC = RPD.ItemFactory:itemByName(name)
          RPD.Dungeon.level:drop(itemC, cell)
        end
 end,
 
 distance = function(pos)
  local y
 local x
 local level=RPD.Dungeon.level
   local hx= level:cellX(RPD.Dungeon.hero:getPos())
   local hy= level:cellY(RPD.Dungeon.hero:getPos())
   local ex= level:cellX(pos)
   local ey= level:cellY(pos)
   if ex>hx then
    x=ex-hx
   else
    x=hx-ex
   end
   if ey>hy then
    y=ey-hy
   else
    y= hy-ey
   end
   return math.max(x,y)-1
 end,
 
 spawnMob = function(mob, pos, thisIsAPet)
local maybeMob = RPD.MobFactory:mobByName(mob)
maybeMob:setPos(pos)
if thisIsAPet then
RPD.Dungeon.level:spawnMob(RPD.Mob:makePet(maybeMob,RPD.Dungeon.hero));
else
RPD.Dungeon.level:spawnMob(maybeMob)
end
end
 
 }
return RPG