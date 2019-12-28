-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    -- 反和谐
    SetCVar("overrideArchive", 0)

    -- 装备对比
    SetCVar("alwaysCompareItems", 1)

    -- 伤害字体大小
    SetCVar("WorldTextScale", 1.5)

    -- 还原经典战斗文字效果
    SetCVar("floatingCombatTextCombatDamage", 1)
    SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:RegisterAllEvents()

SLASH_RELOAD1 = "/rl"
SlashCmdList.RELOAD = function(...)
    ReloadUI()
end
