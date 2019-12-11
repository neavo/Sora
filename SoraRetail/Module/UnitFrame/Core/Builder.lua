-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Initialize
S.oUF = {}

-- Power
S.oUF.CreatePower = function(self, unit, ...)
    local height = nil

    if unit == "player" or unit == "target" or unit == "focus" or string.find(unit, "^boss%d$") ~= nil then
        height = 4
    elseif
        unit == "pet" or unit == "targettarget" or unit == "focustarget" or string.find(unit, "^boss%dtarget$") ~= nil
     then
        height = 2
    elseif unit == "raid" then
        height = 2
    end

    local power = CreateFrame("StatusBar", nil, self)
    power:SetPoint("BOTTOM")
    power:SetSize(self:GetWidth(), height)
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

    self.Power = power
end

-- Health
S.oUF.CreateHealth = function(self, unit, ...)
    local height = nil

    if unit == "player" or unit == "target" or unit == "focus" or string.find(unit, "^boss%d$") ~= nil then
        height = self:GetHeight() - 8
    elseif
        unit == "pet" or unit == "targettarget" or unit == "focustarget" or string.find(unit, "^boss%dtarget$") ~= nil
     then
        height = self:GetHeight() - 4
    elseif unit == "raid" then
        height = self:GetHeight() - 4
    end

    local health = CreateFrame("StatusBar", nil, self)
    health:SetPoint("TOP")
    health:SetStatusBarTexture(DB.Statusbar)
    health:SetSize(self:GetWidth(), height)

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

    self.Health = health
end

-- Tag
S.oUF.CreateTag = function(self, unit, ...)
    if unit == "player" or unit == "target" or unit == "focus" or string.find(unit, "^boss%d$") ~= nil then
        local nameTag = S.MakeText(self.Health, 12)
        nameTag:SetAlpha(0.00)
        nameTag:SetPoint("LEFT", 4, 0)
        self:Tag(nameTag, "[UnitFrame:Level][UnitFrame:Rare][UnitFrame:Name]")

        local powerTag = S.MakeText(self.Power, 10)
        powerTag:SetAlpha(0.00)
        powerTag:SetPoint("RIGHT", -4, 0)
        self:Tag(powerTag, "[UnitFrame:Power] | [UnitFrame:PerPower]")

        local healthTag = S.MakeText(self.Health, 11)
        healthTag:SetAlpha(0.00)
        healthTag:SetPoint("RIGHT", -4, 0)
        self:Tag(healthTag, "[UnitFrame:Health] | [UnitFrame:PerHealth]")

        self.nameTag = nameTag
        self.powerTag = powerTag
        self.healthTag = healthTag
    elseif
        unit == "pet" or unit == "targettarget" or unit == "focustarget" or string.find(unit, "^boss%dtarget$") ~= nil
     then
        local nameTag = S.MakeText(self.Health, 9)
        nameTag:SetPoint("TOPLEFT", 1, -1)
        self:Tag(nameTag, "[UnitFrame:ShortName]")

        local healthTag = S.MakeText(self.Health, 8)
        healthTag:SetPoint("BOTTOMRIGHT", self.Health, 1, -1)
        self:Tag(healthTag, "[UnitFrame:PerHealth]")
    elseif unit == "raid" then
        local nameTag = S.MakeText(self.Health, 10)
        nameTag:SetPoint("CENTER", 0, 0)
        self:Tag(nameTag, "[UnitFrame:Name]")

        local statusTag = S.MakeText(self.Health, 7)
        statusTag:SetPoint("CENTER", 0, -10)
        self:Tag(statusTag, "[UnitFrame:Status]")

        self.NameTag = nameTag
        self.StatusTag = statusTag
    end
end

