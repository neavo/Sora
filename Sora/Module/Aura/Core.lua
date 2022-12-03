-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local size, space, postion = nil, nil, nil

-- Common
local function SortByExpirationTime(l, r)
    local flag = false

    if not l or not r then
        flag = flase
    elseif l.buttonInfo.expirationTime == 0 and r.buttonInfo.expirationTime == 0 then
        flag = false
    elseif l.buttonInfo.expirationTime == 0 and r.buttonInfo.expirationTime > 0 then
        flag = true
    elseif l.buttonInfo.expirationTime > 0 and r.buttonInfo.expirationTime == 0 then
        flag = false
    else
        flag = l.buttonInfo.expirationTime > r.buttonInfo.expirationTime
    end

    return flag
end

local function AuraButtonUpdate(self, info, expanded, ...)
    if not info or not self.Border or self:GetFilter() == "HELPFUL" then
        return
    end

    local color = nil

    if info.debuffType then
        color = DebuffTypeColor[info.debuffType]
    else
        color = {r = 0.00, g = 0.00, b = 0.00}
    end

    self.shadow:SetBackdropBorderColor(color.r, color.g, color.b, 1.00)
end

local function AuraButtonUpdateDuration(self, timeLeft, ...)
    if not timeLeft or timeLeft < 0 then
        return 0
    end

    if timeLeft < BUFF_DURATION_WARNING_TIME then
        self.duration:SetTextColor(1.00, 0.00, 0.00)
    else
        self.duration:SetTextColor(1.00, 0.84, 0.00)
    end
end

local function BuffFrameUpdateAuraButtons(self, ...)
    if not self.__Initialized then
        self.__Initialized = true

        self:ClearAllPoints()
        self.SetPoint = S.Dummy

        self.AuraContainer:ClearAllPoints()
        self.AuraContainer.SetPoint = S.Dummy

        self.CollapseAndExpandButton:SetAlpha(0.00)
        self.CollapseAndExpandButton:ClearAllPoints()
        self.CollapseAndExpandButton.SetPoint = S.Dummy
    end
end

local function BuffFrameAuraContainerUpdateGridLayout(self, auras, ...)
    table.sort(auras, SortByExpirationTime)

    for k, v in pairs(auras) do
        if not v.__Initialized then
            v.__Initialized = true

            v.shadow = S.MakeShadow(v, 4)
            v.shadow:SetFrameLevel(v:GetFrameLevel() - 1)

            v.count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            v.count:SetShadowColor(0.00, 0.00, 0.00, 1.00)
            v.count:SetShadowOffset(1.00, -1.00)

            v.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
            v.duration:SetShadowColor(0.00, 0.00, 0.00, 1.00)
            v.duration:SetShadowOffset(1.00, -1.00)
        end

        v:SetScale(1.00)
        v:SetSize(size, size)
        v:ClearAllPoints()

        v.Icon:SetAllPoints()
        v.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        v.count:ClearAllPoints()
        v.count:SetPoint("TOPRIGHT", -1.0, -1.5)

        v.duration:ClearAllPoints()
        v.duration:SetPoint("BOTTOM", 2, -10)

        if v.buttonInfo.expirationTime <= 0 then
            v.duration:Show()
            v.duration:SetText("N/A")
            v.duration:SetTextColor(1.00, 0.84, 0.00)
        end

        if k == 1 then
            v:SetPoint("TOPRIGHT", SoraAura, "TOPRIGHT", 0, 0)
        elseif mod(k, 12) == 1 then
            v:SetPoint("TOP", auras[k - 12], "BOTTOM", 0, -space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -space, 0)
        end
    end
end

local function DebuffFrameAuraContainerUpdateGridLayout(self, auras, ...)
    table.sort(auras, SortByExpirationTime)

    for k, v in pairs(auras) do
        if not v.__Initialized then
            v.__Initialized = true

            v.Border:Hide()
            v.Border:ClearAllPoints()
            v.Border.SetPoint = S.Dummy

            v.shadow = S.MakeShadow(v, 4)
            v.shadow:SetFrameLevel(v:GetFrameLevel() - 1)

            v.count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            v.count:SetShadowColor(0.00, 0.00, 0.00, 1.00)
            v.count:SetShadowOffset(1.00, -1.00)

            v.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
            v.duration:SetShadowColor(0.00, 0.00, 0.00, 1.00)
            v.duration:SetShadowOffset(1.00, -1.00)
        end

        v:ClearAllPoints()
        v:SetSize(size, size)

        v.Icon:ClearAllPoints()
        v.Icon:SetAllPoints()
        v.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        v.Border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
        v.Border:SetVertexColor(1.00, 0, 0)

        v.count:ClearAllPoints()
        v.count:SetPoint("TOPRIGHT", -1.0, -1.5)

        v.duration:ClearAllPoints()
        v.duration:SetPoint("BOTTOM", 2, -10)

        if v.buttonInfo.expirationTime <= 0 then
            v.duration:Show()
            v.duration:SetText("N/A")
            v.duration:SetTextColor(1.00, 0.84, 0.00)
        end

        if k == 1 then
            v:SetPoint("TOPRIGHT", SoraAura, "TOPRIGHT", 0, -(size + space) * 3)
        elseif mod(k, 12) == 1 then
            v:SetPoint("TOP", auras[k - 12], "BOTTOM", 0, -space)
        else
            v:SetPoint("RIGHT", auras[k - 1], "LEFT", -space, 0)
        end
    end
end

-- Begin
local function SetAnchor()
    local anchor = S.CreateButton(UIParent, 16, "SoraAura")
    anchor:Hide()
    anchor:SetText("状态")
    anchor:SetSize(size * 12 + space * 11, size * 5 + space * 4)
    anchor:SetPoint(unpack(postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.Aura.Mover and C.Config.Aura.Mover.SoraAura then
        local frames = EditModeManagerFrame.registeredSystemFrames
        for i = #frames, 1, -1 do
            if frames[i]:GetName() == "BuffFrame" or frames[i]:GetName() == "DebuffFrame" then
                table.remove(frames, i)
            end
        end

        EditModeManagerFrame.AccountSettings.RefreshAuraFrame = S.Dummy

        anchor:SetScript("OnDragStop", C.Config.Aura.Mover.SoraAura.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.Aura.Mover.SoraAura.OnDragStart)

        C.Config.Aura.Mover.SoraAura.anchor = anchor
    end
end

local function SetHookSecureFunction()
    hooksecurefunc(BuffButtonMixin, "UpdateDuration", AuraButtonUpdateDuration)
    hooksecurefunc(DebuffButtonMixin, "Update", AuraButtonUpdate)
    hooksecurefunc(DebuffButtonMixin, "UpdateDuration", AuraButtonUpdateDuration)

    hooksecurefunc(BuffFrame, "UpdateAuraButtons", BuffFrameUpdateAuraButtons)
    hooksecurefunc(BuffFrame.AuraContainer, "UpdateGridLayout", BuffFrameAuraContainerUpdateGridLayout)
    hooksecurefunc(DebuffFrame.AuraContainer, "UpdateGridLayout", DebuffFrameAuraContainerUpdateGridLayout)
end

-- Event
local function OnInitialize()
    size, space, postion = C.Aura.Size, C.Aura.Space, C.Aura.Postion
end

local function OnPlayerLogin(self, event, ...)
    SetAnchor()
    SetHookSecureFunction()
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
