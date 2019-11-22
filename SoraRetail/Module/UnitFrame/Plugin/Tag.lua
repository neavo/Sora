-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
oUF.colors.power["MANA"] = {0.00, 0.56, 1.00}
oUF.colors.power["RAGE"] = {1.00, 0.00, 0.00}
oUF.colors.power["FOCUS"] = {1.00, 0.75, 0.25}
oUF.colors.power["ENERGY"] = {0.65, 0.65, 0.35}
oUF.colors.power["RUNIC_POWER"] = {0.44, 0.44, 0.44}

-- Begin
oUF.Tags.Methods["Sora:Rare"] = function(unit)
    local str = nil
    local class = UnitClassification(unit)
    
    if class == "elite" then
        str = "|cffFFCC00精英 |r"
    elseif class == "worldboss" then
        str = "|cffFF0000首领 |r"
    elseif class == "rare" or class == "rareelite" then
        str = "|cffCC00FF稀有 |r"
    end
    
    return str
end
oUF.Tags.Events["Sora:Rare"] = "UNIT_CLASSIFICATION_CHANGED"

oUF.Tags.Methods["Sora:Level"] = function(unit)
    local str = nil
    local color = {}
    local level = UnitLevel(unit)
    
    if UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) then
        level = UnitBattlePetLevel(unit)
    end
    
    if level > 0 then
        str = "|cff%02X%02X%02X" .. level .. " |r"
        color = GetQuestDifficultyColor(level)
    else
        str = "|cff%02X%02X%02X" .. "??" .. " |r"
        color.r, color.g, color.b = 1.00, 0.00, 0.00
    end
    
    return string.format(str, color.r * 255, color.g * 255, color.b * 255)
end
oUF.Tags.Events["Sora:Level"] = "UNIT_LEVEL PLAYER_LEVEL_UP"

oUF.Tags.Methods["Sora:Color"] = function(unit)
    local _, class = UnitClass(unit)
    local reaction = UnitReaction(unit, "player")
    
    local color = {}
    local str = "|cff%02X%02X%02X"
    
    if UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) then
        color.r, color.g, color.b = 0.63, 0.63, 0.63
    elseif UnitIsPlayer(unit) and class then
        color.r, color.g, color.b = unpack(oUF.colors.class[class])
    elseif reaction then
        color.r, color.g, color.b = unpack(oUF.colors.reaction[reaction])
    else
        color.r, color.g, color.b = 1.00, 1.00, 1.00
    end
    
    return string.format(str, color.r * 255, color.g * 255, color.b * 255)
end
oUF.Tags.Events["Sora:Color"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION UNIT_FACTION"

oUF.Tags.Methods["Sora:ShortName"] = function(unit)
    local str = UnitName(unit)
    
    if str and str:len() > 9 then
        str = str:sub(0, 9) .. "…"
    end
    
    return str
end
oUF.Tags.Events["Sora:ShortName"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["Sora:Health"] = function(unit)
    return S.FormatInteger(UnitHealth(unit))
end
oUF.Tags.Events["Sora:Health"] = "UNIT_HEALTH UNIT_MAXHEALTH"

oUF.Tags.Methods["Sora:PerHealth"] = function(unit)
    local percent = 0
    local curValue = UnitHealth(unit)
    local maxValue = UnitHealthMax(unit)
    
    if curValue and maxValue and curValue > 0 and maxValue > 0 then
        percent = math.floor(curValue / maxValue * 100 + 0.5)
    end
    
    return S.FormatInteger(percent) .. "%"
end
oUF.Tags.Events["Sora:PerHealth"] = "UNIT_HEALTH UNIT_MAXHEALTH"

oUF.Tags.Methods["Sora:Power"] = function(unit)
    return S.FormatInteger(UnitPower(unit))
end
oUF.Tags.Events["Sora:Power"] = "UNIT_POWER_UPDATE"

oUF.Tags.Methods["Sora:PerPower"] = function(unit)
    local percent = 0
    local curValue = UnitPower(unit)
    local maxValue = UnitPowerMax(unit)
    
    if curValue and maxValue and curValue > 0 and maxValue > 0 then
        percent = math.floor(curValue / maxValue * 100 + 0.5)
    end
    
    return S.FormatInteger(percent) .. "%"
end
oUF.Tags.Events["Sora:PerPower"] = "UNIT_POWER_UPDATE"

oUF.Tags.Methods["Sora:Status"] = function(unit)
    local str = nil
    
    if UnitIsDead(unit) then
        str = "死亡"
    elseif UnitIsGhost(unit) then
        str = "灵魂"
    elseif not UnitIsConnected(unit) then
        str = "离线"
    end
    
    return str
end
oUF.Tags.Events["Sora:Info"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"
