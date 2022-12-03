-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function StyleActionButton(btn)
    if not btn.__Styled then
        btn.__Styled = true

        btn.Shadow = S.MakeShadow(btn, 2)
        btn.Shadow:SetFrameLevel(btn:GetFrameLevel() + 1)

        btn.BG = btn:CreateTexture(nil, "BACKGROUND")
        btn.BG:SetAllPoints()
        btn.BG:SetTexture(DB.Backdrop)
        btn.BG:SetVertexColor(0.20, 0.20, 0.20, 0.60)
    end

    if btn.icon then
        btn.icon:SetAllPoints()
        btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        btn.icon:SetDrawLayer("BACKGROUND", 1)
    end

    if btn.cooldown then
        btn.cooldown:SetAllPoints()
    end

    if btn.Name then
        btn.Name:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
        btn.Name:SetSize(btn:GetWidth(), 10)
        btn.Name:ClearAllPoints()
        btn.Name:SetPoint("BOTTOM", 0, 0)
    end

    if btn.Count then
        btn.Count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        btn.Count:SetSize(btn:GetWidth() - 4, 12)
        btn.Count:ClearAllPoints()
        btn.Count:SetPoint("TOPLEFT", 1, -2)
        btn.Count:SetJustifyH("LEFT")
    end

    if btn.HotKey then
        btn.HotKey:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        btn.HotKey:SetSize(btn:GetWidth() - 4, 12)
        btn.HotKey:ClearAllPoints()
        btn.HotKey:SetPoint("TOPRIGHT", -1, -2)
    end

    if btn.Flash then
        btn.Flash:SetAllPoints()
        btn.Flash:SetTexture(DB.Backdrop)
        btn.Flash:SetVertexColor(0.90, 0.00, 0.00, 0.50)
    end

    if btn.AutoCastable then
        btn.AutoCastable:SetAllPoints()
        btn.AutoCastable:SetTexCoord(0.22, 0.78, 0.22, 0.78)
    end

    if btn.AutoCastShine then
        btn.AutoCastShine:SetAllPoints()
    end

    if btn.PushedTexture then
        btn.PushedTexture:SetAllPoints()
        btn.PushedTexture:SetVertexColor(0.90, 0.90, 0.90)
        btn.PushedTexture:SetTexture(DB.ActionButton.PushedTexture)
    end

    if btn.CheckedTexture then
        btn.CheckedTexture:SetAllPoints()
        btn.CheckedTexture:SetTexture(DB.ActionButton.CheckedTexture)
        btn.CheckedTexture:SetVertexColor(1.00, 1.00, 1.00, 0.50)
    end

    if btn.HighlightTexture then
        btn.HighlightTexture:SetAllPoints()
        btn.HighlightTexture:SetTexture(DB.Backdrop)
        btn.HighlightTexture:SetVertexColor(1.00, 1.00, 1.00, 0.50)
    end

    if btn.NewActionTexture then
        btn.NewActionTexture:SetAllPoints()
        btn.NewActionTexture:SetTexture(DB.ActionButton.NewActionTexture)
        btn.NewActionTexture:SetVertexColor(1.00, 1.00, 1.00, 0.50)
    end

    if btn.QuickKeybindHighlightTexture then
        btn.QuickKeybindHighlightTexture:SetAllPoints()
        btn.QuickKeybindHighlightTexture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
    end

    if btn.Border then
        btn.Border:SetAllPoints()
        btn.Border:SetTexture(0)
    end

    if btn.SlotArt then
        btn.SlotArt:SetAllPoints()
        btn.SlotArt:SetTexture(0)
    end

    if btn.IconMask then
        btn.IconMask:Hide()
    end

    if btn.RightDivider then
        btn.RightDivider:Hide()
    end

    if btn.BottomDivider then
        btn.BottomDivider:Hide()
    end

    if btn.SlotBackground then
        btn.SlotBackground:SetAllPoints()
        btn.SlotBackground:SetTexture(0)
    end

    if btn.NormalTexture then
        btn.NormalTexture:SetAllPoints()
        btn.NormalTexture:SetTexture(0)
    end
end

