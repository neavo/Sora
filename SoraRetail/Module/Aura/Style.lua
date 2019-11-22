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
            {"BOTTOMRIGHT", 2, -2},
        },
    }
    
    auraButton.icon = {
        texCoord = {0.08, 0.92, 0.08, 0.92},
    }
    
    auraButton.border = {
        file = ""
    }
    
    auraButton.normalTexture = {
        file = ""
    }
    
    auraButton.symbol = {
        alpha = 1.0,
    }

    auraButton.count = {
        font = {DB.AuraFont, 12, "THINOUTLINE"},
        points = {
            {"TOPRIGHT", 3, -1}
        }
    }
    
    auraButton.duration = {
        font = {DB.AuraFont, 12, "THINOUTLINE"},
        points = {
            {"BOTTOM", 2, -10},
        }
    }
end

local function OnPlayerLogin(self, event, ...)
    SetAuraButtonStyle()
    
    rButtonTemplate:StyleAllAuraButtons(auraButton)
end

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
