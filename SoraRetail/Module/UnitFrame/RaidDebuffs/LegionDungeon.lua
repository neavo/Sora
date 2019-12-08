-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
if not C.UnitFrame then
	C.UnitFrame = {}
end
if not C.UnitFrame.RaidAuras then
	C.UnitFrame.RaidAuras = {}
end

-- Hack
local zoneid = 0
local GridStatusRaidDebuff = {}
GridStatusRaidDebuff.DebuffId = function(self, zoneid, spellId, priority)
	C.UnitFrame.RaidAuras[spellId] = priority
end
GridStatusRaidDebuff.BossNameId = function(self, zoneid, _, name)
	-- do nothing
end

-- Legion Dungeon
-- Violet Hold
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor

	--Shivermaw
	--GridStatusRaidDebuff:BossNameId(zoneid, 10, "Shivermaw")
	GridStatusRaidDebuff:DebuffId(zoneid, 201379, 11, 6, 6) --Frost Breath
	GridStatusRaidDebuff:DebuffId(zoneid, 201672, 12, 6, 6) --Relentless Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 201960, 13, 6, 6) --Ice Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 202037, 14, 6, 6) --Frozen

	--Blood-Princess Thal'ena
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Blood-Princess Thal'ena")
	GridStatusRaidDebuff:DebuffId(zoneid, 202779, 21, 6, 6) --Essence of the Blood Princess
	GridStatusRaidDebuff:DebuffId(zoneid, 202792, 22, 6, 6) --Frenzied Bloodthirst

	--Festerface
	--GridStatusRaidDebuff:BossNameId(zoneid, 30, "Festerface")
	GridStatusRaidDebuff:DebuffId(zoneid, 202266, 31, 6, 6) --Icky Goo
	GridStatusRaidDebuff:DebuffId(zoneid, 201753, 32, 6, 6) --Necrotic Aura

	--Millificent Manastorm
	--GridStatusRaidDebuff:BossNameId(zoneid, 40, "Millificent Manastorm")
	GridStatusRaidDebuff:DebuffId(zoneid, 201159, 41, 6, 6) --Delta Finger Laser X-treme
	GridStatusRaidDebuff:DebuffId(zoneid, 202310, 42, 6, 6) --Hyper Zap-o-matic Ultimate Mark III

	--Mindflayer Kaahrj
	--GridStatusRaidDebuff:BossNameId(zoneid, 50, "Mindflayer Kaahrj")
	GridStatusRaidDebuff:DebuffId(zoneid, 201146, 51, 6, 6) --Hysteria
	GridStatusRaidDebuff:DebuffId(zoneid, 197783, 52, 6, 6) --Shadow Crash
	GridStatusRaidDebuff:DebuffId(zoneid, 201172, 53, 6, 6) --Eternal Darkness

	--Anub-esset
	--GridStatusRaidDebuff:BossNameId(zoneid, 60, "Anub-esset")
	GridStatusRaidDebuff:DebuffId(zoneid, 202217, 61, 6, 6) --Mandible Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 202341, 62, 6, 6) --Impale

	--Sael-orn
	--GridStatusRaidDebuff:BossNameId(zoneid, 70, "Sael-orn")
	GridStatusRaidDebuff:DebuffId(zoneid, 202306, 71, 6, 6) --Creeping Slaughter
	GridStatusRaidDebuff:DebuffId(zoneid, 202414, 72, 6, 6) --Venom Spray
	GridStatusRaidDebuff:DebuffId(zoneid, 210505, 73, 6, 6) --Toxic Blood

	--Fel Lord Betrug
	--GridStatusRaidDebuff:BossNameId(zoneid, 80, "Fel Lord Betrug")
	GridStatusRaidDebuff:DebuffId(zoneid, 202361, 81, 6, 6) --Execution
	GridStatusRaidDebuff:DebuffId(zoneid, 210879, 82, 6, 6) --Seed of Destruction
end

