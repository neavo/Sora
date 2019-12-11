-- Engine
local S, C, L, DB = unpack(select(2, ...))

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

-- Cata Raid
-- Throne of the Four Winds
do
	-- local zone = "Throne of the Four Winds"
	local zoneid = 328

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	--Conclave of Wind
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Conclave of Wind")
	GridStatusRaidDebuff:DebuffId(zoneid, 84645, 11, 5, 5, true, true) --Wind Chill
	GridStatusRaidDebuff:DebuffId(zoneid, 86111, 12, 6, 6, true, true) --Ice Patch
	GridStatusRaidDebuff:DebuffId(zoneid, 86082, 13, 7, 7) --Permafrost
	GridStatusRaidDebuff:DebuffId(zoneid, 86481, 14, 7, 7) --Hurricane
	GridStatusRaidDebuff:DebuffId(zoneid, 86282, 15, 7, 7, true, true) --Toxic Spores
	GridStatusRaidDebuff:DebuffId(zoneid, 85573, 16, 8, 8) --Deafening Winds
	GridStatusRaidDebuff:DebuffId(zoneid, 85576, 17, 8, 8) --Withering Winds
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 93057, 18, 7, 7, true, true) --Slicing Gale

	--Al'Akir
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Al'Akir")
	GridStatusRaidDebuff:DebuffId(zoneid, 88301, 21, 5, 5) --Acid Rain
	GridStatusRaidDebuff:DebuffId(zoneid, 87873, 22, 6, 6) --Static Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 88427, 23, 6, 6) --Electrocute
	GridStatusRaidDebuff:DebuffId(zoneid, 89666, 24, 6, 6) --Lightning Rod
	GridStatusRaidDebuff:DebuffId(zoneid, 89668, 25, 6, 6) --Lightning Rod
	GridStatusRaidDebuff:DebuffId(zoneid, 87856, 25, 6, 6) --Squall Line
end

