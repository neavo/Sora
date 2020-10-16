-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	MapsterDB = {
		["namespaces"] = {
			["FogClear"] = {
				["profiles"] = {
					["Default"] = {
						["colorG"] = 0.00,
						["colorR"] = 0.00,
						["colorB"] = 0.00,
						["colorA"] = 0.50
					}
				}
			},
			["Coords"] = {
				["profiles"] = {
					["Default"] = {
						["fontSize"] = 12
					}
				}
			}
		},
		["profiles"] = {
			["Default"] = {
				["arrowScale"] = 1.00,
				["ejScale"] = 1.00,
				["scale"] = 1.25,
				["poiScale"] = 1.00
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
