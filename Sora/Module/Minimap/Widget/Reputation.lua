-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function RegisterStyle(self, ...)
    local reputation = CreateFrame("StatusBar", nil, self)
    reputation:EnableMouse(true)
    reputation:SetAllPoints()
    reputation:SetStatusBarTexture(DB.Statusbar)
    reputation.colorStanding = true

    reputation.shadow = S.MakeShadow(reputation, 2)
    reputation.shadow:SetFrameLevel(reputation:GetFrameLevel())

    reputation.text = S.MakeText(reputation, 10)
    reputation.text:SetText("N/A")
    reputation.text:SetPoint("CENTER", 0, 4)
    self:Tag(reputation.text, "[reputation:per]%")

    reputation.bg = reputation:CreateTexture(nil, "BACKGROUND")
    reputation.bg:SetTexture(DB.Statusbar)
    reputation.bg:SetAllPoints()
    reputation.bg:SetVertexColor(0.12, 0.12, 0.12)

    reputation.onEnterInfoLine = S.MakeText(reputation, 10)
    reputation.onEnterInfoLine:ClearAllPoints()
    self:Tag(reputation.onEnterInfoLine, "[reputation:faction] - [reputation:standing]")

    reputation.onEnterValueLine = S.MakeText(reputation, 10)
    reputation.onEnterValueLine:ClearAllPoints()
    self:Tag(reputation.onEnterValueLine, "[reputation:cur]/[reputation:max] - [reputation:per]%")

    local function UpdateTooltip(self, event, ...)
        local name, standingID, min, max, cur, factionID = GetWatchedFactionInfo()
        local _, desc = GetFactionInfoByID(factionID)

        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")

        GameTooltip:AddLine(self.onEnterInfoLine:GetText(), 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(desc, 0.90, 0.90, 0.90, true)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("声望：", self.onEnterValueLine:GetText(), 0.90, 0.90, 0.90)

        GameTooltip:Show()
    end

    self.Reputation = reputation
    self.Reputation.UpdateTooltip = UpdateTooltip
end

function S.Minimap.CreateReputation(parent)
    oUF:RegisterStyle("oUFSoraReputation", RegisterStyle)
    oUF:SetActiveStyle("oUFSoraReputation")

    return oUF:Spawn("player", "oUFSoraReputation")
end
