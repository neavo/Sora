-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local width, height = nil, nil

-- Initialize
S.NamePlates = S.NamePlates or {}

-- Power
S.NamePlates.CreatePower = function(self, unit, ...)
    local power = CreateFrame("StatusBar", nil, self)
    power:SetPoint("BOTTOM")
    power:SetSize(width, 1)
    power:SetStatusBarTexture(DB.Statusbar)

    power.bg = power:CreateTexture(nil, "BACKGROUND")
    power.bg:SetTexture(DB.Statusbar)
    power.bg:SetAllPoints()
    power.bg:SetVertexColor(0.12, 0.12, 0.12)
    power.bg.multiplier = 0.12

    power.Smooth = true
    power.colorPower = true
    power.colorSmooth = true
    power.frequentUpdates = true

    power.shadow = S.MakeShadow(power, 2)
    power.shadow:SetFrameLevel(power:GetFrameLevel())

    self.Power = power
end

-- Health
S.NamePlates.CreateHealth = function(self, unit, ...)
    local health = CreateFrame("StatusBar", nil, self)
    health:SetPoint("TOP")
    health:SetSize(width, height - 2)
    health:SetStatusBarTexture(DB.Statusbar)

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
    health.colorSmooth = true
    health.colorHealth = true
    health.frequentUpdates = true

    health.shadow = S.MakeShadow(health, 2)
    health.shadow:SetFrameLevel(health:GetFrameLevel())

    self.Health = health
end

-- Tag
S.NamePlates.CreateTag = function(self, unit, ...)
    self.RaraTag = S.MakeText(self.Health, 7)
    self.RaraTag:SetPoint("RIGHT", self, "LEFT", -4, 0.5)
    self:Tag(self.RaraTag, "[NamePlates:Rare]")

    self.NameTag = S.MakeText(self.Health, 9)
    self.NameTag:SetPoint("BOTTOM", self, "TOP", 0, 4)
    self:Tag(self.NameTag, "[NamePlates:Level][NamePlates:Name]")
end

-- Auras
S.NamePlates.CreateAuras = function(self, unit, ...)
    local num, spacing = 7, 4
    local size = (self:GetWidth() - spacing * (num - 1)) / num

    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(self:GetWidth(), size)
    auras:SetPoint("TOP", self, "BOTTOM", 0, -spacing)

    auras.gap = true
    auras.size = size
    auras.spacing = spacing
    auras.numTotal = num
    auras["growth-y"] = "UP"
    auras["growth-x"] = "RIGHT"
    auras.onlyShowPlayer = true
    auras.disableCooldown = false
    auras.initialAnchor = "BOTTOMLEFT"

    local PostCreateIcon = function(self, aura, ...)
        if not aura.__isProcessed then
            aura.shadow = S.MakeShadow(aura, 2)

            aura.icon:SetAllPoints()
            aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

            local anchor = CreateFrame("Frame", nil, aura)
            anchor:SetAllPoints(aura)
            anchor:SetFrameLevel(aura.cd:GetFrameLevel() + 1)

            aura.count = S.MakeText(anchor, 5)
            aura.count:SetPoint("BOTTOMRIGHT", 3, 0)

            aura.__isProcessed = true
        end
    end

    auras.PostCreateIcon = PostCreateIcon

    self.Auras = auras
end

-- Threat
local function OnTicker(ticker)
    for i = 1, 999 do
        local nameplate = _G["oUF_Sora_NamePlate" .. i]

        if not nameplate then
            return 0
        end

        local alpha = 0.00
        local isTanking = UnitDetailedThreatSituation("player", nameplate.unit)

        if InCombatLockdown() then
            alpha = isTanking and 1.00 or 0.30
        end

        nameplate.Threat:SetAlpha(alpha)
        nameplate.Threat:SetStatusBarColor(GetThreatStatusColor(isTanking and 3.00 or 0.00))
    end
end
C_Timer.NewTicker(1.00, OnTicker)

S.NamePlates.CreateThreat = function(self, unit, ...)
    local threat = CreateFrame("StatusBar", nil, self)
    threat:SetSize(height, height)
    threat:SetStatusBarTexture(DB.Statusbar)
    threat:SetPoint("LEFT", self, "RIGHT", 4, 0)

    threat:SetAlpha(0.30)
    threat:SetStatusBarColor(GetThreatStatusColor(0))

    threat.shadow = S.MakeShadow(threat, 2)

    self.Threat = threat
end

