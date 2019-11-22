-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local buttons = {}

-- Begin
local function FindButtons()
    if LibDBIcon10_BugSack and LibDBIcon10_BugSack:GetObjectType() == "Button" then
        table.insert(buttons, LibDBIcon10_BugSack)
    end

    if LibDBIcon10_DBM and LibDBIcon10_DBM:GetObjectType() == "Button" then
        table.insert(buttons, LibDBIcon10_DBM)
    end

    if LibDBIcon10_Skada and LibDBIcon10_Skada:GetObjectType() == "Button" then
        table.insert(buttons, LibDBIcon10_Skada)
    end

    if LibDBIcon10_BigWigs and LibDBIcon10_BigWigs:GetObjectType() == "Button" then
        table.insert(buttons, LibDBIcon10_BigWigs)
    end

    if LibDBIcon10_MeetingStone and LibDBIcon10_MeetingStone:GetObjectType() == "Button" then
        table.insert(buttons, LibDBIcon10_MeetingStone)
    end
end

local function ProcessButtons()
    if #buttons > 0 then
        local anchor = CreateFrame("Frame", nil, UIParent)
        anchor:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 0, 0)
        anchor:SetSize(buttons[1]:GetWidth(), Minimap:GetHeight())
        
        for k, v in ipairs(buttons) do            
            if k == 1 then
                v:SetPoint("TOP", anchor, "TOP", 0, 6)
            else
                v:SetPoint("TOP", buttons[k - 1], "BOTTOM", 0, 6)
            end
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
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
