-- Engine
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
oUF.Tags.Methods["NamePlates:Rare"] = function(unit)
    local str = nil
    local class = UnitClassification(unit)

    if class == "elite" then
        str = "|cffFFCC00精|r"
    elseif class == "worldboss" then
        str = "|cffFF0000首|r"
    elseif class == "rare" or class == "rareelite" then
        str = "|cffCC00FF稀|r"
    end

    return str
end
oUF.Tags.Events["NamePlates:Rare"] = "UNIT_CLASSIFICATION_CHANGED"

oUF.Tags.Methods["NamePlates:Level"] = function(unit)
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
oUF.Tags.Events["NamePlates:Level"] = "UNIT_LEVEL PLAYER_LEVEL_UP"

oUF.Tags.Methods["NamePlates:Name"] = function(unit)
    local name = UnitName(unit)
    local _, class = UnitClass(unit)
    local reaction = UnitReaction(unit, "player")

    local r, g, b = 1.00, 1.00, 1.00
    local str = "|cff%02X%02X%02X"

    if UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) then
        r, g, b = 0.63, 0.63, 0.63
    elseif UnitIsPlayer(unit) and class then
        r, g, b = unpack(oUF.colors.class[class])
    elseif reaction then
        r, g, b = unpack(oUF.colors.reaction[reaction])
    end

    if name then
        name = S.SubString(name, 8, " ...")
    end

    return string.format(str, r * 255, g * 255, b * 255) .. name .. "|r"
end
oUF.Tags.Events["NamePlates:Name"] = "UNIT_NAME_UPDATE UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION UNIT_FACTION"
