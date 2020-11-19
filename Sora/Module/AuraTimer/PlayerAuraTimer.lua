-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auras = {}
local anchor = nil
local iconSize = nil
local whitelist, blacklist = nil, nil

-- Common
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
            v.icon:SetTexture(data.texture)
            v.count:SetText(data.count > 1 and data.count or nil)
            v.cooldown:SetCooldown(data.expiration - data.duration, data.duration)
        end
    end
end

local function CreateAuras()
    for i = 1, 8 * 8 do
        local aura = CreateFrame("Frame", nil, anchor)
        aura:Hide()
        aura:SetSize(iconSize, iconSize)

        aura.cooldown = CreateFrame("Cooldown", nil, aura, "CooldownFrameTemplate")
        aura.cooldown:SetAllPoints()

        aura.icon = aura:CreateTexture(nil, "OVERLAY")
        aura.icon:SetAllPoints()
        aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        aura.shadow = S.MakeShadow(aura, 2)
        aura.shadow:SetFrameLevel(aura:GetFrameLevel())

        local countParent = CreateFrame("Frame", nil, aura)
        countParent:SetAllPoints()
        countParent:SetFrameLevel(aura.cooldown:GetFrameLevel() + 1)

        aura.count = S.MakeText(countParent, 9)
        aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 1, -1)

        if i == 1 then
            aura:SetPoint("BOTTOMLEFT")
        elseif mod(i, 8) == 1 then
            aura:SetPoint("BOTTOM", auras[i - 8], "TOP", 0, 4)
        else
            aura:SetPoint("LEFT", auras[i - 1], "RIGHT", 4, 0)
        end

        aura:SetScript("OnEnter", OnEnter)
        aura:SetScript("OnLeave", OnLeave)

        table.insert(auras, aura)
    end
end

-- Event
local function OnUnitAura(self, event, unit, ...)
    if unit == "player" then
        UpdateAuras("player")
    end
end

local function OnInitialize(self, event, ...)
    whitelist, blacklist = C.AuraTimer.Player.WhiteList, C.AuraTimer.Player.BlackList
end

local function OnPlayerLogin(self, event, ...)
    iconSize = (oUF_Sora_Player:GetWidth() - 4 * (8 - 1)) / 8

    anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetPoint("BOTTOM", oUF_Sora_Player, "TOP", 0, 12)
    anchor:SetSize(oUF_Sora_Player:GetWidth(), iconSize * 8 + 4 * (8 - 1))

    local function OnAfter()
        UpdateAuras("player")
    end

    CreateAuras()
    C_Timer.After(1.00, OnAfter)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.UNIT_AURA = OnUnitAura
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
