-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	QuesterDB = {}
	QuesterDB.profiles = {}
	QuesterDB.profiles.Default = {}
	QuesterDB.profiles.Default.morework = false
	QuesterDB.profiles.Default.jobsdone = false
	QuesterDB.profiles.Default.questLevels = true
	QuesterDB.profiles.Default.showTagIcons = true
	QuesterDB.profiles.Default.sinkOptions = {
		["sink20OutputSink"] = "None"
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
