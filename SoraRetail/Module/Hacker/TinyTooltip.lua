-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Event
local function OnPlayerLogin(self, event, ...)
	if BigTipDB then
		BigTipDB.general.bgfile = "dark"
		BigTipDB.general.borderSize = "1"
		BigTipDB.general.borderCorner = "1 Pixel"
		BigTipDB.general.skinMoreFrames = false

		BigTipDB.general.anchor.position = "cursorRight"
		BigTipDB.general.anchor.hiddenInCombat = true
		BigTipDB.general.anchor.returnInCombat = false
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
