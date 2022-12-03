-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	BigTipDB = {}
	BigTipDB.version = 0.01

	BigTipDB.general = {}
	BigTipDB.general.mask = false
	BigTipDB.general.scale = 1.00
	BigTipDB.general.borderSize = 1.00
	BigTipDB.general.borderCorner = "angular"
	BigTipDB.general.alwaysShowIdInfo = true
	BigTipDB.general.statusbarFont = "default"
	BigTipDB.general.statusbarTexture = "Solid"
	BigTipDB.general.statusbarFontFlag = "OUTLINE"
	BigTipDB.general.anchor = {
		["position"] = "cursorRight",
		["p"] = "BOTTOMRIGHT",
		["cp"] = "BOTTOM",
		["hiddenInCombat"] = true,
		["returnInCombat"] = false,
		["returnOnUnitFrame"] = false
	}

	BigTipDB.unit = {}
	BigTipDB.unit.npc = {}
	BigTipDB.unit.npc.showModel = false

	BigTipDB.unit.player = {}
	BigTipDB.unit.player.showModel = false
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
