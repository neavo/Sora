-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	TinyInspectDB = {}
	TinyInspectDB.version = 0.01
	TinyInspectDB.ShowItemStats = true
	TinyInspectDB.ShowPluginGreenState = true
	TinyInspectDB.ShowInspectAngularBorder = true
	TinyInspectDB.ShowOwnFrameWhenInspecting = true
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
