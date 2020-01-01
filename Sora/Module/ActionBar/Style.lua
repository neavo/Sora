-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
	local style = {
		backdrop = {
			bgFile = DB.Backdrop,
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
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		flyoutBorder = {
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		flyoutBorderShadow = {
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		border = {
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		normalTexture = {
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		pushedTexture = {
			file = "",
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		checkedTexture = {
			texCoord = {0.08, 0.92, 0.08, 0.92}
		},
		highlightTexture = {
			texCoord = {0.08, 0.92, 0.08, 0.92}
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
				{"TOPRIGHT", 0, -1}
			}
		}
	}

	rButtonTemplate:StyleAllActionButtons(style)
	rButtonTemplate:StyleExtraActionButton(style)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
