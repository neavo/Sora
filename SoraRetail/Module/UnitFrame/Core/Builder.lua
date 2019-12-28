-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Initialize
S.UnitFrame = S.UnitFrame or {}

-- Common
local function IsCaster()
    local _, class = UnitClass("player")
    local specialization = GetSpecialization()

    return select(5, GetSpecializationInfo(specialization)) == "HEALER" or (class == "MAGE") or
        (class == "DRUID" and specialization == 1) or
        (class == "PRIEST") or
        (class == "SHAMAN" and specialization == 1) or
        (class == "WARLOCK")
end

-- Power
S.UnitFrame.CreatePower = function(self, unit, ...)
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
S.UnitFrame.CreateHealth = function(self, unit, ...)
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
S.UnitFrame.CreateTag = function(self, unit, ...)
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
S.UnitFrame.CreateAuras = function(self, unit, ...)
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

    local function PostCreateIcon(self, aura, ...)
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

    if unit ~= "player" then
        auras.numBuffs = 9
        auras.numTotal = 27
    else
        auras.numBuffs = 0
        auras.numTotal = 27
    end

    self.Auras = auras
end

-- Runes
S.UnitFrame.CreateRunes = function(self, unit, ...)
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
S.UnitFrame.CreateTotems = function(self, unit, ...)
    if select(2, UnitClass("player")) ~= "SHAMAN" then
        return 0
    end

    local totems = {}
    local colors = {
        {0.81, 0.26, 0.10}, -- Fire
        {0.80, 0.72, 0.29}, -- Earth
        {0.17, 0.50, 1.00}, -- Water
        {0.17, 0.73, 0.80} -- Air
    }

    local size = self:GetHeight() - 4 - 4

    local function UpdateTooltip(self)
        GameTooltip:SetTotem(self.i)
    end

    for i = 1, MAX_TOTEMS do
        local totem = CreateFrame("Button", nil, self)
        totem:SetSize(size, size)

        totem.icon = totem:CreateTexture(nil, "ARTWORK")
        totem.icon:SetAllPoints()
        totem.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        totem.bar = CreateFrame("StatusBar", nil, totem)
        totem.bar:SetSize(size, 4)
        totem.bar:SetPoint("BOTTOM", totem, "TOP", 0, 4)
        totem.bar:SetStatusBarTexture(DB.Statusbar)
        totem.bar:SetStatusBarColor(unpack(colors[i]))

        totem.bar.backgourd = CreateFrame("StatusBar", nil, totem.bar)
        totem.bar.backgourd:SetFrameLevel(0)
        totem.bar.backgourd:SetAllPoints(totem.bar)
        totem.bar.backgourd:SetStatusBarTexture(DB.Statusbar)
        totem.bar.backgourd:SetStatusBarColor(0.12, 0.12, 0.12)

        totem.UpdateTooltip = UpdateTooltip
        totem.shadow = S.MakeShadow(totem, 2)
        totem.bar.backgourd.shadow = S.MakeShadow(totem.bar.backgourd, 2)

        if i == 1 then
            totem:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", -4, 0)
        else
            totem:SetPoint("RIGHT", totems[i - 1], "LEFT", -4, 0)
        end

        totems[i] = totem
    end

    local function OnUpdate(self, elapsed, ...)
        if self.expiration - GetTime() > 0 then
            self.bar:SetValue(self.expiration - GetTime())
        end
    end

    local function Override(self, event, ...)
        local datas = {}

        for i = 1, MAX_TOTEMS do
            local haveTotem, name, start, duration, icon = GetTotemInfo(i)

            if haveTotem and duration > 0 and start + duration - GetTime() > 0 then
                local data = {}
                data.i = i
                data.icon = icon
                data.name = name
                data.start = start
                data.duration = duration

                table.insert(datas, data)
            end
        end

        for i = 1, MAX_TOTEMS do
            local data = datas[i]
            local totem = totems[i]

            if not data then
                totem:Hide()
                totem:SetScript("OnUpdate", nil)
            else
                totem.i = data.i
                totem.expiration = data.start + data.duration

                totem.icon:SetTexture(data.icon)
                totem.bar:SetMinMaxValues(0, data.duration)

                totem:Show()
                totem:SetScript("OnUpdate", OnUpdate)
            end
        end
    end

    self.Totems = totems
    self.Totems.Override = Override