-- Cata Raid
-- The Bastion of Twilight
do
	-- local zone = "The Bastion of Twilight"
	local zoneid = 294

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	-- Trash
	--Magma (falling off)
	--GridStatusRaidDebuff:DebuffId(zoneid, 81114, 1, 6, 5) --Magma
	GridStatusRaidDebuff:DebuffId(zoneid, 81118, 1, 6, 5, true, true) --Magma
	--Tremors
	GridStatusRaidDebuff:DebuffId(zoneid, 87931, 1, 6, 5) --Tremors
	--Phased Burn
	GridStatusRaidDebuff:DebuffId(zoneid, 85799, 1, 6, 5) --Phased Burn
	--Crimson Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 88232, 1, 6, 5) --Crimson Flames
	--Twilight Soulblade
	GridStatusRaidDebuff:DebuffId(zoneid, 84850, 1, 6, 5) --Soul Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 84853, 1, 6, 5) --Dark Pool
	--Crimsonborne Firestarter
	GridStatusRaidDebuff:DebuffId(zoneid, 88219, 1, 6, 5) --Burning Twilight
	--Twilight Elementalist
	GridStatusRaidDebuff:DebuffId(zoneid, 88079, 1, 6, 5) --Frostfire Bolt
	--Twilight Shadow Knight
	GridStatusRaidDebuff:DebuffId(zoneid, 76622, 1, 4, 4, true, true) --Sunder Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 84832, 1, 5, 5) --Dismantle
	--Twilight Dark Mender
	GridStatusRaidDebuff:DebuffId(zoneid, 84856, 1, 6, 5) --Hungering Shadows
	--Twilight Shadow Mender
	GridStatusRaidDebuff:DebuffId(zoneid, 85643, 1, 6, 5) --Mind Sear
	--Twilight-shifter
	GridStatusRaidDebuff:DebuffId(zoneid, 85564, 1, 5, 5, true, true) --Shifted Reality
	--Bound Zephyr
	GridStatusRaidDebuff:DebuffId(zoneid, 93277, 1, 6, 5, true, true) --Rending Gale
	-- More important to show Rending Gale stack imo, but user can adjust priority
	-- if they feel differently
	GridStatusRaidDebuff:DebuffId(zoneid, 93306, 1, 4, 4) --Vaporize
	--Bound Rumbler
	GridStatusRaidDebuff:DebuffId(zoneid, 93327, 1, 6, 5, true, true) --Entomb
	-- More important to show Entomb stack imo, but user can adjust priority
	-- if they feel differently
	GridStatusRaidDebuff:DebuffId(zoneid, 93325, 1, 4, 4) --Shockwave
	--Faceless Guardian
	GridStatusRaidDebuff:DebuffId(zoneid, 85482, 1, 6, 5, true, true) --Shadow Volley
	--Shadow Lord
	GridStatusRaidDebuff:DebuffId(zoneid, 87629, 1, 6, 5) --Gripping Shadows

	--Bound Deluge
	--Everyone should get Cold-Touched
	--Frost Whirl is magic

	--Azureborne Destroyer
	-- Statis Strike is magic
	--GridStatusRaidDebuff:DebuffId(zoneid, 88178, 1, 6, 5) --Stasis Strike

	--Earth Ravager
	-- Petrify Skin is magic
	-- GridStatusRaidDebuff:DebuffId(zoneid, 87917, 1, 6, 5) --Petrify Skin

	--Twist Phase-Twister
	-- Twist Phase is magic
	-- GridStatusRaidDebuff:DebuffId(zoneid, 84838, 1, 6, 5) --Twist Phase

	--Twilight Crossfire
	-- Wyvern Sting is a poison and shows up as one

	--Shadow Lord
	-- Gripping Shadows is magic
	--GridStatusRaidDebuff:DebuffId(zoneid, 87629, 1, 6, 5) --Gripping Shadows

	--Chosen Seer
	-- Flame Shock is Magic

	--Halfus Wyrmbreaker
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Halfus Wyrmbreaker")
	GridStatusRaidDebuff:DebuffId(zoneid, 83710, 11, 5, 5) --Furious Roar
	GridStatusRaidDebuff:DebuffId(zoneid, 83908, 12, 5, 5, true, true) --Malevolent Strikes
	GridStatusRaidDebuff:DebuffId(zoneid, 83603, 13, 5, 5) --Stone Touch

	-- Valiona and Theralion
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Valiona and Theralion")
	GridStatusRaidDebuff:DebuffId(zoneid, 86788, 21, 5, 5) --Blackout 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 86622, 22, 5, 5) --Engulfing Magic 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 86202, 23, 5, 5, true, true) --Twilight Shift 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 86014, 24, 5, 5) --Twilight Meteorite
	GridStatusRaidDebuff:DebuffId(zoneid, 92886, 25, 6, 6, true, true) --Twilight Zone

	-- Twilight Ascendant Council
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Ascendant Council")
	GridStatusRaidDebuff:DebuffId(zoneid, 82762, 31, 5, 5) --Waterlogged
	GridStatusRaidDebuff:DebuffId(zoneid, 83099, 32, 7, 7) --Lightning Rod
	GridStatusRaidDebuff:DebuffId(zoneid, 82285, 33, 6, 6) --Elemental Stasis
	GridStatusRaidDebuff:DebuffId(zoneid, 82660, 34, 6, 6) --Burning Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 82665, 35, 6, 6) --Heart of Ice
	GridStatusRaidDebuff:DebuffId(zoneid, 82772, 36, 7, 7) --Frozen
	GridStatusRaidDebuff:DebuffId(zoneid, 84948, 37, 6, 6) --Gravity Crush
	GridStatusRaidDebuff:DebuffId(zoneid, 83500, 38, 4, 4) --Swirling Winds
	GridStatusRaidDebuff:DebuffId(zoneid, 83581, 38, 4, 4) --Grounded
	GridStatusRaidDebuff:DebuffId(zoneid, 82285, 38, 4, 4) --Elemental Stasis
	-- Debuffs we don't care about seeing:
	-- GridStatusRaidDebuff:DebuffId(zoneid, 83587, 39, 4, 4) --Magnetic Pull
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 92307, 39, 7, 7) --Frost Beacon
	GridStatusRaidDebuff:DebuffId(zoneid, 92467, 39, 7, 7) --Static Overload
	GridStatusRaidDebuff:DebuffId(zoneid, 92538, 39, 7, 7) --Gravity Core

	-- Cho'gall
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Cho'gall")
	GridStatusRaidDebuff:DebuffId(zoneid, 81701, 41, 4, 4, true, true) --Corrupted Blood
	-- Corruption: Accelerated is lower priority than the stacks so it won't overwrite
	GridStatusRaidDebuff:DebuffId(zoneid, 81836, 42, 3, 3) --Corruption: Accelerated
	GridStatusRaidDebuff:DebuffId(zoneid, 82125, 43, 3, 3) --Corruption: Malformation
	GridStatusRaidDebuff:DebuffId(zoneid, 82170, 44, 5, 5) --Corruption: Absolute
	GridStatusRaidDebuff:DebuffId(zoneid, 82523, 45, 6, 6) --Gall's Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 82518, 46, 6, 6) --Cho's Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 82411, 47, 7, 7) --Debilitating Beam

	-- Sinestra
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Sinestra")
	GridStatusRaidDebuff:DebuffId(zoneid, 89299, 51, 4, 4, true, true) --Twilight Spit
	-- Wrack is dispellable
	-- GridStatusSinestra handles this better
	-- GridStatusRaidDebuff:DebuffId(zoneid, 92955, 51, 4, 4) --Wrack
