-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetAlpha(0.50)
    frame:SetAllPoints()
    frame:SetFrameLevel(0)
    frame:SetFrameStrata("BACKGROUND")

    frame.bg = frame:CreateTexture(nil, "BORDER")
    frame.bg:SetAllPoints()
    frame.bg:SetTexture(DB.BorderShadow)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
