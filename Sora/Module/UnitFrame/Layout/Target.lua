-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraUFTarget")
    anchor:Hide()
    anchor:SetText("单位框体 - 目标")
    anchor:SetSize(C.UnitFrame.Target.Width, C.UnitFrame.Target.Height)
    anchor:SetPoint(unpack(C.UnitFrame.Target.Postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.UnitFrame.Mover and C.Config.UnitFrame.Mover[anchor:GetName()] then
        anchor:SetScript("OnDragStop", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStart)

        C.Config.UnitFrame.Mover[anchor:GetName()].anchor = anchor
    end
end

-- Begin
local function RegisterStyle(self, unit, ...)
    self:SetSize(SoraUFTarget:GetSize())
    self:SetAllPoints(SoraUFTarget)
    self:RegisterForClicks("AnyUp")

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)
    S.UnitFrame.CreateHealthPrediction(self, unit, ...)

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
    CreateAnchor()

    oUF:RegisterStyle("oUF_Sora_Target", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Target")
    oUF:Spawn("target", "oUF_Sora_Target")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
