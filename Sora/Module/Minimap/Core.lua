-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Common
local function CreateAnchor()
	local anchor = S.CreateButton(UIParent, 16, "SoraMinimap")
	anchor:Hide()
	anchor:SetText("小地图")
	anchor:SetSize(C.Minimap.Size, C.Minimap.Size)
	anchor:SetPoint(unpack(SoraDB.Minimap.Postion))
	anchor:SetMovable(true)
	anchor:EnableMouse(true)
	anchor:SetToplevel(true)
	anchor:SetFrameStrata("DIALOG")
	anchor:RegisterForDrag("LeftButton")
	anchor:SetClampedToScreen(true)

	if C.Config.Minimap.Mover and C.Config.Minimap.Mover.SoraMinimap then
		local frames = EditModeManagerFrame.registeredSystemFrames
		for i = #frames, 1, -1 do
			if frames[i]:GetName() == "MinimapCluster" then
				table.remove(frames, i)
			end
		end

		anchor:SetScript("OnDragStop", C.Config.Minimap.Mover.SoraMinimap.OnDragStop)
		anchor:SetScript("OnDragStart", C.Config.Minimap.Mover.SoraMinimap.OnDragStart)

		C.Config.Minimap.Mover.SoraMinimap.anchor = anchor
	end
end

local function SetBlz()
	MinimapCluster:Hide()
	MinimapCluster.Show = S.Dummy

	S.KillFrame(Minimap.ZoomIn)
	S.KillFrame(Minimap.ZoomOut)
	S.KillFrame(Minimap.ZoomHitArea)
	S.KillFrame(MinimapCompassTexture)
end

local function SetClock()
	local clock = S.CreateButton(Minimap, 12)
	clock:SetSize(48, 16)
	clock:SetPoint("TOP", Minimap, 0, -3)
	clock:SetFrameLevel(Minimap:GetFrameLevel() + 1)

	local function OnTicker()
		clock:SetText(GameTime_GetLocalTime(true))
	end

	local function OnEnter(self, ...)
		local doubleLineColor = {0.90, 0.90, 0.90, 0.90, 0.90, 0.90}

		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:ClearLines()

		GameTooltip:AddLine(date("%Y年%m月%d日"), 0.44, 0.75, 0.96)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_LOCALTIME, GameTime_GetLocalTime(true), unpack(doubleLineColor))
		GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_REALMTIME, GameTime_GetGameTime(true), unpack(doubleLineColor))

		GameTooltip:Show()
	end

	local function OnLeave(self, ...)
		GameTooltip:Hide()
	end

	local function OnClick(self, btn, ...)
		GameTimeFrame:Click()
	end

	C_Timer.NewTicker(1.00, OnTicker)
	clock:HookScript("OnLeave", OnLeave)
	clock:HookScript("OnEnter", OnEnter)
	clock:HookScript("OnClick", OnClick)
end

local function SetMinimap()
	Minimap:SetSize(SoraMinimap:GetSize())
	Minimap:SetParent(UIParent)
	Minimap:ClearAllPoints()
	Minimap:SetAllPoints(SoraMinimap)
	Minimap:SetFrameStrata("MEDIUM")
	Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")

	Minimap.Shadow = S.MakeShadow(Minimap, 2)
	Minimap.Shadow:SetFrameLevel(Minimap:GetFrameLevel())
end

local function SetTracking()
	S.KillFrame(MinimapCluster.Tracking.Background)
	SetCVar("minimapTrackingShowAll", 1) -- 显示所有追踪选项

	MinimapCluster.Tracking:SetSize(16, 16)
	MinimapCluster.Tracking:SetParent(Minimap)
	MinimapCluster.Tracking:SetFrameStrata(Minimap:GetFrameStrata())
	MinimapCluster.Tracking:SetFrameLevel(Minimap:GetFrameLevel() + 2)

	MinimapCluster.Tracking.BG = S.CreateButton(MinimapCluster.Tracking, 20)
	MinimapCluster.Tracking.BG:SetSize(20, 20)
	MinimapCluster.Tracking.BG:SetFrameStrata(Minimap:GetFrameStrata())
	MinimapCluster.Tracking.BG:SetFrameLevel(Minimap:GetFrameLevel() + 1)

	MinimapCluster.Tracking:ClearAllPoints()
	MinimapCluster.Tracking:SetPoint("CENTER", MinimapCluster.Tracking.BG)
	MinimapCluster.Tracking.BG:SetPoint("BOTTOMLEFT", Minimap, 3, 3)

	local function OnTrackingButtonEnter()
		MinimapCluster.Tracking.BG:GetScript("OnEnter")()
	end

	local function OnTrackingButtonLeave()
		MinimapCluster.Tracking.BG:GetScript("OnLeave")()
	end

	local function OnTrackingButtonMouseDown()
		MinimapCluster.Tracking.BG:GetScript("OnClick")()
	end

	MinimapCluster.Tracking.Button:SetAllPoints()
	MinimapCluster.Tracking.Button:HookScript("OnEnter", OnTrackingButtonEnter)
	MinimapCluster.Tracking.Button:HookScript("OnLeave", OnTrackingButtonLeave)
	MinimapCluster.Tracking.Button:HookScript("OnMouseDown", OnTrackingButtonMouseDown)
