-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    local p = C.Core.Pixel or 1.00

    local style = {
        backdrop = {
            bgFile = DB.Backdrop,
            title = false,
            edgeSize = 2 * p,
            edgeFile = DB.GlowTex,
            borderColor = {0.00, 0.00, 0.00, 1.00},
            backgroundColor = {0.12, 0.12, 0.12, 0.30},
            points = {{"TOPLEFT", -2 * p, 2 * p}, {"BOTTOMRIGHT", 2 * p, -2 * p}}
        },
        icon = {texCoord = {0.08, 0.92, 0.08, 0.92}},
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
        -- pushedTexture = {
        -- },
        -- highlightTexture = {
        -- },
        -- checkedTexture = {
        -- },
        shine = {
            points = {{"TOPLEFT", 0.00, 0.00}, {"BOTTOMRIGHT", 0.00, 0.00}}
        },
        cooldown = {
            points = {{"TOPLEFT", 0.00, 0.00}, {"BOTTOMRIGHT", 0.00, 0.00}}
        },
        autocastable = {
            texCoord = {0.22, 0.78, 0.22, 0.78},
            points = {{"TOPLEFT", -2 * p, 2 * p}, {"BOTTOMRIGHT", 2 * p, -2 * p}}
        },
        name = {
            font = {STANDARD_TEXT_FONT, 10, "OUTLINE"},
            points = {{"BOTTOM", 0, 1}}
        },
        count = {
            font = {STANDARD_TEXT_FONT, 12, "OUTLINE"},
            points = {{"TOPLEFT", 0, 0}}
        },
        hotkey = {
            font = {STANDARD_TEXT_FONT, 12, "OUTLINE"},
            points = {{"TOPRIGHT", 0, -1}}
        }
    }

    rButtonTemplate:StyleAllActionButtons(style)
    rButtonTemplate:StyleExtraActionButton(style)
    rButtonTemplate:StyleActionButton(_G["SoraVehicleExitButton"], style)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
