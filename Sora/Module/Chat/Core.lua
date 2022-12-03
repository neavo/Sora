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

	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.50
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0.50
	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1.00
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 1.00
	CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1.00
	CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1.00

	ChatTypeInfo["SAY"].sticky = 1 -- 说
	ChatTypeInfo["PARTY"].sticky = 1 -- 小队
	ChatTypeInfo["GUILD"].sticky = 1 -- 公会
	ChatTypeInfo["WHISPER"].sticky = 0 -- 密语
	ChatTypeInfo["BN_WHISPER"].sticky = 0 -- 实名密语
	ChatTypeInfo["RAID"].sticky = 1 -- 团队
	ChatTypeInfo["OFFICER"].sticky = 1 -- 官员
	ChatTypeInfo["CHANNEL"].sticky = 0 -- 频道
end

local function SetChatTab()
	if not ChatFrameTabBG then
		local ChatFrameTabBG = S.CreateButton(GeneralDockManager, 12, "ChatFrameTabBG")
		ChatFrameTabBG:SetAllPoints()
		ChatFrameTabBG:SetScript("OnEnter", S.Dummy)
		ChatFrameTabBG:SetScript("OnLeave", S.Dummy)
		ChatFrameTabBG:SetScript("OnClick", S.Dummy)
		ChatFrameTabBG:SetFrameStrata("BACKGROUND")
	end

	GeneralDockManager:ClearAllPoints()
	GeneralDockManager:SetWidth(SoraChat:GetWidth())
	GeneralDockManager:SetPoint("TOP", SoraChat, "TOP", 0, 0)

	local function OnShow(self, ...)
		for i = 1, NUM_CHAT_WINDOWS do
			local ChatFrameTab = _G["ChatFrame" .. i .. "Tab"]

			if i >= 4 then
				ChatFrameTab.Text:SetPoint("CENTER", 0, -3)
			end
		end
	end

	local function OnHide(self, ...)
		for i = 1, NUM_CHAT_WINDOWS do
			local ChatFrameTab = _G["ChatFrame" .. i .. "Tab"]

			if i >= 4 then
				ChatFrameTab.Text:SetPoint("CENTER", 0, -6)
			end
		end
	end

	if GeneralDockManagerOverflowButton:IsShown() then
		OnShow()
	else
		OnHide()
	end

	GeneralDockManagerOverflowButton:SetHeight(GeneralDockManager:GetHeight() + 3)
	GeneralDockManagerOverflowButton:ClearAllPoints()
	GeneralDockManagerOverflowButton:SetPoint("RIGHT", GeneralDockManager, "RIGHT", 1, -1)
	GeneralDockManagerOverflowButton:SetScript("OnShow", OnShow)
	GeneralDockManagerOverflowButton:SetScript("OnHide", OnHide)
end

local function SetChatFrame()
	if not ChatFrameBG then
		local ChatFrameBG = S.CreateButton(UIParent, 16, "ChatFrameBG")
		ChatFrameBG:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", -4, 4)
		ChatFrameBG:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 4, -4)
		ChatFrameBG:SetScript("OnEnter", nil)
		ChatFrameBG:SetScript("OnLeave", nil)
		ChatFrameBG:SetFrameStrata("BACKGROUND")
	end

	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("TOPLEFT", SoraChat, "TOPLEFT", 4, -(26 + 4 + 4))
	ChatFrame1:SetPoint("BOTTOMRIGHT", SoraChat, "BOTTOMRIGHT", -4, 16 + 4 + 4)

	for i = 1, NUM_CHAT_WINDOWS do
		local ChatFrame = _G["ChatFrame" .. i]
		local _, fontSize = ChatFrame:GetFont()

		ChatFrame:SetSpacing(2)
		ChatFrame:SetResizeBounds(128, 64, 920, 960)
		ChatFrame:SetClampedToScreen(false)
		ChatFrame:SetClampRectInsets(0, 0, 0, 0)
		ChatFrame:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")

		for j = 1, #CHAT_FRAME_TEXTURES do
			S.KillFrame(_G["ChatFrame" .. i .. CHAT_FRAME_TEXTURES[j]])
		end

		local ScrollBar = ChatFrame.ScrollBar
		ScrollBar:ClearAllPoints()
		ScrollBar:SetSize(16, ChatFrame:GetHeight() - 8)
		ScrollBar:SetPoint("TOPRIGHT", ChatFrame, "TOPRIGHT", 4, 4)

		local ChatFrameThumbTexture = _G["ChatFrame" .. i .. "ThumbTexture"]
		ChatFrameThumbTexture:SetSize(15, 15)

		local ScrollToBottomButton = ChatFrame.ScrollToBottomButton
		ScrollToBottomButton:ClearAllPoints()
		ScrollToBottomButton:SetSize(16, 16)
		ScrollToBottomButton:SetPoint("TOP", ScrollBar, "BOTTOM", 0, 0)
		ScrollToBottomButton.Flash:Hide()
		ScrollToBottomButton.Flash:ClearAllPoints()
	end
