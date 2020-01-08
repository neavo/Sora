-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local size, space, postion = nil, nil, nil

-- Common
local function Initialize()
    size, space, postion = C.Aura.Size, C.Aura.Space, C.Aura.Postion
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
    if timeLeft then
        if timeLeft < BUFF_DURATION_WARNING_TIME then
            self.duration:SetTextColor(1.00, 0.00, 0.00)
        else
            self.duration:SetTextColor(0.96, 0.82, 0.10)
        end
    end
end

local function HookDebuffButtonUpdateAnchors(name, index, ...)
    local anchor = SoraAura

    for i = 1, DEBUFF_MAX_DISPLAY do
        local aura = _G["DebuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", 0, -(size * 3 + space * 3))
        elseif mod(i, 12) == 1 then
            aura:SetPoint("TOP", _G["DebuffButton" .. (i - 12)], "BOTTOM", 0, -space)
        else
            aura:SetPoint("RIGHT", _G["DebuffButton" .. (i - 1)], "LEFT", -space, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

local function HookBuffFrameUpdateAllBuffAnchors(self, ...)
    local anchor = SoraAura

    for i = 1, BUFF_MAX_DISPLAY do
        local aura = _G["BuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", 0, 0)
        elseif mod(i, 12) == 1 then
            aura:SetPoint("TOP", _G["BuffButton" .. (i - 12)], "BOTTOM", 0, -space)
        else
            aura:SetPoint("RIGHT", _G["BuffButton" .. (i - 1)], "LEFT", -space, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

-- Event
local function OnPlayerLogin(self, event, ...)
    Initialize()
    CreateAnchor()

    hooksecurefunc("AuraButton_UpdateDuration", HookAuraButtonUpdateDuration)
    hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButtonUpdateAnchors)
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", HookBuffFrameUpdateAllBuffAnchors)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
