-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    if InCombatLockdown() then
        return 0
    end

    -- Calculate current UI scale
    local pixelScale = 768 / 1080
    local cvarScale, parentScale = tonumber(GetCVar("uiscale")), floor(UIParent:GetScale() * 100 + 0.5) / 100

    -- Setting the `uiScale` cvar will taint the ObjectiveTracker, and by extention the
    -- WorldMap and map action button. As such, we only use that if we absolutly have to
    if cvarScale ~= pixelScale then
        SetCVar("uiScale", max(pixelScale, 0.64))
    end

    if parentScale ~= pixelScale then
        UIParent:SetScale(pixelScale)
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
