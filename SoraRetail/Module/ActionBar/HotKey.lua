-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["ActionButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomLeftButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomRightButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarLeftButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarRightButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end
end

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
