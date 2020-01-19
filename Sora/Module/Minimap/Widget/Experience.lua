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

    experience.datas = {}
    experience.datas[1] = S.MakeText(experience, 10)
    experience.datas[2] = S.MakeText(experience, 10)
    experience.datas[3] = S.MakeText(experience, 10)
    self:Tag(experience.datas[1], "等级 - Lv.[experience:level]")
    self:Tag(experience.datas[2], "[experience:cur]/[experience:max] - [experience:per]%")
    self:Tag(experience.datas[3], "[experience:currested] - [experience:perrested]%")

    local function OverrideUpdateTooltip(self, event, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:AddLine(self.datas[1]:GetText(), 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("经验：", self.datas[2]:GetText(), 0.90, 0.90, 0.90)
        GameTooltip:AddDoubleLine("休息：", self.datas[3]:GetText(), 0.90, 0.90, 0.90)
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
