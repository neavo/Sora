-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auraButton = nil

-- Begin
local function SetAuraButtonStyle()
    auraButton = {}

    auraButton.backdrop = {
        bgFile = "",
        title = false,
        edgeSize = 2,
        edgeFile = DB.GlowTex,
        borderColor = {0.00, 0.00, 0.00, 1.00},
        points = {
            {"TOPLEFT", -2, 2},
            {"BOTTOMRIGHT", 2, -2}
        }
    }

    auraButton.icon = {
        texCoord = {0.08, 0.92, 0.08, 0.92}
    }

    auraButton.border = {
        file = ""
    }

    auraButton.normalTexture = {
        file = ""
    }

    auraButton.count = {
        font = {STANDARD_TEXT_FONT, 10, "OUTLINE"},
        points = {
            {"TOPRIGHT", -1.0, -1.5}
        }
    }

    auraButton.symbol = {
        font = {STANDARD_TEXT_FONT, 12, "OUTLINE"},
        alpha = 1.0,
        points = {
            {"TOPRIGHT", 3, -1}
        }
    }

    auraButton.duration = {
        font = {DB.AuraFont, 12, "OUTLINE"},
        points = {
            {"BOTTOM", 2, -10}
        }
    }
end

local function OnPlayerLogin(self, event, ...)
    SetAuraButtonStyle()

    rButtonTemplate:StyleAllAuraButtons(auraButton)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
