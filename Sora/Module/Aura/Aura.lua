-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local perRow, maxRow = 12, 3
local BuffAnchor, DebuffAnchor = nil, nil
local size, spacing, postion = nil, nil, nil

-- Begin
local HookAuraButtonUpdateDuration = function(self, timeLeft, ...)
    if timeLeft then
        if timeLeft < BUFF_DURATION_WARNING_TIME then
            self.duration:SetTextColor(1.00, 0.00, 0.00)
        else
            self.duration:SetTextColor(0.96, 0.82, 0.10)
        end
    end
end

local HookDebuffButtonUpdateAnchors = function(name, index, ...)
    for i = 1, DEBUFF_MAX_DISPLAY do
        local aura = _G["DebuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", DebuffAnchor, 0, 0)
        elseif mod(i, 8) == 1 then
            aura:SetPoint("TOP", _G["DebuffButton" .. (i - perRow)], "BOTTOM", 0, -spacing)
        else
            aura:SetPoint("RIGHT", _G["DebuffButton" .. (i - 1)], "LEFT", -spacing, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

local HookBuffFrameUpdateAllBuffAnchors = function(self, ...)
    for i = 1, BUFF_MAX_DISPLAY do
        local aura = _G["BuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", BuffAnchor, 0, 0)
        elseif mod(i, perRow) == 1 then
            aura:SetPoint("TOP", _G["BuffButton" .. (i - perRow)], "BOTTOM", 0, -spacing)
        else
            aura:SetPoint("RIGHT", _G["BuffButton" .. (i - 1)], "LEFT", -spacing, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

local OnPlayerLogin = function(self, event, ...)
    size, spacing, postion = C.Aura.Size, C.Aura.Spacing, C.Aura.Postion

    BuffAnchor = CreateFrame("Frame", nil, UIParent)
    BuffAnchor:SetPoint(unpack(postion))
    BuffAnchor:SetSize(size * perRow + spacing * (perRow - 1), size * maxRow + spacing * (maxRow - 1))

    DebuffAnchor = CreateFrame("Frame", nil, UIParent)
    DebuffAnchor:SetSize(size * perRow + spacing * (perRow - 1), size * maxRow + spacing * (maxRow - 1))
    DebuffAnchor:SetPoint("TOPRIGHT", BuffAnchor, "BOTTOMRIGHT", 0, -spacing)

    hooksecurefunc("AuraButton_UpdateDuration", HookAuraButtonUpdateDuration)
    hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButtonUpdateAnchors)
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", HookBuffFrameUpdateAllBuffAnchors)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
