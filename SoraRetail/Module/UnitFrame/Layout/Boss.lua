﻿-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local todo = nil

-- Begin
local function RegisterStyle(self, unit, ...)
    local str = self:GetName():gsub("oUF_Sora_Boss", "")
    
    if tonumber(str) == 1 then
        self:SetPoint("LEFT", anchor, "LEFT", 0, 0)
    else
        self:SetPoint("LEFT", _G["oUF_Sora_Boss" .. (tonumber(str) - 1)], "RIGHT", 32, 0)
    end
    
    self:RegisterForClicks("AnyUp")
    self:SetSize(C.UnitFrame.Boss.Width, C.UnitFrame.Boss.Height)

    S.oUF.CreatePower(self, unit, ...)
    S.oUF.CreateHealth(self, unit, ...)

    S.oUF.CreateTag(self, unit, ...)
    S.oUF.CreateAuras(self, unit, ...)
    S.oUF.CreateThreat(self, unit, ...)
    S.oUF.CreateCastbar(self, unit, ...)
    S.oUF.CreatePortrait(self, unit, ...)
end


local function OnPlayerLogin(self, event, ...)
    anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetPoint(unpack(C.UnitFrame.Boss.Postion))
    anchor:SetSize(C.UnitFrame.Boss.Width * MAX_BOSS_FRAMES + 32 * (MAX_BOSS_FRAMES - 1), C.UnitFrame.Boss.Height)
    
    oUF:RegisterStyle("oUF_Sora_Boss", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Boss")
    
    for i = 1, MAX_BOSS_FRAMES do
        oUF:Spawn("boss" .. i, "oUF_Sora_Boss" .. i)
    end
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.RegisterAllEvents()