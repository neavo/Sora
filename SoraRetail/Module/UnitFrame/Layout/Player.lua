-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
-- TODO

-- Begin
local function PortraitFadeIn(self, ...)
    UIFrameFadeIn(self.Portrait, 0.50, 0.00, 0.30)
    UIFrameFadeOut(self.nameTag, 0.50, 1.00, 0.00)
    UIFrameFadeOut(self.powerTag, 0.50, 1.00, 0.00)
    UIFrameFadeOut(self.healthTag, 0.50, 1.00, 0.00)
end

local function PortraitFadeOut(self, ...)
    UIFrameFadeIn(self.nameTag, 0.50, 0.00, 1.00)
    UIFrameFadeIn(self.healthTag, 0.50, 0.00, 1.00)
    UIFrameFadeIn(self.powerTag, 0.50, 0.00, 1.00)
    UIFrameFadeOut(self.Portrait, 0.50, 0.30, 0.00)
end

local function SetPower(self, ...)
    local power = CreateFrame("StatusBar", nil, self)
    power:SetPoint("BOTTOM")
    power:SetSize(self:GetWidth(), 4)
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

local function SetHealth(self, ...)
    local health = CreateFrame("StatusBar", nil, self)
    health:SetPoint("TOP")
    health:SetStatusBarTexture(DB.Statusbar)
    health:SetSize(self:GetWidth(), self:GetHeight() - 8)
    
    health.bg = health:CreateTexture(nil, "BACKGROUND")
    health.bg:SetAllPoints()
    health.bg:SetTexture(DB.Statusbar)
    health.bg:SetVertexColor(0.12, 0.12, 0.12)
    health.bg.multiplier = 0.12
    
    health.Smooth = true
    health.colorTapping = true
    health.colorDisconnected = true
    health.colorClass = true
    health.colorClassNPC = true
    health.colorClassPet = true
    health.colorReaction = true
    health.colorHealth = true
    health.colorSmooth = true
    health.frequentUpdates = true
    health.shadow = S.MakeShadow(health, 2)
    
    self.Health = health
end

local function SetTag(self, ...)
    local nameTag = S.MakeText(self.Health, 12)
    nameTag:SetAlpha(0.00)
    nameTag:SetPoint("LEFT", 4, 0)
    
    local powerTag = S.MakeText(self.Power, 10)
    powerTag:SetAlpha(0.00)
    powerTag:SetPoint("RIGHT", -4, 0)
    
    local healthTag = S.MakeText(self.Health, 12)
    healthTag:SetAlpha(0.00)
    healthTag:SetPoint("RIGHT", -4, 0)
    
    self.nameTag = nameTag
    self:Tag(self.nameTag, "[Sora:Level][Sora:Rare][Sora:Color][name]|r")
    
    self.powerTag = powerTag
    self:Tag(self.powerTag, "[Sora:Power] | [Sora:PerPower]")
    
    self.healthTag = healthTag
    self:Tag(self.healthTag, "[Sora:Color][Sora:Health]|r | [Sora:Color][Sora:PerHealth]|r")
end

local function SetDebuffs(self, ...)
    local spacing = 4
    local size = (self:GetWidth() - 4 * 8) / 9
    
    local debuffs = CreateFrame("Frame", nil, self)
    debuffs:SetSize(self:GetWidth(), size * 2 + spacing)
    debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -spacing)
    
    debuffs.num = 18
    debuffs.size = size
    debuffs.spacing = spacing
    debuffs["growth-y"] = "DOWN"
    debuffs["growth-x"] = "RIGHT"
    debuffs.disableCooldown = false
    debuffs.initialAnchor = "TOPLEFT"
    
    debuffs.PostCreateIcon = function(self, icon, ...)
        if not icon._isProcessed then
            icon.shadow = S.MakeShadow(icon, 2)
            
            icon.icon:SetAllPoints()
            icon.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            
            icon.count = S.MakeText(icon, 10)
            icon.count:SetPoint("BOTTOMRIGHT", 3, 0)
            
            icon._isProcessed = true
        end
    end
    
    self.Debuffs = debuffs
