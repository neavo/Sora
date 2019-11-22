-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function SetPower(self, ...)
    local power = CreateFrame("StatusBar", nil, self)
    power:SetPoint("BOTTOM")
    power:SetSize(self:GetWidth(), 2)
    power:SetStatusBarTexture(DB.Statusbar)
    
    power.bg = power:CreateTexture(nil, "BACKGROUND")
    power.bg:SetAllPoints()
    power.bg:SetTexture(DB.Statusbar)
    power.bg:SetVertexColor(0.12, 0.12, 0.12)
    power.bg.multiplier = 0.12
    
    power.Smooth = true
    power.colorPower = true
    power.frequentUpdates = true
    power.shadow = S.MakeShadow(power, 2)
    
    self.Power = power
end

local function SetHealth(self, ...)
    local health = CreateFrame("StatusBar", nil, self)
    health:SetPoint("TOP", self)
    health:SetStatusBarTexture(DB.Statusbar)
    health:SetSize(self:GetWidth(), self:GetHeight() - 4)
    
    health.bg = health:CreateTexture(nil, "BACKGROUND")
    health.bg:SetAllPoints()
    health.bg:SetTexture(DB.Statusbar)
    health.bg:SetVertexColor(0.12, 0.12, 0.12)
    health.bg.multiplier = 0.12
    
    health.Smooth = true
    health.colorTapping = true
    health.colorDisconnected = true
    health.colorClass = true
    health.colorReaction = true
    health.colorHealth = true
    health.frequentUpdates = true
    health.shadow = S.MakeShadow(health, 2)
    
    self.Health = health
end

local function SetTag(self, ...)
    local nameTag = S.MakeText(self.Health, 9)
    nameTag:SetPoint("TOPLEFT", 1, -2)
    self:Tag(nameTag, "[Sora:ShortName]")
    
    local healthTag = S.MakeText(self.Health, 9)
    healthTag:SetPoint("BOTTOMRIGHT", self.Health, 1, 1)
    self:Tag(healthTag, "[Sora:PerHealth]")
end

local function SetRaidTargetIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)
    
    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOP", 0, 0)
    
    self.RaidTargetIndicator = indicator
end

local function RegisterForEvent(self, ...)
    self:SetScript("OnLeave", UnitFrame_OnLeave)
    self:SetScript("OnEnter", UnitFrame_OnEnter)
end

local function RegisterForClicks(self, ...)
    self:RegisterForClicks("AnyUp")
end

local function RegisterStyle(self, ...)
    local height = (_G[self:GetName():gsub("Target", "")]:GetWidth() - 4 * 8) / 9 + 4
    
    self:SetSize(height * 2.5, height)
    self:SetPoint("BOTTOMLEFT", _G[self:GetName():gsub("Target", "")], "TOPLEFT", 0, 4)
    
    SetPower(self, ...)
    SetHealth(self, ...)
    
    SetTag(self, ...)
    SetRaidTargetIndicator(self, ...)
    
    RegisterForEvent(self, ...)
    RegisterForClicks(self, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_BossTarget", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_BossTarget")
    
    for i = 1, 5 do
        local oUFFrame = oUF:Spawn("boss" .. i .. "target", "oUF_Sora_Boss" .. i .. "Target")
    end
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