-- Legion Dungeon
-- Vault of the Wardens
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 193164, 1, 6, 6) --Gift of the Doomsayer
	GridStatusRaidDebuff:DebuffId(zoneid, 193956, 1, 6, 6) --Barbed Web
	GridStatusRaidDebuff:DebuffId(zoneid, 194064, 1, 6, 6) --A Mother's Love
	GridStatusRaidDebuff:DebuffId(zoneid, 202615, 1, 6, 6) --Torment
	GridStatusRaidDebuff:DebuffId(zoneid, 193607, 1, 6, 6) --Double Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 193069, 1, 6, 6) --Nightmares
	GridStatusRaidDebuff:DebuffId(zoneid, 206019, 1, 6, 6) --Corrupted Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 210202, 1, 6, 6) --Foul Stench
	GridStatusRaidDebuff:DebuffId(zoneid, 202658, 1, 6, 6) --Drain
	GridStatusRaidDebuff:DebuffId(zoneid, 193969, 1, 6, 6) --Razors
	GridStatusRaidDebuff:DebuffId(zoneid, 202608, 1, 6, 6) --Anguished Souls

	--Tirathon Saltheril
	--GridStatusRaidDebuff:BossNameId(zoneid, 10, "Tirathon Saltheril")
	--GridStatusRaidDebuff:DebuffId(zoneid, 153480, 11, 6, 6)

	--Inquisitor Tormentorum
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Inquisitor Tormentorum")
	--GridStatusRaidDebuff:DebuffId(zoneid, 154415, 21, 6, 6)

	--Glazer
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Glazer")
	GridStatusRaidDebuff:DebuffId(zoneid, 202046, 31, 6, 6) --Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 194942, 32, 6, 6) --Lingering Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 215478, 33, 6, 6) --Fired Up

	--Ash'Golm
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ash'Golm")
	GridStatusRaidDebuff:DebuffId(zoneid, 192519, 41, 6, 6) --Lava

	--Cordana Felsong
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Cordana Felsong")
	GridStatusRaidDebuff:DebuffId(zoneid, 213395, 51, 6, 6) --Deepening Shadows
end

-- Legion Dungeon
-- The Arcway
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 210645, 1, 6, 6) --Arcanic Bane
	GridStatusRaidDebuff:DebuffId(zoneid, 211756, 1, 6, 6) --Searing Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 226269, 1, 6, 6) --Torment
	GridStatusRaidDebuff:DebuffId(zoneid, 211125, 1, 6, 6) --Parallel Dimension
	GridStatusRaidDebuff:DebuffId(zoneid, 211000, 1, 6, 6) --Nether Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 211543, 1, 6, 6) --Devour
	GridStatusRaidDebuff:DebuffId(zoneid, 202156, 1, 6, 6) --Corrosion
	GridStatusRaidDebuff:DebuffId(zoneid, 210750, 1, 6, 6) --Collapsing Rift
	GridStatusRaidDebuff:DebuffId(zoneid, 210684, 1, 6, 6) --Siphon Essence
	GridStatusRaidDebuff:DebuffId(zoneid, 203592, 1, 6, 6) --Black Plague
	GridStatusRaidDebuff:DebuffId(zoneid, 202232, 1, 6, 6) --Consume
	GridStatusRaidDebuff:DebuffId(zoneid, 194006, 1, 6, 6) --Ooze Puddle

	--Corstilax
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Corstilax")
	GridStatusRaidDebuff:DebuffId(zoneid, 196074, 11, 6, 6) --Suppression Protocol
	GridStatusRaidDebuff:DebuffId(zoneid, 195804, 12, 6, 6) --Quarantine
	GridStatusRaidDebuff:DebuffId(zoneid, 220500, 13, 6, 6) --Destabilized Orb

	--Ivanyr
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Ivanyr")
	GridStatusRaidDebuff:DebuffId(zoneid, 196562, 21, 6, 6) --Volatile Magic

	--General Xakal
	--GridStatusRaidDebuff:BossNameId(zoneid, 30, "General Xakal")
	--GridStatusRaidDebuff:DebuffId(zoneid, 153234, 31, 6, 6)

	--Nal'tira
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Nal'tira")
	GridStatusRaidDebuff:DebuffId(zoneid, 200284, 41, 6, 6) --Tangled Web
	GridStatusRaidDebuff:DebuffId(zoneid, 200040, 42, 6, 6) --Nether Venom

	--Advisor Vandros
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Advisor Vandros")
	GridStatusRaidDebuff:DebuffId(zoneid, 203914, 51, 6, 6) --Banished In Time
	GridStatusRaidDebuff:DebuffId(zoneid, 203139, 52, 6, 6) --Force Nova
end

