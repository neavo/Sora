-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Event
local function OnPlayerLogin(self, event, ...)
	if AuroraConfig then
		AuroraConfig.tooltips = false
		AuroraConfig.reskinFont = false
		AuroraConfig.bubbleColor = false
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
