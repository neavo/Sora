-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function RegisterStyle(self, unit, ...)
    local height = (oUF_Sora_Target:GetWidth() - 4 * 8) / 9
    
    self:SetSize(height * 3, height)
    self:SetPoint("TOPLEFT", oUF_Sora_Target, "BOTTOMRIGHT", 4, -4)
    
    self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.oUF.CreatePower(self,unit, ...)
    S.oUF.CreateHealth(self,unit, ...)

    S.oUF.CreateTag(self,unit, ...)
    S.oUF.CreateRaidTargetIndicator(self,unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_TargetTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_TargetTarget")
    oUF:Spawn("targettarget", "oUF_Sora_TargetTarget")
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
