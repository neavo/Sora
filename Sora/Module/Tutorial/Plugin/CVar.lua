﻿-- Engine
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

    -- 启用 - 自动任务监视
    SetCVar("autoQuestWatch", 1)

    -- 启用 - 自动置顶当前区域任务
    SetCVar("autoQuestProgress", 1)

    -- 控制 - 启用自动取消飞行
    SetCVar("autoDismountFlying", 1)

    -- 控制 - 启用 - 自动拾取
    SetCVar("autoLootDefault", 1)

    -- 控制 - 启用合并背包
    SetCVar("combinedBags", 1)

    -- 控制 - 设置镜头跟随模式为移动时只调整水平角度
    SetCVar("cameraSmoothStyle", 1)

    -- 界面 - 设置NPC姓名为敌对及任务NPC
    SetCVar("UnitNameHostleNPC", 0)
    SetCVar("ShowQuestUnitCircles", 0)

    -- 界面 - 关闭教程
    SetCVar("showTutorials", 0)

    -- 动作条 - 启用2-7号动作条
    C_Timer.After(
        1 / 30,
        function(args)
            SetActionBarToggles(1, 1, 1, 1, 1, 1)
        end
    )

    -- 动作条 - 关闭显示冷却时间
    SetCVar("countdownForCooldowns", 0)

    -- 战斗 - 关闭显示个人资源
    SetCVar("nameplateShowSelf", 0)

    -- 战斗 - 启用自动自我施法
    SetCVar("autoSelfCast", 1)

    -- 战斗 - 启用生命值过低时不闪烁屏幕
    SetCVar("doNotFlashLowHealthWarning", 1)

    -- 音频 - 设置伴音通道
    SetCVar("Sound_NumChannels", 128)

    -- 音频 - 启用音乐循环
    SetCVar("Sound_ZoneMusicNoDelay", 1)

    -- 音频 - 启用背景音乐
    SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)

    -- 音频 - 启用混响
    SetCVar("sound_EnableReverb", 1)

    -- 音频 - 启用距离过滤
    SetCVar("Sound_EnablePositionalLowPassFilter", 1)

    -- 网络 - 启动当IPv6可用时开启
    SetCVar("useIPv6", 1)

    -- 网络 - 启用高级战斗日志
    SetCVar("advancedCombatLogging", 1)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
-- EventHandler.Event.CVAR_UPDATE = function(self, event, ...) print(...) end
EventHandler:Register()