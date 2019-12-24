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
    container:SetSize(size * 5 + space * 4, size * 3 + space * 2)
    container:SetPoint("TOPLEFT", anchor, "BOTTOMRIGHT", -space, -space)

    local switch = S.CreateButton(Minimap)
    switch:SetSize(size - 8, size - 8)
    switch:SetPoint("BOTTOM", anchor, "BOTTOM", 2, 0)

    switch.text = S.MakeText(switch, 20)
    switch.text:SetPoint("CENTER", 0, -1)
    switch.text:SetText("△")

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine("点击切换", 0.75, 0.90, 1.00)
        GameTooltip:Show()
    end

    local function OnLeave(self, ...)
        GameTooltip:Hide()
    end

    local function OnMouseUp(self, key, ...)
        if self.toggle then
            container:Hide()
            self.text:SetText("△")
        else
            container:Show()
            self.text:SetText("▽")
        end

        self.toggle = not self.toggle
    end

    switch.toggle = false
    switch:HookScript("OnEnter", OnEnter)
    switch:HookScript("OnLeave", OnLeave)
    switch:HookScript("OnMouseUp", OnMouseUp)

    for k, v in ipairs(buttons) do
        v:ClearAllPoints()
        v:SetSize(size, size)

        if k == 1 then
            v:SetPoint("TOP", anchor, "TOP", 0, space)
        elseif k < 5 then
            v:SetPoint("TOP", buttons[k - 1], "BOTTOM", 0, -space)
        elseif k == 5 then
            v:SetParent(container)
            v:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
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
