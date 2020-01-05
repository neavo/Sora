-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = CreateFrame("Frame", "SoraUFTarget", UIParent)
    anchor:Hide()
    anchor:SetSize(C.UnitFrame.Target.Width, C.UnitFrame.Target.Height)
    anchor:SetPoint(unpack(C.UnitFrame.Target.Postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    anchor.bg = anchor:CreateTexture(nil, "BORDER")
    anchor.bg:SetAllPoints()
    anchor.bg:SetTexture(DB.Backdrop)
    anchor.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    anchor.text = S.MakeText(anchor, 16)
    anchor.text:SetText("单位框体 - 目标")
    anchor.text:SetPoint("CENTER", anchor, "CENTER", 0, 0)

    anchor.shadow = S.MakeShadow(anchor, 2)
    anchor.shadow:SetFrameLevel(anchor:GetFrameLevel())

    local function OnEnter(self, ...)
        self.bg:SetVertexColor(r / 4, g / 4, b / 4, 0.50)
        self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        self.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    if C.Config.UnitFrame.Mover and C.Config.UnitFrame.Mover.SoraUFTarget then
        anchor:SetScript("OnLeave", OnLeave)
        anchor:SetScript("OnEnter", OnEnter)
        anchor:SetScript("OnDragStop", C.Config.UnitFrame.Mover.SoraUFTarget.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.UnitFrame.Mover.SoraUFTarget.OnDragStart)

        C.Config.UnitFrame.Mover.SoraUFTarget.anchor = anchor
    end
end

-- Begin
local function RegisterStyle(self, unit, ...)
    self:SetSize(SoraUFTarget:GetSize())
    self:SetAllPoints(SoraUFTarget)
    self:RegisterForClicks("AnyUp")

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
    CreateAnchor()

    oUF:RegisterStyle("oUF_Sora_Target", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Target")
    oUF:Spawn("target", "oUF_Sora_Target")
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