-- Auras
S.oUF.CreateAuras = function(self, unit, ...)
    local spacing = 4
    local size = (self:GetWidth() - 4 * 8) / 9

    local auras = CreateFrame("Frame", nil, self)
    auras:SetSize(self:GetWidth(), size * 3 + spacing * 2)
    auras:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -spacing)

    auras.gap = true
    auras.size = size
    auras.spacing = spacing
    auras["growth-y"] = "DOWN"
    auras["growth-x"] = "RIGHT"
    auras.onlyShowPlayer = false
    auras.disableCooldown = false
    auras.initialAnchor = "TOPLEFT"

    local PostCreateIcon = function(self, aura, ...)
        if not aura.__isProcessed then
            aura.shadow = S.MakeShadow(aura, 2)

            aura.icon:SetAllPoints()
            aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

            local anchor = CreateFrame("Frame", nil, aura)
            anchor:SetAllPoints(aura)
            anchor:SetFrameLevel(aura.cd:GetFrameLevel() + 1)

            aura.count = S.MakeText(anchor, 9)
            aura.count:SetPoint("BOTTOMRIGHT", 3, 0)

            aura.__isProcessed = true
        end
    end

    auras.PostCreateIcon = PostCreateIcon

    if unit == "player" then
        auras.numBuffs = 0
        auras.numDebuffs = 27
    else
        auras.numBuffs = 9
        auras.numDebuffs = 18
    end

    self.Auras = auras
end

-- Runes
S.oUF.CreateRunes = function(self, unit, ...)
    if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then
        return 0
    end

    local runes = {}
    local num, size = 6, (self:GetWidth() - (num - 1) * 4) / num

    for i = 1, num do
        local rune = CreateFrame("StatusBar", nil, self)
        rune:SetSize(size, 4)
        rune:SetStatusBarTexture(DB.Statusbar)

        rune.backgourd = CreateFrame("StatusBar", nil, self)
        rune.backgourd:SetAllPoints(rune)
        rune.backgourd:SetFrameLevel(0)
        rune.backgourd:SetStatusBarTexture(DB.Statusbar)
        rune.backgourd:SetStatusBarColor(0.12, 0.12, 0.12)
        rune.backgourd.shadow = S.MakeShadow(rune.backgourd, 2)

        if i == 1 then
            rune:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 4)
        else
            rune:SetPoint("LEFT", runes[i - 1], "RIGHT", 4, 0)
        end

        runes[i] = rune
    end

    self.Runes = classPowers
end

-- Totems
S.oUF.CreateTotems = function(self, unit, ...)
    if select(2, UnitClass("player")) ~= "SHAMAN" then
        return 0
    end

    local totems = {}
    local size = self:GetHeight() / 2 - 4

    for i = 1, MAX_TOTEMS do
        local totem = CreateFrame("Button", nil, self)
        totem:SetSize(size, size)

        totem.icon = totem:CreateTexture(nil, "OVERLAY")
        totem.icon:SetAllPoints()
        totem.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        totem.cooldown = CreateFrame("Cooldown", nil, totem, "CooldownFrameTemplate")
        totem.cooldown:SetAllPoints()

        totem.shadow = S.MakeShadow(totem, 2)

        if i == 1 then
            totem:SetPoint("RIGHT", self, "LEFT", -4, 0)
        elseif i == 3 then
            totem:SetPoint("RIGHT", totems[1], "LEFT", -4, 0)
        else
            totem:SetPoint("TOP", totems[i - 1], "RIGHT", 0, -4)
        end

        totems[i] = totem
    end

    self.Totems = totems
end

-- Threat
S.oUF.CreateThreat = function(self, unit, ...)
    local threat = CreateFrame("StatusBar", nil, self)
    threat:SetSize(12, 12)
    threat:SetStatusBarTexture(DB.Statusbar)
    threat:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", 4, 0)

    threat:SetAlpha(0.30)
    threat:SetStatusBarColor(GetThreatStatusColor(0))
    threat.shadow = S.MakeShadow(threat, 2)

    local handler = S.CreateTimerHandler()
    handler.Register()
    handler.Interval = 1.00
    handler.OnUpdate = function(handler, elapsed, ...)
        local alpha = 0.00
        local isTanking = UnitDetailedThreatSituation("player", unit)

        if UnitAffectingCombat("player") then
            alpha = isTanking and 1.00 or 0.30
        end

        threat:SetAlpha(alpha)
        threat:SetStatusBarColor(GetThreatStatusColor(isTanking and 3.00 or 0.00))
    end

    self.Threat = threat
