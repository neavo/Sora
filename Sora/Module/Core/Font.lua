-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function IsTextRegion(k, v)
	return type(v) == "table" and v.GetObjectType and v:GetObjectType() == "Font" and v.GetFont
end

local function ProcessTextRegion(fontString, scale, color)
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

	if color ~= nil then
		fontString:SetTextColor(unpack(color))
	end

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

-- Event
local function OnPlayerLogin(self, event, ...)
	local extras = {
		["CombatTextTemplate"] = true
	}

	local specialScale = {
		["GameFontNormalSmall"] = 0.80
	}

	local specialColor = {
		["GameFontBlack"] = {0.90, 0.90, 0.90, 1.00},
		["GameFontBlackMedium"] = {0.90, 0.90, 0.90, 1.00},
		["GameFontBlackSmall"] = {0.90, 0.90, 0.90, 1.00},
		["GameFontBlackSmall2"] = {0.90, 0.90, 0.90, 1.00},
		["GameFontBlackTiny"] = {0.90, 0.90, 0.90, 1.00},
		["GameFontBlackTiny2"] = {0.90, 0.90, 0.90, 1.00}
	}

	for k, v in pairs(_G) do
		if string.match(k, "Font") and IsTextRegion(k, v) then
			ProcessTextRegion(v, specialScale[k] or 0.95, specialColor[k] or nil)
		end
	end

	for k, v in pairs(extras) do
		if IsTextRegion(k, v) then
			ProcessTextRegion(_G[k], specialScale[k] or 0.95, specialColor[k] or nil)
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
