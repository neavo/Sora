-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraUFPlayer")
    anchor:Hide()
    anchor:SetText("单位框体 - 玩家")
    anchor:SetSize(C.UnitFrame.Player.Width, C.UnitFrame.Player.Height)
    anchor:SetPoint(unpack(C.UnitFrame.Player.Postion))
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

local function RegisterStyle(self, unit, ...)
    self:SetSize(SoraUFPlayer:GetSize())
    self:SetAllPoints(SoraUFPlayer)
    self:RegisterForClicks("AnyUp")

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)
    S.UnitFrame.CreateHealthPrediction(self, unit, ...)

    S.UnitFrame.CreateTag(self, unit, ...)
    S.UnitFrame.CreateAuras(self, unit, ...)
    S.UnitFrame.CreateRunes(self, unit, ...)
    S.UnitFrame.CreateTotems(self, unit, ...)
    S.UnitFrame.CreateCastbar(self, unit, ...)
    S.UnitFrame.CreatePortrait(self, unit, ...)
    S.UnitFrame.CreateQuickMark(self, unit, ...)
    S.UnitFrame.CreateClassPowers(self, unit, ...)
    S.UnitFrame.CreateAdditionalPower(self, unit, ...)

    S.UnitFrame.CreateRaidRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateGroupRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self, unit, ...)
end

-- Event
local function OnPlayerLogin(self, event, ...)
    CreateAnchor()

    oUF:RegisterStyle("oUF_Sora_Player", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Player")
    oUF:Spawn("player", "oUF_Sora_Player")

    PlayerPowerBarAlt:SetMovable(true)
    PlayerPowerBarAlt:EnableMouse(true)
    PlayerPowerBarAlt:SetToplevel(true)
    PlayerPowerBarAlt:SetFrameStrata("HIGH")
    PlayerPowerBarAlt:RegisterForDrag("LeftButton")
    PlayerPowerBarAlt:SetClampedToScreen(true)

    local function OnDragStop(self, button, ...)
        self:StopMovingOrSizing()
    end

    local function OnDragStart(self, button, ...)
        self:StartMoving()
    end

    local function HookUnitPowerBarAltSetup(self, barID)
        if self.statusFrame.enabled then
            self.statusFrame:Show()
            self.statusFrame.Hide = self.statusFrame.Show
        end
    end

    PlayerPowerBarAlt:SetScript("OnDragStop", OnDragStop)
    PlayerPowerBarAlt:SetScript("OnDragStart", OnDragStart)
    hooksecurefunc("UnitPowerBarAlt_SetUp", HookUnitPowerBarAltSetup)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