-- Legion Dungeon
-- The Seat of the Triumvirate
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor

	--Zuraal the Ascended
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Zuraal the Ascended")
	GridStatusRaidDebuff:DebuffId(zoneid, 244588, 11, 6, 6, false, true) --Void Sludge

	--Saprish
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Saprish")
	GridStatusRaidDebuff:DebuffId(zoneid, 246026, 21, 6, 6) --Void Trap

	--Viceroy Nezhar
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Viceroy Nezhar")
	GridStatusRaidDebuff:DebuffId(zoneid, 244916, 31, 6, 6, false, true) --Void Lashing
	GridStatusRaidDebuff:DebuffId(zoneid, 244906, 32, 7, 7) --Collapsing Void
	GridStatusRaidDebuff:DebuffId(zoneid, 246324, 33, 6, 6) --Entropic Force

	--L'ura
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "L'ura")
	GridStatusRaidDebuff:DebuffId(zoneid, 245289, 41, 6, 6) --Void Blast
end

-- Legion Dungeon
-- Neltharion's Lair
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 200154, 1, 6, 6) --Burning Hatred
	GridStatusRaidDebuff:DebuffId(zoneid, 202231, 1, 6, 6) --Leech
	GridStatusRaidDebuff:DebuffId(zoneid, 192800, 1, 6, 6) --Choking Dust
	GridStatusRaidDebuff:DebuffId(zoneid, 193639, 1, 6, 6) --Bone Chomp
	GridStatusRaidDebuff:DebuffId(zoneid, 188494, 1, 6, 6) --Rancid Maw
	GridStatusRaidDebuff:DebuffId(zoneid, 193941, 1, 6, 6) --Impaling Shard
	GridStatusRaidDebuff:DebuffId(zoneid, 183465, 1, 6, 6) --Viscid Bile
	GridStatusRaidDebuff:DebuffId(zoneid, 202181, 1, 6, 6) --Stone Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 193585, 1, 6, 6) --Bound
	GridStatusRaidDebuff:DebuffId(zoneid, 226388, 1, 6, 6) --Rancid Ooze

	--Rokmora
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Rokmora")
	GridStatusRaidDebuff:DebuffId(zoneid, 215898, 11, 6, 6) --Crystalline Ground

	--Ularogg Cragshaper
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Ularogg Cragshaper")
	--GridStatusRaidDebuff:DebuffId(zoneid, 196562, 21, 6, 6) --Volatile Magic

	--Naraxas
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Naraxas")
	GridStatusRaidDebuff:DebuffId(zoneid, 217851, 31, 6, 6) --Toxic Retch
	GridStatusRaidDebuff:DebuffId(zoneid, 199178, 32, 6, 6) --Spiked Tongue

	--Dargrul
	--GridStatusRaidDebuff:BossNameId(zoneid, 40, "Dargrul")
	--GridStatusRaidDebuff:DebuffId(zoneid, 200284, 41, 6, 6) --Tangled Web
end

-- Legion Dungeon
-- Maw of Souls
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 194674, 1, 6, 6) --Barbed Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 200208, 1, 6, 6) --Brackwater Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 195279, 1, 6, 6) --Bind
	GridStatusRaidDebuff:DebuffId(zoneid, 185539, 1, 6, 6) --Rapid Rupture
	GridStatusRaidDebuff:DebuffId(zoneid, 194640, 1, 6, 6) --Curse of Hope
	GridStatusRaidDebuff:DebuffId(zoneid, 198374, 1, 6, 6) --Hamstring
	GridStatusRaidDebuff:DebuffId(zoneid, 225778, 1, 6, 6) --Backlash
	GridStatusRaidDebuff:DebuffId(zoneid, 194099, 1, 6, 6) --Bile Breath
	GridStatusRaidDebuff:DebuffId(zoneid, 199185, 1, 6, 6) --Ravenous Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 198944, 1, 6, 6) --Breach Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 194102, 1, 6, 6) --Poisonous Sludge
	GridStatusRaidDebuff:DebuffId(zoneid, 194657, 1, 6, 6) --Soul Siphon
	GridStatusRaidDebuff:DebuffId(zoneid, 201566, 1, 6, 6) --Swirling Muck

	--Ymiron, the Fallen King
	--GridStatusRaidDebuff:BossNameId(zoneid, 10, "Ymiron, the Fallen King")
	--GridStatusRaidDebuff:DebuffId(zoneid, 153480, 11, 6, 6)

	--Harbaron
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Harbaron")
	GridStatusRaidDebuff:DebuffId(zoneid, 194327, 21, 6, 6) --Fragment
	GridStatusRaidDebuff:DebuffId(zoneid, 194235, 22, 6, 6) --Nether Rip

	--Helya
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Helya")
	GridStatusRaidDebuff:DebuffId(zoneid, 197262, 31, 6, 6) --Taint of the Sea
