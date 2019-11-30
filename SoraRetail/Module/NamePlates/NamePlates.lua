-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
S.NamePlates = {}
local width, height = C.NamePlates.Width, C.NamePlates.Height

-- Power
S.NamePlates.CreatePower = function(self, unit, ...)
    local width, height = C.NamePlates.Width, C.NamePlates.Height

    local power = CreateFrame("StatusBar", nil, self)
    power:SetPoint("BOTTOM")
    power:SetSize(width, 2)
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
    local width, height = C.NamePlates.Width, C.NamePlates.Height

    local health = CreateFrame("StatusBar", nil, self)
    health:SetPoint("TOP")
    health:SetSize(width, height - 4)
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
    local rareTag = S.MakeText(self.Health, 9)
    rareTag:SetPoint("RIGHT", self, "LEFT", -2, 0)
    self:Tag(rareTag, "[NamePlates:Rare]")

    local nameTag = S.MakeText(self.Health, 10)
    nameTag:SetPoint("BOTTOM", self, "TOP", 0, 4)
    self:Tag(nameTag, "[NamePlates:Level][NamePlates:Color][NamePlates:Name]|r")
end

-- Auras
S.NamePlates.CreateAuras = function(self, unit, ...)
    local num, spacing = 6, 4
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
    auras.onlyShowPlayer = false
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

-- ThreatIndicator
-- TODO : Verify
local OnThreatIndicatorEvent = function(self, unit, ...)
    self:SetStatusBarColor(r, g, b)
end

S.NamePlates.CreateThreatIndicator = function(self, unit, ...)
    local status, r, g, b = nil, nil, nil, nil

    local threatIndicator = CreateFrame("StatusBar", nil, self)
    threatIndicator:Hide()
    threatIndicator:SetPoint("BOTTOM")
    threatIndicator:SetSize(height, height)
    threatIndicator:SetStatusBarTexture(DB.Statusbar)
    threatIndicator:SetPoint("LEFT", self, "RIGHT", 4, 0)

    threatIndicator.bg = threatIndicator:CreateTexture(nil, "BACKGROUND")
    threatIndicator.bg:SetTexture(DB.Statusbar)
    threatIndicator.bg:SetAllPoints()
    threatIndicator.bg:SetVertexColor(0.12, 0.12, 0.12)
    threatIndicator.bg.multiplier = 0.12
    threatIndicator.shadow = S.MakeShadow(threatIndicator, 1)

    threatIndicator:RegisterEvent("PLAYER_TARGET_CHANGED")
    threatIndicator:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
    threatIndicator:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    threatIndicator:SetScript(
        "OnEvent",
        function(self, event, ...)
            if not UnitAffectingCombat("player") then
                self:Hide()
            else
                status = UnitThreatSituation("player", unit)
                r, g, b = GetThreatStatusColor(status)

                self:Show()
                self:SetStatusBarColor(r, g, b)
            end
        end
    )
end

-- Begin
local function RegisterStyle(self, unit, ...)
    -- ugly hack to fix frame scale
    self:SetScale(2 / 3)

    self:SetSize(width, height)
    self:SetPoint("BOTTOM", C_NamePlate.GetNamePlateForUnit(unit), "BOTTOM", 0, 0)

    S.NamePlates.CreatePower(self, unit, ...)
    S.NamePlates.CreateHealth(self, unit, ...)

    S.NamePlates.CreateTag(self, unit, ...)
    S.NamePlates.CreateAuras(self, unit, ...)
    S.NamePlates.CreateCastbar(self, unit, ...)
    S.NamePlates.CreateThreatIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_NamePlates", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_NamePlates")
    oUF:SpawnNamePlates("oUF_Sora_NamePlates")
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript(
    "OnEvent",
    function(self, event, ...)
        if event == "PLAYER_LOGIN" then
            OnPlayerLogin(self, event, ...)
        end
    end
)