end

local function SetCastbar(self, ...)
    local space = 4
    local barHeight = (self:GetWidth() - 4 * 8) / 9
    
    local bar = CreateFrame("StatusBar", nil, self)
    bar:SetFrameStrata("HIGH")
    bar:SetStatusBarTexture(DB.Statusbar)
    bar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -space)
    bar:SetSize(self:GetWidth() - barHeight - space, barHeight)
    
    bar.shadow = S.MakeShadow(bar, 2)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetTexture(DB.Statusbar)
    bar.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)
    
    bar.Text = S.MakeText(bar, 10)
    bar.Text:SetPoint("LEFT", 2, 0)
    
    bar.Time = S.MakeText(bar, 10)
    bar.Time:SetPoint("RIGHT", -2, 0)
    
    bar.Icon = bar:CreateTexture(nil, "ARTWORK")
    bar.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    bar.Icon:SetPoint("LEFT", bar, "RIGHT", space, 0)
    bar.Icon:SetSize(bar:GetHeight(), bar:GetHeight())
    bar.Icon.Shadow = S.MakeTextureShadow(bar, bar.Icon, 2)
    
    bar.SafeZone = bar:CreateTexture(nil, "BORDER")
    bar.SafeZone:SetAlpha(0.25)
    
    local updater = CreateFrame("Frame", nil, UIParent)
    updater.timer = 0
    updater.fading = false
    
    bar.CustomTimeText = function(self, duration)
        self.Time:SetText(("%.1f / %.1f"):format(duration, self.max))
    end
    
    bar.PostCastStart = function(self, unit, name, castid, spellid)
        if updater.fading then
            updater.fading = false
            updater:SetScript("OnUpdate", nil)
        end
        
        if self.notInterruptible then
            self:SetStatusBarColor(1.00, 0.50, 0.50)
        else
            self:SetStatusBarColor(0.37, 0.71, 1.00)
        end
        
        self:Show()
        self:SetAlpha(1.00)
    end
    
    bar.PostCastFailed = function(self, unit, spellname, castid, spellid)
        if updater.fading then
            updater.fading = false
            updater:SetScript("OnUpdate", nil)
        end
        
        self:Show()
        self:SetAlpha(1.00)
        self:SetStatusBarColor(1.00, 0.05, 0.00)
        
        updater.timer = 0.00
        updater:SetScript("OnUpdate", function(_self, elasped, ...)
            updater.fading = true
            updater.timer = updater.timer + elasped
            
            if updater.timer > 0.50 then
                updater.fading = false
                updater:SetScript("OnUpdate", nil)
            else
                self:Show()
                self:SetAlpha(1.00 * (1 - updater.timer / 0.50))
            end
        end)
    end
    
    bar.CustomDelayText = bar.CustomTimeText
    bar.PostChannelStart = bar.PostCastStart
    bar.PostCastInterrupted = bar.PostCastFailed
    
    self.Castbar = bar
end

local function SetPortrait(self, ...)
    local portrait = CreateFrame("PlayerModel", nil, self)
    portrait:SetAlpha(0.30)
    portrait:SetAllPoints(self.Health)
    portrait:SetFrameLevel(self.Health:GetFrameLevel() + 1)
    
    self.Portrait = portrait
end

