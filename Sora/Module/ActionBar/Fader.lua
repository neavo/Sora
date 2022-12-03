-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function FadeIn(name)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G[name .. i]

        if not btn then
            break
        end

        if InCombatLockdown() then
            btn:SetAlpha(1.00)
        else
            UIFrameFadeIn(btn, 0.25, 0.50, 1.00)
        end
    end
end

local function FadeOut(name)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G[name .. i]

        if not btn then
            break
        end

        if InCombatLockdown() then
            btn:SetAlpha(0.50)
        else
            UIFrameFadeOut(btn, 0.25, 1.00, 0.50)
        end
    end
end

local function OnLEnter(self, motion, ...)
    FadeIn("MultiBarLeftButton")
    FadeIn("MultiBarRightButton")
end

local function OnLLeave(self, motion, ...)
    FadeOut("MultiBarLeftButton")
    FadeOut("MultiBarRightButton")
end

local function OnREnter(self, motion, ...)
    FadeIn("MultiBar5Button")
    FadeIn("MultiBar6Button")
end

local function OnRLeave(self, motion, ...)
    FadeOut("MultiBar5Button")
    FadeOut("MultiBar6Button")
end

local function OnPlayerLogin(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarLeftButton" .. i]

        if not btn then
            break
        end

        btn:SetAlpha(0.50)
        btn:SetScript("OnEnter", OnLEnter)
        btn:SetScript("OnLeave", OnLLeave)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarRightButton" .. i]

        if not btn then
            break
        end

        btn:SetAlpha(0.50)
        btn:SetScript("OnEnter", OnLEnter)
        btn:SetScript("OnLeave", OnLLeave)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBar5Button" .. i]

        if not btn then
            break
        end

        btn:SetAlpha(0.50)
        btn:SetScript("OnEnter", OnREnter)
        btn:SetScript("OnLeave", OnRLeave)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBar6Button" .. i]

        if not btn then
            break
        end

        btn:SetAlpha(0.50)
        btn:SetScript("OnEnter", OnREnter)
        btn:SetScript("OnLeave", OnRLeave)
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
