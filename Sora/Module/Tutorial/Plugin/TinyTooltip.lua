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
	BigTipDB.general.bgfile = "dark"
	BigTipDB.general.borderSize = 1
	BigTipDB.general.borderColor = {0.90, 0.90, 0.90, 1.00}
	BigTipDB.general.borderCorner = "1 Pixel"
	BigTipDB.general.anchor = {
		["returnOnUnitFrame"] = false,
		["position"] = "cursorRight",
		["hiddenInCombat"] = true,
		["cp"] = "BOTTOM",
		["p"] = "BOTTOMRIGHT",
		["returnInCombat"] = false
	}

	BigTipDB.item = {}
	BigTipDB.item.coloredItemBorder = true

	BigTipDB.unit = {}
	BigTipDB.unit.npc = {}
	BigTipDB.unit.npc.showModel = false
	BigTipDB.unit.npc.background = {
		["alpha"] = 0.70,
		["colorfunc"] = "default"
	}
	BigTipDB.unit.player = {}
	BigTipDB.unit.player.showModel = false
	BigTipDB.unit.player.background = {
		["alpha"] = 0.70,
		["colorfunc"] = "default"
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
