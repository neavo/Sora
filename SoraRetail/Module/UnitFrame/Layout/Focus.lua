-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local todo = nil

-- Begin
local function RegisterStyle(self, unit, ...)
    self:RegisterForClicks("AnyUp")
    self:SetPoint(unpack(C.UnitFrame.Focus.Postion))
    self:SetSize(C.UnitFrame.Focus.Width, C.UnitFrame.Focus.Height)

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)

    S.UnitFrame.CreateTag(self, unit, ...)
    S.UnitFrame.CreateAuras(self, unit, ...)
    S.UnitFrame.CreateThreat(self, unit, ...)
    S.UnitFrame.CreateCastbar(self, unit, ...)
    S.UnitFrame.CreatePortrait(self, unit, ...)
    S.UnitFrame.CreateQuickMark(self, unit, ...)

    S.UnitFrame.CreateRaidRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateGroupRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_Focus", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Focus")
    oUF:Spawn("focus", "oUF_Sora_Focus")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()