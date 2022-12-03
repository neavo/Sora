-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function EditModeManagerFrameOnShow(self, event, ...)
    PlaySound(SOUNDKIT.RAID_WARNING, "Master")
    DEFAULT_CHAT_FRAME:AddMessage("|cff70C0F5[Sora's]|r ------------------------------------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cff70C0F5[Sora's]|r -- 为避免插件间发生冲突，系统编辑模式已禁用 --")
    DEFAULT_CHAT_FRAME:AddMessage("|cff70C0F5[Sora's]|r ------------------------------------------")
end

-- Event
local function OnPlayerLogin(self, event, ...)
    -- 关闭 - 垃圾信息过滤
    SetCVar("spamFilter", 0)

    -- 关闭 - 和谐
    SetCVar("overrideArchive", 0)

    -- 关闭 - 语言过滤器
    if GetCVar("portal") == "CN" then
        ConsoleExec("portal TW")
        SetCVar("profanityFilter", 0)
    end

    -- 干掉原生经验条与声望条
    S.KillFrame(StatusTrackingBarManager)
    S.KillFrame(MicroButtonAndBagsBar)

    -- 禁用系统编辑模式以防止污染
    EditModeManagerFrame:SetScript("OnShow", EditModeManagerFrameOnShow)
    EditModeManagerFrame:SetScript("OnHide", S.Dummy)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