-- Begin
local function SetBlz()
    -- 干掉动作条装饰与翻页按钮
    S.KillFrame(MainMenuBar.EndCaps)
    S.KillFrame(MainMenuBar.BorderArt)
    S.KillFrame(MainMenuBar.Background)
    S.KillFrame(MainMenuBar.ActionBarPageNumber)

    -- 禁用动作条对鼠标操作的响应
    MainMenuBar:EnableMouse(false)
    MultiBarBottomLeft:EnableMouse(false)
    MultiBarBottomRight:EnableMouse(false)
    MultiBar5:EnableMouse(false)
    MultiBar6:EnableMouse(false)
    MultiBarLeft:EnableMouse(false)
    MultiBarRight:EnableMouse(false)
    StanceBar:EnableMouse(false)
    PetActionBar:EnableMouse(false)
    PossessActionBar:EnableMouse(false)
    ExtraActionBarFrame:EnableMouse(false)
end

local function SetMainBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["ActionButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarBottomLeftButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarBottomRightButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetLeftBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarLeftButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBarRightButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetRightBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBar5Button" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["MultiBar6Button" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetStanceBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["StanceButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetPetActionBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["PetActionButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetPossessActionBar()
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local btn = _G["PossessButton" .. i]

        if not btn then
            break
        end

        StyleActionButton(btn)
    end
end

local function SetExtraActionButton()
    StyleActionButton(ExtraActionButton1)
end

local function SetVehicleLeaveButton()
    if not MainMenuBarVehicleLeaveButton then
        return
    end

    if not MainMenuBarVehicleLeaveButton.__Styled then
        MainMenuBarVehicleLeaveButton.__Styled = true
        MainMenuBarVehicleLeaveButton.Shadow = S.MakeShadow(MainMenuBarVehicleLeaveButton, 2)
        MainMenuBarVehicleLeaveButton.Shadow:SetFrameLevel(MainMenuBarVehicleLeaveButton:GetFrameLevel() + 1)

        MainMenuBarVehicleLeaveButton.BG = MainMenuBarVehicleLeaveButton:CreateTexture(nil, "BACKGROUND")
        MainMenuBarVehicleLeaveButton.BG:SetAllPoints()
        MainMenuBarVehicleLeaveButton.BG:SetTexture(DB.Backdrop)
        MainMenuBarVehicleLeaveButton.BG:SetVertexColor(0.20, 0.20, 0.20, 0.60)
    end

    MainMenuBarVehicleLeaveButton:GetNormalTexture():SetAllPoints()
    MainMenuBarVehicleLeaveButton:GetNormalTexture():SetTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Down")
    MainMenuBarVehicleLeaveButton:GetNormalTexture():SetTexCoord(0.18, 0.82, 0.18, 0.82)

    MainMenuBarVehicleLeaveButton:GetPushedTexture():SetAllPoints()
    MainMenuBarVehicleLeaveButton:GetPushedTexture():SetTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up")
    MainMenuBarVehicleLeaveButton:GetPushedTexture():SetTexCoord(0.18, 0.82, 0.18, 0.82)

    MainMenuBarVehicleLeaveButton:GetHighlightTexture():SetAllPoints()
    MainMenuBarVehicleLeaveButton:GetHighlightTexture():SetTexture(DB.Backdrop)
    MainMenuBarVehicleLeaveButton:GetHighlightTexture():SetVertexColor(1.00, 1.00, 1.00, 0.50)
end

-- Event
local function OnPlayerEnteringWorld(self, event, ...)
    SetBlz()
    SetMainBar()
    SetLeftBar()
    SetRightBar()
    SetStanceBar()
    SetPetActionBar()
    SetPossessActionBar()
    SetExtraActionButton()
    SetVehicleLeaveButton()
end

local function OnActiveCombatConfigChanged(self, event, ...)
    SetBlz()
    SetMainBar()
    SetLeftBar()
    SetRightBar()
    SetStanceBar()
    SetPetActionBar()
    SetPossessActionBar()
    SetExtraActionButton()
    SetVehicleLeaveButton()
end

-- Handler
local Handler = S.CreateEventHandler()
Handler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
Handler.Event.ACTIVE_COMBAT_CONFIG_CHANGED = OnActiveCombatConfigChanged
Handler.Register()
