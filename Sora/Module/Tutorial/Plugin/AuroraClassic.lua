-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AuroraClassicDB = {
		["Shadow"] = true,
		["FlatMode"] = true,
		["ChatBubbles"] = true,
		["Bags"] = false,
		["Alpha"] = 0.5,
		["ObjectiveTracker"] = true,
		["Loot"] = true,
		["FontOutline"] = false,
		["FontScale"] = 1,
		["Tooltips"] = false,
		["UIScale"] = 0.71111,
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
