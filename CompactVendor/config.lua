local addonName = ...

CompactVendorDB = {
	ListItemScale = 1,
}

_G["SLASH_" .. addonName .. "1"] = "/compactvendor"
_G["SLASH_" .. addonName .. "2"] = "/cv"

local PATTERN_SCALE_NUMBER = "^%s*[Ss][Cc][Aa][Ll][Ee]%s*([%d%.]*)%s*$"

local function output(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[" .. addonName .. "]|r" .. text, YELLOW_FONT_COLOR.r, YELLOW_FONT_COLOR.g, YELLOW_FONT_COLOR.b)
end

SlashCmdList[addonName] = function(text)

	local scale = text:match(PATTERN_SCALE_NUMBER)
	if scale then
		scale = tonumber(scale)
		if scale then
			scale = math.max(0.01, math.min(10, scale))
			CompactVendorDB.ListItemScale = scale
			output("List scale set to |cffFFFFFF" .. scale .. "|r. Please apply the change by typing |cffFFFFFF/console reloadui|r and reloading your interface.")
			return
		end
	end

	output("Supported commands:")
	output("  /compactvendor scale 1  |cffFFFFFF0.5 = half, 1 = normal, 2 = double|r")

end
