-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

local frames = {
    "oUF_Sora_Player", "oUF_Sora_PlayerPet",
    "oUF_Sora_Focus", "oUF_Sora_FocusTarget",
    "oUF_Sora_Target", "oUF_Sora_TargetTarget",
    "oUF_Sora_Boss1", "oUF_Sora_Boss2", "oUF_Sora_Boss3", "oUF_Sora_Boss4", "oUF_Sora_Boss5",
    "oUF_Sora_Boss1Target", "oUF_Sora_Boss2Target", "oUF_Sora_Boss3Target", "oUF_Sora_Boss4Target", "oUF_Sora_Boss5Target"
}

local function toggle(frame)
    if frame.__realunit then
        frame:SetAttribute("unit", frame.__realunit)
        frame.unit = frame.__realunit
        frame.__realunit = nil
        frame:Hide()
    else
        frame.__realunit = frame:GetAttribute("unit") or frame.unit
        frame:SetAttribute("unit", "player")
        frame.unit = "player"
        frame:Show()
    end
end

local function SlashSoraTest()
    for k, v in pairs(frames) do
        local frame = _G[v]
        
        if frame then
            toggle(frame)
        end
    end
end

-- Begin
local function OnPlayerLogin(self, event, ...)
    SLASH_SORATEST1 = "/st"
    SLASH_SORATEST2 = "/soratest"
    SlashCmdList.SORATEST = SlashSoraTest
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
