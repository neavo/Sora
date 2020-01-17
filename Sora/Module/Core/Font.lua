-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function IsTextRegion(k, v)
	return type(v) == "table" and v.GetObjectType and v:GetObjectType() == "Font" and v.GetFont
end

local function ProcessTextRegion(fontString, scale)
	if fontString.__Processed then
		return 0
	end

	local font, size, flag = fontString:GetFont()

	if size <= 0 then
		return 0
	end

	local s = C.Core.FontShadow == nil and true or C.Core.FontShadow
	local o = C.Core.FontOutline == nil and true or C.Core.FontOutline

	fontString:SetShadowOffset(1.00, -1.00)
	fontString:SetShadowColor(0.00, 0.00, 0.00, s and 1.00 or 0.00)
	fontString:SetFont(STANDARD_TEXT_FONT, size * scale, o and "OUTLINE" or nil)

	fontString.__Processed = true
end

-- Special for PaperDollFrame
local function HookPaperDollFrameSetLabelAndText(statFrame, label, text, isPercentage, numericValue)
	if isPercentage or string.match(text, "%%") then
		statFrame.Value:SetText(format("%.2f%%", numericValue))
	end
end
do
	hooksecurefunc("PaperDollFrame_SetLabelAndText", HookPaperDollFrameSetLabelAndText)
end

-- Special for Blizzard_WarboardUI、Blizzard_QuestChoice
local function SetTextColor(r, g, b, a)
	-- do nothing
end
local function HookQuestChoiceFrameUpdate()
	local regions = S.GetRegions(QuestChoiceFrame, "FontString")

	for k, v in pairs(regions) do
		ProcessTextRegion(v, 1.00)

		v:SetText((v:GetText() or ""):gsub("\r+", ""):gsub("\n+", ""))
		v:SetSpacing(2)
		v:SetTextColor(0.90, 0.90, 0.90, 1.00)
		v.SetTextColor = SetTextColor
	end
end
local function HookWarboardQuestChoiceFrameUpdate()
	local regions = S.GetRegions(WarboardQuestChoiceFrame, "FontString")

	for k, v in pairs(regions) do
		ProcessTextRegion(v, 1.00)

		v:SetText((v:GetText() or ""):gsub("\r+", ""):gsub("\n+", ""))
		v:SetSpacing(2)
		v:SetTextColor(0.90, 0.90, 0.90, 1.00)
		v.SetTextColor = SetTextColor
	end
end
local function OnBlizzardWarboardUILoad(self, event, name, ...)
	hooksecurefunc(WarboardQuestChoiceFrame, "Update", HookWarboardQuestChoiceFrameUpdate)
end
local function OnBlizzardQuestChoiceLoad(self, event, name, ...)
	hooksecurefunc(QuestChoiceFrame, "Update", HookQuestChoiceFrameUpdate)
end

-- Event
local function OnAddonLoaded(self, event, name, ...)
	if name == "Blizzard_WarboardUI" then
		OnBlizzardWarboardUILoad(self, event, name, ...)
	elseif name == "Blizzard_QuestChoice" then
		OnBlizzardQuestChoiceLoad(self, event, name, ...)
	end
end

local function OnPlayerLogin(self, event, ...)
	local extras = {
		"CombatTextTemplate"
	}

	local specials = {
		["GameFontNormalSmall"] = 0.80
	}

	for k, v in pairs(_G) do
		if string.match(k, "Font") and IsTextRegion(k, v) then
			ProcessTextRegion(v, specials[k] or 0.95)
		end
	end

	for k, v in pairs(extras) do
		if IsTextRegion(k, v) then
			ProcessTextRegion(_G[v], specials[v] or 0.95)
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