end

-- Cata Raid
-- Firelands
do
	-- local zone = "Firelands"
	local zoneid = 367

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	--Trash
	--Flamewaker Forward Guard
	GridStatusRaidDebuff:DebuffId(zoneid, 76622, 1, 4, 4, true, true) --Sunder Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 99610, 1, 5, 5) --Shockwave
	--Flamewaker Pathfinder
	GridStatusRaidDebuff:DebuffId(zoneid, 99695, 1, 4, 4) --Flaming Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 99800, 1, 4, 4) --Ensnare
	--Flamewaker Cauterizer
	--GridStatusRaidDebuff:DebuffId(zoneid, 99625, 1, 4, 4) --Conflagration (Magic/dispellable)
	--Flamewaker Centurion
	GridStatusRaidDebuff:DebuffId(zoneid, 16856, 1, 4, 4) --Mortal Strike
	--Fire Scorpion
	GridStatusRaidDebuff:DebuffId(zoneid, 99993, 1, 4, 4, true, true) --Fiery Blood
	--Molten Lord
	GridStatusRaidDebuff:DebuffId(zoneid, 100767, 1, 4, 4, true, true) --Melt Armor
	--Ancient Core Hound
	--GridStatusRaidDebuff:DebuffId(zoneid, 99692, 1, 4, 4) --Terrifying Roar (Magic/dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 99693, 1, 4, 4) --Dinner Time
	-- Unstable Magma
	GridStatusRaidDebuff:DebuffId(zoneid, 100549, 1, 4, 4) --Lava Surge
	-- Hell Hound
	GridStatusRaidDebuff:DebuffId(zoneid, 100057, 1, 4, 4, true, true) --Rend Flesh
	-- Inferno Hawk
	GridStatusRaidDebuff:DebuffId(zoneid, 99762, 1, 1, 1, false, false, 0, true) --Flames of the Firehawk
	-- Unbound Pyrelord
	GridStatusRaidDebuff:DebuffId(zoneid, 101166, 1, 4, 4) --Ignite
	-- Flamewaker Subjugator
	GridStatusRaidDebuff:DebuffId(zoneid, 100526, 1, 4, 4, true, true) --Blistering Wound
	-- Harbinger of Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 100095, 1, 4, 4) --Fieroclast Barrage
	-- Druid of the Flame
	-- Add Reckless Leap and Sunfire and put Reckless Leap higher priority
	-- so that you can dispell stuns before dots
	GridStatusRaidDebuff:DebuffId(zoneid, 99646, 1, 5, 5) --Reckless Leap (Magic/dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 99626, 1, 4, 4) --Sunfire (Magic/dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 99650, 1, 4, 4, true, true) --Reactive flames
	--Magma
	GridStatusRaidDebuff:DebuffId(zoneid, 97151, 1, 4, 4, true, true) --Magma
	-- Soul Burn is dispelable magic
	-- Tormented Protector (Legendary Quest)
	GridStatusRaidDebuff:DebuffId(zoneid, 100274, 1, 1, 1, false, false, 0, true) --Blessed Defender of Nordrassil
	-- Volcanus (Legendary Quest)
	GridStatusRaidDebuff:DebuffId(zoneid, 100324, 1, 4, 4) --Molten Fixation

	--Beth'tilac
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Beth'tilac")
	GridStatusRaidDebuff:DebuffId(zoneid, 99506, 11, 5, 5, true, true) --The Widow's Kiss
	--Cinderweb Drone
	GridStatusRaidDebuff:DebuffId(zoneid, 49026, 12, 6, 6) --Fixate (Heroic)
	--Cinderweb Spinner
	GridStatusRaidDebuff:DebuffId(zoneid, 97202, 13, 5, 5) --Fiery Web Spin
	--Cinderweb Spiderling
	GridStatusRaidDebuff:DebuffId(zoneid, 97079, 14, 4, 4) --Seeping Venom
	--Cinderweb Broodling (Heroic)
	--Also cast fixate, same one as above?
	-- Upstairs
	GridStatusRaidDebuff:DebuffId(zoneid, 100048, 15, 3, 3) --Fiery Web Silk

	--Lord Rhyolith
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Lord Rhyolith")
	GridStatusRaidDebuff:DebuffId(zoneid, 98492, 21, 5, 5, true, true) --Eruption

	--Alysrazor
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Alysrazor")
	GridStatusRaidDebuff:DebuffId(zoneid, 101729, 31, 5, 5, true, true) --Blazing Claw
	GridStatusRaidDebuff:DebuffId(zoneid, 100094, 32, 4, 4, true, true) --Fieroblast
	GridStatusRaidDebuff:DebuffId(zoneid, 99389, 33, 3, 3) --Imprinted
	GridStatusRaidDebuff:DebuffId(zoneid, 99308, 34, 6, 6) --Gushing Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 100640, 35, 6, 6, true, true) --Harsh Winds
	GridStatusRaidDebuff:DebuffId(zoneid, 100555, 36, 6, 6) --Smouldering Roots
	GridStatusRaidDebuff:DebuffId(zoneid, 99275, 37, 6, 6) --Molten Boulder
	--Do we want to show these?
	GridStatusRaidDebuff:DebuffId(zoneid, 99461, 38, 4, 4, true, true) --Blazing Power
	--GridStatusRaidDebuff:DebuffId(zoneid, 98734, 32, 4, 4, true, true) --Molten Feather
	--GridStatusRaidDebuff:DebuffId(zoneid, 98619, 32, 4, 4) --Wings of Flame
	--GridStatusRaidDebuff:DebuffId(zoneid, 100029, 32, 4, 4, true, true) --Alysra's Razor

	--Shannox
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Shannox")
	GridStatusRaidDebuff:DebuffId(zoneid, 99936, 41, 5, 5, true, true) --Jagged Tear
	GridStatusRaidDebuff:DebuffId(zoneid, 99837, 42, 7, 7) --Crystal Prison Trap Effect
	GridStatusRaidDebuff:DebuffId(zoneid, 101208, 43, 4, 4) --Immolation Trap
	GridStatusRaidDebuff:DebuffId(zoneid, 99840, 44, 4, 4) --Magma Rupture
	-- Riplimp
	-- GridStatusRaidDebuff:DebuffId(zoneid, 99937, 41, 5, 5, true, true) --Jagged Tear
	-- Rageface
	GridStatusRaidDebuff:DebuffId(zoneid, 99947, 45, 6, 6) --Face Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 100415, 46, 5, 5) --Rage

	--Baleroc
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Baleroc")
	GridStatusRaidDebuff:DebuffId(zoneid, 99252, 51, 5, 5, true, true) --Blaze of Glory
	GridStatusRaidDebuff:DebuffId(zoneid, 99256, 52, 5, 5, true, true) --Torment
	GridStatusRaidDebuff:DebuffId(zoneid, 99403, 53, 6, 6) --Tormented
	GridStatusRaidDebuff:DebuffId(zoneid, 99516, 54, 7, 7) --Countdown
	GridStatusRaidDebuff:DebuffId(zoneid, 99353, 55, 7, 7) --Decimating Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 100908, 56, 6, 6, true, true) --Fiery Torment
	-- These don't show up currently because they are buffs
	GridStatusRaidDebuff:DebuffId(zoneid, 99262, 57, 4, 4, true, true) --Vital Spark
	GridStatusRaidDebuff:DebuffId(zoneid, 99263, 58, 4, 4, true, true) --Vital Flame

	--Majordomo Staghelm
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Majordomo Staghelm")
	GridStatusRaidDebuff:DebuffId(zoneid, 98535, 61, 5, 5, true, true) --Leaping Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 98443, 62, 6, 6) --Fiery Cyclone
	GridStatusRaidDebuff:DebuffId(zoneid, 98450, 63, 5, 5) --Searing Seeds
	--Burning Orbs
	GridStatusRaidDebuff:DebuffId(zoneid, 100210, 65, 6, 6, true, true) --Burning Orb
	-- ?
	GridStatusRaidDebuff:DebuffId(zoneid, 96993, 64, 5, 5) --Stay Withdrawn?

	--Ragnaros
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Ragnaros")
	GridStatusRaidDebuff:DebuffId(zoneid, 99399, 71, 6, 6, true, true) --Burning Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 100293, 72, 7, 7) --Lava Wave
	GridStatusRaidDebuff:DebuffId(zoneid, 100238, 73, 4, 4, true, true) --Magma Trap Vulnerability
	GridStatusRaidDebuff:DebuffId(zoneid, 98313, 74, 4, 4, true, true) --Magma Blast
	--Heroic Phase 4
	GridStatusRaidDebuff:DebuffId(zoneid, 100941, 75, 4, 4) --Dreadflame
	GridStatusRaidDebuff:DebuffId(zoneid, 100594, 75, 4, 4, true, true) --Superheated
	--Lava Scion
	GridStatusRaidDebuff:DebuffId(zoneid, 100460, 76, 6, 6) --Blazing Heat
	--Son of Flame
	--Lava
	GridStatusRaidDebuff:DebuffId(zoneid, 98981, 77, 5, 5) --Lava Bolt
	--Molten Elemental
	--Living Meteor
	GridStatusRaidDebuff:DebuffId(zoneid, 100249, 78, 5, 5, true, true) --Combustion
	--Molten Wyrms
	GridStatusRaidDebuff:DebuffId(zoneid, 99613, 79, 6, 6, true, true) --Molten Blast
