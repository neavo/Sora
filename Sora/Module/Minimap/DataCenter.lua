-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function UpdateAnchors(self, ...)
    local lines = {}

    table.insert(lines, anchors.First)
    table.insert(lines, anchors.Second)

    if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
        table.insert(lines, anchors.Experience)
    end

    if select(1, GetWatchedFactionInfo()) then
        table.insert(lines, anchors.Reputation)
    end

    if HasArtifactEquipped() or (C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()) then
        table.insert(lines, anchors.ArtifactPower)
    end

    for k, v in pairs(lines) do
        if k == 1 then
            v:SetPoint("TOP")
        else
            v:SetPoint("TOP", lines[k - 1], "BOTTOM", 0, 0)
        end
    end
end

-- Event
local function OnPlayerLogin(self, event, ...)
    local unit = nil
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

    if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
        row = row + 1

        unit = S.Minimap.CreateExperience(Minimap)
        unit:SetSize(Minimap:GetWidth(), 6)
        unit:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
    end

    if select(1, GetWatchedFactionInfo()) then
        row = row + 1

        unit = S.Minimap.CreateReputation(Minimap)
        unit:SetSize(Minimap:GetWidth(), 6)
        unit:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
    end

    if HasArtifactEquipped() or C_AzeriteItem.FindActiveAzeriteItem() then
        row = row + 1

        unit = S.Minimap.CreateArtifactPower(Minimap)
        unit:SetSize(Minimap:GetWidth(), 6)
        unit:SetPoint("TOP", Minimap, "BOTTOM", 0, yOffset * row + 4)
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
