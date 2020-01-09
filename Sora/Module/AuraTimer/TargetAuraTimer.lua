-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auras = {}
local anchor = nil
local iconSize, barWidth = nil, nil
local whitelist, blacklist = nil, nil

-- Begin
local function OnEnter(self)
    if not self:IsVisible() then
        return
    end

    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:SetUnitAura(unpack(self.tooltipData))
end

local function OnLeave(self)
    GameTooltip:Hide()
end

local function OnAuraUpdate(self, elapsed, ...)
    if not self:IsVisible() then
        self:SetScript("OnUpdate", nil)
    else
        local timeLeft = self.expiration - GetTime()

        if timeLeft <= 0 then
            self.bar:SetValue(1)
            self.timeText:SetText("N/A")
        else
            self.bar:SetValue(timeLeft)
            self.timeText:SetText(string.format("%.1f", timeLeft))
        end
    end
end

local function DoFilter(duration, caster, spellID)
    local inwhite, inblack = false, false

    for k, v in pairs(whitelist) do
        if v == spellID then
            inwhite = true
            break
        end
    end

    for k, v in pairs(blacklist) do
        if v == spellID then
            inblack = true
            break
        end
    end

    return not inblack and caster == "player" and (inwhite or (duration > 0 and duration <= 60))
end

local function UpdateAuras(unit)
    local data, datas = nil, {}

    for k, v in pairs({"HELPFUL", "HARMFUL"}) do
        for i = 1, 40 do
            local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

            if spellID and DoFilter(duration, caster, spellID) then
                data = {}
                data.name = name
                data.count = count
                data.caster = caster
                data.texture = texture
                data.spellID = spellID
                data.duration = duration
                data.expiration = expiration
                data.tooltipData = {unit, i, v}

                table.insert(datas, data)
            end
        end
    end

    for k, v in pairs(auras) do
        data = datas[k]

        if not data then
            v:Hide()
        else
            v.tooltipData = data.tooltipData

            v:Show()
            v.bar:SetMinMaxValues(0, data.duration > 0 and data.duration or 1)
            v.icon:SetTexture(data.texture)
            v.count:SetText(data.count > 1 and data.count or nil)
            v.nameText:SetText(data.name)

            v.expiration = data.expiration
            v:SetScript("OnUpdate", OnAuraUpdate)
        end
    end
end

local function CreateAuras()
    local _, class = UnitClass("player")

    for i = 1, 8 * 8 do
        local aura = CreateFrame("Frame", nil, anchor)
        aura:Hide()
        aura:SetSize(iconSize, iconSize)

        aura.icon = aura:CreateTexture(nil, "ARTWORK")
        aura.icon:SetAllPoints()
        aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        aura.count = S.MakeText(aura, 9)
        aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 1, -1)

        aura.bar = CreateFrame("StatusBar", nil, aura)
        aura.bar:SetSize(barWidth, iconSize / 3)
        aura.bar:SetStatusBarTexture(DB.Statusbar)
        aura.bar:SetPoint("BOTTOMLEFT", aura, "BOTTOMRIGHT", 4, 0)
        aura.bar:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

        aura.bar.bg = aura.bar:CreateTexture(nil, "BACKGROUND")
        aura.bar.bg:SetTexture(DB.Statusbar)
        aura.bar.bg:SetAllPoints()
        aura.bar.bg:SetVertexColor(0.12, 0.12, 0.12)

        aura.timeText = S.MakeText(aura.bar, 10)
        aura.timeText:SetPoint("RIGHT", 0, 6)

        aura.nameText = S.MakeText(aura.bar, 10)
        aura.nameText:SetPoint("CENTER", -10, 6)

        aura.shadow = S.MakeShadow(aura, 2)
        aura.shadow:SetFrameLevel(aura:GetFrameLevel())

        aura.bar.shadow = S.MakeShadow(aura.bar, 2)
        aura.bar.shadow:SetFrameLevel(aura.bar:GetFrameLevel())

        if i == 1 then
            aura:SetPoint("BOTTOMLEFT")
        else
            aura:SetPoint("BOTTOM", auras[i - 1], "TOP", 0, 4)
        end

        aura:SetScript("OnEnter", OnEnter)
        aura:SetScript("OnLeave", OnLeave)

        table.insert(auras, aura)
    end
end

local function OnInitialize(self, event, ...)
    whitelist, blacklist = C.AuraTimer.Target.WhiteList, C.AuraTimer.Target.BlackList
end

local function OnUnitAura(self, event, unit, ...)
    if unit == "target" then
        UpdateAuras("target")
    end
end

local function OnUnitTarget(self, event, unit, ...)
    if unit == "player" then
        UpdateAuras("target")
    end
end

local function OnPlayerLogin(self, event, ...)
    iconSize = (oUF_Sora_Player:GetWidth() - 4 * (8 - 1)) / 8
    barWidth = oUF_Sora_Target:GetWidth() - iconSize - 4

    anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetPoint("BOTTOM", oUF_Sora_Target, "TOP", 0, 12)
    anchor:SetSize(oUF_Sora_Target:GetWidth(), iconSize * 8 + 4 * (8 - 1))

    CreateAuras()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.UNIT_AURA = OnUnitAura
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.UNIT_TARGET = OnUnitTarget
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
