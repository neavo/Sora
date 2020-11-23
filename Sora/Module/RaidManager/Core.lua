-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function HasRight()
    local inParty = IsInGroup() and not IsInRaid()
    local isGroupLeader = UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")

    return inParty or isGroupLeader
end

local function CreateInstance(parent)
    local instance = CreateFrame("Frame", nil, UIParent)
    instance:SetSize(36 * 5 + 8 * 4 + 16, 20 + 16)
    instance:SetMovable(true)
    instance:EnableMouse(true)
    instance:SetToplevel(true)
    instance:SetFrameStrata("DIALOG")
    instance:RegisterForDrag("LeftButton")
    instance:SetClampedToScreen(true)

    instance.bg = instance:CreateTexture(nil, "BORDER")
    instance.bg:SetAllPoints()
    instance.bg:SetTexture(DB.Backdrop)
    instance.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(parent:GetFrameLevel() + 1)

    return instance
end

local function CreateReady(instance)
    local btn = S.CreateButton(instance, 12)
    btn:SetText("就位")
    btn:SetSize(36, 20)
    btn:SetPoint("LEFT", 8, 0)

    local function OnClick()
        DoReadyCheck()
    end

    btn:HookScript("OnClick", OnClick)
end

local function CreateRolePoll(instance)
    local btn = S.CreateButton(instance, 12)
    btn:SetText("职责")
    btn:SetSize(36, 20)
    btn:SetPoint("LEFT", 8 + 36 + 8, 0)

    local function OnClick()
        InitiateRolePoll()
    end

    btn:HookScript("OnClick", OnClick)
end

local function CreateConverter(instance)
    local btn = S.CreateButton(instance, 12)
    btn:SetText("转换")
    btn:SetSize(36, 20)
    btn:SetPoint("LEFT", 8 + 36 * 2 + 8 * 2, 0)

    local function OnClick()
        if IsInRaid() then
            C_PartyInfo.ConvertToParty()
        else
            C_PartyInfo.ConvertToRaid()
        end
    end

    btn:HookScript("OnClick", OnClick)
end

local function CreateCountDown(instance)
    local btn = S.CreateButton(instance, 12)
    btn:SetText("倒数")
    btn:SetSize(36, 20)
    btn:SetPoint("LEFT", 8 + 36 * 3 + 8 * 3, 0)

    local function OnClick()
        C_PartyInfo.DoCountdown(5)
    end

    btn:HookScript("OnClick", OnClick)
end

local function CreateWorldMarker(instance)
    local btn = S.CreateButton(instance, 12)
    btn:SetText("标记")
    btn:SetSize(36, 20)
    btn:SetPoint("LEFT", 8 + 36 * 4 + 8 * 4, 0)

    local marker = CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton

    if not marker then
        for _, addon in next, {"Blizzard_CUFProfiles", "Blizzard_CompactRaidFrames"} do
            EnableAddOn(addon)
            LoadAddOn(addon)
        end
    end

    if marker then
        marker:ClearAllPoints()
        marker:SetAlpha(0)
        marker:SetParent(btn)
        marker:SetAllPoints(btn)

        local function OnEnter(self, ...)
            local r, g, b = S.GetClassColor()

            btn.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
            btn.shadow:SetBackdropBorderColor(r, g, b, 1.00)
        end

        local function OnLeave(self, ...)
            btn.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
            btn.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
        end

        marker:HookScript("OnEnter", OnEnter)
        marker:HookScript("OnLeave", OnLeave)
    end
end

-- Event
local function OnInitialize(self, event, ...)
end

local function OnPlayerLogin(self, event, ...)
    local instance = CreateInstance(UIParent)
    instance:SetPoint("TOP", UIParent, "TOP", 0, -8)

    local function OnEvent(self, event, ...)
        if event ~= "GROUP_ROSTER_UPDATE" then
            return 0
        end

        if HasRight() then
            instance:Show()
        else
            instance:Hide()
        end
    end

    local function OnDragStop(self, button, ...)
        instance:StopMovingOrSizing()
    end

    local function OnDragStart(self, button, ...)
        instance:StartMoving()
    end

    instance:RegisterEvent("GROUP_ROSTER_UPDATE")
    instance:SetScript("OnEvent", OnEvent)
    instance:SetScript("OnDragStop", OnDragStop)
    instance:SetScript("OnDragStart", OnDragStart)

    CreateReady(instance)
    CreateRolePoll(instance)
    CreateConverter(instance)
    CreateCountDown(instance)
    CreateWorldMarker(instance)

    do
        if HasRight() then
            instance:Show()
        else
            instance:Hide()
        end
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
