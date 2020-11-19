-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local width, height = nil, nil

-- Power
local function CreatePower(self, unit, ...)
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
local function CreateHealth(self, unit, ...)
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

    local function PostUpdate(self, unit, cur, max)
        local guid = UnitGUID(unit)
        local _, _, _, _, _, id = strsplit("-", guid or "")

        if id == "120651" then
            self:SetStatusBarColor(0.00, 0.90, 0.00, 1.00)
        end
    end

    self.Health = health
    self.Health.PostUpdate = PostUpdate
end

-- HealthPrediction
local function CreateHealthPrediction(self, unit, ...)
    local myBar = CreateFrame("StatusBar", nil, self.Health)
    myBar:SetSize(self.Health:GetSize())
    myBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
    myBar:SetFrameLevel(self.Health:GetFrameLevel())
    myBar:SetStatusBarTexture(DB.Statusbar)
    myBar:SetStatusBarColor(125 / 255, 255 / 255, 50 / 255, 0.50)

    local otherBar = CreateFrame("StatusBar", nil, self.Health)
    otherBar:SetSize(self.Health:GetSize())
    otherBar:SetPoint("LEFT", myBar:GetStatusBarTexture(), "RIGHT")
    otherBar:SetFrameLevel(self.Health:GetFrameLevel())
    otherBar:SetStatusBarTexture(DB.Statusbar)
    otherBar:SetStatusBarColor(100 / 255, 235 / 255, 200 / 255, 0.50)

    local absorbBar = CreateFrame("StatusBar", nil, self.Health)
    absorbBar:SetSize(self.Health:GetSize())
    absorbBar:SetPoint("LEFT", otherBar:GetStatusBarTexture(), "RIGHT")
    absorbBar:SetFrameLevel(self.Health:GetFrameLevel())
    absorbBar:SetStatusBarTexture(DB.Statusbar)
    absorbBar:SetStatusBarColor(180 / 255, 255 / 255, 205 / 255, 0.35)

    local healAbsorbBar = CreateFrame("StatusBar", nil, self.Health)
    healAbsorbBar:SetSize(self.Health:GetSize())
    healAbsorbBar:SetPoint("RIGHT", self.Health:GetStatusBarTexture())
    healAbsorbBar:SetFrameLevel(self.Health:GetFrameLevel())
    healAbsorbBar:SetReverseFill(true)
    healAbsorbBar:SetStatusBarTexture(DB.Statusbar)
    healAbsorbBar:SetStatusBarColor(183 / 255, 244 / 255, 255 / 255, 0.35)

    self.HealthPrediction = {}
    self.HealthPrediction.myBar = myBar
    self.HealthPrediction.otherBar = otherBar
    self.HealthPrediction.absorbBar = absorbBar
    self.HealthPrediction.healAbsorbBar = healAbsorbBar
    self.HealthPrediction.maxOverflow = 1.00
    self.HealthPrediction.frequentUpdates = true
end

-- Tag
local function CreateTag(self, unit, ...)
    self.RaraTag = S.MakeText(self.Health, 7)
    self.RaraTag:SetPoint("RIGHT", self, "LEFT", -4, 0.5)
    self:Tag(self.RaraTag, "[NamePlates:Rare]")

    self.NameTag = S.MakeText(self.Health, 9)
    self.NameTag:SetPoint("BOTTOM", self, "TOP", 0, 4)
    self:Tag(self.NameTag, "[NamePlates:Level][NamePlates:Name]")
end

-- Auras
local function CreateAuras(self, unit, ...)
    local perRow, maxRow = 7, 2
    local size = (self:GetWidth() - 4 * (perRow - 1)) / perRow

    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(self:GetWidth(), size * maxRow + 4 * (maxRow - 1))
    auras:SetPoint("TOP", self, "BOTTOM", 0, -4)

    auras.gap = true
    auras.size = size
    auras.spacing = 4
    auras.numTotal = perRow * maxRow
    auras.numBuffs = perRow * maxRow
    auras.numDebuffs = perRow * maxRow
    auras["growth-y"] = "DOWN"
    auras["growth-x"] = "RIGHT"
    auras.initialAnchor = "TOPLEFT"
    auras.disableCooldown = false

    function auras.CustomFilter(self, unit, _, _, _, _, _, _, _, caster)
        return caster == unit or caster == "player"
    end

    function auras.PostCreateIcon(self, aura, ...)
        local anchor = CreateFrame("Frame", nil, aura)
        anchor:SetAllPoints(aura)
        anchor:SetFrameLevel(aura.cd:GetFrameLevel() + 1)

        aura.icon:SetAllPoints()
        aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        aura.count = S.MakeText(anchor, 5)
        aura.count:SetPoint("BOTTOMRIGHT", 3, -2)

        aura.shadow = S.MakeShadow(aura, 2)
        aura.shadow:SetFrameLevel(aura:GetFrameLevel())
    end

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