end

-- Legion Dungeon
-- Karazhan
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor

	--Shade of Medivh
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Shade of Medivh")
	GridStatusRaidDebuff:DebuffId(zoneid, 227779, 11, 6, 6, false, true) --Ceaseless Winter
	GridStatusRaidDebuff:DebuffId(zoneid, 228261, 12, 6, 6, true) --Flame Wreath
	GridStatusRaidDebuff:DebuffId(zoneid, 227592, 13, 6, 6, true) --Frostbite
	GridStatusRaidDebuff:DebuffId(zoneid, 228249, 14, 6, 6, true) --Inferno Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 227644, 16, 6, 6, true) --Piercing Missiles

	--Mana Devourer
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Mana Devourer ")
	GridStatusRaidDebuff:DebuffId(zoneid, 227502, 21, 6, 6) --Unstable Mana

	--Opera Hall: Wikket
	--GridStatusRaidDebuff:BossNameId(zoneid, 30, "Opera Hall: Wikket")
	--GridStatusRaidDebuff:DebuffId(zoneid, 244916, 31, 6, 6, false, true) --Void Lashing

	--Opera Hall: Westfall Story
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Opera Hall: Westfall Story")
	GridStatusRaidDebuff:DebuffId(zoneid, 227568, 41, 6, 6, true) --Burning Leg Sweep
	GridStatusRaidDebuff:DebuffId(zoneid, 227567, 41, 6, 6, true) --Knocked Down

	--Opera Hall: Beautiful Beast
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Opera Hall: Beautiful Beast")
	GridStatusRaidDebuff:DebuffId(zoneid, 227985, 51, 6, 6, true) --Dent Armor

	--Maiden of Virtue
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Maiden of Virtue")
	GridStatusRaidDebuff:DebuffId(zoneid, 227800, 71, 6, 6, false, true) --Holy Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 227823, 72, 6, 6, false, true) --Holy Wrath
	GridStatusRaidDebuff:DebuffId(zoneid, 227789, 73, 6, 6, false, true) --Sacred Ground

	--Attumen the Huntsman
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Attumen the Huntsman")
	GridStatusRaidDebuff:DebuffId(zoneid, 227493, 71, 6, 6, true) --Mortal Strike

	--The Curator
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "The Curator")
	GridStatusRaidDebuff:DebuffId(zoneid, 227279, 81, 6, 6) --Power Discharge

	--Moroes
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "Moroes")
	GridStatusRaidDebuff:DebuffId(zoneid, 227832, 91, 6, 6, true) --Coat Check
	GridStatusRaidDebuff:DebuffId(zoneid, 227742, 92, 6, 6) --Garrote

	--Viz'aduum the Watcher
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Viz'aduum the Watcher")
	GridStatusRaidDebuff:DebuffId(zoneid, 229083, 101, 6, 6, false, true) --Burning Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 229159, 102, 6, 6, true) --Chaotic Shadows
end

-- Legion Dungeon
-- Halls of Valor
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 199050, 1, 6, 6) --Mortal Hew
	GridStatusRaidDebuff:DebuffId(zoneid, 199652, 1, 6, 6) --Sever
	GridStatusRaidDebuff:DebuffId(zoneid, 198944, 1, 6, 6) --Breach Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 215430, 1, 6, 6) --Thunderstrike
	GridStatusRaidDebuff:DebuffId(zoneid, 199674, 1, 6, 6) --Wicked Dagger
	GridStatusRaidDebuff:DebuffId(zoneid, 199818, 1, 6, 6) --Crackle
	GridStatusRaidDebuff:DebuffId(zoneid, 198959, 1, 6, 6) --Etch
	GridStatusRaidDebuff:DebuffId(zoneid, 193702, 1, 6, 6) --Infernal Flames

	--Hymdall
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Hymdall")
	GridStatusRaidDebuff:DebuffId(zoneid, 193092, 11, 6, 6) --Bloodletting Sweep

	--Hyrja
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Hyrja")
	--GridStatusRaidDebuff:DebuffId(zoneid, 154415, 21, 6, 6)

	--Fenryr
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Fenryr")
	GridStatusRaidDebuff:DebuffId(zoneid, 196497, 31, 6, 6) --Ravenous Leap

	--God-King Skovald
	--GridStatusRaidDebuff:BossNameId(zoneid, 40, "God-King Skovald")
	--GridStatusRaidDebuff:DebuffId(zoneid, 156829, 41, 6, 6)

	--Odyn
	--GridStatusRaidDebuff:BossNameId(zoneid, 50, "Odyn")
	--GridStatusRaidDebuff:DebuffId(zoneid, 156829, 51, 6, 6)
