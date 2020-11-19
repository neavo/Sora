-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
local actionBarPrefixs = {
    "ActionButton",
    "MultiBarLeftButton",
    "MultiBarRightButton",
    "MultiBarBottomLeftButton",
    "MultiBarBottomRightButton"
}

-- Common
local function CreateAnchor()
    local width = C.ActionBar.Size * 18 + C.ActionBar.Space * 15 + C.ActionBar.Space * 4
    local height = C.ActionBar.Size * 3 + C.ActionBar.Space * 2

    local anchor = S.CreateButton(UIParent, 16, "SoraActionBar")
    anchor:Hide()
    anchor:SetText("动作条")
    anchor:SetSize(width, height)
    anchor:SetPoint(unpack(SoraDB.ActionBar.Postion))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.ActionBar.Mover and C.Config.ActionBar.Mover.SoraActionBar then
        anchor:SetScript("OnDragStop", C.Config.ActionBar.Mover.SoraActionBar.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.ActionBar.Mover.SoraActionBar.OnDragStart)

        C.Config.ActionBar.Mover.SoraActionBar.anchor = anchor
    end
end

local function CreateAnchorLeftSide()
    local width = C.ActionBar.Size
    local height = C.ActionBar.Size * 12 + C.ActionBar.Space * 11

    local anchor = S.CreateButton(UIParent, 16, "SoraActionBarLeftSide")
    anchor:Hide()
    anchor:SetText("左\n侧\n动\n作\n条")
    anchor:SetSize(width, height)
    anchor:SetPoint(unpack(SoraDB.ActionBar.PostionLeftSide))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.ActionBar.Mover and C.Config.ActionBar.Mover.SoraActionBarLeftSide then
        anchor:SetScript("OnDragStop", C.Config.ActionBar.Mover.SoraActionBarLeftSide.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.ActionBar.Mover.SoraActionBarLeftSide.OnDragStart)

        C.Config.ActionBar.Mover.SoraActionBarLeftSide.anchor = anchor
    end
end

local function CreateAnchorRightSide()
    local width = C.ActionBar.Size
    local height = C.ActionBar.Size * 12 + C.ActionBar.Space * 11

    local anchor = S.CreateButton(UIParent, 16, "SoraActionBarRightSide")
    anchor:Hide()
    anchor:SetText("右\n侧\n动\n作\n条")
    anchor:SetSize(width, height)
    anchor:SetPoint(unpack(SoraDB.ActionBar.PostionRightSide))
    anchor:SetMovable(true)
    anchor:EnableMouse(true)
    anchor:SetToplevel(true)
    anchor:SetFrameStrata("DIALOG")
    anchor:RegisterForDrag("LeftButton")
    anchor:SetClampedToScreen(true)

    if C.Config.ActionBar.Mover and C.Config.ActionBar.Mover.SoraActionBarRightSide then
        anchor:SetScript("OnDragStop", C.Config.ActionBar.Mover.SoraActionBarRightSide.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.ActionBar.Mover.SoraActionBarRightSide.OnDragStart)

        C.Config.ActionBar.Mover.SoraActionBarRightSide.anchor = anchor
    end
end

-- Begin
local function CreateMainBar(self, event, ...)
    rActionBar:CreateActionBar1(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {SoraActionBar:GetPoint()},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 12,
            startPoint = "LEFT"
        }
    )

    rActionBar:CreateActionBar2(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOM", SoraBar1, "TOP", 0, C.ActionBar.Space},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 12,
            startPoint = "LEFT"
        }
    )
end

local function CreateSideBar(self, event, ...)
    rActionBar:CreateActionBar4(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {SoraActionBarLeftSide:GetPoint()},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 1,
            startPoint = "TOP"
        }
    )

    rActionBar:CreateActionBar5(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {SoraActionBarRightSide:GetPoint()},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 1,
            startPoint = "TOP"
        }
    )
end

local function CreateFunctionBar(self, event, ...)
    rActionBar:CreateActionBar3(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOMLEFT", SoraBar1, "BOTTOMRIGHT", C.ActionBar.Space * 3, 0},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 4,
            startPoint = "TOPLEFT"
        }
    )

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarBottomRightButton" .. i]

        if not btn then
            break
        end

        btn:ClearAllPoints()
        btn:SetSize(C.ActionBar.Size, C.ActionBar.Size)

        if i == 1 then
            btn:SetPoint("TOPLEFT", SoraBar2, "TOPLEFT", -(C.ActionBar.Size * 3 + C.ActionBar.Space * 4), 0)
        elseif i == 7 then
            btn:SetPoint("TOPLEFT", SoraBar2, "TOPRIGHT", C.ActionBar.Space * 2, 0)
        elseif mod(i, 3) == 1 then
            btn:SetPoint("TOP", _G["MultiBarBottomRightButton" .. (i - 3)], "BOTTOM", 0, -C.ActionBar.Space)
        else
            btn:SetPoint("LEFT", _G["MultiBarBottomRightButton" .. (i - 1)], "RIGHT", C.ActionBar.Space, 0)
        end
    end
end

