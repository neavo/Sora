-- Engine
local S, C, L, DB = unpack(select(2, ...))
local _G, tsort, tinsert = _G, table.sort, tinsert

-- Variables
local BuffAnchor, DebuffAnchor = nil, nil

-- Begin
local function HookAuraButtonUpdateDuration(self, timeLeft, ...)
    if timeLeft then
        if timeLeft < BUFF_DURATION_WARNING_TIME then
            self.duration:SetTextColor(1.00, 0.00, 0.00)
        else
            self.duration:SetTextColor(0.96, 0.82, 0.10)
        end
    end
end

local function HookDebuffButtonUpdateAnchors(buttonName, index, ...)
    local auras = {}
    
    for i = 1, DEBUFF_MAX_DISPLAY do
        local aura = _G["DebuffButton" .. i]
        
        if aura and aura:IsShown() then
            table.insert(auras, aura)
        end
    end
    
    for k, v in pairs(auras) do
        v:ClearAllPoints()
        v:SetSize(C.Aura.Size, C.Aura.Size)
        
        if k == 1 then
            v:SetPoint("TOPRIGHT", DebuffAnchor, 0, 0)
        elseif k % 8 == 1 then
            v:SetPoint("TOP", auras[k - 8], "BOTTOM", 0, -C.Aura.Space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -C.Aura.Space, 0)
        end
    end
end

local function HookBuffFrameUpdateAllBuffAnchors(self, ...)
    local auras = {}
    
    for i = 1, BUFF_MAX_DISPLAY do
        local aura = _G["BuffButton" .. i]
        
        if aura and aura:IsShown() then
            table.insert(auras, aura)
        end
    end
    
    for k, v in pairs(auras) do
        v:ClearAllPoints()
        v:SetSize(C.Aura.Size, C.Aura.Size)
        
        if k == 1 then
            v:SetPoint("TOPRIGHT", BuffAnchor, 0, 0)
        elseif k % 12 == 1 then
            v:SetPoint("TOP", auras[k - 12], "BOTTOM", 0, -C.Aura.Space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -C.Aura.Space, 0)
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    BuffAnchor = CreateFrame("Frame", nil, UIParent)
    BuffAnchor:SetPoint(unpack(C.Aura.Postion))
    BuffAnchor:SetSize(C.Aura.Size * 12 + C.Aura.Size * 11, C.Aura.Size * 3 + C.Aura.Space * 2)
    
    DebuffAnchor = CreateFrame("Frame", nil, UIParent)
    DebuffAnchor:SetSize(C.Aura.Size * 8 + C.Aura.Size * 7, C.Aura.Size * 2 + C.Aura.Space)
    DebuffAnchor:SetPoint("TOPRIGHT", BuffAnchor, "BOTTOMRIGHT", 0, -C.Aura.Space)
    
    hooksecurefunc("AuraButton_UpdateDuration", HookAuraButtonUpdateDuration)
    hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButtonUpdateAnchors)
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", HookBuffFrameUpdateAllBuffAnchors)
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