end

-- Threat
S.UnitFrame.CreateThreat = function(self, unit, ...)
    local threat = CreateFrame("StatusBar", nil, self)
    threat:SetSize(12, 12)
    threat:SetStatusBarTexture(DB.Statusbar)
    threat:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", 4, 0)

    threat:SetAlpha(0.30)
    threat:SetStatusBarColor(GetThreatStatusColor(0))
    threat.shadow = S.MakeShadow(threat, 2)

    local function OnTicker(ticker)
        local alpha = 0.00
        local isTanking = UnitDetailedThreatSituation("player", unit)

        if InCombatLockdown() then
            alpha = isTanking and 1.00 or 0.30
        end

        threat:SetAlpha(alpha)
        threat:SetStatusBarColor(GetThreatStatusColor(isTanking and 3.00 or 0.00))
    end
    C_Timer.NewTicker(1.00, OnTicker)

    self.Threat = threat
end

-- Castbar
S.UnitFrame.CreateCastbar = function(self, unit, ...)
    local spacing, size = self.Auras.spacing, self.Auras.size

    local castbar = CreateFrame("StatusBar", nil, self)
    castbar:SetFrameLevel(self.Health:GetFrameLevel() + 255)
    castbar:SetStatusBarTexture(DB.Statusbar)

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
    castbar.Icon.Shadow = S.MakeTextureShadow(castbar, castbar.Icon, 2)

    castbar.SafeZone = castbar:CreateTexture(nil, "BORDER")
    castbar.SafeZone:SetAlpha(0.25)
    castbar.SafeZone:SetAllPoints()

    local function SetAnchor(self, ...)
        if unit == "player" and IsCaster() then
            local raidWidth = C.UnitFrame.Raid.Width or 96

            castbar:ClearAllPoints()
            castbar:SetSize(raidWidth * 5 + 8 * (5 - 1) - (24 + spacing), 24)
            castbar:SetPoint("BOTTOM", UIParent, "BOTTOM", -(24 + spacing) / 2, 140)

            castbar.Icon:ClearAllPoints()
            castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
            castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)
        elseif unit == "player" and not IsCaster() then
            castbar:ClearAllPoints()
            castbar:SetSize(self:GetWidth() - size - spacing, size)
            castbar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -spacing)

            castbar.Icon:ClearAllPoints()
            castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
            castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)
        elseif unit == "target" or unit == "focus" then
            castbar:ClearAllPoints()
            castbar:SetSize(self:GetWidth() - size - spacing, size)
            castbar:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -spacing)

            castbar.Icon:ClearAllPoints()
            castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
            castbar.Icon:SetPoint("RIGHT", castbar, "LEFT", -spacing, 0)
        else
            castbar:ClearAllPoints()
            castbar:SetSize(self:GetWidth() - size - size * 3 - spacing * 2, size)
            castbar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", size * 3 + spacing, spacing)

            castbar.Icon:ClearAllPoints()
            castbar.Icon:SetSize(castbar:GetHeight(), castbar:GetHeight())
            castbar.Icon:SetPoint("LEFT", castbar, "RIGHT", spacing, 0)
        end
    end

    local function OnPlayerTalentUpdate(_, event, ...)
        SetAnchor(self, ...)
    end

    local function OnPlayerEnteringWorld(_, event, ...)
        SetAnchor(self, ...)
    end

    local EventHandler = S.CreateEventHandler()
    EventHandler.Event.PLAYER_TALENT_UPDATE = OnPlayerTalentUpdate
    EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
    EventHandler.Register()

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

