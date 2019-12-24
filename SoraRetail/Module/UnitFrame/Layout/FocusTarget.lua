-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function RegisterStyle(self, unit, ...)
    local height = (oUF_Sora_Focus:GetWidth() - 4 * 8) / 9
    
    self:SetSize(height * 3, height)
    self:SetPoint("TOPLEFT", oUF_Sora_Focus, "BOTTOMRIGHT", 4, -4)
    
    self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.UnitFrame.CreatePower(self,unit, ...)
    S.UnitFrame.CreateHealth(self,unit, ...)

    S.UnitFrame.CreateTag(self,unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self,unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_FocusTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_FocusTarget")
    oUF:Spawn("focustarget", "oUF_Sora_FocusTarget")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()