end

-- Legion Dungeon
-- Eye of Azshara
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 196064, 1, 6, 6) --Tearing Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 195105, 1, 6, 6) --Crunching Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 196111, 1, 6, 6) --Jagged Claws
	GridStatusRaidDebuff:DebuffId(zoneid, 196058, 1, 6, 6) --Lethargic Toxin
	GridStatusRaidDebuff:DebuffId(zoneid, 196060, 1, 6, 6) --Numbing Toxin

	--Lady Hatecoil
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Warlord Parjesh")
	GridStatusRaidDebuff:DebuffId(zoneid, 192131, 11, 6, 6) --Throw Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 192094, 12, 6, 6) --Impaling Spear

	--Hatecoil Warrior
	GridStatusRaidDebuff:DebuffId(zoneid, 195094, 13, 6, 6) --Coral Slash

	--Lady Hatecoil
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Lady Hatecoil")
	GridStatusRaidDebuff:DebuffId(zoneid, 193698, 21, 6, 6) --Curse of the Witch

	--Serpentrix
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Serpentrix")
	GridStatusRaidDebuff:DebuffId(zoneid, 191855, 31, 6, 6) --toxic-wound
end

-- Legion Dungeon
-- Darkheart Thicket
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 200580, 1, 6, 6) --Maddening Roar
	GridStatusRaidDebuff:DebuffId(zoneid, 200642, 1, 6, 6) --Despair
	GridStatusRaidDebuff:DebuffId(zoneid, 225484, 1, 6, 6) --Grievous Rip
	GridStatusRaidDebuff:DebuffId(zoneid, 201365, 1, 6, 6) --Darksoul Drain
	GridStatusRaidDebuff:DebuffId(zoneid, 204243, 1, 6, 6) --Tormenting Eye
	GridStatusRaidDebuff:DebuffId(zoneid, 198904, 1, 6, 6) --Poison Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 199063, 1, 6, 6) --Strangling Roots
	GridStatusRaidDebuff:DebuffId(zoneid, 204246, 1, 6, 6) --Tormenting Fear
	GridStatusRaidDebuff:DebuffId(zoneid, 225568, 1, 6, 6) --Curse of Isolation

	--Archdruid Glaidalis
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Archdruid Glaidalis")
	GridStatusRaidDebuff:DebuffId(zoneid, 196376, 11, 6, 6) --Grievous Tear
	GridStatusRaidDebuff:DebuffId(zoneid, 198408, 12, 6, 6) --Nightfall

	--Oakheart
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Oakheart")
	GridStatusRaidDebuff:DebuffId(zoneid, 204667, 21, 6, 6) --Nightmare Breath
	GridStatusRaidDebuff:DebuffId(zoneid, 204611, 22, 6, 6) --Crushing Grip

	--Dresaron
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Dresaron")
	GridStatusRaidDebuff:DebuffId(zoneid, 220855, 31, 6, 6) --Down Draft
	GridStatusRaidDebuff:DebuffId(zoneid, 191326, 32, 6, 6) --Breath of Corruption

	--Shade of Xavius
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Shade of Xavius")
	GridStatusRaidDebuff:DebuffId(zoneid, 200289, 41, 6, 6) --Growing Paranoia
	GridStatusRaidDebuff:DebuffId(zoneid, 200238, 42, 6, 6) --Feed on the Weak
	GridStatusRaidDebuff:DebuffId(zoneid, 200182, 43, 6, 6) --Festering Rip
end

