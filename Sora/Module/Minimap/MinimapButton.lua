-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local buttons = {}

-- Begin
local function FindButtons()
    local match = string.match
    local insert = table.insert

    for k, v in pairs(_G) do
        if match(k, "LibDBIcon10_") and v:GetObjectType() == "Button" then
            insert(buttons, v)
        end
    end
end

local function ProcessButtons()
    local space = 4
    local size = (Minimap:GetHeight() + space - space * (5 - 1)) / 5

    local anchor = CreateFrame("Frame", nil, Minimap)
    anchor:SetSize(size, Minimap:GetHeight())
    anchor:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 0, 0)

    local container = CreateFrame("Frame", nil, Minimap)
    container:Hide()
    container:SetSize(size * 8 + space * 7 + space * 2, size * 2 + space * 1 + space * 2)
    container:SetPoint("TOPLEFT", anchor, "BOTTOMRIGHT", space, -space)

    container.bg = container:CreateTexture(nil, "BORDER")
    container.bg:SetAllPoints()
    container.bg:SetTexture(DB.Backdrop)
    container.bg:SetVertexColor(0.12, 0.12, 0.12, 0.50)

    container.shadow = S.MakeShadow(container, 2)
    container.shadow:SetFrameLevel(container:GetFrameLevel() + 1)

    local switch = S.CreateButton(Minimap, 20)
    switch:SetSize(size - 8, size - 8)
    switch:SetText("△")
    switch:SetPoint("BOTTOM", anchor, "BOTTOM", 2, 0)

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self.toggle and "点击收起" or "点击展开", 0.75, 0.90, 1.00)
        GameTooltip:Show()
    end

    local function OnLeave(self, ...)
        GameTooltip:Hide()
    end

    local function OnButtonClick(self, key, ...)
        if not switch.toggle then
            return 0
        end

        container:Hide()
        switch:SetText("△")

        switch.toggle = not switch.toggle
    end

    local function OnSwitchClick(self, key, ...)
        if switch.toggle then
            container:Hide()
            switch.text:SetText("△")
        else
            container:Show()
            switch:SetText("▽")
        end

        switch.toggle = not switch.toggle
    end

    switch.toggle = false
    switch:HookScript("OnEnter", OnEnter)
    switch:HookScript("OnLeave", OnLeave)
    switch:HookScript("OnClick", OnSwitchClick)

    for k, v in ipairs(buttons) do
        v:ClearAllPoints()
        v:SetSize(size, size)
        v:HookScript("OnClick", OnButtonClick)

        if k == 1 then
            v:SetPoint("TOP", anchor, "TOP", 0, space)
        elseif k < 5 then
            v:SetPoint("TOP", buttons[k - 1], "BOTTOM", 0, -space)
        elseif k == 5 then
            v:SetParent(container)
            v:SetPoint("TOPLEFT", container, "TOPLEFT", space, -space)
        elseif mod(k, 5) == 0 then
            v:SetParent(container)
            v:SetPoint("TOP", buttons[k - 5], "BOTTOM", 0, -space)
        else
            v:SetParent(container)
            v:SetPoint("LEFT", buttons[k - 1], "RIGHT", space, 0)
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    FindButtons()
    ProcessButtons()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
