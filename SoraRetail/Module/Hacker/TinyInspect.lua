-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Event
local function OnPlayerLogin(self, event, ...)
	if TinyInspectDB then
		TinyInspectDB.ShowInspectAngularBorder = true
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
