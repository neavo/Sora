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
						["colorB"] = 0.12,
						["colorA"] = 0.50,
						["colorG"] = 0.12,
						["colorR"] = 0.12
					}
				}
			},
			["Coords"] = {
				["profiles"] = {
					["Default"] = {
						["accuracy"] = 2
					}
				}
			}
		},
		["profiles"] = {
			["Default"] = {
				["ejScale"] = 1.00,
				["scale"] = 1.20,
				["poiScale"] = 1.00
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
