--
-- User: mike
-- Date: 06.11.2017
-- Time: 23:57
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/commonClasses"
local actor = require "scripts/lib/actor"

return actor.init({
    actionTime = function()
        return math.huge
    end,
    activate = function()
       local wnd = RPD.new(RPD.Objects.Ui.WndStory," Убежище Тёмного Санты, место где поселилась тень Санты. Под воздействием тёмной магии Йога Джевы тень Санты обрела разум. После, она покинула Санту и стала бродить по подземелью. В итоге её странствий она создала свое подземелье. Оно разделялось на три уровня, каждый из которых опасней предыдущего. Ходят слухи, что все три уровня открываются в предверии Нового Года. Отсюда и пошло имя Тёмный Санта")
       RPD.GameScene:show(wnd)
    end
})