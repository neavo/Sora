-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	QuesterDB = {
		["profiles"] = {
			["Default"] = {
				["questLevels"] = true,
				["morework"] = false,
				["showTagIcons"] = true,
				["jobsdone"] = false,
				["trackerMovable"] = false,
				["sinkOptions"] = {
					["sink20OutputSink"] = "None"
				}
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