local function SetClassPower(self, ...)
    local _, class = UnitClass("player") 

    if class == "DEATHKNIGHT" then
       local runes = {}
        
        for i = 1, 6 do
            local rune = CreateFrame("StatusBar", nil, self)
            rune:SetStatusBarTexture(DB.Statusbar)
            rune:SetSize((self:GetWidth() - 20) / 6, 4)

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
        
        self.Runes = runes
    elseif class == "SHAMAN" then
        
    else
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
        
        powers.PostUpdate = function(element, cur, max, hasMaxChanged, powerType)
            if (max and max > 0) and hasMaxChanged then
                for i = max, 8 do
                    powers[i]:ClearAllPoints()
                end
                
                for i = 1, max do
                    if i == 1 then
                        powers[i]:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 4)
                    else
                        powers[i]:SetPoint("LEFT", powers[i - 1], "RIGHT", 4, 0)
                    end
                    
                    powers[i]:SetSize((self:GetWidth() - (max - 1) * 4) / max, 4)
                end
            end
        end
        
        self.ClassPower = powers
    end
end

local function SetAlternativePower(self, ...)
    PlayerPowerBarAlt:SetMovable(true)
    PlayerPowerBarAlt:SetUserPlaced(true)
    PlayerPowerBarAlt:SetFrameStrata("HIGH")
        
    PlayerPowerBarAlt:SetScript("OnMouseDown", function(self, button, ...)
        self:StartMoving()
    end)
    
    PlayerPowerBarAlt:SetScript("OnMouseUp", function(self, button, ...)
        self:StopMovingOrSizing()
    end)
end

local function SetLeaderIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints(self.Portrait)
    anchor:SetFrameLevel(self.Portrait:GetFrameLevel() + 1)
    
    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(16, 16)
    indicator:SetPoint("CENTER", anchor, "TOPLEFT", 0, 1)
    
    self.LeaderIndicator = indicator
end

local function SetAssistantIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints(self.Portrait)
    anchor:SetFrameLevel(self.Portrait:GetFrameLevel() + 1)
    
    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(16, 16)
    indicator:SetPoint("CENTER", anchor, "TOPLEFT", 0, 1)
    
    self.AssistantIndicator = indicator
end

local function SetRaidTargetIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints(self.Portrait)
    anchor:SetFrameLevel(self.Portrait:GetFrameLevel() + 1)
    
    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(16, 16)
    indicator:SetPoint("CENTER", anchor, "TOP", 0, 0)
    
    self.RaidTargetIndicator = indicator
end

local function RegisterForEvent(self, ...)
    self:SetScript("OnLeave", function(self, event, ...)
        UnitFrame_OnLeave(self)
        
        if not UnitAffectingCombat("player") then
            PortraitFadeIn(self, ...)
        end
    end)
    
    self:SetScript("OnEnter", function(self, event, ...)
        UnitFrame_OnEnter(self)
        
        if not UnitAffectingCombat("player") then
            PortraitFadeOut(self, ...)
        end
    end)
    
    self.event = CreateFrame("Frame", nil, UIParent)
    self.event:RegisterEvent("PLAYER_REGEN_ENABLED")
    self.event:RegisterEvent("PLAYER_REGEN_DISABLED")
    self.event:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_REGEN_ENABLED" then
            PortraitFadeIn(self, ...)
        elseif event == "PLAYER_REGEN_DISABLED" then
            PortraitFadeOut(self, ...)
        end
    end)
end

local function RegisterForClicks(self, ...)
    self:RegisterForClicks("AnyUp")
end

local function RegisterStyle(self, ...)
    self:SetPoint(unpack(C.UnitFrame.Player.Postion))
    self:SetSize(C.UnitFrame.Player.Width, C.UnitFrame.Player.Height)
    
    SetPower(self, ...)
    SetHealth(self, ...)
    
    SetTag(self, ...)
    SetDebuffs(self, ...)
    SetCastbar(self, ...)
    SetPortrait(self, ...)
    SetClassPower(self, ...)
    SetAlternativePower(self, ...)
    
    SetLeaderIndicator(self, ...)
    SetAssistantIndicator(self, ...)
    SetRaidTargetIndicator(self, ...)
    
    RegisterForEvent(self, ...)
    RegisterForClicks(self, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_Player", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Player")
    
    local oUFFrame = oUF:Spawn("player", "oUF_Sora_Player")
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
