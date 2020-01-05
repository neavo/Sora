-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function IsTextRegion(k, v)
	return type(v) == "table" and v.GetObjectType and v:GetObjectType() == "Font" and v.GetFont
end

local function ProcessTextRegion(text, scale)
	if text.__Processed then
		return 0
	end

	local font, size, flag = text:GetFont()

	if size <= 0 then
		return 0
	end

	text:SetFont(STANDARD_TEXT_FONT, size * scale, "OUTLINE")
	text:SetShadowOffset(1.00, 1.00)
	text:SetShadowColor(0, 0, 0, 0.5)

	text.__Processed = true
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
local function FindAllText(frame)
	local result = {}

	local function FindText(object)
		if not object then
			return 0
		end

		if object.GetChildren and #{object:GetChildren()} > 0 then
			for k, v in pairs({object:GetChildren()}) do
				FindText(v)
			end
		elseif object.GetRegions and #{object:GetRegions()} > 0 then
			for k, v in pairs({object:GetRegions()}) do
				FindText(v)
			end
		elseif object:GetObjectType() == "FontString" then
			table.insert(result, object)
		end
	end

	do
		FindText(frame)
	end

	return result
end
local function SetTextColor(r, g, b, a)
	-- do nothing
end
local function HookQuestChoiceFrameUpdate()
	local fontStrings = FindAllText(QuestChoiceFrame)

	for k, v in pairs(fontStrings) do
		ProcessTextRegion(v, 1.00)

		v:SetText((v:GetText() or ""):gsub("\r+", ""):gsub("\n+", ""))
		v:SetSpacing(2)
		v:SetTextColor(0.90, 0.90, 0.90, 1.00)
		v.SetTextColor = SetTextColor
	end
end
local function HookWarboardQuestChoiceFrameUpdate()
	local fontStrings = FindAllText(WarboardQuestChoiceFrame)

	for k, v in pairs(fontStrings) do
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
