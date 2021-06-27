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
       local wnd = RPD.new(RPD.Objects.Ui.WndStory,"Гигантский термитник, ещё одно логово гигантских насекомых. До сюда доходили немногие приключенцы и немногие возвращались живыми, поэтому информации об этом месте немного. В ходе очередного обхода подземелья приключенцами, они заглянули в логово пауков. На последнем этаже они заметили странность, король пауков исчез. А также был обнаружен вход в новую локацию")
       RPD.GameScene:show(wnd)
    end
})