local function CreatePetBar(self, event, ...)
    rActionBar:CreatePetBar(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOMLEFT", SoraBar2, "TOPLEFT", 0, C.ActionBar.Space},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 12,
            startPoint = "LEFT"
        }
    )
end

local function CreateStanceBar(self, event, ...)
    rActionBar:CreateStanceBar(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOMLEFT", SoraBar2, "TOPLEFT", 0, C.ActionBar.Space},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 12,
            startPoint = "LEFT"
        }
    )
end

local function CreateExtraBar(self, event, ...)
    ExtraActionButton1:SetMovable(true)
    ExtraActionButton1:EnableMouse(true)
    ExtraActionButton1:SetToplevel(true)
    ExtraActionButton1:SetFrameStrata("HIGH")
    ExtraActionButton1:RegisterForDrag("LeftButton")
    ExtraActionButton1:SetClampedToScreen(true)

    local function OnDragStop(self, button, ...)
        self:StopMovingOrSizing()
    end

    local function OnDragStart(self, button, ...)
        self:StartMoving()
    end

    ExtraActionButton1:SetScript("OnDragStop", OnDragStop)
    ExtraActionButton1:SetScript("OnDragStart", OnDragStart)

    rActionBar:CreateExtraBar(
        "Sora",
        {
            frameScale = 0.80,
            framePoint = {
                "BOTTOM",
                SoraBar2,
                "TOP",
                0,
                16 + C.ActionBar.Size + C.ActionBar.Space * 2 + 8
            },
            framePadding = 0,
            buttonWidth = ExtraActionButton1:GetWidth(),
            buttonHeight = ExtraActionButton1:GetHeight(),
            buttonMargin = C.ActionBar.Space,
            numCols = 1,
            startPoint = "LEFT"
        }
    )
end

local function CreateVehicleExitBar(self, event, ...)
    rActionBar:CreateVehicleExitBar(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOMRIGHT", SoraBar2, "TOPRIGHT", 0, C.ActionBar.Space},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 1,
            startPoint = "LEFT"
        }
    )
end

local function CreatePossessExitBar(self, event, ...)
    rActionBar:CreatePossessExitBar(
        "Sora",
        {
            frameScale = 1.0,
            framePoint = {"BOTTOMRIGHT", SoraBar2, "TOPRIGHT", 0, C.ActionBar.Space},
            framePadding = 0,
            buttonWidth = C.ActionBar.Size,
            buttonHeight = C.ActionBar.Size,
            buttonMargin = C.ActionBar.Space,
            numCols = 2,
            startPoint = "LEFT"
        }
    )
end

local function UpdateActionBarTexture(self, event, ...)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local button = _G["ActionButton" .. i]

        local icon = button.icon
        local texture = GetActionTexture(button.action)

        if texture then
            icon:SetTexture(texture)
            icon:Show()
        else
            icon:Hide()
        end

        button:UpdateUsable()
    end
end

local function OnMultiActionBarUpdateGridVisibility()
    if InCombatLockdown() then
        return 0
    end

    for k, v in pairs(actionBarPrefixs) do
        for i = 1, NUM_ACTIONBAR_BUTTONS do
            local button = _G[v .. i]

            if not button then
                break
            end

            button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_CVAR)
            button:SetAttribute("showgrid", tonumber(GetCVar("alwaysShowActionBars")))
        end
    end
end

-- Event
local function OnCVarUpdate(self, event, key, value)
    if key == "ALWAYS_SHOW_MULTIBARS_TEXT" then
        C_Timer.After(1 / 30, OnMultiActionBarUpdateGridVisibility)
    end
end

local function OnPlayerLogin(self, event, ...)
    CreateAnchor(self, event, ...)
    CreateAnchorLeftSide(self, event, ...)
    CreateAnchorRightSide(self, event, ...)

    CreateMainBar(self, event, ...)
    CreateSideBar(self, event, ...)
    CreateFunctionBar(self, event, ...)

    CreatePetBar(self, event, ...)
    CreateStanceBar(self, event, ...)

    CreateExtraBar(self, event, ...)
    CreatePossessExitBar(self, event, ...)
    CreateVehicleExitBar(self, event, ...)

    hooksecurefunc("MultiActionBar_UpdateGridVisibility", OnMultiActionBarUpdateGridVisibility)
end

local function OnSpellUpdateIcon(self, event, ...)
    UpdateActionBarTexture()
end

local function OnPlayerEnteringWorld(self, event, ...)
    MultiActionBar_UpdateGridVisibility()
end

local function OnUpdateVehicleActionBar(self, event, ...)
    UpdateActionBarTexture()
end

local function OnUpdateOverrideActionBar(self, event, ...)
    UpdateActionBarTexture()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.CVAR_UPDATE = OnCVarUpdate
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.SPELL_UPDATE_ICON = OnSpellUpdateIcon
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Event.UPDATE_VEHICLE_ACTIONBAR = OnUpdateVehicleActionBar
EventHandler.Event.UPDATE_OVERRIDE_ACTIONBAR = OnUpdateOverrideActionBar
EventHandler.Register()
