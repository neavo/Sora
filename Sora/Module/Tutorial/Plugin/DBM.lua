-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	DBT_AllPersistentOptions = DBT_AllPersistentOptions or {}
	DBT_AllPersistentOptions.Default = DBT_AllPersistentOptions.Default or {}
	DBT_AllPersistentOptions.Default.DBM = DBT_AllPersistentOptions.Default.DBM or {}

	DBT_AllPersistentOptions.Default.DBM.TimerX = nil
	DBT_AllPersistentOptions.Default.DBM.TimerY = nil
	DBT_AllPersistentOptions.Default.DBM.TimerPoint = nil
	DBT_AllPersistentOptions.Default.DBM.HugeTimerX = 0
	DBT_AllPersistentOptions.Default.DBM.HugeTimerY = -64
	DBT_AllPersistentOptions.Default.DBM.HugeTimerPoint = "CENTER"
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
