-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local todo = nil

-- Begin
local function RegisterStyle(self, unit, ...)
    self:RegisterForClicks("AnyUp")
    self:SetPoint(unpack(C.UnitFrame.Target.Postion))
    self:SetSize(C.UnitFrame.Target.Width, C.UnitFrame.Target.Height)

    S.oUF.CreatePower(self, unit, ...)
    S.oUF.CreateHealth(self, unit, ...)

    S.oUF.CreateTag(self, unit, ...)
    S.oUF.CreateAuras(self, unit, ...)
    S.oUF.CreateThreat(self, unit, ...)
    S.oUF.CreateCastbar(self, unit, ...)
    S.oUF.CreatePortrait(self, unit, ...)

    S.oUF.CreateRaidRoleIndicator(self, unit, ...)
    S.oUF.CreateGroupRoleIndicator(self, unit, ...)
    S.oUF.CreateRaidTargetIndicator(self, unit, ...)
end


local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_Target", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Target")
    oUF:Spawn("target", "oUF_Sora_Target")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.RegisterAllEvents()