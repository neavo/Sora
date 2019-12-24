-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function SetMinimap()
    Minimap:ClearAllPoints()
    Minimap:SetFrameStrata("MEDIUM")
    Minimap:SetPoint(unpack(C.MiniMap.Postion))
    Minimap:SetSize(C.MiniMap.Width, C.MiniMap.Height)
    Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")

    if not Minimap.Shadow then
        Minimap.Shadow = S.MakeShadow(Minimap, 2)
    end
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
    local frame = CreateFrame("Frame", "SoraMinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")

    local menus = {
        {
            text = CHARACTER_BUTTON,
            func = function()
                CharacterMicroButton:Click()
            end
        },
        {
            text = SPELLBOOK_ABILITIES_BUTTON,
            func = function()
                SpellbookMicroButton:Click()
            end
        },
        {
            text = TALENTS_BUTTON,
            func = function()
                TalentMicroButton:Click()
            end
        },
        {
            text = ACHIEVEMENT_BUTTON,
            func = function()
                AchievementMicroButton:Click()
            end
        },
        {
            text = QUESTLOG_BUTTON,
            func = function()
                QuestLogMicroButton:Click()
            end
        },
        {
            text = GUILD,
            func = function()
                GuildMicroButton:Click()
            end
        },
        {
            text = LFG_TITLE,
            func = function()
                LFDMicroButton:Click()
            end
        },
        {
            text = MOUNTS_AND_PETS,
            func = function()
                CollectionsMicroButton:Click()
            end
        },
        {
            text = ENCOUNTER_JOURNAL,
            func = function()
                EJMicroButton:Click()
            end
        },
        {
            text = BLIZZARD_STORE,
            func = function()
                StoreMicroButton:Click()
            end
        },
        {
            text = MAINMENU_BUTTON,
            func = function()
                MainMenuMicroButton:Click()
            end
        },
        {
            text = INVTYPE_BAG,
            func = function()
                ToggleAllBags:Click()
            end
        },
        {
            text = SOCIAL_BUTTON,
            func = function()
                ToggleFriendsFrame(1)
            end
        },
        {
            text = HELP_BUTTON,
            func = function()
                HelpMicroButton:Click()
            end
        }
    }

    local OnMouseUp = function(self, btn, ...)
        if btn ~= "RightButton" then
            Minimap_OnClick(self)
        else
            EasyMenu(menus, frame, "cursor", 0, 0, "MENU", 2)
        end
    end

    Minimap:SetScript("OnMouseUp", OnMouseUp)
end

local function SetMouseScroll()
    local OnMouseWheel = function(self, z, ...)
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
