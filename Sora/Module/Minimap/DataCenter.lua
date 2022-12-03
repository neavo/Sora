-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function ShouldShowHonor()
    return IsPlayerAtEffectiveMaxLevel() and (IsWatchingHonorAsXP() or C_PvP.IsActiveBattlefield() or IsInActiveWorldPVP())
end

local function ShouldShowArtifactPower()
    local azeriteItem = C_AzeriteItem.FindActiveAzeriteItem()
    local showAzeriteBar = azeriteItem and azeriteItem:IsEquipmentSlot() and C_AzeriteItem.IsAzeriteItemEnabled(azeriteItem)
    local showArtifactBar = HasArtifactEquipped() and not C_ArtifactUI.IsEquippedArtifactDisabled()

    return showAzeriteBar or showArtifactBar
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

    local Honor = S.Minimap.CreateHonor(Minimap)
    Honor:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, Honor)

    local Experience = S.Minimap.CreateExperience(Minimap)
    Experience:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, Experience)

    local Reputation = S.Minimap.CreateReputation(Minimap)
    Reputation:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, Reputation)

    local ArtifactPower = S.Minimap.CreateArtifactPower(Minimap)
    ArtifactPower:SetSize(Minimap:GetWidth(), 6)
    table.insert(units, ArtifactPower)

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
            Honor:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if not IsPlayerAtEffectiveMaxLevel() then
            row = row + 1
            Experience:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if select(1, GetWatchedFactionInfo()) then
            row = row + 1
            Reputation:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end

        if ShouldShowArtifactPower() then
            row = row + 1
            ArtifactPower.ArtifactPower:ForceUpdate()
            ArtifactPower:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
        end
    end

    C_Timer.NewTicker(1.00, OnTicker)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
