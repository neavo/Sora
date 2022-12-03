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

		GridStatusRaidDebuff:DebuffId(zoneid, 32197, 1, 6, 6) --Corruption
		GridStatusRaidDebuff:DebuffId(zoneid, 31467, 1, 6, 6) --Time Lapse
		GridStatusRaidDebuff:DebuffId(zoneid, 38520, 1, 6, 6) --Deadly Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 38534, 1, 6, 6) --Frostbolt
		GridStatusRaidDebuff:DebuffId(zoneid, 13323, 1, 6, 6) --Polymorph
		GridStatusRaidDebuff:DebuffId(zoneid, 38535, 1, 6, 6) --Pyroblast
		GridStatusRaidDebuff:DebuffId(zoneid, 15583, 1, 6, 6) --Rupture
		GridStatusRaidDebuff:DebuffId(zoneid, 31464, 1, 6, 6) --Mortal Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 12542, 1, 6, 6) --Fear
		GridStatusRaidDebuff:DebuffId(zoneid, 31422, 1, 6, 6) --Time Stop
		GridStatusRaidDebuff:DebuffId(zoneid, 09080, 1, 6, 6) --Hamstring
		GridStatusRaidDebuff:DebuffId(zoneid, 34366, 1, 6, 6) --Ebon Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 30981, 1, 6, 6) --Crippling Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 35054, 1, 6, 6) --Mortal Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 36276, 1, 6, 6) --Curse of Vulnerability
		GridStatusRaidDebuff:DebuffId(zoneid, 11428, 1, 6, 6) --Knockdown
		GridStatusRaidDebuff:DebuffId(zoneid, 38536, 1, 6, 6) --Blast Wave
		GridStatusRaidDebuff:DebuffId(zoneid, 15531, 1, 6, 6) --Frost Nova
		GridStatusRaidDebuff:DebuffId(zoneid, 16145, 1, 6, 6) --Sunder Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 39049, 1, 6, 6) --Sand Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 30832, 1, 6, 6) --Kidney Shot
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