end

-- Cata Raid
-- Dragon Soul
do
	-- local zone = "Dragon Soul"
	local zoneid = 409

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	--Trash

	--Stormbinder Adept
	GridStatusRaidDebuff:DebuffId(zoneid, 109442, 1, 4, 4) --Tornado
	--Lieutenant Shara
	GridStatusRaidDebuff:DebuffId(zoneid, 109331, 1, 4, 4, true, true) --Shatter
	GridStatusRaidDebuff:DebuffId(zoneid, 109333, 1, 5, 5) --Frost Corruption (magic)
	--Ancient Water Lord
	GridStatusRaidDebuff:DebuffId(zoneid, 107801, 1, 4, 4) --Drenched
	GridStatusRaidDebuff:DebuffId(zoneid, 107797, 1, 4, 4) --Flood
	GridStatusRaidDebuff:DebuffId(zoneid, 107770, 1, 1, 1, false, false, 0, true) --Pure Water
	--Earthen Destroyer
	GridStatusRaidDebuff:DebuffId(zoneid, 107677, 1, 4, 4, true, true) --Dust Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 107629, 1, 5, 5) --Boulder Smash (magic)
	--Stormborn Myrmidon
	GridStatusRaidDebuff:DebuffId(zoneid, 109368, 1, 4, 4, true, true) --Spark
	--Twilight Frost Evoker
	GridStatusRaidDebuff:DebuffId(zoneid, 109423, 1, 5, 5) --Shackles of Ice (magic)
	--Twilight Siege Captain
	GridStatusRaidDebuff:DebuffId(zoneid, 108183, 1, 5, 5) --Twilight Submission (magic)

	--Morchok
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Morchok")
	GridStatusRaidDebuff:DebuffId(zoneid, 103687, 11, 4, 4, true, true) --Crush Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 103821, 12, 3, 3) --Earthen Vortex
	GridStatusRaidDebuff:DebuffId(zoneid, 103785, 13, 6, 6) --Black Blood of the Earth
	GridStatusRaidDebuff:DebuffId(zoneid, 103534, 14, 5, 5) --Danger (Red)
	GridStatusRaidDebuff:DebuffId(zoneid, 103536, 15, 5, 5) --Warning (Yellow)
	-- Don't need to show Safe people
	GridStatusRaidDebuff:DebuffId(zoneid, 103541, 16, 5, 5, false, false, 0, true) --Safe (Blue)
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 109033, 17, 3, 3) --Stomp

	--Warlord Zon'ozz
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Warlord Zon'ozz")
	GridStatusRaidDebuff:DebuffId(zoneid, 104378, 21, 3, 3) --Black Blood of Go'rath
	GridStatusRaidDebuff:DebuffId(zoneid, 103434, 22, 5, 5) --Disrupting Shadows (dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 108799, 23, 2, 2) --Black Blood Erruption

	--Yor'sahj the Unsleeping
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Yor'sahj the Unsleeping")
	GridStatusRaidDebuff:DebuffId(zoneid, 104849, 31, 3, 3, true, true) --Void Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 105171, 32, 4, 4, true, true) --Deep Corruption

	--Hagara the Stormbinder
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Hagara the Stormbinder")
	GridStatusRaidDebuff:DebuffId(zoneid, 105316, 41, 6, 6, true, true) --Ice Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 105465, 42, 6, 6) --Lightning Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 105369, 43, 5, 5) --Lightning Conduit
	GridStatusRaidDebuff:DebuffId(zoneid, 105289, 44, 7, 7) --Shattered Ice (dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 105285, 45, 4, 4) --Target (next Ice Lance)
	GridStatusRaidDebuff:DebuffId(zoneid, 104451, 46, 5, 5) --Ice Tomb
	GridStatusRaidDebuff:DebuffId(zoneid, 110317, 47, 3, 3) --Watery Entrenchment
	GridStatusRaidDebuff:DebuffId(zoneid, 105314, 48, 3, 3) --Ice Wave
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 109325, 49, 7, 7) --Frostflake (dispellable)

	--Ultraxion
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Ultraxion")
	GridStatusRaidDebuff:DebuffId(zoneid, 105925, 51, 6, 6) --Fading Light
	GridStatusRaidDebuff:DebuffId(zoneid, 106108, 52, 5, 5) --Heroic Will
	GridStatusRaidDebuff:DebuffId(zoneid, 105984, 53, 2, 2) --Timeloop
	GridStatusRaidDebuff:DebuffId(zoneid, 105927, 54, 4, 4) --Faded Into Twilight
	GridStatusRaidDebuff:DebuffId(zoneid, 106415, 55, 4, 4, true, true) --Twilight Burst
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 106498, 56, 3, 3) --Looming Darkness

	--Warmaster Blackhorn
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Warmaster Blackhorn")
	GridStatusRaidDebuff:DebuffId(zoneid, 108043, 61, 4, 4, true, true) --Sunder Armor
	GridStatusRaidDebuff:DebuffId(zoneid, 107558, 62, 3, 3, true, true) --Degeneration
	GridStatusRaidDebuff:DebuffId(zoneid, 107567, 64, 3, 3, true, true) --Brutal Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 108046, 65, 5, 5) --Shockwave
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 109204, 66, 5, 5) -- Twilight Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 110214, 67, 6, 6) -- Consuming Shroud

	--Spine of Deathwing
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Spine of Deathwing")
	GridStatusRaidDebuff:DebuffId(zoneid, 105563, 71, 3, 3) --Grasping Tendrils
	GridStatusRaidDebuff:DebuffId(zoneid, 105479, 72, 6, 6) --Searing Plasma
	GridStatusRaidDebuff:DebuffId(zoneid, 105490, 73, 4, 4) --Fiery Grip
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 106005, 74, 1, 1, false, false, 0, true) --Degradation (disabled)
	GridStatusRaidDebuff:DebuffId(zoneid, 106200, 75, 5, 5) --Blood Corruption: Earth
	GridStatusRaidDebuff:DebuffId(zoneid, 106199, 76, 7, 7) --Blood Corruption: Death

	--Madness of Deathwing
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Madness of Deathwing")
	GridStatusRaidDebuff:DebuffId(zoneid, 105445, 81, 3, 3, true, true) --Blistering Heat
	GridStatusRaidDebuff:DebuffId(zoneid, 105841, 82, 4, 4, true, true) --Degenerative Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 106385, 83, 5, 5, true, true) --Crush
	GridStatusRaidDebuff:DebuffId(zoneid, 106730, 84, 5, 5, true, true) --Tetanus
	GridStatusRaidDebuff:DebuffId(zoneid, 106444, 85, 5, 5, true, true) --Impale
	GridStatusRaidDebuff:DebuffId(zoneid, 106794, 86, 6, 6) --Shrapnel (target)
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 108649, 87, 6, 6) --Corrupting Parasite
end

