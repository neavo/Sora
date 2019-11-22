-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function kill(frame)
    if frame.UnregisterAllEvents then
        frame:UnregisterAllEvents()
    end

    frame.Show = function()
    end
    frame:Hide()
end

local function SetOption()
    kill(ChatFrameMenuButton)
    kill(QuickJoinToastButton)

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
    ChatFrame1:SetUserPlaced(true)
    ChatFrame1:SetSize(unpack(C.Chat.ChatFrameSize))
    ChatFrame1:SetPoint(unpack(C.Chat.ChatFramePostion))
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
            kill(_G["ChatFrame" .. i .. CHAT_FRAME_TEXTURES[j]])
        end

        kill(_G["ChatFrame" .. i .. "ButtonFrame"])

        kill(_G["ChatFrame" .. i .. "TabLeft"])
        kill(_G["ChatFrame" .. i .. "TabRight"])
        kill(_G["ChatFrame" .. i .. "TabMiddle"])
        kill(_G["ChatFrame" .. i .. "TabSelectedLeft"])
        kill(_G["ChatFrame" .. i .. "TabSelectedRight"])
        kill(_G["ChatFrame" .. i .. "TabSelectedMiddle"])
        kill(_G["ChatFrame" .. i .. "TabHighlightLeft"])
        kill(_G["ChatFrame" .. i .. "TabHighlightRight"])
        kill(_G["ChatFrame" .. i .. "TabHighlightMiddle"])

        _G["ChatFrame" .. i .. "TabText"].SetTextColor = function()
        end
        _G["ChatFrame" .. i .. "TabText"]:SetFont(STANDARD_TEXT_FONT, 12, "THINOUTLINE")

        local EditBox = _G["ChatFrame" .. i .. "EditBox"]
        local EditBoxHeader = _G["ChatFrame" .. i .. "EditBoxHeader"]

        local _, size = ChatFrame:GetFont()
        EditBox:SetFont(STANDARD_TEXT_FONT, (size >= 10 and size <= 18) and size or 12, "THINOUTLINE")
        EditBoxHeader:SetFont(STANDARD_TEXT_FONT, (size >= 10 and size <= 18) and size or 12, "THINOUTLINE")

        EditBox:ClearAllPoints()
        EditBox:EnableMouse(false)
        EditBox:SetAltArrowKeyMode(false)
        EditBox:SetPoint("TOPLEFT", ChatFrame, "BOTTOMLEFT", -8, -6)
        EditBox:SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", 8, -22)

        kill(_G["ChatFrame" .. i .. "EditBoxMid"])
        kill(_G["ChatFrame" .. i .. "EditBoxLeft"])
        kill(_G["ChatFrame" .. i .. "EditBoxRight"])
        kill(_G["ChatFrame" .. i .. "EditBoxLanguage"])
        kill(_G["ChatFrame" .. i .. "EditBoxFocusMid"])
        kill(_G["ChatFrame" .. i .. "EditBoxFocusLeft"])
        kill(_G["ChatFrame" .. i .. "EditBoxFocusRight"])
    end
end

local function OnPlayerLogin(self, event, unit, ...)
    SetOption()
    SetChatFrame()
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript(
    "OnEvent",
    function(self, event, unit, ...)
        if event == "PLAYER_LOGIN" then
            OnPlayerLogin(self, event, unit, ...)
        end
    end
)
