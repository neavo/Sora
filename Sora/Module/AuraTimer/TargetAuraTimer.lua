-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auras = {}
local anchor = nil
local spacing, iconSize, barWidth, maxLines = 4, nil, nil, 8
local whitelist = C.AuraTimer.WhiteList.Target

-- Begin
local OnEnter = function(self)
    if not self:IsVisible() then
        return
    end

    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:SetUnitAura(unpack(self.tooltipData))
end

local OnLeave = function(self)
    GameTooltip:Hide()
end

local OnAuraUpdate = function(self, elapsed, ...)
    if not self:IsVisible() then
        self:SetScript("OnUpdate", nil)
    else
        local timeLeft = self.expiration - GetTime()

        self.bar:SetValue(timeLeft)
        self.timeText:SetText(("%.1f"):format(timeLeft))
    end
end

local UpdateAuras = function(unit)
    local data, datas = nil, {}

    for k, v in pairs({"HELPFUL", "HARMFUL"}) do
        for i = 1, 40 do
            local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

            if caster == "player" and ((duration > 0 and duration < 60) or whitelist[spellID]) then
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
            v.bar:SetMinMaxValues(0, data.duration)
            v.icon:SetTexture(data.texture)
            v.count:SetText(data.count > 1 and data.count or nil)
            v.nameText:SetText(data.name)

            v.expiration = data.expiration
            v:SetScript("OnUpdate", OnAuraUpdate)
        end
    end
end

local CreateAuras = function()
    local _, class = UnitClass("player")

    for i = 1, 8 * maxLines do
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
        aura.bar:SetPoint("BOTTOMLEFT", aura, "BOTTOMRIGHT", spacing, 0)
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
            aura:SetPoint("BOTTOM", auras[i - 1], "TOP", 0, spacing)
        end

        aura:SetScript("OnEnter", OnEnter)
        aura:SetScript("OnLeave", OnLeave)

        table.insert(auras, aura)
    end
end

local OnUnitAura = function(self, event, unit, ...)
    if unit == "target" then
        UpdateAuras("target")
    end
end

local OnUnitTarget = function(self, event, unit, ...)
    if unit == "player" then
        UpdateAuras("target")
    end
end

local OnPlayerLogin = function(self, event, ...)
    iconSize = (oUF_Sora_Player:GetWidth() - spacing * (8 - 1)) / 8
    barWidth = oUF_Sora_Target:GetWidth() - iconSize - spacing

    anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetPoint("BOTTOM", oUF_Sora_Target, "TOP", 0, 12)
    anchor:SetSize(oUF_Sora_Target:GetWidth(), iconSize * maxLines + spacing * (maxLines - 1))

    CreateAuras()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.UNIT_AURA = OnUnitAura
EventHandler.Event.UNIT_TARGET = OnUnitTarget
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
