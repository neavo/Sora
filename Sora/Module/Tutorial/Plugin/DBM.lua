-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	DBM_AllSavedOptions = DBM_AllSavedOptions or {}
	DBM_AllSavedOptions.Default = {}
	DBM_AllSavedOptions.Default.WarningFontStyle = "OUTLINE"
	DBM_AllSavedOptions.Default.EventSoundVictory = "None"
	DBM_AllSavedOptions.Default.EventSoundVictory2 = "None"
	DBM_AllSavedOptions.Default.SpecialWarningFontShadow = true

	DBT_AllPersistentOptions = DBT_AllPersistentOptions or {}
	DBT_AllPersistentOptions.Default = {}
	DBT_AllPersistentOptions.Default.DBM = {}

	DBT_AllPersistentOptions.Default.DBM.FontFlag = "OUTLINE"
	DBT_AllPersistentOptions.Default.DBM.IconLeft = true
	DBT_AllPersistentOptions.Default.DBM.IconRight = true
	DBT_AllPersistentOptions.Default.DBM.HugeScale = 1.00
	DBT_AllPersistentOptions.Default.DBM.HugeTimerX = 0
	DBT_AllPersistentOptions.Default.DBM.HugeTimerY = -64
	DBT_AllPersistentOptions.Default.DBM.HugeTimerPoint = "CENTER"

	if IsAddOnLoaded("DBM-VPYike") then
		DBM_AllSavedOptions.Default.ChosenVoicePack = "Yike"
		DBM_AllSavedOptions.Default.CountdownVoice = "VP:Yike"
		DBM_AllSavedOptions.Default.CountdownVoice2 = "VP:Yike"
		DBM_AllSavedOptions.Default.CountdownVoice3 = "VP:Yike"
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