-- Cata Raid
-- Blackwing Descent
do
	-- local zone = "Blackwing Descent"
	local zoneid = 285

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	-- It looks like Grid works by name, not by spell Id
	-- So don't need to add all the different spell ids for the different difficulties

	-- Trash
	--Drakonid Slayer
	GridStatusRaidDebuff:DebuffId(zoneid, 80390, 1, 6, 5) --Mortal Strike
	-- Don't care about Blast Wave, it's just a slow
	--Maimgor/Ivoroc
	GridStatusRaidDebuff:DebuffId(zoneid, 80270, 1, 6, 5) --Shadowflame
	GridStatusRaidDebuff:DebuffId(zoneid, 80145, 1, 6, 5) --Piercing Grip
	--Spirit of Ironstar (spreads to other spirits when you kill Ironstar)
	GridStatusRaidDebuff:DebuffId(zoneid, 80727, 1, 6, 5, true) --Execution Sentence
	--Drakeadon Mongrel
	GridStatusRaidDebuff:DebuffId(zoneid, 80345, 1, 6, 5) --Corrosive Acid
	GridStatusRaidDebuff:DebuffId(zoneid, 80329, 1, 6, 5) --Time Lapse
	-- Frost Burn is magic and alredy shows up
	--Drakonid Drudge
	GridStatusRaidDebuff:DebuffId(zoneid, 79630, 1, 6, 5) --Drakonid Rush
	--Drakonid Chainwielder
	GridStatusRaidDebuff:DebuffId(zoneid, 79589, 1, 6, 5) --Constricting Chains
	GridStatusRaidDebuff:DebuffId(zoneid, 79580, 1, 6, 5) --Overhead Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 91910, 1, 7, 6) --Grievous Wound
	--Golem Sentry
	GridStatusRaidDebuff:DebuffId(zoneid, 81060, 1, 6, 5) --Flash Bomb
	--Pyrecraw
	GridStatusRaidDebuff:DebuffId(zoneid, 80127, 1, 4, 4, true, true) --Flame Buffet
	--Nefarian
	GridStatusRaidDebuff:DebuffId(zoneid, 79353, 1, 4, 4, true, true) --Shadow of Cowardice

	--Curse of Mending shows up as a Curse (dispellable)
	--Stormbolt shows up as Magic (dispellable)
	--Burden of the Crown is a buff debuff
	GridStatusRaidDebuff:DebuffId(zoneid, 80718, 1, 1, 1, false, false, 0, true) --Burden of the Crown
	-- Don't show this either
	GridStatusRaidDebuff:DebuffId(zoneid, 89798, 1, 1, 1, false, false, 0, true) --Master Adventurer Award

	--Magmaw
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Magmaw")
	GridStatusRaidDebuff:DebuffId(zoneid, 89773, 11, 5, 5) --Mangle
	GridStatusRaidDebuff:DebuffId(zoneid, 78941, 12, 5, 5) --Parasitic Infection
	GridStatusRaidDebuff:DebuffId(zoneid, 88287, 13, 5, 5) --Massive Crash
	GridStatusRaidDebuff:DebuffId(zoneid, 78199, 14, 4, 4) --Sweltering Armor

	--Omnitron Defense System
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Omnitron Defense System")
	GridStatusRaidDebuff:DebuffId(zoneid, 79888, 21, 5, 5) --Lightning Conductor
	GridStatusRaidDebuff:DebuffId(zoneid, 80161, 22, 5, 5) --Chemical Cloud
	GridStatusRaidDebuff:DebuffId(zoneid, 80011, 23, 5, 5) --Soaked in Poison
	GridStatusRaidDebuff:DebuffId(zoneid, 79505, 24, 5, 5) --Flamethrower
	GridStatusRaidDebuff:DebuffId(zoneid, 80094, 25, 5, 5) --Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 79501, 26, 5, 5) --Acquiring Target
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 92053, 27, 5, 5) --Shadow Conductor
	GridStatusRaidDebuff:DebuffId(zoneid, 92048, 28, 5, 5) --Shadow Infusion
	GridStatusRaidDebuff:DebuffId(zoneid, 92023, 29, 6, 6) --Encasing Shadows
	-- Power Generator is good, don't need to watch it
	GridStatusRaidDebuff:DebuffId(zoneid, 79629, 29, 1, 1, false, false, 0, true) --Power Generator
	-- Overcharged Power Generator is good, don't need to watch it
	GridStatusRaidDebuff:DebuffId(zoneid, 91858, 29, 1, 1, false, false, 0, true) --Overcharged Power Generator

	--Chimaeron
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Chimaeron")
	GridStatusRaidDebuff:DebuffId(zoneid, 89084, 31, 8, 8) --Low Health
	GridStatusRaidDebuff:DebuffId(zoneid, 82890, 32, 5, 5) --Mortality
	GridStatusRaidDebuff:DebuffId(zoneid, 82935, 33, 6, 6) --Caustic Slime
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 82881, 34, 7, 7, true, true) --Break
	GridStatusRaidDebuff:DebuffId(zoneid, 91307, 35, 4, 4) --Mocking Shadows
	-- Don't care about Finkle's Mixture
	GridStatusRaidDebuff:DebuffId(zoneid, 82705, 36, 1, 1, false, false, 0, true) --Finkle's Mixture

	--Atramedes
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Atramedes")
	GridStatusRaidDebuff:DebuffId(zoneid, 78092, 41, 7, 7) --Tracking
	GridStatusRaidDebuff:DebuffId(zoneid, 77982, 42, 4, 4, true, true) --Searing Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 78023, 43, 6, 6) --Roaring Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 78897, 44, 6, 6) --Noisy!
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 92685, 45, 6, 6) --Pestered!

	--Maloriak
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Maloriak")
	GridStatusRaidDebuff:DebuffId(zoneid, 78034, 51, 5, 5, true, true) --Rend 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 78225, 52, 6, 6) --Acid Nova 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 77615, 53, 5, 5) --Debilitating Slime 10-normal/25-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 77786, 54, 6, 6) --Consuming Flames 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 78617, 55, 6, 6) --Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 77760, 56, 6, 6) --Biting Chill
	GridStatusRaidDebuff:DebuffId(zoneid, 77699, 57, 6, 6) --Flash Freeze 10-normal
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 92987, 58, 5, 5) --Dark Sludge
	GridStatusRaidDebuff:DebuffId(zoneid, 92982, 59, 7, 7) --Engulfing Darkness

	--Nefarian
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Nefarian")
	GridStatusRaidDebuff:DebuffId(zoneid, 81118, 81, 5, 5, true, true) --Magma 10-normal
	GridStatusRaidDebuff:DebuffId(zoneid, 77827, 82, 5, 5) --Tail Lash 10-normal
	-- Heroic
	GridStatusRaidDebuff:DebuffId(zoneid, 79339, 83, 6, 6) --Explosive Cinders
	GridStatusRaidDebuff:DebuffId(zoneid, 79318, 84, 6, 6) --Dominion
end

-- Cata Raid
-- Baradin Hold
do
	-- local zone = "Baradin Hold"
	local zoneid = 282

	--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

	--Trash
	-- Demon Containment Unit
	GridStatusRaidDebuff:DebuffId(zoneid, 89354, 1, 6, 5) --Arcane Amplifier
	-- Disciple of Hate
	GridStatusRaidDebuff:DebuffId(zoneid, 105859, 1, 5, 5) --Run Through

	--Argaloth
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Argaloth")
	GridStatusRaidDebuff:DebuffId(zoneid, 88942, 11, 5, 5, true, true) --Meteor Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 88954, 12, 6, 6) --Consuming Darkness

	--Occu'thar
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Occu'thar")
	GridStatusRaidDebuff:DebuffId(zoneid, 96913, 21, 5, 5, true, true) --Searing Shadows
	-- Eye of Occu'thar
	GridStatusRaidDebuff:DebuffId(zoneid, 97028, 22, 6, 6) --Gaze of Occu'thar

	--Alizabal
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Alizabal")
	GridStatusRaidDebuff:DebuffId(zoneid, 104936, 31, 4, 4) --Skewer
	GridStatusRaidDebuff:DebuffId(zoneid, 105067, 32, 6, 6) --Seething Hate
end
