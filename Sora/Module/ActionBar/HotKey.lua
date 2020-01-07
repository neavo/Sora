-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function ProcessTextRegion(text)
    if text.__Processed then
        return 0
    end

    local font, size, flag = text:GetFont()

    if size <= 0 then
        return 0
    end

    local p = C.Core.Pixel or 1.00

    text:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")
    text:SetShadowOffset(1.00 * p, -1.00 * p)
    text:SetShadowColor(0.00, 0.00, 0.00, 0.50)

    text.__Processed = true
end

local function OnPlayerLogin(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["ActionButton" .. i .. "HotKey"]
        
        ProcessTextRegion(hotkey)
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomLeftButton" .. i .. "HotKey"]

        ProcessTextRegion(hotkey)
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarBottomRightButton" .. i .. "HotKey"]

        ProcessTextRegion(hotkey)
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarLeftButton" .. i .. "HotKey"]

        ProcessTextRegion(hotkey)
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local hotkey = _G["MultiBarRightButton" .. i .. "HotKey"]

        ProcessTextRegion(hotkey)
        hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
        hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
