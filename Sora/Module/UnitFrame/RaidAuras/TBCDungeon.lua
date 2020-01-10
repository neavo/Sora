-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	-- Initialize
	C.UnitFrame = C.UnitFrame or {}
	C.UnitFrame.RaidAuras = C.UnitFrame.RaidAuras or {}

	-- Hack
	local zoneid = 0
	local GridStatusRaidDebuff = {}
	GridStatusRaidDebuff.DebuffId = function(self, zoneid, spellId, priority)
		C.UnitFrame.RaidAuras[spellId] = priority
	end
	GridStatusRaidDebuff.BossNameId = function(self, zoneid, _, name)
		-- do nothing
	end

	-- TBC Dungeon
	-- Mana-Tombs
	do
		--local zone = "Mana-Tombs"
		local zoneid = 272

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 25602, 1, 6, 6) --Faerie Fire
		GridStatusRaidDebuff:DebuffId(zoneid, 34942, 1, 6, 6) --Shadow Word: Pain
		GridStatusRaidDebuff:DebuffId(zoneid, 33865, 1, 6, 6) --Singe
		GridStatusRaidDebuff:DebuffId(zoneid, 37668, 1, 6, 6) --Immolate
		GridStatusRaidDebuff:DebuffId(zoneid, 13323, 1, 6, 6) --Polymorph
		GridStatusRaidDebuff:DebuffId(zoneid, 34925, 1, 6, 6) --Curse of Impotence
		GridStatusRaidDebuff:DebuffId(zoneid, 33919, 1, 6, 6) --Earthquake
		GridStatusRaidDebuff:DebuffId(zoneid, 25603, 1, 6, 6) --Slow
		GridStatusRaidDebuff:DebuffId(zoneid, 34940, 1, 6, 6) --Gouge
		GridStatusRaidDebuff:DebuffId(zoneid, 32315, 1, 6, 6) --Soul Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 32361, 1, 6, 6) --Crystal Prison
		GridStatusRaidDebuff:DebuffId(zoneid, 34922, 1, 6, 6) --Shadows Embrace
		GridStatusRaidDebuff:DebuffId(zoneid, 38065, 1, 6, 6) --Death Coil
		GridStatusRaidDebuff:DebuffId(zoneid, 38064, 1, 6, 6) --Blast Wave
		GridStatusRaidDebuff:DebuffId(zoneid, 32365, 1, 6, 6) --Frost Nova
		GridStatusRaidDebuff:DebuffId(zoneid, 39332, 1, 6, 6) --Phantom Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 32364, 1, 6, 6) --Frostbolt
		GridStatusRaidDebuff:DebuffId(zoneid, 22911, 1, 6, 6) --Charge
	end

	-- TBC Dungeon
	-- The Black Morass
	do
		--local zone = "The Black Morass"
		local zoneid = 273

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Corruption"] = 32197,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Time Lapse"] = 31467,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Deadly Poison"] = 38520,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Frostbolt"] = 38534,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Polymorph"] = 13323,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Pyroblast"] = 38535,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Rupture"] = 15583,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Mortal Wound"] = 31464,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Fear"] = 12542,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Time Stop"] = 31422,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Hamstring"] = 9080,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Ebon Poison"] = 34366,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Crippling Poison"] = 30981,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Mortal Strike"] = 35054,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Curse of Vulnerability"] = 36276,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Knockdown"] = 11428,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Blast Wave"] = 38536,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Frost Nova"] = 15531,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Sunder Armor"] = 16145,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Sand Breath"] = 39049,
		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Kidney Shot"] = 30832,
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
