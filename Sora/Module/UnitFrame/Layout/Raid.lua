-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local width, height = nil, nil
local raidAuras, indicatorFilters = nil, nil

-- Common
local function IsHealer()
    return select(5, GetSpecializationInfo(GetSpecialization())) == "HEALER"
end

-- Anchor
local function UpdateAnchor(self, ...)
    if not oUF_Sora_Raid or InCombatLockdown() then
        return 0
    end

    if oUF_Sora_Raid:GetNumPoints() > 0 then
        oUF_Sora_Raid:ClearAllPoints()
    end

    if IsHealer() then
        oUF_Sora_Raid:SetPoint("TOPLEFT", SoraUFRaidHealer)
    else
        oUF_Sora_Raid:SetPoint("TOPLEFT", SoraUFRaidDefault)
    end
end

local function CreateHealerAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraUFRaidHealer")
    anchor:Hide()
    anchor:SetText("单位框体 - 团队 - 治疗模式")
    anchor:SetSize(C.UnitFrame.Raid.Width * 5 + 8 * 4, C.UnitFrame.Raid.Height * 6 + 8 * 5)
    anchor:SetPoint(unpack(C.UnitFrame.Raid.HealerPostion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.UnitFrame.Mover and C.Config.UnitFrame.Mover[anchor:GetName()] then
        anchor:SetScript("OnDragStop", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStart)

        C.Config.UnitFrame.Mover[anchor:GetName()].anchor = anchor
    end
end

local function CreateDefaultAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraUFRaidDefault")
    anchor:Hide()
    anchor:SetText("单位框体 - 团队 - 默认模式")
    anchor:SetSize(C.UnitFrame.Raid.Width * 5 + 8 * 4, C.UnitFrame.Raid.Height * 6 + 8 * 5)
    anchor:SetPoint(unpack(C.UnitFrame.Raid.DefaultPostion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.UnitFrame.Mover and C.Config.UnitFrame.Mover[anchor:GetName()] then
        anchor:SetScript("OnDragStop", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.UnitFrame.Mover[anchor:GetName()].OnDragStart)

        C.Config.UnitFrame.Mover[anchor:GetName()].anchor = anchor
    end
end

-- RaidDebuff
local function UpdateRaidDebuff(self, event, unit, ...)
    local data = nil

    for k, v in pairs({"HELPFUL", "HARMFUL"}) do
        for i = 1, 40 do
            local name, texture, count, _, duration, expiration, _, _, _, spellID = UnitAura(unit, i, v)

            if not spellID then
                break
            end

            local priority = raidAuras[spellID]

            if priority and (not data or priority > data.priority) then
                data = {}
                data.priority = priority
                data.count = count
                data.texture = texture
                data.duration = duration
                data.expiration = expiration
            end
        end
    end

    if not data then
        self.RaidDebuff:Hide()
        self.NameTag:SetAlpha(1.00)
        self.StatusTag:SetAlpha(1.00)
    else
        self.RaidDebuff.icon:SetTexture(data.texture)
        self.RaidDebuff.count:SetText(data.count > 1 and data.count or "")
        self.RaidDebuff.cooldown:SetCooldown(data.expiration - data.duration, data.duration)

        self.RaidDebuff:Show()
        self.NameTag:SetAlpha(0.25)
        self.StatusTag:SetAlpha(0.25)
    end
end

local function CreateRaidDebuff(self, ...)
    local raidDebuff = CreateFrame("Frame", nil, self.Health)
    raidDebuff:Hide()
    raidDebuff:SetSize(20, 20)
    raidDebuff:SetPoint("CENTER", 0, 0)
    raidDebuff:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    raidDebuff.icon = raidDebuff:CreateTexture(nil, "OVERLAY")
    raidDebuff.icon:SetAllPoints()
    raidDebuff.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    raidDebuff.cooldown = CreateFrame("Cooldown", "$parentCooldown", raidDebuff, "CooldownFrameTemplate")
    raidDebuff.cooldown:SetAllPoints()
    raidDebuff.cooldown:SetFrameLevel(self.Health:GetFrameLevel() + 2)

    raidDebuff.border = S.MakeBorder(raidDebuff, 1)
    raidDebuff.border:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    local parent = CreateFrame("Frame", nil, raidDebuff)
    parent:SetAllPoints()
    parent:SetFrameLevel(self.Health:GetFrameLevel() + 3)

    raidDebuff.count = S.MakeText(parent, 7)
    raidDebuff.count:SetPoint("BOTTOMRIGHT", raidDebuff, "BOTTOMRIGHT", 2, -1)

    self.RaidDebuff = raidDebuff
end

-- AuraIndicator
local function OnIndicatorUpdate(self, elapsed, ...)
    self.timer = self.timer or 0.00
    self.timer = self.timer + elapsed

    if self.timer > 0.25 then
        self.timer = 0.00

        if not self:IsVisible() then
            self.timer = nil
            self:SetScript("OnUpdate", nil)
        elseif self.duration > 0 and self.expiration - GetTime() < 3.00 then
            self.icon:SetVertexColor(1.00, 0.00, 0.00)
        else
            self.icon:SetVertexColor(1.00, 1.00, 1.00)
        end
    end
end

local function UpdateAuraIndicator(self, event, unit, ...)
    local data, datas = nil, {}

    for k, v in pairs(self.Indicators) do
        local data = nil
        local indicator = v
        local filter = indicatorFilters[k]

        if not filter then
            return
        end

        for k, v in pairs({"HELPFUL", "HARMFUL"}) do
            for i = 1, 40 do
                local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

                if not spellID then
                    break
                end

                if caster == "player" and spellID == filter then
                    data = {}
                    data.texture = texture
                    data.duration = duration
                    data.expiration = expiration
                end
            end
        end

        if not data then
            indicator:Hide()
        else
            indicator:Show()
            indicator.icon:SetTexture(data.texture)

            indicator.duration = data.duration
            indicator.expiration = data.expiration

            indicator:SetScript("OnUpdate", OnIndicatorUpdate)
        end
    end
end

local function CreateAuraIndicator(self, ...)
    local size = 9
    local indicators = {}

    for i = 1, 12 do
        local indicator = CreateFrame("Frame", nil, self)
        indicator:Hide()
        indicator:SetSize(size, size)

        indicator.icon = indicator:CreateTexture(nil, "OVERLAY")
        indicator.icon:SetAllPoints()
        indicator.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        indicator.border = S.MakeBorder(indicator, 1)
        indicator.border:SetFrameLevel(indicator:GetFrameLevel() + 1)

        if i == 1 then
            indicator:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 1, 1)
        elseif i == 4 then
            indicator:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", -(size * 2 + 2 * 2 + 1), 1)
        elseif i == 7 then
            indicator:SetPoint("TOPLEFT", self.Health, "TOPLEFT", 1, -1)
        elseif i == 10 then
            indicator:SetPoint("TOPRIGHT", self.Health, "TOPRIGHT", -(size * 2 + 2 * 2 + 1), -1)
        else
            indicator:SetPoint("LEFT", indicators[i - 1], "RIGHT", 1, 0)
        end

        indicators[i] = indicator
    end

    self.Indicators = indicators
end

-- ThreatIndicator
local function CreateThreatIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 255)

    local function PostUpdate(indicator, unit, status, r, g, b)
        local alpha = 1.00

        if status and status > 1 then
            alpha = 0.75
        else
            r, g, b = 0.00, 0.00, 0.00
        end

        self.Power.shadow:SetBackdropBorderColor(r, g, b, alpha)
        self.Health.shadow:SetBackdropBorderColor(r, g, b, alpha)
    end

    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator.PostUpdate = PostUpdate

    self.ThreatIndicator = indicator
end

-- ReadyCheckIndicator
local function CreateReadyCheckIndicator(self, ...)
    local anchor = CreateFrame("Frame", nil, self.Health)
    anchor:SetAllPoints()
    anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

    local indicator = anchor:CreateTexture(nil, "ARTWORK")
    indicator:SetSize(16, 16)
    indicator:SetPoint("CENTER", anchor, "CENTER", 0, 0)

    self.ReadyCheckIndicator = indicator
end

-- Begin
local function RegisterStyle(self, unit, ...)
    self.Range = {}
    self.Range.insideAlpha = 1.00
    self.Range.outsideAlpha = 0.40

    local function OnUnitAura(self, event, unit, ...)
        if self.unit ~= unit then
            return
        end

        UpdateRaidDebuff(self, event, unit, ...)
        UpdateAuraIndicator(self, event, unit, ...)
    end

    self:RegisterForClicks("AnyUp")
    self:RegisterEvent("UNIT_AURA", OnUnitAura)
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    S.UnitFrame.CreatePower(self, unit, ...)
    S.UnitFrame.CreateHealth(self, unit, ...)
    S.UnitFrame.CreateHealthPrediction(self, unit, ...)

    S.UnitFrame.CreateTag(self, unit, ...)
    S.UnitFrame.CreateRaidRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateGroupRoleIndicator(self, unit, ...)
    S.UnitFrame.CreateRaidTargetIndicator(self, unit, ...)

    CreateRaidDebuff(self, ...)
    CreateAuraIndicator(self, ...)
    CreateThreatIndicator(self, ...)
    CreateReadyCheckIndicator(self, ...)
end

-- Event
local function OnInitialize(self, event, ...)
    width, height = C.UnitFrame.Raid.Width, C.UnitFrame.Raid.Height
    raidAuras, indicatorFilters = C.UnitFrame.RaidAuras, C.UnitFrame.Raid.IndicatorFilters[S.GetClass()]
end

local function OnPlayerLogin(self, event, ...)
    CreateHealerAnchor()
    CreateDefaultAnchor()

    S.KillFrame(CompactRaidFrameManager)
    S.KillFrame(CompactRaidFrameContainer)

    oUF:RegisterStyle("oUF_Sora_Raid", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Raid")

    local oUFArguments = {}

    do
        table.insert(oUFArguments, "oUF_Sora_Raid")
        table.insert(oUFArguments, "SecureGroupHeaderTemplate")
        table.insert(oUFArguments, "solo,party,raid")
        table.insert(oUFArguments, "point")
        table.insert(oUFArguments, "LEFT")
        table.insert(oUFArguments, "xoffset")
        table.insert(oUFArguments, 8)
        table.insert(oUFArguments, "yoffset")
        table.insert(oUFArguments, -8)
        table.insert(oUFArguments, "maxColumns")
        table.insert(oUFArguments, 6)
        table.insert(oUFArguments, "columnSpacing")
        table.insert(oUFArguments, 8)
        table.insert(oUFArguments, "unitsPerColumn")
        table.insert(oUFArguments, 5)
        table.insert(oUFArguments, "columnAnchorPoint")
        table.insert(oUFArguments, "TOP")
        table.insert(oUFArguments, "showSolo")
        table.insert(oUFArguments, true)
        table.insert(oUFArguments, "showRaid")
        table.insert(oUFArguments, true)
        table.insert(oUFArguments, "showParty")
        table.insert(oUFArguments, true)
        table.insert(oUFArguments, "showPlayer")
        table.insert(oUFArguments, true)
        table.insert(oUFArguments, "groupBy")
        table.insert(oUFArguments, "ASSIGNEDROLE")
        table.insert(oUFArguments, "groupingOrder")
        table.insert(oUFArguments, "TANK,HEALER,DAMAGER,NONE")
        table.insert(oUFArguments, "sortMethod")
        table.insert(oUFArguments, "INDEX")
        table.insert(oUFArguments, "oUF-initialConfigFunction")
        table.insert(oUFArguments, ([[ self:SetWidth(%d) self:SetHeight(%d) ]]):format(width, height))
    end

    oUF:SpawnHeader(unpack(oUFArguments))
end

local function OnPlayerTalentUpdate(self, event, ...)
    UpdateAnchor(self, ...)
end

local function OnPlayerEnteringWorld(self, event, ...)
    UpdateAnchor(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.PLAYER_TALENT_UPDATE = OnPlayerTalentUpdate
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
