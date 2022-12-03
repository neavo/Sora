-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local engine = nil
local size, space = nil, nil

-- Common
local function SetMainBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["ActionButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("BOTTOMLEFT", SoraActionBar, "BOTTOMLEFT", size * 3 + space * 4, 0)
		else
			btn:SetPoint("LEFT", _G["ActionButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBarBottomLeftButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("BOTTOM", ActionButton1, "TOP", 0, space)
		else
			btn:SetPoint("LEFT", _G["MultiBarBottomLeftButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBarBottomRightButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("TOPLEFT", SoraActionBar, "TOPLEFT", 0, 0)
		elseif i == 7 then
			btn:SetPoint("TOPLEFT", MultiBarBottomLeftButton12, "TOPRIGHT", space * 2, 0)
		elseif mod(i, 3) == 1 then
			btn:SetPoint("TOP", _G["MultiBarBottomRightButton" .. (i - 3)], "BOTTOM", 0, -space)
		else
			btn:SetPoint("LEFT", _G["MultiBarBottomRightButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end
end

local function SetLeftBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBarLeftButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("TOPLEFT", SoraActionBarLeftSide, "TOPLEFT", 0, 0)
		else
			btn:SetPoint("TOP", _G["MultiBarLeftButton" .. (i - 1)], "BOTTOM", 0, -space)
		end
	end

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBarRightButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("LEFT", MultiBarLeftButton1, "RIGHT", space, 0)
		else
			btn:SetPoint("TOP", _G["MultiBarRightButton" .. (i - 1)], "BOTTOM", 0, -space)
		end
	end
end

local function SetRightBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBar5Button" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("TOPLEFT", SoraActionBarRightSide, "TOPLEFT", 0, 0)
		else
			btn:SetPoint("TOP", _G["MultiBar5Button" .. (i - 1)], "BOTTOM", 0, -space)
		end
	end

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["MultiBar6Button" .. i]

		if not btn then
			break
		end

		btn:SetSize(size, size)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("LEFT", MultiBar5Button1, "RIGHT", space, 0)
		else
			btn:SetPoint("TOP", _G["MultiBar6Button" .. (i - 1)], "BOTTOM", 0, -space)
		end
	end
end

local function SetStanceBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["StanceButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size * 0.75, size * 0.75)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, space)
		else
			btn:SetPoint("LEFT", _G["StanceButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end
end

local function SetPetActionBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["PetActionButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size * 0.75, size * 0.75)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("BOTTOMLEFT", SoraActionBar, "TOPLEFT", size*3 + space * 4, space)
		else
			btn:SetPoint("LEFT", _G["PetActionButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end
end

local function SetPossessActionBar()
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local btn = _G["PossessButton" .. i]

		if not btn then
			break
		end

		btn:SetSize(size * 0.75, size * 0.75)
		btn:ClearAllPoints()

		if i == 1 then
			btn:SetPoint("BOTTOMLEFT", SoraActionBar, "TOPLEFT", size*3 + space * 4, space)
		else
			btn:SetPoint("LEFT", _G["PossessButton" .. (i - 1)], "RIGHT", space, 0)
		end
	end
end

local function SetExtraActionButton()
	if not ExtraActionButton1 then
		return
	end

	ExtraActionButton1:SetSize(size, size)
	ExtraActionButton1:ClearAllPoints()
	ExtraActionButton1:SetPoint("BOTTOMLEFT", SoraActionBar, "TOPLEFT", 0, space)
end

local function SetVehicleLeaveButton()
	if not MainMenuBarVehicleLeaveButton then
		return
	end

	MainMenuBarVehicleLeaveButton:SetSize(size, size)
	MainMenuBarVehicleLeaveButton:ClearAllPoints()
	MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMRIGHT", SoraActionBar, "TOPRIGHT", 0, space)
end

-- Begin
local function CreateAnchor()
	local width = size * 18 + space * 19
	local height = size * 2 + space * 1

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
	local width = size * 2 + space
	local height = size * 12 + space * 11

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
	local width = size * 2 + space
	local height = size * 12 + space * 11

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

local function MultiBarBottomLeftButtonSetPoint(self, ...)
	local _, frame = ...

	if frame and frame.GetName and frame:GetName() ~= "ActionButton1" then
		SetMainBar()
	end
end

local function PetActionBarSetPoint(self, ...)
	local _, frame = ...

	if frame and frame.GetName and frame:GetName() ~= "SoraActionBar" then
		SetPetActionBar()
	end
end

local function MainMenuBarVehicleLeaveButtonSetPoint(self, ...)
	local _, frame = ...

	if frame and frame.GetName and frame:GetName() ~= "SoraActionBar" then
		SetVehicleLeaveButton()
	end
end

-- Event
local function OnInitialize(self, event, ...)
	size, space = C.ActionBar.Size, C.ActionBar.Space
end

local function OnPlayerLogin(self, event, ...)
	CreateAnchor()
	CreateAnchorLeftSide()
	CreateAnchorRightSide()

	hooksecurefunc(PetActionBar, "SetPoint", PetActionBarSetPoint)
	hooksecurefunc(MainMenuBarVehicleLeaveButton, "SetPoint", MainMenuBarVehicleLeaveButtonSetPoint)
end

local function OnPlayerEnteringWorld(self, event, ...)
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
Handler.Event.INITIALIZE = OnInitialize
Handler.Event.PLAYER_LOGIN = OnPlayerLogin
Handler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
Handler.Event.ACTIVE_COMBAT_CONFIG_CHANGED = OnActiveCombatConfigChanged
Handler.Register()