end

local function SetMailFrame()
	MiniMapMailIcon:SetAllPoints()
	MinimapCluster.MailFrame:SetSize(20, 15)
	MinimapCluster.MailFrame:SetParent(Minimap)
	MinimapCluster.MailFrame:ClearAllPoints()
	MinimapCluster.MailFrame:SetPoint("TOPLEFT", Minimap, 3, -3)
	MinimapCluster.MailFrame:SetFrameStrata(Minimap:GetFrameStrata())
	MinimapCluster.MailFrame:SetFrameLevel(Minimap:GetFrameLevel() + 1)
end

local function SetQueueStatusButton()
	-- 隐藏系统自带的眼睛图标
	QueueStatusButtonIcon:SetAlpha(0)

	-- 修改鼠标提示框体的位置
	QueueStatusFrame:ClearAllPoints()
	QueueStatusFrame:SetPoint("TOPLEFT", QueueStatusButton, "BOTTOMLEFT", -16, 0)

	QueueStatusButton:SetSize(16, 16)
	QueueStatusButton:ClearAllPoints()
	QueueStatusButton:SetPoint("TOPRIGHT", Minimap, -3, -3)
	QueueStatusButton:SetParent(Minimap)
	QueueStatusButton:SetFrameStrata(Minimap:GetFrameStrata())
	QueueStatusButton:SetFrameLevel(Minimap:GetFrameLevel() + 2)

	QueueStatusButton.Icon = QueueStatusButton:CreateTexture(nil, "ARTWORK")
	QueueStatusButton.Icon:SetAllPoints()
	QueueStatusButton.Icon:SetTexture("Interface\\Minimap\\Raid_Icon")
	QueueStatusButton.Icon:SetTexCoord(0.30, 0.70, 0.30, 0.70)

	QueueStatusButton.Icon.AnimationGroup = QueueStatusButton.Icon:CreateAnimationGroup()
	QueueStatusButton.Icon.AnimationGroup:SetLooping("REPEAT")
	QueueStatusButton.Icon.AnimationGroup.Animation = QueueStatusButton.Icon.AnimationGroup:CreateAnimation("Rotation")
	QueueStatusButton.Icon.AnimationGroup.Animation:SetDuration(2)
	QueueStatusButton.Icon.AnimationGroup.Animation:SetDegrees(360)

	local function QueueStatusButtonOnShow()
		QueueStatusButton.Icon:Show()
	end

	local function QueueStatusButtonOnHide()
		QueueStatusButton.Icon:Hide()
	end

	local function QueueStatusButtonEyePlayAnim()
		QueueStatusButton.Icon.AnimationGroup:Play()
	end

	local function QueueStatusButtonEyeStartPokeAnimationEnd()
		QueueStatusButton.Icon.AnimationGroup.Animation:SetDuration(2.0)
	end

	local function QueueStatusButtonEyeStartPokeAnimationInitial()
		QueueStatusButton.Icon.AnimationGroup.Animation:SetDuration(0.5)
	end

	QueueStatusButton:HookScript("OnShow", QueueStatusButtonOnShow)
	QueueStatusButton:HookScript("OnHide", QueueStatusButtonOnHide)
	hooksecurefunc(QueueStatusButton.Eye, "PlayAnim", QueueStatusButtonEyePlayAnim)
	hooksecurefunc(QueueStatusButton.Eye, "StartPokeAnimationEnd", QueueStatusButtonEyeStartPokeAnimationEnd)
	hooksecurefunc(QueueStatusButton.Eye, "StartPokeAnimationInitial", QueueStatusButtonEyeStartPokeAnimationInitial)
end

local function SetMouseClick()
	local menu = S.CreateEasyMenu()
	menu.NewLine("系统菜单", nil, nil, {isTitle = true})
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

	local function OnMouseUp(self, btn, ...)
		if btn == "RightButton" then
			menu.Show()
		else
			Minimap:OnClick()
		end
	end

	Minimap:SetScript("OnMouseUp", OnMouseUp)
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

	SetBlz()
	SetClock()
	SetMinimap()
	SetTracking()
	SetMailFrame()
	SetQueueStatusButton()

	SetMouseClick()
	SetMouseScroll()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
