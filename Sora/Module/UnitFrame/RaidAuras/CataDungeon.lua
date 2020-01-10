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

	-- Cata Dungeon
	-- Hour of Twilight
	do
		--local zone = "Hour of Twilight"
		local zoneid = 399

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Arcurion
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Arcurion")
		GridStatusRaidDebuff:DebuffId(zoneid, 102582, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 103904, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 103962, 13, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 104050, 14, 6, 6)
		--Asira Dawnslayer
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Asira Dawnslayer")
		GridStatusRaidDebuff:DebuffId(zoneid, 102726, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 103558, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 103790, 23, 6, 6)
		--Archbishop Benedictus
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Archbishop Benedictus")
		GridStatusRaidDebuff:DebuffId(zoneid, 103151, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 103363, 32, 6, 6)
	end

	-- Cata Dungeon
	-- Lost City of the Tol'vir
	do
		--local zone = "Lost City of the Tol'vir"
		local zoneid = 277

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--General Husam
		--Lockmaw
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Lockmaw")
		--Viscous Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 81642, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 81690, 12, 6, 6)
		--Vicious Bite
		--Paralytic Blow Dart
		--Smoke Bomb
		--Dragon's Breath
		--High Prophet Barim
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "High Prophet Barim")
		GridStatusRaidDebuff:DebuffId(zoneid, 82622, 21, 6, 6)
		--Heaven's Fury
		--Blaze of the Heavens
		GridStatusRaidDebuff:DebuffId(zoneid, 81947, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 82139, 23, 6, 6)
		--Wail of Darkness
		--Siamat
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Siamat")
		--Lightning Nova
		--Lightning Charge
		--Tempest Storm
		GridStatusRaidDebuff:DebuffId(zoneid, 83066, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 83089, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 84982, 33, 6, 6)
	end

	-- Cata Dungeon
	-- Shadow fang Keep (Heroic)
	do
		local zoneid = 310
	end

	-- Cata Dungeon
	-- The Dead mines (Heroic)
	do
		local zoneid = 291
	end

	-- Cata Dungeon
	-- The Stonecore
	do
		--local zone = "The Stonecore"
		local zoneid = 324

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 81441, 1, 6, 6) --Shadowfury
		GridStatusRaidDebuff:DebuffId(zoneid, 81440, 1, 6, 6) --Frostbolt Volley
		GridStatusRaidDebuff:DebuffId(zoneid, 81508, 1, 6, 6) --Dust Storm
		GridStatusRaidDebuff:DebuffId(zoneid, 81711, 1, 6, 6) --Fracture
		GridStatusRaidDebuff:DebuffId(zoneid, 80221, 1, 6, 6) --Beat Down
		GridStatusRaidDebuff:DebuffId(zoneid, 80913, 1, 6, 6) --Crystal Shards
		GridStatusRaidDebuff:DebuffId(zoneid, 80151, 1, 6, 6) --Ignite
		GridStatusRaidDebuff:DebuffId(zoneid, 81569, 1, 6, 6) --Spinning Slash
		GridStatusRaidDebuff:DebuffId(zoneid, 80028, 1, 6, 6) --Rock Bore
		GridStatusRaidDebuff:DebuffId(zoneid, 81442, 1, 6, 6) --Fear

		--Corborus
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Corborus")
		GridStatusRaidDebuff:DebuffId(zoneid, 86881, 11, 6, 6)
		--Crystal Shard
		GridStatusRaidDebuff:DebuffId(zoneid, 82415, 12, 6, 6)
		--Rock Borer
		--Slabhide
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Slabhide")
		--Lava Fissure
		GridStatusRaidDebuff:DebuffId(zoneid, 80807, 21, 6, 6)
		--Stalactite
		GridStatusRaidDebuff:DebuffId(zoneid, 92265, 22, 6, 6)
		--Ozruk
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Ozruk")
		GridStatusRaidDebuff:DebuffId(zoneid, 78835, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 78859, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 92426, 33, 6, 6)
		--High Priestess Azil
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "High Priestess Azil")
		GridStatusRaidDebuff:DebuffId(zoneid, 79345, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 79351, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 42499, 43, 6, 6)
	end

	-- Cata Dungeon
	-- The Vortex Pinnacle
	do
		--local zone = "The Vortex Pinnacle"
		local zoneid = 325

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 87759, 1, 6, 6) --Shockwave
		GridStatusRaidDebuff:DebuffId(zoneid, 87930, 1, 6, 6) --Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 88182, 1, 6, 6) --Lethargic Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 88171, 1, 6, 6) --Hurricane
		GridStatusRaidDebuff:DebuffId(zoneid, 88314, 1, 6, 6) --Twisting Winds
		GridStatusRaidDebuff:DebuffId(zoneid, 87923, 1, 6, 6) --Wind Blast
		GridStatusRaidDebuff:DebuffId(zoneid, 86292, 1, 6, 6) --Cyclone Shield
		GridStatusRaidDebuff:DebuffId(zoneid, 88075, 1, 6, 6) --Typhoon
		GridStatusRaidDebuff:DebuffId(zoneid, 87771, 1, 6, 6) --Crusader Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 88175, 1, 6, 6) --Asphyxiate
		GridStatusRaidDebuff:DebuffId(zoneid, 76622, 1, 6, 6) --Sunder Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 88282, 1, 6, 6) --Upwind of Altairus
		GridStatusRaidDebuff:DebuffId(zoneid, 88010, 1, 6, 6) --Cyclone

		--Grand Vizier Ertan
		--Cyclone Shield
		--Storm's Edge
		--Altairus
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Altairus")
		GridStatusRaidDebuff:DebuffId(zoneid, 88308, 21, 6, 6)
		--Asaad, Caliph of Zephyrs
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Asaad, Caliph of Zephyrs")
		GridStatusRaidDebuff:DebuffId(zoneid, 86930, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 87618, 32, 6, 6)
	end

	-- Cata Dungeon
	-- Gate of the Setting Sun
	do
		--local zone = "Gate of the Setting Sun"
		local zoneid = 323

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Lady Naz'jar
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Lady Naz'jar")
		GridStatusRaidDebuff:DebuffId(zoneid, 76001, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 80564, 12, 6, 6)
		--Water Vortexes
		--Commander Ulthok, the Festering Prince
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Commander Ulthok, the Festering Prince")
		GridStatusRaidDebuff:DebuffId(zoneid, 76026, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76047, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76094, 23, 6, 6)
		--Mindbender Ghur'sha
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Mindbender Ghur'sha")
		--Emberstrike
		--Magma Splash
		--Earth Shards
		GridStatusRaidDebuff:DebuffId(zoneid, 76234, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76339, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76207, 33, 6, 6)
		--Ozumat
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ozumat")
		--Veil of Shadow
		--Blight Spray
		--Aura of Dread
		GridStatusRaidDebuff:DebuffId(zoneid, 83672, 41, 6, 6)
	end

	-- Cata Dungeon
	-- Well of Eternity
	do
		--local zone = "Well of Eternity"
		local zoneid = 398

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Peroth'arn
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Peroth'arn")
		--Corrupting Touch
		GridStatusRaidDebuff:DebuffId(zoneid, 108141, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 105544, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 104905, 13, 6, 6)
		--Easy Prey
		--Queen Azshara
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Queen Azshara")
		GridStatusRaidDebuff:DebuffId(zoneid, 103241, 21, 6, 6)
		--Coldflame
		--Firebomb
		--Mannoroth and Varo'then
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Mannoroth and Varo'then")
		GridStatusRaidDebuff:DebuffId(zoneid, 103888, 31, 6, 6)
		--Aura of Immolation
	end

	-- Cata Dungeon
	-- Zul'Aman
	do
		--local zone = "Zul'Aman"
		local zoneid = 333

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Akil'zon
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Akil'zon")
		GridStatusRaidDebuff:DebuffId(zoneid, 44008, 11, 6, 6)
		--Plucked
		GridStatusRaidDebuff:DebuffId(zoneid, 43648, 12, 6, 6)
		--Nalorakk
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Nalorakk")
		GridStatusRaidDebuff:DebuffId(zoneid, 42402, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 42397, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 42395, 23, 6, 6)
		--Jan'alai
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Jan'alai")
		GridStatusRaidDebuff:DebuffId(zoneid, 43140, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97497, 32, 6, 6)
		--Halazzi
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Halazzi")
		GridStatusRaidDebuff:DebuffId(zoneid, 43303, 41, 6, 6)
		--Shred Armor
		--Fixate
		--Lightning
		--Hex Lord Malacrass
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Hex Lord Malacrass")
		--Venom Spit
		--Psychic Wail
		GridStatusRaidDebuff:DebuffId(zoneid, 43382, 51, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43383, 52, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 61601, 53, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 61603, 54, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43545, 55, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43444, 56, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43447, 57, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43426, 58, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43428, 59, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43429, 60, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43432, 61, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97642, 62, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97643, 63, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97644, 64, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43461, 65, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43439, 66, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43522, 67, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43441, 68, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 127734, 69, 6, 6)
		--Daakara
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Daakara")
		GridStatusRaidDebuff:DebuffId(zoneid, 43093, 81, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 42402, 82, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43095, 83, 6, 6)
		--Feral Swipe
		GridStatusRaidDebuff:DebuffId(zoneid, 43153, 84, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43150, 85, 6, 6)
		--Lightning
		GridStatusRaidDebuff:DebuffId(zoneid, 43140, 86, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97497, 87, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 44090, 88, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 43213, 89, 6, 6)
		--Pillar of Fire
	end

	-- Cata Dungeon
	-- Zul'Gurub
	do
		--local zone = "Zul'Gurub"
		local zoneid = 337

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--High Priest Venoxis
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "High Priest Venoxis")
		--Venomous Effusion
		GridStatusRaidDebuff:DebuffId(zoneid, 96466, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96477, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96515, 13, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96509, 14, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96842, 15, 6, 6)
		--Poison Cloud
		--Bloodlord Mandokir
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Bloodlord Mandokir")
		GridStatusRaidDebuff:DebuffId(zoneid, 96684, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96740, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96776, 23, 6, 6)
		--Cache of Madness - Gri'lek
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Cache of Madness - Gri'lek")
		GridStatusRaidDebuff:DebuffId(zoneid, 96306, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96633, 32, 6, 6)
		--Cache of Madness - Hazza'rah
		--Sleep
		--Cache of Madness - Renataki
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Cache of Madness - Renataki")
		GridStatusRaidDebuff:DebuffId(zoneid, 96648, 51, 6, 6)
		--Cache of Madness - Wushoolay
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Cache of Madness - Wushoolay")
		GridStatusRaidDebuff:DebuffId(zoneid, 96710, 61, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96698, 62, 6, 6)
		--High Priestess Kilnara
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "High Priestess Kilnara")
		GridStatusRaidDebuff:DebuffId(zoneid, 96435, 71, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96423, 72, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96592, 73, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96700, 74, 6, 6)
		--Gaping Wound
		--Zanzil
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Zanzil")
		GridStatusRaidDebuff:DebuffId(zoneid, 96914, 81, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96916, 82, 6, 6)
		--Thunderclap
		GridStatusRaidDebuff:DebuffId(zoneid, 96338, 83, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96488, 84, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96486, 85, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 96487, 86, 6, 6)
		--Jin'do the Godbreaker
		GridStatusRaidDebuff:BossNameId(zoneid, 90, "Jin'do the Godbreaker")
		GridStatusRaidDebuff:DebuffId(zoneid, 97170, 91, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97600, 92, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 101360, 93, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 97172, 94, 6, 6)
		--Body Slam
		--Sunder Rift
	end

	-- Cata Dungeon
	-- Blackrock Caverns
	do
		--local zone = "Blackrock Caverns"
		local zoneid = 283

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Rom'ogg Bonecrusher
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Rom'ogg Bonecrusher")
		GridStatusRaidDebuff:DebuffId(zoneid, 75272, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75539, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75571, 13, 6, 6)
		--Corla, Herald of Twilight
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Corla, Herald of Twilight")
		GridStatusRaidDebuff:DebuffId(zoneid, 75610, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75823, 22, 6, 6)
		--Force Blast
		--Gravity Strike
		--Grievous Whirl
		--Karsh Steelbender
		--Beauty
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Beauty")
		GridStatusRaidDebuff:DebuffId(zoneid, 76028, 31, 6, 6)
		--Lava Drool
		--Little Big Flame Breath
		--Ascendant Lord Obsidius
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ascendant Lord Obsidius")
		GridStatusRaidDebuff:DebuffId(zoneid, 76185, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76188, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76186, 43, 6, 6)
		--Crepuscular Veil
	end

	-- Cata Dungeon
	-- End Time
	do
		--local zone = "End Time"
		local zoneid = 404

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 102066, 1, 6, 6) --Flesh Rip
		GridStatusRaidDebuff:DebuffId(zoneid, 101984, 1, 6, 6) --Distortion Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 102414, 1, 6, 6) --Dark Moonlight
		GridStatusRaidDebuff:DebuffId(zoneid, 277373, 1, 6, 6) --Massive Glaive
		GridStatusRaidDebuff:DebuffId(zoneid, 101619, 1, 6, 6) --Magma
		GridStatusRaidDebuff:DebuffId(zoneid, 102057, 1, 6, 6) --Scorched
		GridStatusRaidDebuff:DebuffId(zoneid, 109952, 1, 6, 6) --Cadaver Toss
		GridStatusRaidDebuff:DebuffId(zoneid, 108589, 1, 6, 6) --Tail Sweep
		GridStatusRaidDebuff:DebuffId(zoneid, 101840, 1, 6, 6) --Molten Blast
		GridStatusRaidDebuff:DebuffId(zoneid, 102158, 1, 6, 6) --Sear Flesh
		GridStatusRaidDebuff:DebuffId(zoneid, 102132, 1, 6, 6) --Break Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 102600, 1, 6, 6) --Temporal Vortex

		--Echo of Baine
		--Echo of Jaina
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Echo of Jaina")
		GridStatusRaidDebuff:DebuffId(zoneid, 101339, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 101810, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 101809, 13, 6, 6)
		--Echo of Sylvanas
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Echo of Sylvanas")
		--Wracking Pain
		GridStatusRaidDebuff:DebuffId(zoneid, 101412, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 101411, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 101401, 23, 6, 6)
		--Echo of Tyrande
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Echo of Tyrande")
		--Dark Moonlight
		GridStatusRaidDebuff:DebuffId(zoneid, 102151, 31, 6, 6)
		--Piercing Gaze of Elune
		GridStatusRaidDebuff:DebuffId(zoneid, 102241, 32, 6, 6)
		--Murozond
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Murozond")
		GridStatusRaidDebuff:DebuffId(zoneid, 102381, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 102569, 42, 6, 6)
	end

	-- Cata Dungeon
	-- Grim Batol
	do
		--local zone = "Grim Batol"
		local zoneid = 293

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--General Umbriss
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "General Umbriss")
		GridStatusRaidDebuff:DebuffId(zoneid, 74846, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 74634, 12, 6, 6)
		--Modgud's Malady
		--Claw Puncture
		--Forgemaster Throngus
		--Drahga Shadowburner
		--Erudax, the Duke of Below
	end

	-- Cata Dungeon
	-- Halls of Origination
	do
		--local zone = "Halls of Origination"
		local zoneid = 297

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Temple Guardian Anhuur
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Temple Guardian Anhuur")
		--Burning Light
		GridStatusRaidDebuff:DebuffId(zoneid, 75592, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75322, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75323, 13, 6, 6)
		--Poison-tipped Fangs
		--Earthrager Ptah
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Earthrager Ptah")
		GridStatusRaidDebuff:DebuffId(zoneid, 77370, 21, 6, 6)
		--Quicksand
		--Sand Vortex
		--Anraphet
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Anraphet")
		GridStatusRaidDebuff:DebuffId(zoneid, 75603, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75604, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 76184, 33, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75622, 34, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75623, 35, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75609, 36, 6, 6)
		--Isiset, Construct of Magic
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Isiset, Construct of Magic")
		GridStatusRaidDebuff:DebuffId(zoneid, 74136, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 74137, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 74134, 43, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 74365, 44, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 74371, 45, 6, 6)
		--Ammunae, Construct of Life
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Ammunae, Construct of Life")
		GridStatusRaidDebuff:DebuffId(zoneid, 76043, 51, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 75718, 52, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 79766, 53, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 79767, 54, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 79768, 55, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 80968, 56, 6, 6)
		--Thorn Slash
		--Noxious Spores
		--Setesh, Construct of Destruction
		--Reign of Chaos
		--Chaos Blast
		--Seed of Chaos
		--Rajh, Construct of Sun
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Rajh, Construct of Sun")
		GridStatusRaidDebuff:DebuffId(zoneid, 73872, 71, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 73874, 72, 6, 6)
		--Solar Fire
		GridStatusRaidDebuff:DebuffId(zoneid, 76355, 73, 6, 6)
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
