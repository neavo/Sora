-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function IsPlayerMaxLevel()
    local maxLevel = GetRestrictedAccountData()

    if (maxLevel == 0) then
        maxLevel = GetMaxLevelForPlayerExpansion()
    end

    return maxLevel == UnitLevel("player")
end

local function ShouldShowHonor()
    return IsPlayerMaxLevel() and (IsWatchingHonorAsXP() or C_PvP.IsActiveBattlefield() or IsInActiveWorldPVP())
end

-- Event
local function OnPlayerLogin(self, event, ...)
    local unit = nil
    local units = {}
    local row, yOffset = 0, -18

    row = row + 1
    unit = S.Minimap.CreateSystem(Minimap)
    unit:SetSize((Minimap:GetWidth() - 8) / 2, 6)
    unit:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, yOffset * row + 4)
    unit = S.Minimap.CreateAddon(Minimap)
    unit:SetSize((Minimap:GetWidth() - 8) / 2, 6)
    unit:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, yOffset * row + 4)

    row = row + 1
    unit = S.Minimap.CreateCurrency(Minimap)
    unit:SetSize((Minimap:GetWidth() - 8) / 2, 6)
    unit:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, yOffset * row + 4)
    unit = S.Minimap.CreateDurability(Minimap)
    unit:SetSize((Minimap:GetWidth() - 8) / 2, 6)
    unit:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, yOffset * row + 4)

    unit = S.Minimap.CreateHonor(Minimap)
    unit:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, unit)

    unit = S.Minimap.CreateExperience(Minimap)
    unit:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, unit)

    unit = S.Minimap.CreateReputation(Minimap)
    unit:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, unit)

    unit = S.Minimap.CreateArtifactPower(Minimap)
    unit:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, unit)

    local function OnTicker()
        if InCombatLockdown() then
            return 0
        end

        for k, v in pairs(units) do
            v:ClearAllPoints()
        end

        row = 2
        if ShouldShowHonor() then
            row = row + 1
            units[1]:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if not IsPlayerMaxLevel() then
            row = row + 1
            units[2]:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if select(1, GetWatchedFactionInfo()) then
            row = row + 1
            units[3]:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if HasArtifactEquipped() or C_AzeriteItem.FindActiveAzeriteItem() then
            row = row + 1
            units[4]:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end
    end

    C_Timer.NewTicker(1.00, OnTicker)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
