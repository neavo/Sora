-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["ActionButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomLeftButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomRightButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarLeftButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarRightButton" .. i .. "HotKey"]
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
