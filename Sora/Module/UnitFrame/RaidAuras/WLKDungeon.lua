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

	-- WLK Dungeon
	-- Halls of Stone
	do
		--local zone = "Halls of Stone"
		local zoneid = 140

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 46202, 1, 6, 6) --Pierce Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 50895, 1, 6, 6) --Lightning Tether
		GridStatusRaidDebuff:DebuffId(zoneid, 50761, 1, 6, 6) --Pillar of Woe
		GridStatusRaidDebuff:DebuffId(zoneid, 50834, 1, 6, 6) --Static Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 50841, 1, 6, 6) --Lightning Ring
		GridStatusRaidDebuff:DebuffId(zoneid, 51491, 1, 6, 6) --Unrelenting Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 51496, 1, 6, 6) --Chiseling Ray
		GridStatusRaidDebuff:DebuffId(zoneid, 50760, 1, 6, 6) --Shock of Sorrow
	end

	-- WLK Dungeon
	-- The Nexus
	do
		--local zone = "The Nexus"
		local zoneid = 129

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 60067, 1, 6, 6) --Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 47731, 1, 6, 6) --Critter
		GridStatusRaidDebuff:DebuffId(zoneid, 57091, 1, 6, 6) --Crystalfire Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 56775, 1, 6, 6) --Frostbolt
		GridStatusRaidDebuff:DebuffId(zoneid, 13323, 1, 6, 6) --Polymorph
		GridStatusRaidDebuff:DebuffId(zoneid, 48053, 1, 6, 6) --Ensnare
		GridStatusRaidDebuff:DebuffId(zoneid, 56776, 1, 6, 6) --Arcane Shock
		GridStatusRaidDebuff:DebuffId(zoneid, 56777, 1, 6, 6) --Silence
		GridStatusRaidDebuff:DebuffId(zoneid, 29882, 1, 6, 6) --Loose Mana
		GridStatusRaidDebuff:DebuffId(zoneid, 47700, 1, 6, 6) --Crystal Freeze
		GridStatusRaidDebuff:DebuffId(zoneid, 47736, 1, 6, 6) --Time Stop
		GridStatusRaidDebuff:DebuffId(zoneid, 55041, 1, 6, 6) --Freezing Trap Effect
		GridStatusRaidDebuff:DebuffId(zoneid, 56933, 1, 6, 6) --Incendiary Shot
		GridStatusRaidDebuff:DebuffId(zoneid, 48095, 1, 6, 6) --Intense Cold
		GridStatusRaidDebuff:DebuffId(zoneid, 57050, 1, 6, 6) --Crystal Chains
		GridStatusRaidDebuff:DebuffId(zoneid, 29544, 1, 6, 6) --Frightening Shout
		GridStatusRaidDebuff:DebuffId(zoneid, 50132, 1, 6, 6) --Draw Magic
		GridStatusRaidDebuff:DebuffId(zoneid, 30849, 1, 6, 6) --Spell Lock
		GridStatusRaidDebuff:DebuffId(zoneid, 56860, 1, 6, 6) --Magic Burn
		GridStatusRaidDebuff:DebuffId(zoneid, 48179, 1, 6, 6) --Crystallize
		GridStatusRaidDebuff:DebuffId(zoneid, 57063, 1, 6, 6) --Arcane Attraction
		GridStatusRaidDebuff:DebuffId(zoneid, 30633, 1, 6, 6) --Thunderclap
		GridStatusRaidDebuff:DebuffId(zoneid, 47779, 1, 6, 6) --Arcane Torrent
		GridStatusRaidDebuff:DebuffId(zoneid, 38384, 1, 6, 6) --Cone of Cold
		GridStatusRaidDebuff:DebuffId(zoneid, 61556, 1, 6, 6) --Tangle
	end

	-- WLK Dungeon
	-- Utgarde Keep
	do
		--local zone = "Halls of Stone
		local zoneid = 133

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 9791, 1, 6, 6) --Head Crack
		GridStatusRaidDebuff:DebuffId(zoneid, 35570, 1, 6, 6) --Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 42972, 1, 6, 6) --Blind
		GridStatusRaidDebuff:DebuffId(zoneid, 42702, 1, 6, 6) --Decrepify
		GridStatusRaidDebuff:DebuffId(zoneid, 16244, 1, 6, 6) --Demoralizing Shout
		GridStatusRaidDebuff:DebuffId(zoneid, 43931, 1, 6, 6) --Rend
		GridStatusRaidDebuff:DebuffId(zoneid, 43936, 1, 6, 6) --Knockdown Spin
		GridStatusRaidDebuff:DebuffId(zoneid, 48400, 1, 6, 6) --Frost Tomb
		GridStatusRaidDebuff:DebuffId(zoneid, 43650, 1, 6, 6) --Debilitate
		GridStatusRaidDebuff:DebuffId(zoneid, 42723, 1, 6, 6) --Dark Smash
		GridStatusRaidDebuff:DebuffId(zoneid, 15572, 1, 6, 6) --Sunder Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 43757, 1, 6, 6) --Burning Brand
		GridStatusRaidDebuff:DebuffId(zoneid, 22427, 1, 6, 6) --Concussion Blow
	end

	-- WLK Dungeon
	-- Utgarde Pinnacle
	do
		--local zone = "Utgarde Pinnacle"
		local zoneid = 136

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 49089, 1, 6, 6) --Shrink
		GridStatusRaidDebuff:DebuffId(zoneid, 59239, 1, 6, 6) --Rend
		GridStatusRaidDebuff:DebuffId(zoneid, 59267, 1, 6, 6) --Withering Roar
		GridStatusRaidDebuff:DebuffId(zoneid, 59330, 1, 6, 6) --Crush
		GridStatusRaidDebuff:DebuffId(zoneid, 48291, 1, 6, 6) --Fetid Rot
		GridStatusRaidDebuff:DebuffId(zoneid, 59263, 1, 6, 6) --Grievous Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 48278, 1, 6, 6) --Paralyze
		GridStatusRaidDebuff:DebuffId(zoneid, 59265, 1, 6, 6) --Mortal Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 59271, 1, 6, 6) --Poison Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 56785, 1, 6, 6) --Volatile Infection
		GridStatusRaidDebuff:DebuffId(zoneid, 59268, 1, 6, 6) --Impale
		GridStatusRaidDebuff:DebuffId(zoneid, 48132, 1, 6, 6) --Acid Spit
		GridStatusRaidDebuff:DebuffId(zoneid, 48131, 1, 6, 6) --Stomp
		GridStatusRaidDebuff:DebuffId(zoneid, 48639, 1, 6, 6) --Hamstring
		GridStatusRaidDebuff:DebuffId(zoneid, 48871, 1, 6, 6) --Aimed Shot
		GridStatusRaidDebuff:DebuffId(zoneid, 49092, 1, 6, 6) --Net
		GridStatusRaidDebuff:DebuffId(zoneid, 48144, 1, 6, 6) --Terrifying Roar
		GridStatusRaidDebuff:DebuffId(zoneid, 48277, 1, 6, 6) --Ritual Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 59408, 1, 6, 6) --Shadows in the Dark
		GridStatusRaidDebuff:DebuffId(zoneid, 51750, 1, 6, 6) --Screams of the Dead
		GridStatusRaidDebuff:DebuffId(zoneid, 59264, 1, 6, 6) --Gore
		GridStatusRaidDebuff:DebuffId(zoneid, 59079, 1, 6, 6) --Grave Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 59237, 1, 6, 6) --Beast's Mark
		GridStatusRaidDebuff:DebuffId(zoneid, 59334, 1, 6, 6) --Poisoned Spear
		GridStatusRaidDebuff:DebuffId(zoneid, 49106, 1, 6, 6) --Terrify
		GridStatusRaidDebuff:DebuffId(zoneid, 61549, 1, 6, 6) --Shred
		GridStatusRaidDebuff:DebuffId(zoneid, 59304, 1, 6, 6) --Spirit Strike
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
