---
--- Created by Mongol
--- VK: mongolinsult
---

local RPD  = require "scripts/lib/commonClasses"

local buff = require "scripts/lib/buff"

return buff.init{
    desc  = function ()
        return {
            icon          = 58,
            name          = "Метка ки",
            info          = "",
        }
    end,
    
    defenceProc = function(self, buff, enemy, damage)
      buff:detach()
      return damage
    end
}