local function CreateThreat(self, unit, ...)
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
local function CreateCastbar(self, unit, ...)
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
local function CreateRaidTargetIndicator(self, unit, ...)
    local indicator = self:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(10, 10)
    indicator:SetPoint("LEFT", self.NameTag, "RIGHT", 2, 0)

    self.RaidTargetIndicator = indicator
end

-- QuestTargetIndicator
local function CreateQuestTargetIndicator(self, unit, ...)
    local indicator = self:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(10, 10)
    indicator:SetPoint("RIGHT", self.NameTag, "LEFT", -2, 0)
    indicator:SetTexture([[Interface\TargetingFrame\PortraitQuestBadge]])

    self.QuestTargetIndicator = indicator
end

-- Common
local function UpdateQuestTargetIndicator(self, unit, ...)
    if not self or not self.QuestTargetIndicator then
        return 0
    end

    local indicator = self.QuestTargetIndicator

    if not indicator.tooltip then
        indicator.tooltip = CreateFrame("GameTooltip", "SoraNamePlatesTooltip", nil, "GameTooltipTemplate")
    end

    local tooltip = indicator.tooltip
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetUnit(unit or self.unit)

    local flag = false

    for i = 2, tooltip:NumLines() do
        local text = _G["SoraNamePlatesTooltipTextLeft" .. i]
        local title = text:GetText()

        if title == nil or title == "" then
            break
        end

        local r, g, b = text:GetTextColor()
        flag = flag or (r >= 0.99 and g >= 0.82 and b == 0.00) -- ugly, but useful
    end

    if flag then
        indicator:Show()
    else
        indicator:Hide()
    end
end

-- Event
local function RegisterStyle(self, unit, ...)
    self.unit = unit
    self:SetSize(width, height)
    self:SetPoint("BOTTOM", C_NamePlate.GetNamePlateForUnit(unit), "BOTTOM", 0, 0)

    CreatePower(self, unit, ...)
    CreateHealth(self, unit, ...)
    CreateHealthPrediction(self, unit, ...)

    CreateTag(self, unit, ...)
    CreateAuras(self, unit, ...)
    CreateThreat(self, unit, ...)
    CreateCastbar(self, unit, ...)
    CreateRaidTargetIndicator(self, unit, ...)
    CreateQuestTargetIndicator(self, unit, ...)
end

local function OnPostUpdate(self, event, unit, ...)
    UpdateQuestTargetIndicator(self, unit, ...)
end

local function OnInitialize(self, event, ...)
    width, height = C.NamePlates.Width, C.NamePlates.Height
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_")
    oUF:SpawnNamePlates("oUF_Sora_", OnPostUpdate)

    SetCVar("namePlateMinScale", 1) -- 固定大小，提高性能
    SetCVar("namePlateMaxScale", 1) -- 固定大小，提高性能
    SetCVar("nameplateGlobalScale", 1) -- 固定大小，提高性能
    SetCVar("nameplateSelfScale", 1) -- 固定大小，提高性能，玩家姓名板的缩放
    SetCVar("nameplateLargerScale", 1) -- 固定大小，提高性能，重要目标（如首領）姓名板的缩放
    SetCVar("nameplateSelectedScale", 1) -- 固定大小，提高性能，目标（选中）姓名板的縮放
    
    SetCVar("nameplateMaxDistance", 40) -- 还原最远显示距离（40码）
    SetCVar("showQuestTrackingTooltips", 1) -- 显示姓名板任务标记
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
