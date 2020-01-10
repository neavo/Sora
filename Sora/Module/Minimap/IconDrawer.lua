-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function findIcons()
    local icons = {}

    local match = string.match
    local insert = table.insert

    for k, v in pairs(_G) do
        if match(k, "LibDBIcon10_") and v:GetObjectType() == "Button" then
            insert(icons, v)
        end
    end

    return icons
end

local function getPerRowAndSpace(size)
    local perRow = math.modf(Minimap:GetHeight() / size)
    local space = (Minimap:GetHeight() - size * perRow) / (perRow - 1)

    return perRow, space
end

local function ProcessButtons()
    local size = 28
    local icons = findIcons()
    local perRow, space = getPerRowAndSpace(size)

    local anchor = CreateFrame("Frame", nil, Minimap)
    anchor:SetSize(size, Minimap:GetHeight())
    anchor:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 0, 0)

    local container = CreateFrame("Frame", nil, Minimap)
    container:Hide()
    container:EnableMouse(true)
    container:SetAllPoints(Minimap)
    container:SetFrameStrata("DIALOG")

    container.bg = container:CreateTexture(nil, "BORDER")
    container.bg:SetAllPoints()
    container.bg:SetTexture(DB.Backdrop)
    container.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    container.shadow = S.MakeShadow(container, 2)
    container.shadow:SetFrameLevel(container:GetFrameLevel() + 1)

    local switch = S.CreateButton(Minimap, size - 8)
    switch:SetSize(size - 8, size - 8)
    switch:SetText("+")
    switch:SetPoint("BOTTOM", anchor, "BOTTOM", 2, 0)
    table.insert(icons, perRow, switch)

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 4)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(container:IsVisible() and "点击收起" or "点击展开", 0.75, 0.90, 1.00)
        GameTooltip:Show()
    end

    local function OnLeave(self, ...)
        GameTooltip:Hide()
    end

    local function OnClick(self, key, ...)
        if container:IsVisible() then
            switch:SetText("+")
            container:Hide()
        else
            switch:SetText("×")
            container:Show()
        end
    end

    switch:HookScript("OnEnter", OnEnter)
    switch:HookScript("OnLeave", OnLeave)
    switch:HookScript("OnClick", OnClick)

    for k, v in ipairs(icons) do
        if not k == perRow then
            v:ClearAllPoints()
            v:SetSize(size, size)

            local function OnClick(self, key, ...)
                container:Hide()
                switch:SetText("+")
            end

            v:HookScript("OnClick", OnClick)
        end

        if k > perRow then
            v:SetParent(container)
        end

        if k == 1 then
            v:SetPoint("TOP", anchor, "TOP", 0, space)
        elseif mod(k, perRow) == 1 then
            v:SetPoint("TOPRIGHT", icons[k - perRow], "TOPLEFT", 0, 0)
        else
            v:SetPoint("TOP", icons[k - 1], "BOTTOM", 0, -space)
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    ProcessButtons()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
