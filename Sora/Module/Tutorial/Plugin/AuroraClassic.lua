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
		["FlatColor"] = {
			0.2, -- [1]
			0.2, -- [2]
			0.2, -- [3]
			0.6, -- [4]
		},
		["Bags"] = false,
		["Alpha"] = 0.5,
		["CustomColor"] = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		["FontOutline"] = true,
		["ObjectiveTracker"] = true,
		["Loot"] = true,
		["UIScale"] = 0.71111,
		["FontScale"] = 1,
		["GradientColor"] = {
			0.3, -- [1]
			0.3, -- [2]
			0.3, -- [3]
			0.3, -- [4]
		},
		["Tooltips"] = false,
		["UseCustomColor"] = false,
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
