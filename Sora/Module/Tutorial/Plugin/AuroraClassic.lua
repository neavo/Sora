-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AuroraConfig = {
		["useButtonGradientColour"] = false,
		["shadow"] = true,
		["reskinFont"] = false,
		["uiScale"] = 0.7111111283302307,
		["chatBubbles"] = true,
		["bags"] = true,
		["alpha"] = 0.5,
		["fontScale"] = 1,
		["objectiveTracker"] = true,
		["buttonGradientColour"] = {
			0.3, -- [1]
			0.3, -- [2]
			0.3, -- [3]
			0.3 -- [4]
		},
		["loot"] = true,
		["tooltips"] = false,
		["useCustomColour"] = false,
		["customColour"] = {
			["b"] = 1,
			["g"] = 1,
			["r"] = 1
		},
		["bubbleColor"] = true,
		["buttonSolidColour"] = {
			0.2, -- [1]
			0.2, -- [2]
			0.2, -- [3]
			0.6 -- [4]
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
