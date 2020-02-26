-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnTicker(self, ...)
    if not InCombatLockdown() then
        local frame = CharacterNeckSlot.RankFrame.Label

        frame:Hide()
        frame.Show = frame.Hide

        self:Cancel()
    end
end

local function OnPlayerLogin(self, event, ...)
    C_Timer.NewTicker(1.00, OnTicker)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
