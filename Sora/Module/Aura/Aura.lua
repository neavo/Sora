-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local size, Space, postion = nil, nil, nil

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function Initialize()
    size, Space, postion = C.Aura.Size, C.Aura.Space, C.Aura.Postion
end

local function CreateAnchor()
    local anchor = CreateFrame("Frame", "SoraAura", UIParent)
    anchor:Hide()
    anchor:SetSize(size * 12 + Space * (12 - 1), size * 5 + Space * (5 - 1))
    anchor:SetPoint(unpack(postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    anchor.bg = anchor:CreateTexture(nil, "BORDER")
    anchor.bg:SetAllPoints()
    anchor.bg:SetTexture(DB.Backdrop)
    anchor.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    anchor.text = S.MakeText(anchor, 16)
    anchor.text:SetText("增益")
    anchor.text:SetPoint("CENTER", anchor, "CENTER", 0, 0)

    anchor.shadow = S.MakeShadow(anchor, 2)
    anchor.shadow:SetFrameLevel(anchor:GetFrameLevel())

    local function OnEnter(self, ...)
        self.bg:SetVertexColor(r / 4, g / 4, b / 4, 0.50)
        self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        self.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    if C.Config.Aura.Mover and C.Config.Aura.Mover.SoraAura then
        anchor:SetScript("OnLeave", OnLeave)
        anchor:SetScript("OnEnter", OnEnter)
        anchor:SetScript("OnDragStop", C.Config.Aura.Mover.SoraAura.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.Aura.Mover.SoraAura.OnDragStart)

        C.Config.Aura.Mover.SoraAura.anchor = anchor
    end
end

-- Hook
local function HookAuraButtonUpdateDuration(self, timeLeft, ...)
    if timeLeft then
        if timeLeft < BUFF_DURATION_WARNING_TIME then
            self.duration:SetTextColor(1.00, 0.00, 0.00)
        else
            self.duration:SetTextColor(0.96, 0.82, 0.10)
        end
    end
end

local function HookDebuffButtonUpdateAnchors(name, index, ...)
    local anchor = SoraAura

    for i = 1, DEBUFF_MAX_DISPLAY do
        local aura = _G["DebuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", 0, -(size * 3 + Space * (3 - 1)))
        elseif mod(i, 12) == 1 then
            aura:SetPoint("TOP", _G["DebuffButton" .. (i - 12)], "BOTTOM", 0, -Space)
        else
            aura:SetPoint("RIGHT", _G["DebuffButton" .. (i - 1)], "LEFT", -Space, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

local function HookBuffFrameUpdateAllBuffAnchors(self, ...)
    local anchor = SoraAura

    for i = 1, BUFF_MAX_DISPLAY do
        local aura = _G["BuffButton" .. i]

        if not aura then
            return 0
        end

        aura:ClearAllPoints()
        aura:SetSize(size, size)

        if i == 1 then
            aura:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", 0, 0)
        elseif mod(i, 12) == 1 then
            aura:SetPoint("TOP", _G["BuffButton" .. (i - 12)], "BOTTOM", 0, -Space)
        else
            aura:SetPoint("RIGHT", _G["BuffButton" .. (i - 1)], "LEFT", -Space, 0)
        end

        aura.duration:SetShadowOffset(1, -1)
        aura.duration:SetShadowColor(0, 0, 0, 0.5)
        aura.duration:SetFont(DB.AuraFont, 12, "OUTLINE")
    end
end

-- Event
local function OnPlayerLogin(self, event, ...)
    Initialize()
    CreateAnchor()

    hooksecurefunc("AuraButton_UpdateDuration", HookAuraButtonUpdateDuration)
    hooksecurefunc("DebuffButton_UpdateAnchors", HookDebuffButtonUpdateAnchors)
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", HookBuffFrameUpdateAllBuffAnchors)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
