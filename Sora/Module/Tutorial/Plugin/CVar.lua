-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    if C.Tutorial.Initialized then
        return 0
    end

    -- 启用反和谐
    SetCVar("overrideArchive", 0)

    -- 启用装备对比
    SetCVar("alwaysCompareItems", 1)

    -- 伤害字体大小
    SetCVar("WorldTextScale", 1.5)

    -- 启用跨甲显示外观收藏状态
    SetCVar("missingTransmogSourceInItemTooltips", 1)

    -- 启用所有动作条
    SetActionBarToggles(1, 1, 1, 1)

    -- 启用自动拾取
    SetCVar("autoLootDefault", 1)

    -- 启用自动任务监视
    SetCVar("autoQuestWatch", 1)

    -- 启用自动自我施法
    SetCVar("autoSelfCast", 1)

    -- 关闭游戏向导
    SetCVar("showTutorials", 0)

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
