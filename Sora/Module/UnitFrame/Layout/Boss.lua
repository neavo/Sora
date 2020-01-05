-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = CreateFrame("Frame", "SoraUFBoss", UIParent)
    anchor:Hide()
    anchor:SetSize(C.UnitFrame.Boss.Width * MAX_BOSS_FRAMES + 32 * (MAX_BOSS_FRAMES - 1), C.UnitFrame.Boss.Height)
    anchor:SetPoint(unpack(C.UnitFrame.Boss.Postion))
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
    anchor.text:SetText("单位框体 - 首领")
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

    if C.Config.UnitFrame.Mover and C.Config.UnitFrame.Mover.SoraUFBoss then
        anchor:SetScript("OnLeave", OnLeave)
        anchor:SetScript("OnEnter", OnEnter)
        anchor:SetScript("OnDragStop", C.Config.UnitFrame.Mover.SoraUFBoss.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.UnitFrame.Mover.SoraUFBoss.OnDragStart)

        C.Config.UnitFrame.Mover.SoraUFBoss.anchor = anchor
    end
end

local function RegisterStyle(self, unit, ...)
    local i = tonumber(self:GetName():match("%d+"))

    if i == 1 then
        self:SetPoint("LEFT", SoraUFBoss, "LEFT", 0, 0)
    else
        self:SetPoint("LEFT", _G["oUF_Sora_Boss" .. (i - 1)], "RIGHT", 32, 0)
    end

    self:RegisterForClicks("AnyUp")
    self:SetSize(C.UnitFrame.Boss.Width, C.UnitFrame.Boss.Height)

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)

    S.UnitFrame.CreateTag(self, unit, ...)
    S.UnitFrame.CreateAuras(self, unit, ...)
    S.UnitFrame.CreateThreat(self, unit, ...)
    S.UnitFrame.CreateCastbar(self, unit, ...)
    S.UnitFrame.CreatePortrait(self, unit, ...)
    S.UnitFrame.CreateQuickMark(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    CreateAnchor()

    oUF:RegisterStyle("oUF_Sora_Boss", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Boss")

    for i = 1, MAX_BOSS_FRAMES do
        oUF:Spawn("boss" .. i, "oUF_Sora_Boss" .. i)
    end
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
