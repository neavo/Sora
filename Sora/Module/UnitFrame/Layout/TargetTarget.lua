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

    S.UnitFrame.CreatePower(self,unit, ...)
    S.UnitFrame.CreateHealth(self,unit, ...)

    S.UnitFrame.CreateTag(self,unit, ...)
    S.UnitFrame.CreateQuickMark(self,unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self,unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_TargetTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_TargetTarget")
    oUF:Spawn("targettarget", "oUF_Sora_TargetTarget")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()