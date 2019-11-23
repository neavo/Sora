-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
	local style = {
		backdrop = {
			bgFile = DB.Statusbar,
			title = false,
			edgeSize = 2,
			edgeFile = DB.GlowTex,
			borderColor = {0.00, 0.00, 0.00, 1.00},
			backgroundColor = {0.12, 0.12, 0.12, 0.25},
			points = {
				{"TOPLEFT", -2, 2},
				{"BOTTOMRIGHT", 2, -2}
			}
		},
		icon = {
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		flash = {
			file = ""
		},
		flyoutBorder = {
			file = ""
		},
		flyoutBorderShadow = {
			file = ""
		},
		border = {
			file = ""
		},
		normalTexture = {
			file = ""
		},
		pushedTexture = {
			file = ""
		},
		checkedTexture = {
			points = {
				{"TOPLEFT", -2, 2},
				{"BOTTOMRIGHT", 2, -2}
			}
		},
		highlightTexture = {
			points = {
				{"TOPLEFT", -2, 2},
				{"BOTTOMRIGHT", 2, -2}
			}
		},
		name = {
			font = {STANDARD_TEXT_FONT, 10, "OUTLINE"},
			points = {
				{"BOTTOM", 0, 1}
			}
		},
		count = {
			font = {STANDARD_TEXT_FONT, 12, "OUTLINE"},
			points = {
				{"TOPLEFT", 0, 0}
			}
		},
		hotkey = {
			font = {STANDARD_TEXT_FONT, 12, "OUTLINE"},
			points = {
				{"TOPRIGHT", 1, -1}
			}
		}
	}

	rButtonTemplate:StyleAllActionButtons(style)
	rButtonTemplate:StyleExtraActionButton(style)
end

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "PLAYER_LOGIN" then
			OnPlayerLogin(self, event, ...)
		end
	end
)
