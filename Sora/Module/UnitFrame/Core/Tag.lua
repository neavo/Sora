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
oUF.colors.runes = {
    {247 / 255 * 0.9, 65 / 255 * 0.9, 57 / 255 * 0.9}, -- blood
    {148 / 255 * 0.9, 203 / 255 * 0.9, 247 / 255 * 0.9}, -- frost
    {173 / 255 * 0.9, 235 / 255 * 0.9, 66 / 255 * 0.9} -- unholy
}

-- Functions
local DyeText = function(unit, text, colorClass, colorReaction, colorDisabled)
    local str = text or ""
    local r, g, b = 0.90, 0.90, 0.90

    if colorClass == true then
        local _, class = UnitClass(unit)
        r, g, b = unpack(oUF.colors.class[class])
    elseif colorReaction == true then
        local reaction = UnitReaction(unit, "player")
        r, g, b = unpack(oUF.colors.reaction[reaction])
    elseif colorDisabled == true then
        r, g, b = 0.63, 0.63, 0.63
    end

    return string.format("|cff%02X%02X%02X", r * 255, g * 255, b * 255) .. str .. "|r"
end

-- Begin
oUF.Tags.Methods["UnitFrame:Rare"] = function(unit)
    local str = nil
    local class = UnitClassification(unit)

    if class == "elite" then
        str = "|cffFFCC00精 |r"
    elseif class == "worldboss" then
        str = "|cffFF0000首 |r"
    elseif class == "rare" or class == "rareelite" then
        str = "|cffCC00FF稀 |r"
    end

    return str
end
oUF.Tags.Events["UnitFrame:Rare"] = "UNIT_CLASSIFICATION_CHANGED"

oUF.Tags.Methods["UnitFrame:Level"] = function(unit)
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
oUF.Tags.Events["UnitFrame:Level"] = "UNIT_LEVEL PLAYER_LEVEL_UP"

oUF.Tags.Methods["UnitFrame:Name"] = function(unit)
    local name = UnitName(unit) or ""

    if name then
        name = S.SubString(name, 7, "...")
    end

    return DyeText(unit, name)
end
oUF.Tags.Events["UnitFrame:Name"] = "UNIT_NAME_UPDATE UNIT_FACTION"

oUF.Tags.Methods["UnitFrame:ShortName"] = function(unit)
    local name = UnitName(unit) or ""

    if name then
        name = S.SubString(name, 3, "...")
    end

    return DyeText(unit, name)
end
oUF.Tags.Events["UnitFrame:ShortName"] = "UNIT_NAME_UPDATE"

oUF.Tags.Methods["UnitFrame:Health"] = function(unit)
    return DyeText(unit, S.FormatInteger(UnitHealth(unit)))
end
oUF.Tags.Events["UnitFrame:Health"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_FACTION"

oUF.Tags.Methods["UnitFrame:PerHealth"] = function(unit)
    local percent = 0
    local curValue = UnitHealth(unit)
    local maxValue = UnitHealthMax(unit)

    if curValue and maxValue and curValue > 0 and maxValue > 0 then
        percent = math.floor(curValue / maxValue * 100 + 0.5)
    end
    return DyeText(unit, S.FormatInteger(percent) .. "%")
end
oUF.Tags.Events["UnitFrame:PerHealth"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_FACTION"

oUF.Tags.Methods["UnitFrame:Power"] = function(unit)
    return DyeText(unit, S.FormatInteger(UnitPower(unit)))
end
oUF.Tags.Events["UnitFrame:Power"] = "UNIT_POWER_UPDATE UNIT_FACTION"

oUF.Tags.Methods["UnitFrame:PerPower"] = function(unit)
    local percent = 0
    local curValue = UnitPower(unit)
    local maxValue = UnitPowerMax(unit)

    if curValue and maxValue and curValue > 0 and maxValue > 0 then
        percent = math.floor(curValue / maxValue * 100 + 0.5)
    end

    return DyeText(unit, S.FormatInteger(percent) .. "%")
end
oUF.Tags.Events["UnitFrame:PerPower"] = "UNIT_POWER_UPDATE UNIT_FACTION"

oUF.Tags.Methods["UnitFrame:Status"] = function(unit)
    local str = ""

    if UnitIsDead(unit) then
        str = "死亡"
    elseif UnitIsGhost(unit) then
        str = "灵魂"
    elseif not UnitIsConnected(unit) then
        str = "离线"
    end

    return DyeText(unit, str, false, false, true)
end
oUF.Tags.Events["UnitFrame:Status"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION UNIT_FACTION"
