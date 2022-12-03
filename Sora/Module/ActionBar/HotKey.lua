-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function ProcessHotKeyText(hotkey)
    if not hotkey then
        return 0
    end

    hotkey:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    hotkey:SetSize(hotkey:GetParent():GetWidth() - 4, 12)
    hotkey:ClearAllPoints()
    hotkey:SetPoint("TOPRIGHT", -1, -2)

    hotkey:SetText(hotkey:GetText():gsub("a%-", "A"))
    hotkey:SetText(hotkey:GetText():gsub("c%-", "C"))
    hotkey:SetText(hotkey:GetText():gsub("s%-F", "SF"))
    hotkey:SetText(hotkey:GetText():gsub("鼠标按键", "M"))
end

-- Begin
local function OnPlayerLogin(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        ProcessHotKeyText(_G["ActionButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarLeftButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarRightButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarBottomLeftButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarBottomRightButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["PetActionButton" .. i .. "HotKey"])
    end
end

local function OnUpdateBindings()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        ProcessHotKeyText(_G["ActionButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarLeftButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarRightButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarBottomLeftButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["MultiBarBottomRightButton" .. i .. "HotKey"])
        ProcessHotKeyText(_G["PetActionButton" .. i .. "HotKey"])
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.UPDATE_BINDINGS = OnUpdateBindings
EventHandler.Register()
