-- Engines
local S, C, L, DB = unpack(select(2, ...))

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
        local _, fontSize = ChatFrame:GetFont()

        FCF_SetWindowAlpha(ChatFrame, 0)
        ChatFrame:SetSpacing(2)
        ChatFrame:SetFading(false)
        ChatFrame:SetMinResize(128, 64)
        ChatFrame:SetMaxResize(1920, 960)
        ChatFrame:SetClampedToScreen(false)
        ChatFrame:SetClampRectInsets(0, 0, 0, 0)
        ChatFrame:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")

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

        local ChatFrameTabText = _G["ChatFrame" .. i .. "TabText"]
        ChatFrameTabText:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
        ChatFrameTabText:SetShadowOffset(1.00, -1.00)
        ChatFrameTabText:SetShadowColor(0.00, 0.00, 0.00, 1.00)

        local x, a, y, xOffset, yOffset = ChatFrameTabText:GetPoint()
        ChatFrameTabText:ClearAllPoints()
        ChatFrameTabText:SetPoint(x, a, y, xOffset, yOffset + 3)

        local ScrollToBottomButton = ChatFrame.ScrollToBottomButton
        ScrollToBottomButton:ClearAllPoints()
        ScrollToBottomButton:SetPoint("BOTTOMLEFT", ChatFrame, "BOTTOMRIGHT", 3, 0)

        local EditBox = _G["ChatFrame" .. i .. "EditBox"]
        EditBox:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
        EditBox:SetShadowColor(0.00, 0.00, 0.00, 1.00)
        EditBox:SetShadowOffset(1.00, -1.00)
        EditBox:ClearAllPoints()
        EditBox:EnableMouse(false)
        EditBox:SetAltArrowKeyMode(false)
        EditBox:SetPoint("TOPLEFT", ChatFrame, "BOTTOMLEFT", -8, -6)
        EditBox:SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", 8, -22)

        local EditBoxHeader = _G["ChatFrame" .. i .. "EditBoxHeader"]
        EditBoxHeader:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
        EditBoxHeader:SetShadowColor(0.00, 0.00, 0.00, 1.00)
        EditBoxHeader:SetShadowOffset(1.00, -1.00)

        local EditBoxBG = CreateFrame("Frame", nil, ChatFrame)
        EditBoxBG:Hide()
        EditBoxBG:SetPoint("TOPLEFT", ChatFrame, "BOTTOMLEFT", 0, -6)
        EditBoxBG:SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", -0.5, -22)

        EditBoxBG.shadow = S.MakeShadow(EditBoxBG, 2)
        EditBoxBG.shadow:SetFrameLevel(EditBoxBG:GetFrameLevel())

        EditBoxBG.bg = EditBoxBG:CreateTexture(nil, "BORDER")
        EditBoxBG.bg:SetAllPoints()
        EditBoxBG.bg:SetTexture(DB.Backdrop)
        EditBoxBG.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

        local EditBoxLanguage = CreateFrame("Frame", nil, ChatFrame)
        EditBoxLanguage:Hide()
        EditBoxLanguage:SetPoint("TOPLEFT", EditBoxBG, "TOPRIGHT", 4, 0)
        EditBoxLanguage:SetPoint("BOTTOMRIGHT", EditBoxBG, "BOTTOMRIGHT", 20, 0)

        EditBoxLanguage.text = S.MakeText(EditBoxLanguage, 11)
        EditBoxLanguage.text:SetPoint("CENTER")

        EditBoxLanguage.shadow = S.MakeShadow(EditBoxLanguage, 2)
        EditBoxLanguage.shadow:SetFrameLevel(EditBoxLanguage:GetFrameLevel())

        EditBoxLanguage.bg = EditBoxLanguage:CreateTexture(nil, "BORDER")
        EditBoxLanguage.bg:SetAllPoints()
        EditBoxLanguage.bg:SetTexture(DB.Backdrop)
        EditBoxLanguage.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

        local function OnTextChanged(self)
            local str = self:GetText()

            for i = 1, #str do
                if string.byte(str, i) > 127 then
                    EditBoxLanguage.text:SetText("中")
                    return 0
                end
            end

            EditBoxLanguage.text:SetText("英")
        end

        local function OnEditFocusLost(self)
            EditBoxBG:Hide()
            EditBoxLanguage:Hide()
        end

        local function OnEditFocusGained(self)
            EditBoxBG:Show()
            EditBoxLanguage:Show()
        end

        EditBox:HookScript("OnTextChanged", OnTextChanged)
        EditBox:HookScript("OnEditFocusLost", OnEditFocusLost)
        EditBox:HookScript("OnEditFocusGained", OnEditFocusGained)

        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxMid"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxRight"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxLanguage"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusMid"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusLeft"])
        S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusRight"])
    end

    for i = 1, 2 do
        local btn = _G["CombatLogQuickButtonFrameButton" .. i]

        local regions = S.GetRegions(btn, "FontString")
        for k, v in pairs(regions) do
            v:SetFont(ChatFrame2:GetFont())
            v:SetShadowColor(0.00, 0.00, 0.00, 1.00)
            v:SetShadowOffset(1.00, -1.00)
        end
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