end

-- Castbar
S.oUF.CreateCastbar = function(self, unit, ...)
    local spacing, barHeight = self.Auras.spacing, self.Auras.size

    local castbar = CreateFrame("StatusBar", nil, self)
    castbar:SetFrameLevel(self.Health:GetFrameLevel() + 255)
    castbar:SetStatusBarTexture(DB.Statusbar)
    castbar:SetSize(self:GetWidth() - barHeight - spacing, barHeight)

    castbar.shadow = S.MakeShadow(castbar, 2)
    castbar.bg = castbar:CreateTexture(nil, "BACKGROUND")
    castbar.bg:SetAllPoints()
    castbar.bg:SetTexture(DB.Statusbar)
    castbar.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    castbar.Text = S.MakeText(castbar, 10)
    castbar.Text:SetPoint("LEFT", 2, 0)

    castbar.Time = S.MakeText(castbar, 10)
    castbar.Time:SetPoint("RIGHT", -2, 0)

    castbar.Icon = castbar:CreateTexture(nil, "ARTWORK")
    castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
    castbar.Icon.Shadow = S.MakeTextureShadow(castbar, castbar.Icon, 2)

    castbar.SafeZone = castbar:CreateTexture(nil, "BORDER")
    castbar.SafeZone:SetAlpha(0.25)
    castbar.SafeZone:SetAllPoints()

    if unit == "player" then
        castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -spacing)
        castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)
    elseif unit == "target" or unit == "focus" then
        castbar:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -spacing)
        castbar.Icon:SetPoint("RIGHT", castbar, "LEFT", -spacing, 0)
    else
        castbar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", barHeight * 3 + spacing, spacing)
        castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)
        castbar:SetSize(self:GetWidth() - barHeight - barHeight * 3 - spacing * 2, barHeight)
    end

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

        handler.timer = 0.00
        handler:SetScript(
            "OnUpdate",
            function(handler, elasped, ...)
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
        )
    end

    castbar.CustomDelayText = castbar.CustomTimeText
    castbar.PostChannelStart = castbar.PostCastStart
    castbar.PostCastInterrupted = castbar.PostCastFailed

    self.Castbar = castbar
end

-- Portrait
S.oUF.CreatePortrait = function(self, unit, ...)
    local portrait = CreateFrame("PlayerModel", nil, self)
    portrait:SetAlpha(0.30)
    portrait:SetAllPoints(self.Health)
    portrait:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    local function PortraitFadeIn(self, ...)
        UIFrameFadeIn(self.Portrait, 0.30, 0.00, 0.30)
        UIFrameFadeOut(self.nameTag, 0.30, 1.00, 0.00)
        UIFrameFadeOut(self.powerTag, 0.30, 1.00, 0.00)
        UIFrameFadeOut(self.healthTag, 0.30, 1.00, 0.00)
    end

    local function PortraitFadeOut(self, ...)
        UIFrameFadeIn(self.nameTag, 0.30, 0.00, 1.00)
        UIFrameFadeIn(self.healthTag, 0.30, 0.00, 1.00)
        UIFrameFadeIn(self.powerTag, 0.30, 0.00, 1.00)
        UIFrameFadeOut(self.Portrait, 0.30, 0.30, 0.00)
    end

    local OnEnter = function(self, event, ...)
        UnitFrame_OnEnter(self)

        if not UnitAffectingCombat("player") then
            PortraitFadeOut(self, ...)
        end
    end

    local OnLeave = function(self, event, ...)
        UnitFrame_OnLeave(self)

        if not UnitAffectingCombat("player") then
            PortraitFadeIn(self, ...)
        end
    end

    self:SetScript("OnEnter", OnEnter)
    self:SetScript("OnLeave", OnLeave)

    local OnPlayerRegenEnabled = function(handler, event, ...)
        PortraitFadeIn(self, ...)
    end

    local OnPlayerRegenDisabled = function(handler, event, ...)
        PortraitFadeOut(self, ...)
    end

    local EventHandler = S.CreateEventHandler()
    EventHandler.Event.PLAYER_REGEN_ENABLED = OnPlayerRegenEnabled
    EventHandler.Event.PLAYER_REGEN_DISABLED = OnPlayerRegenDisabled
    EventHandler.RegisterAllEvents()

    self.Portrait = portrait
