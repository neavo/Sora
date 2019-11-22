-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local fontScale = C.Core.FontScale

-- Begin
local function SetFont(font, size, outline)
    font:SetFont(STANDARD_TEXT_FONT, size * fontScale * 0.9, outline)
    font:SetShadowColor(0, 0, 0, 0)
end

-- Event
local function OnPlayerLogin(self, event, ...)
	SetFont(RaidWarningFrame.slot1, 20, "OUTLINE")
	SetFont(RaidWarningFrame.slot2, 20, "OUTLINE")
	SetFont(RaidBossEmoteFrame.slot1, 20, "OUTLINE")
	SetFont(RaidBossEmoteFrame.slot2, 20, "OUTLINE")
	SetFont(AchievementFont_Small, 12, "OUTLINE")
	SetFont(CoreAbilityFont, 32, "OUTLINE")
	SetFont(DestinyFontMed, 14, "OUTLINE")
	SetFont(DestinyFontHuge, 32, "OUTLINE")
	SetFont(DestinyFontLarge, 18, "OUTLINE")
	SetFont(FriendsFont_Normal, 15, "OUTLINE")
	SetFont(FriendsFont_Small, 13, "OUTLINE")
	SetFont(FriendsFont_Large, 17, "OUTLINE")
	SetFont(FriendsFont_UserText, 11, "OUTLINE")
	SetFont(GameFont_Gigantic, 38, "OUTLINE")
	SetFont(GameTooltipHeader, 16, "OUTLINE")
	SetFont(InvoiceFont_Small, 10, "OUTLINE")
	SetFont(InvoiceFont_Med, 12, "OUTLINE")
	SetFont(MailFont_Large, 15, "OUTLINE")
	SetFont(NumberFont_Small, 11, "OUTLINE")
	SetFont(NumberFont_GameNormal, 12, "OUTLINE")
	SetFont(NumberFont_Normal_Med, 12, "OUTLINE")
	SetFont(NumberFont_Shadow_Tiny, 10, "OUTLINE")
	SetFont(NumberFont_OutlineThick_Mono_Small, 13, "OUTLINE")
	SetFont(NumberFont_Outline_Med, 13, "OUTLINE")
	SetFont(NumberFont_Outline_Large, 14, "OUTLINE")
	SetFont(NumberFont_Shadow_Med, 16, "OUTLINE")
	SetFont(NumberFont_Shadow_Small, 12, "OUTLINE")
	SetFont(QuestFont_Shadow_Small, 13, "OUTLINE")
	SetFont(QuestFont_Large, 15, "OUTLINE")
	SetFont(QuestFont_Shadow_Huge, 17, "OUTLINE")
	SetFont(QuestFont_Huge, 17, "OUTLINE")
	SetFont(QuestFont_Super_Huge, 22, "OUTLINE")
	SetFont(QuestFont_Enormous, 30, "OUTLINE")
	SetFont(ReputationDetailFont, 12, "OUTLINE")
	SetFont(SpellFont_Small, 12, "OUTLINE")
	SetFont(SystemFont_InverseShadow_Small, 10, "OUTLINE")
	SetFont(SystemFont_Large, 13, "OUTLINE")
	SetFont(SystemFont_Huge1, 20, "OUTLINE")
	SetFont(SystemFont_Huge2, 24, "OUTLINE")
	SetFont(SystemFont_Med1, 13, "OUTLINE")
	SetFont(SystemFont_Med2, 14, "OUTLINE")
	SetFont(SystemFont_Med3, 13, "OUTLINE")
	SetFont(SystemFont_OutlineThick_WTF, 32, "OUTLINE")
	SetFont(SystemFont_OutlineThick_Huge2, 22, "OUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4, 26, "OUTLINE")
	SetFont(SystemFont_Outline_Small, 12, "OUTLINE")
	SetFont(SystemFont_Outline, 15, "OUTLINE")
	SetFont(SystemFont_Shadow_Large, 17, "OUTLINE")
	SetFont(SystemFont_Shadow_Large_Outline, 17, "OUTLINE")
	SetFont(SystemFont_Shadow_Large2, 19, "OUTLINE")
	SetFont(SystemFont_Shadow_Med1, 15, "OUTLINE")
	SetFont(SystemFont_Shadow_Med1_Outline, 14, "OUTLINE")
	SetFont(SystemFont_Shadow_Med2, 16, "OUTLINE")
	SetFont(SystemFont_Shadow_Med3, 14, "OUTLINE")
	SetFont(SystemFont_Shadow_Outline_Huge2, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1, 20, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge2, 24, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge3, 25, "OUTLINE")
	SetFont(SystemFont_Small, 12, "OUTLINE")
	SetFont(SystemFont_Small2, 13, "OUTLINE")
	SetFont(SystemFont_Tiny, 9, "OUTLINE")
	SetFont(SystemFont_Tiny2, 8, "OUTLINE")
	SetFont(SystemFont_World, 64, "OUTLINE")
	SetFont(SystemFont_World_ThickOutline, 64, "OUTLINE")
	SetFont(SystemFont_WTF2, 64, "OUTLINE")
	SetFont(Tooltip_Med, 13, "OUTLINE")
	SetFont(Tooltip_Small, 12, "OUTLINE")
	SetFont(HelpFrameKnowledgebaseNavBarHomeButtonText, 15, "OUTLINE")
	SetFont(Game11Font, 11, "OUTLINE")
	SetFont(Game12Font, 12, "OUTLINE")
	SetFont(Game13Font, 13, "OUTLINE")
	SetFont(Game13FontShadow, 13, "OUTLINE")
	SetFont(Game15Font, 15, "OUTLINE")
	SetFont(Game16Font, 16, "OUTLINE")
	SetFont(Game18Font, 18, "OUTLINE")
	SetFont(Game20Font, 20, "OUTLINE")
	SetFont(Game24Font, 24, "OUTLINE")
	SetFont(Game27Font, 27, "OUTLINE")
	SetFont(Game30Font, 30, "OUTLINE")
	SetFont(Game32Font, 32, "OUTLINE")
	SetFont(Game36Font, 36, "OUTLINE")
	SetFont(Game42Font, 42, "OUTLINE")
	SetFont(Game46Font, 46, "OUTLINE")
	SetFont(Game48Font, 48, "OUTLINE")
	SetFont(Game48FontShadow, 48, "OUTLINE")
	SetFont(Game60Font, 60, "OUTLINE")
	SetFont(Game72Font, 72, "OUTLINE")
	SetFont(Game120Font, 120, "OUTLINE")
	SetFont(System_IME, 16, "OUTLINE")
	SetFont(Fancy12Font, 12, "OUTLINE")
	SetFont(Fancy14Font, 14, "OUTLINE")
	SetFont(Fancy16Font, 16, "OUTLINE")
	SetFont(Fancy18Font, 18, "OUTLINE")
	SetFont(Fancy20Font, 20, "OUTLINE")
	SetFont(Fancy22Font, 22, "OUTLINE")
	SetFont(Fancy24Font, 24, "OUTLINE")
	SetFont(Fancy27Font, 27, "OUTLINE")
	SetFont(Fancy30Font, 30, "OUTLINE")
	SetFont(Fancy32Font, 32, "OUTLINE")
	SetFont(Fancy48Font, 48, "OUTLINE")
	SetFont(SplashHeaderFont, 24, "OUTLINE")
	SetFont(ChatBubbleFont, 13, "OUTLINE")
	SetFont(GameFontNormalHuge2, 24, "OUTLINE")

    SetFont(SystemFont_Shadow_Small, 12, "OUTLINE")
    SetFont(SystemFont_Shadow_Small2, 12, "OUTLINE")

    SetFont(SystemFont_NamePlate, 10, "OUTLINE")
    SetFont(SystemFont_LargeNamePlate, 10, "OUTLINE")
    SetFont(SystemFont_NamePlateFixed, 10, "OUTLINE")
    SetFont(SystemFont_LargeNamePlateFixed, 10, "OUTLINE")

	-- Refont RaidFrame Health
	hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(frame)
		if frame:IsForbidden() then return end

		local options = DefaultCompactUnitFrameSetupOptions
		frame.statusText:ClearAllPoints()
		frame.statusText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 3, options.height/3 - 5)
		frame.statusText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, options.height/3 - 5)

		if not frame.fontStyled then
			local fontName, fontSize = frame.statusText:GetFont()
			frame.statusText:SetFont(fontName, fontSize, "OUTLINE")
			frame.statusText:SetTextColor(.7, .7, .7)
			frame.statusText:SetShadowColor(0, 0, 0, 0)
			frame.fontStyled = true
		end
	end)

	-- Refont Titles Panel
	hooksecurefunc("PaperDollTitlesPane_UpdateScrollFrame", function()
		local bu = PaperDollTitlesPane.buttons
		for i = 1, #bu do
			if not bu[i].fontStyled then
				ReskinFont(bu[i].text, 14)
				bu[i].fontStyled = true
			end
		end
	end)

	-- WhoFrame LevelText
	hooksecurefunc("WhoList_Update", function()
		for i = 1, WHOS_TO_DISPLAY, 1 do
			local level = _G["WhoFrameButton"..i.."Level"]
			if level and not level.fontStyled then
				level:SetWidth(32)
				level:SetJustifyH("LEFT")
				level.fontStyled = true
			end
		end
	end)

	-- Text color
	CoreAbilityFont:SetTextColor(1, 1, 1)
	GameFontBlackMedium:SetTextColor(1, 1, 1)
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent",function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		OnPlayerLogin(self, event, ...)
	end
end)
