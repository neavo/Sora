-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function RegisterStyle(self, unit, ...)
    local height = (_G[self:GetName():gsub("Target", "")]:GetWidth() - 4 * 8) / 9

    self:SetSize(height * 3, height)
    self:SetPoint("BOTTOMLEFT", _G[self:GetName():gsub("Target", "")], "TOPLEFT", 0, 4)

    self:RegisterForClicks("AnyUp")
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)
    S.UnitFrame.CreateHealthPrediction(self, unit, ...)

    S.UnitFrame.CreateTag(self, unit, ...)
    S.UnitFrame.CreatePortrait(self, unit, ...)
    S.UnitFrame.CreateQuickMark(self, unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_BossTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_BossTarget")

    for i = 1, 5 do
        oUF:Spawn("boss" .. i .. "target", "oUF_Sora_Boss" .. i .. "Target")
    end
    
    oUF:RegisterStyle("oUF_Sora_ArenaTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_ArenaTarget")

    for i = 1, 5 do
        oUF:Spawn("arena" .. i .. "target", "oUF_Sora_Arena" .. i .. "Target")
    end
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
