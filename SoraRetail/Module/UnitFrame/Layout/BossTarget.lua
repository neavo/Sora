-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function RegisterStyle(self, unit, ...)
    local height = (_G[self:GetName():gsub("Target", "")]:GetWidth() - 4 * 8) / 9

    self:SetSize(height * 3, height)
    self:SetPoint("BOTTOMLEFT", _G[self:GetName():gsub("Target", "")], "TOPLEFT", 0, 4)

    self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.oUF.CreatePower(self, unit, ...)
    S.oUF.CreateHealth(self, unit, ...)

    S.oUF.CreateTag(self, unit, ...)
    S.oUF.CreateRaidTargetIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_BossTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_BossTarget")
    
    for i = 1, 5 do
        oUF:Spawn("boss" .. i .. "target", "oUF_Sora_Boss" .. i .. "Target")
    end
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)