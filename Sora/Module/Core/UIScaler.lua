-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    if InCombatLockdown() then
        return 0
    end

    if tonumber(GetCVar("uiScale")) ~= 1 then
        SetCVar("uiScale", 1)
    end

    if tonumber(GetCVar("useUiScale")) ~= 0 then
        SetCVar("useUiScale", 0)
    end

    if tonumber(GetCVar("uiScaleMultiplier")) ~= -1 then
        SetCVar("uiScaleMultiplier", -1)
    end

    UIParent:SetScale(768 / 1080 * SoraDB.Core.UIScale)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
