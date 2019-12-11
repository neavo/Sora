-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local OnPlayerLogin = function(self, event, ...)
    if UnitAffectingCombat("player") then
        return 0
    end

    UIParent:SetScale(0.72 * C.Core.UIScale)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
