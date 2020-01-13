-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function RegisterStyle(self, ...)
    local experience = CreateFrame("StatusBar", nil, self)
    experience:EnableMouse(true)
    experience:SetAllPoints()
    experience:SetStatusBarTexture(DB.Statusbar)

    experience.shadow = S.MakeShadow(experience, 2)
    experience.shadow:SetFrameLevel(experience:GetFrameLevel())

    experience.rested = CreateFrame("StatusBar", nil, experience)
    experience.rested:SetAllPoints()
    experience.rested:SetStatusBarTexture(DB.Statusbar)

    experience.text = S.MakeText(experience, 10)
    experience.text:SetText("N/A")
    experience.text:SetPoint("CENTER", 0, 4)
    self:Tag(experience.text, "[experience:per]%")

    experience.bg = experience.rested:CreateTexture(nil, "BACKGROUND")
    experience.bg:SetTexture(DB.Statusbar)
    experience.bg:SetAllPoints()
    experience.bg:SetVertexColor(0.12, 0.12, 0.12)

    experience.onEnterInfoLine = S.MakeText(experience, 10)
    experience.onEnterInfoLine:Hide()
    self:Tag(experience.onEnterInfoLine, "[class] - Lv.[level]")

    experience.onEnterValueLine = S.MakeText(experience, 10)
    experience.onEnterValueLine:Hide()
    self:Tag(experience.onEnterValueLine, "[experience:cur]/[experience:max] - [experience:per]%")

    experience.onEnterRestedLine = S.MakeText(experience, 10)
    experience.onEnterRestedLine:Hide()
    self:Tag(experience.onEnterRestedLine, "[experience:currested] - [experience:perrested]%")

    local function OverrideUpdateTooltip(self, event, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:ClearLines()

        GameTooltip:AddLine(self.onEnterInfoLine:GetText(), 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("经验：", self.onEnterValueLine:GetText(), 0.90, 0.90, 0.90)
        GameTooltip:AddDoubleLine("休息：", self.onEnterRestedLine:GetText(), 0.90, 0.90, 0.90)

        GameTooltip:Show()
    end

    self.Experience = experience
    self.Experience.Rested = experience.rested
    self.Experience.OverrideUpdateTooltip = OverrideUpdateTooltip
end

function S.Minimap.CreateExperience(parent)
    oUF:RegisterStyle("oUFSoraExperience", RegisterStyle)
    oUF:SetActiveStyle("oUFSoraExperience")

    return oUF:Spawn("player", "oUFSoraExperience")
end