-- Legion Dungeon
-- Court of Stars
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 214692, 1, 6, 6) --Shadow Bolt Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 211464, 1, 6, 6) --Fel Detonation
	GridStatusRaidDebuff:DebuffId(zoneid, 211473, 1, 6, 6) --Shadow Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 207981, 1, 6, 6) --Disintegration Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 211391, 1, 6, 6) --Felblaze Puddle
	GridStatusRaidDebuff:DebuffId(zoneid, 209036, 1, 6, 6) --Throw Torch
	GridStatusRaidDebuff:DebuffId(zoneid, 209378, 1, 6, 6) --Whirling Blades
	GridStatusRaidDebuff:DebuffId(zoneid, 214690, 1, 6, 6) --Cripple
	GridStatusRaidDebuff:DebuffId(zoneid, 209512, 1, 6, 6) --Disrupting Energy
	GridStatusRaidDebuff:DebuffId(zoneid, 209516, 1, 6, 6) --Mana Fang
	GridStatusRaidDebuff:DebuffId(zoneid, 209413, 1, 6, 6) --Suppress

	--Patrol Captain Gerdo
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Patrol Captain Gerdo")
	GridStatusRaidDebuff:DebuffId(zoneid, 207278, 11, 6, 6) --Arcane Lockdown

	--Talixae Flamewreath
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Talixae Flamewreath")
	--GridStatusRaidDebuff:DebuffId(zoneid, 154415, 21, 6, 6)

	--Advisor Melandrus
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Advisor Melandrus")
	GridStatusRaidDebuff:DebuffId(zoneid, 209667, 31, 6, 6) --Blade Surge
end

-- Legion Dungeon
-- Cathedral of Eternal Night
do
	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor

	--Zuraal the Ascended
	--GridStatusRaidDebuff:BossNameId(zoneid, 10, "Zuraal the Ascended")
	--GridStatusRaidDebuff:DebuffId(zoneid, 244588, 11, 6, 6, false, true)  --Void Sludge

	--Saprish
	--GridStatusRaidDebuff:BossNameId(zoneid, 20, "Saprish")
	--GridStatusRaidDebuff:DebuffId(zoneid, 246026, 21, 6, 6) --Void Trap

	--Viceroy Nezhar
	--GridStatusRaidDebuff:BossNameId(zoneid, 30, "Viceroy Nezhar")
	--GridStatusRaidDebuff:DebuffId(zoneid, 244916, 31, 6, 6, false, true) --Void Lashing

	--L'ura
	--GridStatusRaidDebuff:BossNameId(zoneid, 40, "L'ura")
	--GridStatusRaidDebuff:DebuffId(zoneid, 245289, 41, 6, 6) --Void Blast
end

-- Legion Dungeon
-- Black Rook Hold
do
	--Whole Dungeon/Trash/Mythic Plus
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, false, true) --Necrotic Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, false, true) --Bursting
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, false, true) --Grievous
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 225963, 1, 6, 6) --Bloodthirsty Leap
	GridStatusRaidDebuff:DebuffId(zoneid, 225909, 1, 6, 6) --Soul Venom
	GridStatusRaidDebuff:DebuffId(zoneid, 214002, 1, 6, 6) --Raven's Dive
	GridStatusRaidDebuff:DebuffId(zoneid, 200261, 1, 6, 6) --Bonebreaking Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 200084, 1, 6, 6) --Soul Blade

	--Amalgam of Souls
	--GridStatusRaidDebuff:BossNameId(zoneid, 10, "Amalgam of Souls")
	--GridStatusRaidDebuff:DebuffId(zoneid, 153480, 11, 6, 6)

	--Illysanna Ravencrest
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Illysanna Ravencrest")
	GridStatusRaidDebuff:DebuffId(zoneid, 197546, 21, 6, 6) --Brutal Glaive

	--Smashspite the Hateful
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Smashspite the Hateful")
	GridStatusRaidDebuff:DebuffId(zoneid, 224188, 31, 6, 6) --Hateful Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 198245, 32, 6, 6) --Brutal Haymaker

	--Lord Kur'talos Ravencrest
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lord Kur'talos Ravencrest")
	GridStatusRaidDebuff:DebuffId(zoneid, 198635, 41, 6, 6) --Unerring Shear

	--Latosius
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Latosius")
	GridStatusRaidDebuff:DebuffId(zoneid, 201733, 51, 6, 6) --Stinging Swarm
end
