-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function RegisterStyle(self, ...)
    local honor = CreateFrame("StatusBar", nil, self)
    honor:EnableMouse(true)
    honor:SetAllPoints()
    honor:SetStatusBarTexture(DB.Statusbar)

    honor.shadow = S.MakeShadow(honor, 2)
    honor.shadow:SetFrameLevel(honor:GetFrameLevel())

    honor.rested = CreateFrame("StatusBar", nil, honor)
    honor.rested:SetAllPoints()
    honor.rested:SetStatusBarTexture(DB.Statusbar)

    honor.text = S.MakeText(honor, 10)
    honor.text:SetText("N/A")
    honor.text:SetPoint("CENTER", 0, 4)
    self:Tag(honor.text, "[experience:per]%")

    honor.bg = honor.rested:CreateTexture(nil, "BACKGROUND")
    honor.bg:SetTexture(DB.Statusbar)
    honor.bg:SetAllPoints()
    honor.bg:SetVertexColor(0.12, 0.12, 0.12)

    honor.datas = {}
    honor.datas[1] = S.MakeText(honor, 10)
    honor.datas[2] = S.MakeText(honor, 10)
    self:Tag(honor.datas[1], "荣誉等级 - Lv.[experience:level]")
    self:Tag(honor.datas[2], "[experience:cur]/[experience:max] - [experience:per]%")

    local function OverrideUpdateTooltip(self, event, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:AddLine(self.datas[1]:GetText(), 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("荣誉：", self.datas[2]:GetText(), 0.90, 0.90, 0.90)
        GameTooltip:Show()
    end

    self.Experience = honor
    self.Experience.Rested = honor.rested
    self.Experience.OverrideUpdateTooltip = OverrideUpdateTooltip
end

function S.Minimap.CreateHonor(parent)
    oUF:RegisterStyle("oUFSoraHonor", RegisterStyle)
    oUF:SetActiveStyle("oUFSoraHonor")

    return oUF:Spawn("player", "oUFSoraHonor")
end
