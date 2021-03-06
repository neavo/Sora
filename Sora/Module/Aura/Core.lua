﻿-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auras = {}
local size, space, postion = nil, nil, nil

-- Common
local function DoSkin(aura)
    aura.count:SetShadowColor(0.00, 0.00, 0.00, 1.00)
    aura.count:SetShadowOffset(1.00, -1.00)

    aura.duration:SetShadowColor(0.00, 0.00, 0.00, 1.00)
    aura.duration:SetShadowOffset(1.00, -1.00)
end

local function CreateAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraAura")
    anchor:Hide()
    anchor:SetText("状态")
    anchor:SetSize(size * 12 + space * 11, size * 5 + space * 4)
    anchor:SetPoint(unpack(postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.Aura.Mover and C.Config.Aura.Mover.SoraAura then
        anchor:SetScript("OnDragStop", C.Config.Aura.Mover.SoraAura.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.Aura.Mover.SoraAura.OnDragStart)

        C.Config.Aura.Mover.SoraAura.anchor = anchor
    end
end

-- Hook
local function HookAuraButtonUpdateDuration(self, timeLeft, ...)
    if not timeLeft then
        return 0
    end

    if timeLeft < BUFF_DURATION_WARNING_TIME then
        self.duration:SetTextColor(1.00, 0.00, 0.00)
    else
        self.duration:SetTextColor(1.00, 0.84, 0.00)
    end
end

local function HookDebuffButtonUpdateAnchors(name, index, ...)
    table.wipe(auras)

    for i = 1, DEBUFF_MAX_DISPLAY do
        local aura = _G["DebuffButton" .. i]

        if not aura then
            break
        end

        table.insert(auras, aura)
    end

    for k, v in pairs(auras) do
        if not v.__skined then
            DoSkin(v)
            v.__skined = true
        end

        v:ClearAllPoints()
        v:SetSize(size, size)

        if k == 1 then
            v:SetPoint("TOPRIGHT", SoraAura, "TOPRIGHT", 0, -(size * 3 + space * 3))
        elseif mod(k, 12) == 1 then
            v:SetPoint("TOP", auras[k - 12], "BOTTOM", 0, -space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -space, 0)
        end
    end
end

local function HookBuffFrameUpdateAllBuffAnchors(self, ...)
    table.wipe(auras)

    for i = 1, BuffFrame.numEnchants do
        local aura = _G["TempEnchant" .. i]

        if not aura then
            break
        end

        table.insert(auras, aura)
    end

    for i = 1, BUFF_MAX_DISPLAY do
        local aura = _G["BuffButton" .. i]

        if not aura then
            break
        end

        table.insert(auras, aura)
    end

    for k, v in pairs(auras) do
        if not v.__skined then
            DoSkin(v)
            v.__skined = true
        end

        v:ClearAllPoints()
        v:SetSize(size, size)

        if k == 1 then
            v:SetPoint("TOPRIGHT", SoraAura, "TOPRIGHT", 0, 0)
        elseif mod(k, 12) == 1 then
            v:SetPoint("TOP", auras[k - 12], "BOTTOM", 0, -space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -space, 0)
        end
    end
end

-- Event
local function OnInitialize()
    size, space, postion = C.Aura.Size, C.Aura.Space, C.Aura.Postion
end

local function OnPlayerLogin(self, event, ...)
    OnInitialize()
    CreateAnchor()

    hooksecurefunc("AuraButton_UpdateDuration", HookAuraButtonUpdateDuration)
    hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButtonUpdateAnchors)
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", HookBuffFrameUpdateAllBuffAnchors)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
