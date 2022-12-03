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

    local _, status, _, _, threatValue = UnitDetailedThreatSituation(unit, "target")

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
    UpdateThreat("npc", mobiUnit)
    UpdateThreat("focus", mobiUnit)
    UpdateThreat("player", mobiUnit)
    UpdateThreat("target", mobiUnit)
    UpdateThreat("vehicle", mobiUnit)

    UpdateThreat("pettarget", mobiUnit)
    UpdateThreat("npctarget", mobiUnit)
    UpdateThreat("focustarget", mobiUnit)
    UpdateThreat("playertarget", mobiUnit)
    UpdateThreat("targettarget", mobiUnit)
    UpdateThreat("vehicletarget", mobiUnit)

    for i = 1, 4 do
        UpdateThreat("party" .. i, mobiUnit)
        UpdateThreat("partypet" .. i, mobiUnit)
        UpdateThreat("partypet" .. i .. "target", mobiUnit)
    end

    for i = 1, 40 do
        UpdateThreat("raid" .. i, mobiUnit)
        UpdateThreat("raidpet" .. i, mobiUnit)
        UpdateThreat("raidpet" .. i .. "target", mobiUnit)
    end

    for i = 1, 20 do
        UpdateThreat("nameplate" .. i, mobiUnit)
        UpdateThreat("nameplate" .. i .. "target", mobiUnit)
    end

    local tempThreats = {}
    for k, v in pairs(threats) do
        tempThreats[v.guid] = v
    end

    table.wipe(threats)
    for k, v in pairs(tempThreats) do
        table.insert(threats, v)
    end

    local SortFunc = function(l, r)
        local result = false

        if (l and not r) or (l.isTanking and not r.isTanking) then
            result = true
        elseif (not l and r) or (not l and not r) or (not l.isTanking and r.isTanking) then
            result = false
        else
            result = l.threatValue > r.threatValue
        end

        return result
    end

    table.sort(threats, SortFunc)
end

local function UpdateAllThreatBars()
    for i = 1, 4 do
        local bar, threat = bars[i], threats[i]

        if not threat or #threats <= 1 then
            bar:SetAlpha(0.00)
        else
            bar:SetAlpha(1.00)
            bar:SetValue(threat.threatValue / maxThreatValue * 100)
            bar:SetStatusBarColor(threat.classColor.r, threat.classColor.g, threat.classColor.b)

            bar.infoText:SetText(i .. " - " .. threat.name)
            bar.valueText:SetText(("%2.f%%"):format(threat.threatValue / maxThreatValue * 100))
        end
    end
end

local function OnTicker(ticker)
    UpdateAllThreats()
    UpdateAllThreatBars()
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

    C_Timer.NewTicker(0.50, OnTicker)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