end

local function SetChatFrameEditBox()
	if not EditBoxBG then
		local EditBoxBG = S.CreateButton(UIParent, 12, "EditBoxBG")
		EditBoxBG:SetSize(SoraChat:GetWidth(), 16)
		EditBoxBG:SetPoint("BOTTOM", SoraChat, "BOTTOM", 0, 0)
		EditBoxBG:SetScript("OnClick", nil)
		EditBoxBG:SetScript("OnEnter", nil)
		EditBoxBG:SetScript("OnLeave", nil)
		EditBoxBG:SetFrameStrata("BACKGROUND")
	end

	for i = 1, NUM_CHAT_WINDOWS do
		local ChatFrame = _G["ChatFrame" .. i]
		local _, fontSize = ChatFrame:GetFont()

		local EditBox = _G["ChatFrame" .. i .. "EditBox"]
		EditBox:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
		EditBox:SetShadowColor(0.00, 0.00, 0.00, 1.00)
		EditBox:SetShadowOffset(1.00, -1.00)
		EditBox:ClearAllPoints()
		EditBox:EnableMouse(false)
		EditBox:SetAltArrowKeyMode(false)
		EditBox:SetPoint("TOPLEFT", EditBoxBG, "TOPLEFT", -10, 0)
		EditBox:SetPoint("BOTTOMRIGHT", EditBoxBG, "BOTTOMRIGHT", 0, 0)

		local EditBoxHeader = _G["ChatFrame" .. i .. "EditBoxHeader"]
		EditBoxHeader:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
		EditBoxHeader:SetShadowColor(0.00, 0.00, 0.00, 1.00)
		EditBoxHeader:SetShadowOffset(1.00, -1.00)

		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxMid"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxLeft"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxRight"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxLanguage"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusMid"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusLeft"])
		S.KillFrame(_G["ChatFrame" .. i .. "EditBoxFocusRight"])
	end
end

local function SetCombatLogQuickButtonFrame()
	for i = 1, 2 do
		local btn = _G["CombatLogQuickButtonFrameButton" .. i]
		local regions = S.GetRegions(btn, "FontString")

		for k, v in pairs(regions) do
			v:SetFont(ChatFrame2:GetFont())
			v:SetShadowColor(0.00, 0.00, 0.00, 1.00)
			v:SetShadowOffset(1.00, -1.00)
		end
	end

	CombatLogQuickButtonFrame_Custom:ClearAllPoints()
	CombatLogQuickButtonFrame_Custom:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", -4, 4)
	CombatLogQuickButtonFrame_Custom:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 4, -(CombatLogQuickButtonFrameButton1:GetHeight() + 4))
end

-- Event
local function OnPlayerLogin(self, event, ...)
	CreateAnchor()

	SetOption()
	SetChatTab()
	SetChatFrame()
	SetChatFrameEditBox()
	SetCombatLogQuickButtonFrame()
end

local function OnActiveCombatConfigChanged(self, event, ...)
	SetOption()
	SetChatTab()
	SetChatFrame()
	SetChatFrameEditBox()
	SetCombatLogQuickButtonFrame()
end

-- Handler
local Handler = S.CreateEventHandler()
Handler.Event.PLAYER_LOGIN = OnPlayerLogin
Handler.Event.ACTIVE_COMBAT_CONFIG_CHANGED = OnActiveCombatConfigChanged
Handler:Register()
