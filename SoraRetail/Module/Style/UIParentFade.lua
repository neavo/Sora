-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnTicker(ticker)
    if InCombatLockdown("player") then
        UIParent:SetAlpha(1.00)
    else
        UIFrameFadeIn(UIParent, 1.00, 0.00, 1.00)
    end
end

-- Event
local function OnPlayerEnteringWorld(self, event, ...)
    if InCombatLockdown("player") then
        return 0
    end

    UIParent:SetAlpha(0.00)
    C_Timer.NewTicker(1.00, OnTicker, 1)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
