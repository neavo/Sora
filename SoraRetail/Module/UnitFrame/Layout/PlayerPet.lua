﻿-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function RegisterStyle(self, unit, ...)
    local height = (oUF_Sora_Player:GetWidth() - 4 * 8) / 9
    
    self:SetSize(height * 3, height)
    self:SetPoint("TOPRIGHT", oUF_Sora_Player, "BOTTOMLEFT", -4, -4)
    
    self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.oUF.CreatePower(self,unit, ...)
    S.oUF.CreateHealth(self,unit, ...)

    S.oUF.CreateTag(self,unit, ...)
    S.oUF.CreateRaidTargetIndicator(self,unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_PlayerPet", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_PlayerPet")
    oUF:Spawn("pet", "oUF_Sora_PlayerPet")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.RegisterAllEvents()