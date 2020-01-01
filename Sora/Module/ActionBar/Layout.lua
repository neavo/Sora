-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function CreateMainBar(self, event, ...)
	local postion = C.ActionBar.Postion
	postion[4] = postion[4] - 2 * (C.ActionBar.Size + C.ActionBar.Space)

	rActionBar:CreateActionBar1(
		"Sora",
		{
			frameScale = 1.0,
			framePoint = {unpack(postion)},
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
			framePoint = {"BOTTOM", _G["SoraBar1"], "TOP", 0, C.ActionBar.Space},
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
			framePoint = {"LEFT", UIParent, C.ActionBar.Space, 0},
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
			framePoint = {"RIGHT", UIParent, -C.ActionBar.Space, 0},
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
			framePoint = {"BOTTOMLEFT", _G["SoraBar1"], "BOTTOMRIGHT", C.ActionBar.Space * 3, 0},
			framePadding = 0,
			buttonWidth = C.ActionBar.Size,
			buttonHeight = C.ActionBar.Size,
			buttonMargin = C.ActionBar.Space,
			numCols = 4,
			startPoint = "TOPLEFT"
		}
	)
end

local function CreatePetBar(self, event, ...)
	rActionBar:CreatePetBar(
		"Sora",
		{
			frameScale = 1.0,
			framePoint = {"BOTTOMLEFT", _G["SoraBar2"], "TOPLEFT", 0, C.ActionBar.Space},
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
			framePoint = {"BOTTOMLEFT", _G["SoraBar2"], "TOPLEFT", 0, C.ActionBar.Space},
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
	rActionBar:CreateExtraBar(
		"Sora",
		{
			frameScale = 1.0,
			framePoint = {
				"BOTTOM",
				_G["SoraBar2"],
				"TOP",
				C.ActionBar.Size * 2 + C.ActionBar.Space * 3,
				C.ActionBar.Size + C.ActionBar.Space * 2 + 16
			},
			framePadding = 0,
			buttonWidth = C.ActionBar.Size,
			buttonHeight = C.ActionBar.Size,
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
			framePoint = {"BOTTOMRIGHT", _G["SoraBar2"], "TOPRIGHT", 0, C.ActionBar.Space},
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
			framePoint = {"BOTTOMRIGHT", _G["SoraBar2"], "TOPRIGHT", 0, C.ActionBar.Space},
			framePadding = 0,
			buttonWidth = C.ActionBar.Size,
			buttonHeight = C.ActionBar.Size,
			buttonMargin = C.ActionBar.Space,
			numCols = 2,
			startPoint = "LEFT"
		}
	)
end

local function OnMultiActionBarUpdateGridVisibility()
	if InCombatLockdown() then
		return
	end

	local buttons = {}
	local buttonNames = {
		"ActionButton",
		"MultiBarBottomLeftButton",
		"MultiBarBottomRightButton",
		"MultiBarRightButton",
		"MultiBarLeftButton"
	}

	for k, v in pairs(buttonNames) do
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			local button = _G[v .. i]

			if not button then
				break
			end

			table.insert(buttons, button)
		end
	end

	for k, v in pairs(buttons) do
		ActionButton_ShowGrid(v, ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		v:SetAttribute("showgrid", tonumber(GetCVar("alwaysShowActionBars")))
	end
end

local function FixMultiActionBarUpdateGridVisibility(self, event, ...)
	hooksecurefunc("MultiActionBar_UpdateGridVisibility", OnMultiActionBarUpdateGridVisibility)

	do
		C_Timer.NewTicker(0.10, OnMultiActionBarUpdateGridVisibility, 1)
	end
end

local function OnCVarUpdate(self, event, key, value)
	if key == "ALWAYS_SHOW_MULTIBARS_TEXT" then
		C_Timer.NewTicker(0.10, OnMultiActionBarUpdateGridVisibility, 1)
	end
end

local function OnPlayerLogin(self, event, ...)
	CreateMainBar(self, event, ...)
	CreateSideBar(self, event, ...)
	CreateFunctionBar(self, event, ...)

	CreatePetBar(self, event, ...)
	CreateStanceBar(self, event, ...)

	CreateExtraBar(self, event, ...)
	CreatePossessExitBar(self, event, ...)
	CreateVehicleExitBar(self, event, ...)

	FixMultiActionBarUpdateGridVisibility(self, event, ...)
end

local function OnPlayerEnteringWorld(self, event, ...)
	MultiActionBar_UpdateGridVisibility()
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.CVAR_UPDATE = OnCVarUpdate
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
