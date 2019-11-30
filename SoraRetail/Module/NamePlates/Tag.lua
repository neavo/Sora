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

oUF.Tags.Methods["NamePlates:Color"] = function(unit)
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
oUF.Tags.Events["NamePlates:Color"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION UNIT_FACTION"

oUF.Tags.Methods["NamePlates:Name"] = function(unit)
    local str = UnitName(unit)
    
    if str and str:len() > 24 then
        str = str:sub(0, 24) .. " ..."
    end
    
    return str
end
oUF.Tags.Events["NamePlates:Name"] = "UNIT_NAME_UPDATE"