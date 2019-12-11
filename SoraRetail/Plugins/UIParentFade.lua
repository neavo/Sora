-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local OnUpdate = function(self, elasped, ...)
    self.timer = self.timer + elasped

    if self.timer > 1.00 then
        self:SetScript("OnUpdate", nil)

        if UnitAffectingCombat("player") then
            return 0
        end

        UIFrameFadeIn(UIParent, 1.00, 0.00, 1.00)
    end
end

local function OnPlayerEnteringWorld(self, event, ...)
    if UnitAffectingCombat("player") then
        return 0
    end

    UIParent:SetAlpha(0.00)

    self.timer = 0
    self:SetScript("OnUpdate", OnUpdate)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