end

-- ClassPowers
S.oUF.CreateClassPowers = function(self, unit, ...)
    local powers = {}

    for i = 1, 8 do
        local power = CreateFrame("StatusBar", nil, self)
        power:SetStatusBarTexture(DB.Statusbar)

        power.backgourd = CreateFrame("StatusBar", nil, self)
        power.backgourd:SetAllPoints(power)
        power.backgourd:SetFrameLevel(0)
        power.backgourd:SetStatusBarTexture(DB.Statusbar)
        power.backgourd:SetStatusBarColor(0.12, 0.12, 0.12)
        power.backgourd.shadow = S.MakeShadow(power.backgourd, 2)

        powers[i] = power
    end

    local lastMax = nil
    local PostUpdate = function(powers, cur, max, hasMaxChanged, powerType)
        if lastMax == max then
            return 0
        else
            lastMax = max
        end

        for i = 1, 8 do
            local power = powers[i]

            if not max or i > max then
                power:Hide()
                power.backgourd:Hide()
            else
                if i == 1 then
                    power:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 4)
                else
                    power:SetPoint("LEFT", powers[i - 1], "RIGHT", 4, 0)
                end

                power:Show()
                power.backgourd:Show()

                power:SetSize((self:GetWidth() - (max - 1) * 4) / max, 4)
            end
        end
    end

    self.ClassPower = powers
    self.ClassPower.PostUpdate = PostUpdate
end

-- RaidRoleIndicator
S.oUF.CreateRaidRoleIndicator = function(self, unit, ...)
    local anchor, indicator = nil, nil

    anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOPLEFT", 0, 1)
    self.LeaderIndicator = indicator

    indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOPLEFT", 0, 1)
    self.RaidRoleIndicator = indicator

    indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOPLEFT", 0, 1)
    self.RaidRoleIndicator = indicator
end

-- GroupRoleIndicator
S.oUF.CreateGroupRoleIndicator = function(self, unit, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOPRIGHT", 0, 0)
    self.GroupRoleIndicator = indicator
end

-- RaidTargetIndicator
S.oUF.CreateRaidTargetIndicator = function(self, unit, ...)
    local size, base = nil, nil

    if unit == "player" or unit == "target" or unit == "focus" or string.find(unit, "^boss%d$") ~= nil then
        size = 16
        base = self.Portrait
    elseif
        unit == "pet" or unit == "targettarget" or unit == "focustarget" or string.find(unit, "^boss%dtarget$") ~= nil
     then
        size = 12
        base = self.Health
    elseif unit == "raid" then
        size = 12
        base = self.Health
    end

    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints(base)
    anchor:SetFrameLevel(base:GetFrameLevel() + 1)

    local raidTargetIndicator = anchor:CreateTexture(nil, "ARTWORK")
    raidTargetIndicator:SetAlpha(0.75)
    raidTargetIndicator:SetSize(size, size)
    raidTargetIndicator:SetPoint("CENTER", anchor, "TOP", 0, 0)

    self.RaidTargetIndicator = raidTargetIndicator
end
