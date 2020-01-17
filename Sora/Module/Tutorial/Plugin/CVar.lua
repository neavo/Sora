-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    if C.Tutorial.Initialized then
        return 0
    end

    -- 设置最大视野距离
    SetCVar("cameraDistanceMaxZoomFactor", 2.6)

    -- 设置截图品质与格式
    SetCVar("screenshotQuality", 10) -- 1 to 10
    SetCVar("screenshotFormat", "jpg") -- jpg or tga

    -- 设置伤害字体大小
    SetCVar("WorldTextScale", 1.5)

    -- 还原经典战斗文字效果
    SetCVar("floatingCombatTextFloatMode", 1)
    SetCVar("floatingCombatTextCombatDamage", 1)
    SetCVar("floatingCombatTextCombatHealing", 1)
    SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)

    -- 启用 - 自动装备对比
    SetCVar("alwaysCompareItems", 1)

    -- 启用 - 自动解除飞行
    SetCVar("autoDismountFlying", 1)

    -- 启用 - 所有动作条
    local function OnTicker(self, ...)
        SetActionBarToggles(1, 1, 1, 1)
    end
    C_Timer.NewTicker(0.50, OnTicker, 1)

    -- 启用 - 总是显示所有动作条
    SetCVar("alwaysShowActionBars", 1)

    -- 启用 - 自动拾取
    SetCVar("autoLootDefault", 1)

    -- 启用 - 自动任务监视
    SetCVar("autoQuestWatch", 1)

    -- 启用 - 自动置顶当前区域任务
    SetCVar("autoQuestProgress", 1)

    -- 启用 - 生命值过低时不闪烁屏幕
    SetCVar("doNotFlashLowHealthWarning", 1)

    -- 启用 - 自动自我施法
    SetCVar("autoSelfCast", 1)

    -- 关闭 - 垃圾信息过滤
    SetCVar("SPAM_FILTER", 0)

    -- 关闭 - 游戏向导
    SetCVar("showTutorials", 0)

    -- 关闭 - 显示个人资源
    SetCVar("nameplateShowSelf", 0)

    -- 关闭 - 和谐
    SetCVar("overrideArchive", 0)

    -- 关闭 - 语言过滤器
    SetCVar("profanityFilter", 0)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
-- EventHandler.Event.CVAR_UPDATE = function(self, event, ...)
--     print(...)
-- end
EventHandler:Register()
