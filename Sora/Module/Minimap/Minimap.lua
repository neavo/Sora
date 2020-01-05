-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
    local anchor = CreateFrame("Frame", "SoraMinimap", UIParent)
    anchor:Hide()
    anchor:SetSize(C.Minimap.Width, C.Minimap.Height)
    anchor:SetPoint(unpack(SoraDB.Minimap.Postion))
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
    anchor.text:SetText("小地图")
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

    if C.Config.Minimap.Mover and C.Config.Minimap.Mover.SoraMinimap then
        anchor:SetScript("OnLeave", OnLeave)
        anchor:SetScript("OnEnter", OnEnter)
        anchor:SetScript("OnDragStop", C.Config.Minimap.Mover.SoraMinimap.OnDragStop)
        anchor:SetScript("OnDragStart", C.Config.Minimap.Mover.SoraMinimap.OnDragStart)

        C.Config.Minimap.Mover.SoraMinimap.anchor = anchor
    end
end

local function SetMinimap()
    local anchor = SoraMinimap

    Minimap:ClearAllPoints()
    Minimap:SetSize(SoraMinimap:GetSize())
    Minimap:SetAllPoints(SoraMinimap)
    Minimap:SetFrameStrata("MEDIUM")
    Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")

    Minimap.Shadow = S.MakeShadow(Minimap, 2)
end

local function SetBlzFrame()
    -- Cluster
    MinimapCluster:EnableMouse(false)

    -- Tracking
    MiniMapTracking:SetScale(1.00)
    MiniMapTracking:ClearAllPoints()
    MiniMapTracking:SetPoint("BOTTOMLEFT", Minimap, -5, -5)
    MiniMapTrackingButton:SetAlpha(0.00)
    MiniMapTrackingBackground:SetAlpha(0.00)

    -- Random Group icon
    QueueStatusMinimapButton:SetScale(0.90)
    QueueStatusMinimapButton:ClearAllPoints()
    QueueStatusMinimapButton:SetFrameStrata("MEDIUM")
    QueueStatusMinimapButton:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 4)
    QueueStatusMinimapButtonBorder:SetAlpha(0.00)

    -- Mail icon
    MiniMapMailFrame:SetScale(0.90)
    MiniMapMailFrame:ClearAllPoints()
    MiniMapMailFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -2, 4)

    -- Garrison
    GarrisonLandingPageMinimapButton:SetScale(0.55)
    GarrisonLandingPageMinimapButton:ClearAllPoints()
    GarrisonLandingPageMinimapButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, -4)
end

local function HideBlzFrame()
    S.KillFrame(StreamingIcon)
    S.KillFrame(GuildInstanceDifficulty)
    S.KillFrame(MiniMapInstanceDifficulty)
    S.KillFrame(GameTimeCalendarInvitesTexture)
    S.KillFrame(GameTimeFrame)
    S.KillFrame(MinimapBorderTop)
    S.KillFrame(MinimapNorthTag)
    S.KillFrame(MinimapBorder)
    S.KillFrame(MinimapZoneTextButton)
    S.KillFrame(MinimapZoomOut)
    S.KillFrame(MinimapZoomIn)
    S.KillFrame(MiniMapWorldMapButton)
    S.KillFrame(MiniMapMailBorder)
end

local function SetMouseClick()
    local menu = S.CreateEasyMenu()
    menu.NewLine(CHARACTER_BUTTON, ToggleCharacter, {"PaperDollFrame"})
    menu.NewLine(SPELLBOOK_ABILITIES_BUTTON, SpellbookMicroButton.Click, {SpellbookMicroButton})
    menu.NewLine(TALENTS_BUTTON, TalentMicroButton.Click, {TalentMicroButton})
    menu.NewLine(ACHIEVEMENT_BUTTON, AchievementMicroButton.Click, {AchievementMicroButton})
    menu.NewLine(QUESTLOG_BUTTON, QuestLogMicroButton.Click, {QuestLogMicroButton})
    menu.NewLine(GUILD, GuildMicroButton.Click, {GuildMicroButton})
    menu.NewLine(LFG_TITLE, LFDMicroButton.Click, {LFDMicroButton})
    menu.NewLine(MOUNTS_AND_PETS, CollectionsMicroButton.Click, {CollectionsMicroButton})
    menu.NewLine(ENCOUNTER_JOURNAL, EJMicroButton.Click, {EJMicroButton})
    menu.NewLine(BLIZZARD_STORE, StoreMicroButton.Click, {StoreMicroButton})
    menu.NewLine(MAINMENU_BUTTON, ToggleFrame, {GameMenuFrame})
    menu.NewLine(INVTYPE_BAG, ToggleAllBags)
    menu.NewLine(SOCIAL_BUTTON, ToggleFriendsFrame, {1})
    menu.NewLine(HELP_BUTTON, HelpMicroButton.Click, {HelpMicroButton})

    local function OnMouseDown(self, btn, ...)
        if btn == "RightButton" then
            menu.Show()
        else
            Minimap_OnClick(self)
        end
    end

    Minimap:SetScript("OnMouseUp", nil)
    Minimap:SetScript("OnMouseDown", OnMouseDown)
end

local function SetMouseScroll()
    local function OnMouseWheel(self, z, ...)
        local c = Minimap:GetZoom()
        if z > 0 and c < 5 then
            Minimap:SetZoom(c + 1)
        elseif z < 0 and c > 0 then
            Minimap:SetZoom(c - 1)
        end
    end

    Minimap:EnableMouseWheel(true)
    Minimap:SetScript("OnMouseWheel", OnMouseWheel)
end

local function OnPlayerLogin(self, event, unit, ...)
    CreateAnchor()
    SetMinimap()
    SetBlzFrame()
    HideBlzFrame()
    SetMouseClick()
    SetMouseScroll()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
