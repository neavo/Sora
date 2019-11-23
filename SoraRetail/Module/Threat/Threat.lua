-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local maxThreatValue = 255
local bars, threats = nil, nil

-- Begin
local function UpdateThreat(unit)
    local name = UnitName(unit)
    local guid = UnitGUID(unit)
    local _, class = UnitClass(unit)
    
    if not guid then
        return
    end
    
    local isTanking, status, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(unit, "target")
    
    if not status or not threatValue or threatValue == 0 then
        return
    end
    
    local threat = {}
    threat.guid = guid
    threat.name = name
    threat.status = status
    threat.threatValue = threatValue
    threat.classColor = RAID_CLASS_COLORS[class]
    threat.isTanking = threat.isTanking or threat.status >= 2
    
    if threat.isTanking then
        maxThreatValue = threat.threatValue
    end
    
    table.insert(threats, threat)
end

local function UpdateAllThreats()
    threats = {}
    
    local mobiUnit = nil
    
    if UnitCanAttack("player", "target") then
        mobiUnit = "target"
    elseif UnitCanAttack("player", "targettarget") then
        mobiUnit = "targettarget"
    else
        return
    end
    
    UpdateThreat("pet", mobiUnit)
    UpdateThreat("player", mobiUnit)
    
    UpdateThreat("target", mobiUnit)
    UpdateThreat("targettarget", mobiUnit)
    
    for i = 1, 5 do
        UpdateThreat("party" .. i, mobiUnit)
        UpdateThreat("party" .. i .. "pet", mobiUnit)
        UpdateThreat("party" .. i .. "target", mobiUnit)
    end
    
    for i = 1, 20 do
        UpdateThreat("nameplate" .. i, mobiUnit)
    end
    
    for i = 1, 40 do
        UpdateThreat("raid" .. i, mobiUnit)
        UpdateThreat("raid" .. i .. "pet", mobiUnit)
        UpdateThreat("raid" .. i .. "target", mobiUnit)
    end
    
    local tempThreats = {}
    for k, v in pairs(threats) do
        tempThreats[v.guid] = v
    end
    
    table.wipe(threats)
    for k, v in pairs(tempThreats) do
        table.insert(threats, v)
    end
    
    table.sort(threats, function(l, r)
        local result = false
        
        if (l and not r) or (l.isTanking and not r.isTanking) then
            result = true
        elseif (not l and r) or (not l and not r) or (not l.isTanking and r.isTanking) then
            result = false
        else
            result = l.threatValue > r.threatValue
        end
        
        return result
    end)
end

local function UpdateAllThreatBars()
    if #threats < 2 then
        for i = 1, 4 do
            bars[i]:Hide()
        end
    else
        for i = 1, 4 do
            if not bars[i] or not threats[i] then
                bars[i]:Hide()
            else
                local bar, threat = bars[i], threats[i]
                
                bar:Show()
                bar:SetValue(threat.threatValue / maxThreatValue * 100)
                bar:SetStatusBarColor(threat.classColor.r, threat.classColor.g, threat.classColor.b)
                
                bar.infoText:SetText(i .. " - " .. threat.name)
                bar.valueText:SetText(("%2.f%%"):format(threat.threatValue / maxThreatValue * 100))
            end
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    bars = {}
    
    for i = 1, 4 do
        local bar = CreateFrame("StatusBar", nil, UIParent)
        bar:SetSize(220, 14)
        bar:SetMinMaxValues(0, 130)
        bar:SetStatusBarTexture(DB.Statusbar)
        
        bar.shadow = S.MakeShadow(bar, 2)
        bar.bg = bar:CreateTexture(nil, "BACKGROUND")
        bar.bg:SetTexture(DB.Statusbar)
        bar.bg:SetAllPoints()
        bar.bg:SetVertexColor(0.12, 0.12, 0.12)
        
        bar.infoText = S.MakeText(bar, 10)
        bar.infoText:SetPoint("LEFT", bar, "LEFT", 4, 0)
        
        bar.valueText = S.MakeText(bar, 10)
        bar.valueText:SetPoint("RIGHT", bar, "RIGHT", -4, 0)
        
        if i == 1 then
            bar:SetPoint("TOP", UIParent, "CENTER", -384, -203)
        else
            bar:SetPoint("TOP", bars[i - 1], "BOTTOM", 0, -4)
        end
        
        table.insert(bars, bar)
    end
end

local function OnPlayerTargetChanged(self, event, ...)
    UpdateAllThreats()
    UpdateAllThreatBars()
end

local function OnUnitThreatListUpdate(self, event, ...)
    UpdateAllThreats()
    UpdateAllThreatBars()
end

local function OnUnitThreatSituationUpdate(self, event, ...)
    UpdateAllThreats()
    UpdateAllThreatBars()
end

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_LOGIN")
Event:RegisterEvent("PLAYER_TARGET_CHANGED")
Event:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
Event:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    elseif event == "PLAYER_TARGET_CHANGED" then
        OnPlayerTargetChanged(self, event, ...)
    elseif event == "UNIT_THREAT_LIST_UPDATE" then
        OnUnitThreatListUpdate(self, event, ...)
    elseif event == "UNIT_THREAT_SITUATION_UPDATE" then
        OnUnitThreatSituationUpdate(self, event, ...)
    end
end)
