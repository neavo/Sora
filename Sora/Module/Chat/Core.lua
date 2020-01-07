-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraChat")
    anchor:Hide()
    anchor:SetText("聊天框体")
    anchor:SetSize(C.Chat.Width, C.Chat.Height)
    anchor:SetPoint(unpack(SoraDB.Chat.Postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.Chat.Mover and C.Config.Chat.Mover.SoraChat then
        anchor:SetScript("OnDragStop", C.Config.Chat.Mover.SoraChat.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.Chat.Mover.SoraChat.OnDragStart)

        C.Config.Chat.Mover.SoraChat.anchor = anchor
    end
end

local function SetOption()
    S.KillFrame(ChatFrameMenuButton)
    S.KillFrame(QuickJoinToastButton)

    BNToastFrame:SetClampedToScreen(true)
    BNToastFrame:SetClampRectInsets(-15, 15, 15, -15)

    CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18}

    ChatTypeInfo["SAY"].sticky = 1 -- 说
    ChatTypeInfo["PARTY"].sticky = 1 -- 小队
    ChatTypeInfo["GUILD"].sticky = 1 -- 公会
    ChatTypeInfo["WHISPER"].sticky = 0 -- 密语
    ChatTypeInfo["BN_WHISPER"].sticky = 0 -- 实名密语
    ChatTypeInfo["RAID"].sticky = 1 -- 团队
    ChatTypeInfo["OFFICER"].sticky = 1 -- 官员
    ChatTypeInfo["CHANNEL"].sticky = 0 -- 频道

    ChatFrame1:ClearAllPoints()
    ChatFrame1:SetAllPoints(SoraChat)
    ChatFrame1:SetUserPlaced(true)
end

local function SetChatFrame()
    for i = 1, NUM_CHAT_WINDOWS do
        local ChatFrame = _G["ChatFrame" .. i]

        FCF_SetWindowAlpha(ChatFrame, 0)
        ChatFrame:SetSpacing(2)
        ChatFrame:SetFading(false)
        ChatFrame:SetMinResize(128, 64)
        ChatFrame:SetMaxResize(1920, 960)
        ChatFrame:SetClampedToScreen(false)
        ChatFrame:SetClampRectInsets(0, 0, 0, 0)

        local _, size = ChatFrame:GetFont()
        ChatFrame:SetFont(STANDARD_TEXT_FONT, (size >= 10 and size <= 18) and size or 12, "OUTLINE")

        for j = 1, #CHAT_FRAME_TEXTURES do
            S.KillFrame(_G["ChatFrame" .. i .. CHAT_FRAME_TEXTURES[j]])
        end

        S.KillFrame(_G["ChatFrame" .. i .. "ButtonFrame"])

        S.KillFrame(_G["ChatFrame" .. i .. "TabLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabRight"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabMiddle"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabSelectedLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabSelectedRight"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabSelectedMiddle"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabHighlightLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabHighlightRight"])
        S.KillFrame(_G["ChatFrame" .. i .. "TabHighlightMiddle"])

        _G["ChatFrame" .. i .. "TabText"].SetTextColor = function()
        end
        _G["ChatFrame" .. i .. "TabText"]:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        _G["ChatFrame" .. i .. "TabText"]:SetShadowOffset(1, -1)
        _G["ChatFrame" .. i .. "TabText"]:SetShadowColor(0, 0, 0, 0.5)

        local EditBox = _G["ChatFrame" .. i .. "EditBox"]
        local EditBoxHeader = _G["ChatFrame" .. i .. "EditBoxHeader"]
        local EditBoxLanguage = _G["ChatFrame" .. i .. "EditBoxLanguage"]

        local _, size = ChatFrame:GetFont()

        EditBox:SetFont(STANDARD_TEXT_FONT, (size >= 10 and size <= 18) and size or 12, "OUTLINE")
        EditBox:SetShadowOffset(1, -1)
        EditBox:SetShadowColor(0, 0, 0, 0.5)

        EditBoxHeader:SetFont(STANDARD_TEXT_FONT, (size >= 10 and size <= 18) and size or 12, "OUTLINE")
        EditBoxHeader:SetShadowOffset(1, -1)
        EditBoxHeader:SetShadowColor(0, 0, 0, 0.5)

        EditBox:ClearAllPoints()
        EditBox:EnableMouse(false)
        EditBox:SetAltArrowKeyMode(false)
        EditBox:SetPoint("TOPLEFT", ChatFrame, "BOTTOMLEFT", -8, -6)
        EditBox:SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", 8, -22)

        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxMid"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxRight"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusMid"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusRight"])
    end
end

local function OnPlayerLogin(self, event, unit, ...)
    CreateAnchor()

    SetOption()
    SetChatFrame()
end

-- Handler
local Handler = S.CreateEventHandler()
Handler.Event.PLAYER_LOGIN = OnPlayerLogin
Handler:Register()
