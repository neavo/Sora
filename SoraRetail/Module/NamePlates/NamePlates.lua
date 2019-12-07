-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
S.NamePlates = {}
local width, height = C.NamePlates.Width, C.NamePlates.Height

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
    power.shadow = S.MakeShadow(power, 1)

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
    health.shadow = S.MakeShadow(health, 1)

    self.Health = health
end

-- Tag
S.NamePlates.CreateTag = function(self, unit, ...)
    self.RaraTag = S.MakeText(self.Health, 8)
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

    auras.PostCreateIcon = function(self, icon, ...)
        if not icon._isProcessed then
            icon.shadow = S.MakeShadow(icon, 2)

            icon.icon:SetAllPoints()
            icon.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

            icon.count = S.MakeText(icon, 10)
            icon.count:SetPoint("BOTTOMRIGHT", 3, 0)

            icon._isProcessed = true
        end
    end

    self.Auras = auras
end

-- Threat
local TimerHandler = S.CreateTimerHandler()
TimerHandler.Interval = 1.00
TimerHandler.OnUpdate = function(handler, elapsed, ...)
    for i = 1, 40 do
        local nameplate = _G["oUF_Sora_NamePlate" .. i]

        if nameplate then
            local alpha = 0.00
            local isTanking = UnitDetailedThreatSituation("player", nameplate.unit)

            if UnitAffectingCombat("player") then
                alpha = isTanking and 1.00 or 0.30
            end

            nameplate.Threat:SetAlpha(alpha)
            nameplate.Threat:SetStatusBarColor(GetThreatStatusColor(isTanking and 3.00 or 0.00))
        end
    end
end

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

    castbar.Text = S.MakeText(castbar, 8)
    castbar.Text:SetPoint("LEFT", 2, 0)

    castbar.Time = S.MakeText(castbar, 8)
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

    local handler = CreateFrame("Frame", nil, UIParent)
    handler.timer = 0
    handler.fading = false

    castbar.CustomTimeText = function(self, duration)
        self.Time:SetText(("%.1f / %.1f"):format(duration, self.max))
    end

    castbar.PostCastStart = function(self, unit, name, castid, spellid)
        if handler.fading then
            handler.fading = false
            handler:SetScript("OnUpdate", nil)
        end

        if self.notInterruptible then
            self:SetStatusBarColor(1.00, 0.50, 0.50)
        else
            self:SetStatusBarColor(0.37, 0.71, 1.00)
        end

        self:Show()
        self:SetAlpha(1.00)
    end

    castbar.PostCastFailed = function(self, unit, spellname, castid, spellid)
        if handler.fading then
            handler.fading = false
            handler:SetScript("OnUpdate", nil)
        end

        self:Show()
        self:SetAlpha(1.00)
        self:SetStatusBarColor(1.00, 0.05, 0.00)

        local HandlerOnUpdate = function(handler, elasped, ...)
            handler.fading = true
            handler.timer = handler.timer + elasped

            if handler.timer > 0.30 then
                handler.fading = false
                handler:SetScript("OnUpdate", nil)
            else
                self:Show()
                self:SetAlpha(1.00 * (1 - handler.timer / 0.30))
            end
        end

        handler.timer = 0.00
        handler:SetScript("OnUpdate", HandlerOnUpdate)
    end

    castbar.CustomDelayText = castbar.CustomTimeText
    castbar.PostChannelStart = castbar.PostCastStart
    castbar.PostCastInterrupted = castbar.PostCastFailed

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
    oUF:RegisterStyle("oUF_Sora_", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_")
    oUF:SpawnNamePlates("oUF_Sora_")

    SetCVar("namePlateMinScale", 1) -- 固定大小，提高性能
    SetCVar("namePlateMaxScale", 1) -- 固定大小，提高性能
    SetCVar("nameplateMaxDistance", 40) -- 还原最远显示距离40码
    SetCVar("nameplateLargerScale", 1) -- 重要目标（如首領）的姓名板縮放
    SetCVar("nameplateSelectedScale", 1) -- 當前（選中）目標姓名板的縮放
    -- SetCVar("nameplateOverlapH", 0.30) --名條堆疊的水平百分比，預設是0.8
    -- SetCVar("nameplateOverlapV", 0.30) --名條堆疊的垂直百分比，預設是1.1
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:RegisterAllEvents()