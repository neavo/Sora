-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local buttons = {}

-- Begin
local function FindButtons()
    for k, v in pairs(_G) do
        if string.match(k, "LibDBIcon10_") and v:GetObjectType() == "Button" then
            table.insert(buttons, v)
        end
    end
end

local function ProcessButtons()
    local anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 0, 0)
    anchor:SetSize(buttons[1]:GetWidth(), Minimap:GetHeight())

    for k, v in ipairs(buttons) do
        if k == 1 then
            v:SetPoint("TOP", anchor, "TOP", 0, 6)
        else
            v:SetPoint("TOP", buttons[k - 1], "BOTTOM", 0, 0)
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    FindButtons()
    ProcessButtons()
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript(
    "OnEvent",
    function(self, event, ...)
        if event == "PLAYER_LOGIN" then
            OnPlayerLogin(self, event, ...)
        end
    end
)
