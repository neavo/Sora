-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraUFBoss")
    anchor:Hide()
    anchor:SetText("单位框体 - 首领")
    anchor:SetSize(C.UnitFrame.Boss.Width * MAX_BOSS_FRAMES + 32 * (MAX_BOSS_FRAMES - 1), C.UnitFrame.Boss.Height)
    anchor:SetPoint(unpack(C.UnitFrame.Boss.Postion))
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
    S.UnitFrame.CreateHealthPrediction(self, unit, ...)

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