-- Portrait
S.UnitFrame.CreatePortrait = function(self, unit, ...)
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

    local function OnEnter(self, event, ...)
        UnitFrame_OnEnter(self)

        if not UnitAffectingCombat("player") then
            PortraitFadeOut(self, ...)
        end
    end

    local function OnLeave(self, event, ...)
        UnitFrame_OnLeave(self)

        if not UnitAffectingCombat("player") then
            PortraitFadeIn(self, ...)
        end
    end

    self:SetScript("OnEnter", OnEnter)
    self:SetScript("OnLeave", OnLeave)

    local function OnPlayerRegenEnabled(handler, event, ...)
        PortraitFadeIn(self, ...)
    end

    local function OnPlayerRegenDisabled(handler, event, ...)
        PortraitFadeOut(self, ...)
    end

    local EventHandler = S.CreateEventHandler()
    EventHandler.Event.PLAYER_REGEN_ENABLED = OnPlayerRegenEnabled
    EventHandler.Event.PLAYER_REGEN_DISABLED = OnPlayerRegenDisabled
    EventHandler.Register()

    self.Portrait = portrait
end

-- QuickMark
local function HasMarkRight()
    local inSolo = not IsInGroup()
    local inParty = IsInGroup() and not IsInRaid()
    local isGroupLeader = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")

    return inSolo or inParty or isGroupLeader
end

S.UnitFrame.CreateQuickMark = function(self, unit, ...)
    local function getText(r, g, b, i)
        return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255) ..
            _G["RAID_TARGET_" .. i] .. " " .. ICON_LIST[i] .. "12|t"
    end

    local menu = S.CreateEasyMenu()
    menu.NewLine(RAID_TARGET_NONE, SetRaidTarget, {unit, 0})
    menu.NewLine(getText(1.00, 0.92, 0.00, 1), SetRaidTarget, {unit, 1})
    menu.NewLine(getText(0.98, 0.57, 0.00, 2), SetRaidTarget, {unit, 2})
    menu.NewLine(getText(0.83, 0.22, 0.90, 3), SetRaidTarget, {unit, 3})
    menu.NewLine(getText(0.04, 0.95, 0.00, 4), SetRaidTarget, {unit, 4})
    menu.NewLine(getText(0.70, 0.82, 0.88, 5), SetRaidTarget, {unit, 5})
    menu.NewLine(getText(0.00, 0.71, 1.00, 6), SetRaidTarget, {unit, 6})
    menu.NewLine(getText(1.00, 0.24, 0.17, 7), SetRaidTarget, {unit, 7})
    menu.NewLine(getText(0.98, 0.98, 0.98, 8), SetRaidTarget, {unit, 8})

    local function OnDoubleClick(self, btn, ...)
        if btn == "LeftButton" and HasMarkRight() and UnitExists(unit) then
            local ricon = GetRaidTargetIndex(unit)

            for i = 1, 8 do
                if ricon == i then
                    menu.Set(i + 1, "checked", true)
                else
                    menu.Set(i + 1, "checked", false)
                end
            end

            menu.Show()
        end
    end

    self:HookScript("OnDoubleClick", OnDoubleClick)
end

-- ClassPowers
S.UnitFrame.CreateClassPowers = function(self, unit, ...)
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
    local function PostUpdate(powers, cur, max, hasMaxChanged, powerType)
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
S.UnitFrame.CreateRaidRoleIndicator = function(self, unit, ...)
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
S.UnitFrame.CreateGroupRoleIndicator = function(self, unit, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(12, 12)
    indicator:SetPoint("CENTER", anchor, "TOPRIGHT", 0, 0)
    self.GroupRoleIndicator = indicator
end

-- RaidTargetIndicator
S.UnitFrame.CreateRaidTargetIndicator = function(self, unit, ...)
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