-- Castbar
S.NamePlates.CreateCastbar = function(self, unit, ...)
    local spacing, barHeight = self.Auras.spacing, 12

    local castbar = CreateFrame("StatusBar", nil, self)
    castbar:SetFrameLevel(self.Health:GetFrameLevel() + 255)
    castbar:SetStatusBarTexture(DB.Statusbar)
    castbar:SetSize(self:GetWidth() - barHeight - spacing, barHeight)

    castbar.shadow = S.MakeShadow(castbar, 2)
    castbar.bg = castbar:CreateTexture(nil, "BACKGROUND")
    castbar.bg:SetAllPoints()
    castbar.bg:SetTexture(DB.Statusbar)
    castbar.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    castbar.Text = S.MakeText(castbar, 7)
    castbar.Text:SetPoint("LEFT", 2, 0)

    castbar.Time = S.MakeText(castbar, 7)
    castbar.Time:SetPoint("RIGHT", -2, 0)

    castbar.Icon = castbar:CreateTexture(nil, "ARTWORK")
    castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
    castbar.Icon.Shadow = S.MakeTextureShadow(castbar, castbar.Icon, 2)

    castbar.SafeZone = castbar:CreateTexture(nil, "BORDER")
    castbar.SafeZone:SetAlpha(0.25)
    castbar.SafeZone:SetAllPoints()

    castbar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, spacing)
    castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)

    local OnTimeUpdate = function(self, duration)
        self.Text:SetText(S.SubString(self.Text:GetText(), 7, "..."))

        if duration < 60 and self.max < 60 then
            self.Time:SetText(("%.1f / %.1f"):format(duration, self.max))
        else
            self.Time:SetText(S.FormatTime(duration, true) .. " / " .. S.FormatTime(self.max, true))
        end
    end

    local function OnCastStart(self, unit, name, castid, spellid)
        UIFrameFadeRemoveFrame(self)

        if self.notInterruptible then
            self:SetStatusBarColor(1.00, 0.50, 0.50)
        else
            self:SetStatusBarColor(0.37, 0.71, 1.00)
        end

        self:SetAlpha(1.00)
    end

    local function OnCastStopped(self, unit, spellname, castid, spellid)
        UIFrameFadeRemoveFrame(self)

        self:SetAlpha(1.00)
        self:SetStatusBarColor(1.00, 0.05, 0.00)

        self.holdTime = 0.30
        UIFrameFadeOut(self, 0.30, 1.00, 0.00)
    end

    castbar.CustomTimeText = OnTimeUpdate
    castbar.CustomDelayText = OnTimeUpdate
    castbar.PostCastStart = OnCastStart
    castbar.PostCastFailed = OnCastStopped
    castbar.PostChannelStart = OnCastStart
    castbar.PostCastInterrupted = OnCastStopped

    self.Castbar = castbar
end

-- RaidTargetIndicator
S.NamePlates.CreateRaidTargetIndicator = function(self, unit, ...)
    local size, base = 10, self.Health

    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints(base)
    anchor:SetFrameLevel(base:GetFrameLevel() + 1)

    local raidTargetIndicator = anchor:CreateTexture(nil, "ARTWORK")
    raidTargetIndicator:SetSize(size, size)
    raidTargetIndicator:SetPoint("LEFT", self.NameTag, "RIGHT", 2, 1)

    self.RaidTargetIndicator = raidTargetIndicator
end

-- Begin
local function RegisterStyle(self, unit, ...)
    self.unit = unit
    self:SetSize(width, height)
    self:SetPoint("BOTTOM", C_NamePlate.GetNamePlateForUnit(unit), "BOTTOM", 0, 0)

    S.NamePlates.CreatePower(self, unit, ...)
    S.NamePlates.CreateHealth(self, unit, ...)

    S.NamePlates.CreateTag(self, unit, ...)
    S.NamePlates.CreateAuras(self, unit, ...)
    S.NamePlates.CreateThreat(self, unit, ...)
    S.NamePlates.CreateCastbar(self, unit, ...)
    S.NamePlates.CreateRaidTargetIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    width, height = C.NamePlates.Width, C.NamePlates.Height

    oUF:RegisterStyle("oUF_Sora_", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_")
    oUF:SpawnNamePlates("oUF_Sora_")

    SetCVar("namePlateMinScale", 1) -- 固定大小，提高性能
    SetCVar("namePlateMaxScale", 1) -- 固定大小，提高性能
    SetCVar("nameplateMaxDistance", 40) -- 还原最远显示距离40码
    SetCVar("nameplateLargerScale", 1) -- 重要目标（如首領）的姓名板縮放
    SetCVar("nameplateSelectedScale", 1) -- 當前（選中）目標姓名板的縮放
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
