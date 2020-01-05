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

	-- MoP Raid
	-- Throne of Thunder
	do
		--local zone = "Throne of Thunder"
		local zoneid = 508

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Trash
		-- Jin'rokh the Breaker
		-- Zandalari Storm-Caller
		GridStatusRaidDebuff:DebuffId(zoneid, 139322, 1, 2, 2) -- Storm Energy
		-- Zandalari Water-Binder
		GridStatusRaidDebuff:DebuffId(zoneid, 136952, 1, 1, 1) -- Frostbolt (slow)
		-- Zandalari Spear-Shaper
		GridStatusRaidDebuff:DebuffId(zoneid, 137072, 1, 3, 3) -- Retrieve Spear (stun)
		-- Zandalari Blade Initiate
		GridStatusRaidDebuff:DebuffId(zoneid, 140049, 1, 2, 2) -- Wounding Strike

		-- Horridon
		-- Stormbringer Draz'kil
		GridStatusRaidDebuff:DebuffId(zoneid, 139900, 1, 1, 1) --Stormcloud
		-- Tormented Spirit
		GridStatusRaidDebuff:DebuffId(zoneid, 139550, 1, 1, 1, true, true) --Torment
		-- Soul-Fed Construct
		GridStatusRaidDebuff:DebuffId(zoneid, 33661, 1, 1, 1, true, true) --Crush Armor

		-- Horridon & Council of Elders
		-- Ancient Python
		GridStatusRaidDebuff:DebuffId(zoneid, 139888, 1, 1, 1, true, true) --Ancient Venom
		-- Drakkari Frost Warden
		GridStatusRaidDebuff:DebuffId(zoneid, 138687, 1, 6, 6) --Glacial Freeze (Magic, stun)

		-- Council of Elders
		-- Zandalari Prelate
		GridStatusRaidDebuff:DebuffId(zoneid, 139213, 1, 6, 6) -- Mark of the Loa (Magic)
		-- Farraki Sand Conjurer
		GridStatusRaidDebuff:DebuffId(zoneid, 138742, 1, 7, 7) -- Choking Sands (Magic, silence/pacify)
		-- Zandalari Prophet
		-- GridStatusRaidDebuff:DebuffId(zoneid, 139205, 1, 6, 6) -- Visions of Grandeur (Magic)
		GridStatusRaidDebuff:DebuffId(zoneid, 140400, 1, 6, 6) -- Mark of the Prophet (Magic)
		-- Gurubashi Berserker
		GridStatusRaidDebuff:DebuffId(zoneid, 138693, 1, 1, 1) --Bloodletting

		-- Tortos
		-- Greater Cave Bat
		GridStatusRaidDebuff:DebuffId(zoneid, 136751, 1, 1, 1) --Sonic Screech
		GridStatusRaidDebuff:DebuffId(zoneid, 136753, 1, 1, 1, true, true) --Slashing Talons

		-- Magaera
		-- Mist Lurker
		GridStatusRaidDebuff:DebuffId(zoneid, 140686, 1, 1, 1) --Corrosive Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 140682, 1, 1, 1) --Chokin Mists
		-- Shale Spider
		GridStatusRaidDebuff:DebuffId(zoneid, 140616, 1, 1, 1) --Shale Shards
		-- Eternal Guardian
		GridStatusRaidDebuff:DebuffId(zoneid, 140629, 1, 6, 6) --Eternal Prison (Magic)
		-- Fungal Growth
		GridStatusRaidDebuff:DebuffId(zoneid, 140620, 1, 6, 6) --Fungal Spores (Magic)

		-- Ji-Kun
		-- Gastropod
		GridStatusRaidDebuff:DebuffId(zoneid, 134415, 1, 1, 1) --Devoured (stun)

		-- Durumu the Forgotten
		-- Roaming Fog
		GridStatusRaidDebuff:DebuffId(zoneid, 134668, 1, 1, 1) --Gnawed Upon

		-- Dark Animus
		-- Archritualist Kelada
		GridStatusRaidDebuff:DebuffId(zoneid, 139356, 1, 1, 1) --Extermination Beam
		-- Ritual Guard
		GridStatusRaidDebuff:DebuffId(zoneid, 139215, 1, 1, 1) --Shockwave (stun)

		-- Iron Qon
		-- Skittering Spiderling
		GridStatusRaidDebuff:DebuffId(zoneid, 139310, 1, 6, 6) --Foul Venom (Disease)
		-- Untrained Quilen
		GridStatusRaidDebuff:DebuffId(zoneid, 122962, 1, 2, 2) --Carnivorous Bite
		-- Putrid Waste
		GridStatusRaidDebuff:DebuffId(zoneid, 139317, 1, 1, 1) --Putrify
		-- Rotting Scavenger
		GridStatusRaidDebuff:DebuffId(zoneid, 139314, 1, 6, 6) --Infected Bite (Disease)

		-- Lei Shen
		-- Lightning Guardian
		GridStatusRaidDebuff:DebuffId(zoneid, 138196, 1, 6, 6) --Lightning Burst (Magic)

		-- Bosses

		-- Jin'rokh the Breaker
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Jin'rokh the Breaker")
		GridStatusRaidDebuff:DebuffId(zoneid, 138006, 11, 4, 4) --Electrified Waters
		GridStatusRaidDebuff:DebuffId(zoneid, 137399, 12, 6, 6) --Focused Lightning fixate
		GridStatusRaidDebuff:DebuffId(zoneid, 138732, 13, 5, 5) --Ionization
		GridStatusRaidDebuff:DebuffId(zoneid, 138349, 14, 2, 2) --Static Wound (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 137371, 15, 2, 2) --Thundering Throw (tank only)

		--Horridon
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Horridon")
		GridStatusRaidDebuff:DebuffId(zoneid, 136769, 21, 6, 6) --Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 136767, 22, 2, 2, true, true) --Triple Puncture (tanks only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136708, 23, 6, 6) --Stone Gaze (stun, dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 136723, 24, 5, 5) --Sand Trap
		GridStatusRaidDebuff:DebuffId(zoneid, 136587, 25, 5, 5, true, true) --Venom Bolt Volley (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 136710, 26, 5, 5, true, true) --Deadly Plague (disease)
		GridStatusRaidDebuff:DebuffId(zoneid, 136670, 27, 4, 4) --Mortal Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 136573, 28, 5, 5) --Frozen Bolt (DebuffId used by frozen orb)
		GridStatusRaidDebuff:DebuffId(zoneid, 136512, 29, 6, 6) --Hex of Confusion
		GridStatusRaidDebuff:DebuffId(zoneid, 136719, 30, 6, 6) --Blazing Sunlight
		GridStatusRaidDebuff:DebuffId(zoneid, 136654, 31, 6, 6) --Rending Charge (major healing bleed)
		GridStatusRaidDebuff:DebuffId(zoneid, 140946, 32, 4, 4) --Dire Fixation (Heroic Only)

		--Council of Elders
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Council of Elders")
		GridStatusRaidDebuff:DebuffId(zoneid, 136922, 41, 6, 6, true, true) --Frostbite
		GridStatusRaidDebuff:DebuffId(zoneid, 137084, 42, 3, 3, true, true) --Body Heat
		GridStatusRaidDebuff:DebuffId(zoneid, 137641, 43, 6, 6) --Soul Fragment (Heroic only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136878, 44, 5, 5, true, true) --Ensnared
		GridStatusRaidDebuff:DebuffId(zoneid, 136857, 45, 6, 6) --Entrapped (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 137650, 46, 5, 5, true, true) --Shadowed Soul
		GridStatusRaidDebuff:DebuffId(zoneid, 137359, 47, 6, 6) --Shadowed Loa Spirit fixate target
		GridStatusRaidDebuff:DebuffId(zoneid, 137972, 48, 6, 6) --Twisted Fate (Heroic only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136860, 49, 5, 5) --Quicksand
		GridStatusRaidDebuff:DebuffId(zoneid, 136860, 50, 2, 2) --Frigid Assault (stun)

		--Tortos
		GridStatusRaidDebuff:BossNameId(zoneid, 51, "Tortos")
		GridStatusRaidDebuff:DebuffId(zoneid, 134030, 52, 6, 6) --Kick Shell
		GridStatusRaidDebuff:DebuffId(zoneid, 134920, 53, 6, 6) --Quake Stomp
		GridStatusRaidDebuff:DebuffId(zoneid, 136751, 54, 6, 6) --Sonic Screech
		GridStatusRaidDebuff:DebuffId(zoneid, 136753, 55, 2, 2) --Slashing Talons (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 137633, 56, 5, 5) --Crystal Shell (heroic only)

		--Megaera
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Megaera")
		GridStatusRaidDebuff:DebuffId(zoneid, 139822, 61, 6, 6) --Cinder (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 134396, 62, 6, 6) --Consuming Flames (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 137731, 63, 5, 5, true, true) --Ignite Flesh
		GridStatusRaidDebuff:DebuffId(zoneid, 136892, 64, 6, 6) --Frozen Solid
		GridStatusRaidDebuff:DebuffId(zoneid, 139909, 65, 5, 5) --Icy Ground
		GridStatusRaidDebuff:DebuffId(zoneid, 137746, 66, 6, 6) --Consuming Magic
		GridStatusRaidDebuff:DebuffId(zoneid, 139843, 67, 4, 4) --Artic Freeze
		GridStatusRaidDebuff:DebuffId(zoneid, 139840, 68, 4, 4) --Rot Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 140179, 69, 6, 6) --Suppression (stun)

		--Ji-Kun
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Ji-Kun")
		GridStatusRaidDebuff:DebuffId(zoneid, 140092, 71, 2, 2, true, true) --Infected Talons (tank)
		GridStatusRaidDebuff:DebuffId(zoneid, 140092, 72, 2, 2, true, true) --Talon Rake (tank)
		GridStatusRaidDebuff:DebuffId(zoneid, 138309, 73, 4, 4, true, true) --Slimed
		GridStatusRaidDebuff:DebuffId(zoneid, 138319, 74, 5, 5) --Feed Pool
		GridStatusRaidDebuff:DebuffId(zoneid, 140571, 75, 3, 3) --Feed Pool
		GridStatusRaidDebuff:DebuffId(zoneid, 134372, 76, 3, 3) --Screech
		-- This is good, don't need to show it
		GridStatusRaidDebuff:DebuffId(zoneid, 140014, 77, 1, 1, false, false, 0, true) --Daedalian Wings

		--Durumu the Forgotten
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Durumu")
		GridStatusRaidDebuff:DebuffId(zoneid, 133768, 81, 3, 3) --Arterial Cut (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 133767, 82, 2, 2, true, true) --Serious Wound (Tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136932, 83, 6, 6) --Force of Will
		GridStatusRaidDebuff:DebuffId(zoneid, 134122, 84, 5, 5) --Blue Beam
		GridStatusRaidDebuff:DebuffId(zoneid, 134123, 85, 5, 5) --Red Beam
		GridStatusRaidDebuff:DebuffId(zoneid, 134124, 86, 5, 5) --Yellow Beam
		GridStatusRaidDebuff:DebuffId(zoneid, 133795, 87, 6, 6) --Life Drain
		GridStatusRaidDebuff:DebuffId(zoneid, 133597, 88, 6, 6) --Dark Parasite
		GridStatusRaidDebuff:DebuffId(zoneid, 133732, 89, 3, 3, true, true) --Infrared Light (the stacking red debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 133677, 90, 3, 3, true, true) --Blue Rays (the stacking blue debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 133738, 91, 3, 3, true, true) --Bright Light (the stacking yellow debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 133737, 92, 4, 4) --Bright Light (The one that says you are actually in a beam)
		GridStatusRaidDebuff:DebuffId(zoneid, 133675, 93, 4, 4) --Blue Rays (The one that says you are actually in a beam)
		GridStatusRaidDebuff:DebuffId(zoneid, 134626, 94, 5, 5) --Lingering Gaze

		--Primordius
		GridStatusRaidDebuff:BossNameId(zoneid, 100, "Primordius")
		GridStatusRaidDebuff:DebuffId(zoneid, 140546, 101, 5, 5) --Fully Mutated
		GridStatusRaidDebuff:DebuffId(zoneid, 136180, 102, 3, 3, true, true) --Keen Eyesight (Helpful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136181, 103, 4, 4, true, true) --Impared Eyesight (Harmful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136182, 104, 3, 3, true, true) --Improved Synapses (Helpful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136183, 105, 4, 4, true, true) --Dulled Synapses (Harmful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136184, 106, 3, 3, true, true) --Thick Bones (Helpful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136185, 107, 4, 4, true, true) --Fragile Bones (Harmful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136186, 108, 3, 3, true, true) --Clear Mind (Helpful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136187, 109, 4, 4, true, true) --Clouded Mind (Harmful)
		GridStatusRaidDebuff:DebuffId(zoneid, 136050, 110, 2, 2, true, true) --Malformed Blood(Tank Only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136228, 111, 6, 6) --Volatile Pathogen

		--Dark Animus
		GridStatusRaidDebuff:BossNameId(zoneid, 120, "Dark Animus")
		GridStatusRaidDebuff:DebuffId(zoneid, 138569, 121, 2, 2) --Explosive Slam (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 138659, 122, 6, 6) --Touch of the Animus
		GridStatusRaidDebuff:DebuffId(zoneid, 138609, 123, 6, 6) --Matter Swap
		GridStatusRaidDebuff:DebuffId(zoneid, 138691, 124, 4, 4) --Anima Font
		GridStatusRaidDebuff:DebuffId(zoneid, 136962, 125, 5, 5) --Anima Ring
		GridStatusRaidDebuff:DebuffId(zoneid, 138480, 126, 6, 6) --Crimson Wake Fixate

		--Iron Qon
		GridStatusRaidDebuff:BossNameId(zoneid, 130, "Iron Qon")
		GridStatusRaidDebuff:DebuffId(zoneid, 134647, 131, 6, 6, true, true) --Scorched
		GridStatusRaidDebuff:DebuffId(zoneid, 136193, 132, 5, 5) --Arcing Lightning
		GridStatusRaidDebuff:DebuffId(zoneid, 135147, 133, 2, 2) --Dead Zone
		GridStatusRaidDebuff:DebuffId(zoneid, 134691, 134, 2, 2, true, true) --Impale (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 135145, 135, 6, 6) --Freeze
		GridStatusRaidDebuff:DebuffId(zoneid, 136520, 136, 5, 5, true, true) --Frozen Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 137669, 137, 3, 3) --Storm Cloud
		GridStatusRaidDebuff:DebuffId(zoneid, 137668, 138, 5, 5, true, true) --Burning Cinders
		GridStatusRaidDebuff:DebuffId(zoneid, 137654, 139, 5, 5) --Rushing Winds
		GridStatusRaidDebuff:DebuffId(zoneid, 136577, 140, 4, 4) --Wind Storm
		GridStatusRaidDebuff:DebuffId(zoneid, 136192, 141, 4, 4) --Lightning Storm
		GridStatusRaidDebuff:DebuffId(zoneid, 136615, 142, 6, 6) --Electrified

		--Twin Consorts
		GridStatusRaidDebuff:BossNameId(zoneid, 150, "Twin Consorts")
		GridStatusRaidDebuff:DebuffId(zoneid, 137440, 151, 6, 6) --Icy Shadows
		GridStatusRaidDebuff:DebuffId(zoneid, 137417, 152, 6, 6) --Flames of Passion
		GridStatusRaidDebuff:DebuffId(zoneid, 138306, 153, 5, 5) --Serpent's Vitality
		GridStatusRaidDebuff:DebuffId(zoneid, 137408, 154, 2, 2) --Fan of Flames (tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 137360, 155, 6, 6, true, true) --Corrupted Healing (tanks and healers only?)
		GridStatusRaidDebuff:DebuffId(zoneid, 137375, 156, 3, 3) --Beast of Nightmares
		GridStatusRaidDebuff:DebuffId(zoneid, 136722, 157, 6, 6) --Slumber Spores

		--Lei Shen
		GridStatusRaidDebuff:BossNameId(zoneid, 160, "Lei Shen")
		GridStatusRaidDebuff:DebuffId(zoneid, 135695, 161, 6, 6) --Static Shock
		GridStatusRaidDebuff:DebuffId(zoneid, 136295, 162, 6, 6) --Overcharged
		GridStatusRaidDebuff:DebuffId(zoneid, 135000, 163, 2, 2) --Decapitate (Tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 136478, 164, 5, 5) --Fusion Slash
		GridStatusRaidDebuff:DebuffId(zoneid, 136543, 165, 5, 5) --Ball Lightning
		GridStatusRaidDebuff:DebuffId(zoneid, 134821, 166, 4, 4) --Discharged Energy
		GridStatusRaidDebuff:DebuffId(zoneid, 136326, 167, 6, 6) --Overcharge
		GridStatusRaidDebuff:DebuffId(zoneid, 137176, 168, 4, 4) --Overloaded Circuits
		GridStatusRaidDebuff:DebuffId(zoneid, 136853, 169, 4, 4) --Lightning Bolt
		GridStatusRaidDebuff:DebuffId(zoneid, 135153, 170, 6, 6) --Crashing Thunder
		GridStatusRaidDebuff:DebuffId(zoneid, 136914, 171, 2, 2) --Electrical Shock
		GridStatusRaidDebuff:DebuffId(zoneid, 135001, 172, 2, 2) --Maim

		--Ra-den (Heroic only)
		GridStatusRaidDebuff:BossNameId(zoneid, 180, "Ra-den")
		GridStatusRaidDebuff:DebuffId(zoneid, 138308, 181, 6, 6) --Unstable Vita
		GridStatusRaidDebuff:DebuffId(zoneid, 138372, 182, 5, 5) --Vita Sensitivity
	end

	-- MoP Raid
	-- errace of Endless Spring
	do
		-- local zone = "Terrace of Endless Spring"
		local zoneid = 456

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Trash

		-- Protectors trash
		-- Apparition of Terror
		GridStatusRaidDebuff:DebuffId(zoneid, 130115, 1, 6, 6) --Grip of Fear (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 125758, 1, 6, 6) --Overwhelming Fear (dispellable/interruptable)
		-- Night Terror
		GridStatusRaidDebuff:DebuffId(zoneid, 125760, 1, 5, 5, true, true) --Enveloping Darkness  (dispellable)

		--Protector Kaolan
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Protector Kaolan")
		GridStatusRaidDebuff:DebuffId(zoneid, 117519, 11, 2, 2) --Touch of Sha (dot)
		GridStatusRaidDebuff:DebuffId(zoneid, 111850, 12, 6, 6) --Lightning Prison: Targeted
		GridStatusRaidDebuff:DebuffId(zoneid, 117436, 13, 6, 6) --Lightning Prison: Stunned
		GridStatusRaidDebuff:DebuffId(zoneid, 118191, 14, 5, 5, true, true) --Corrupted Essence
		GridStatusRaidDebuff:DebuffId(zoneid, 118091, 15, 4, 4, true, true) --Defiled Ground: Stacks
		GridStatusRaidDebuff:DebuffId(zoneid, 117235, 16, 1, 1) --Purified (buff from Corrupted Waters)
		GridStatusRaidDebuff:DebuffId(zoneid, 117283, 17, 1, 1) --Cleansing Waters (buff from Cleansing Waters, don't dispell off players, dispel off enemy targets)
		GridStatusRaidDebuff:DebuffId(zoneid, 117353, 18, 3, 3, true, true) -- Overwhelming Corruption (stacking dot) - if an Elder is killed last

		--Tsulong
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Tsulong")
		GridStatusRaidDebuff:DebuffId(zoneid, 122768, 21, 2, 2, true, true) --Dread Shadows
		GridStatusRaidDebuff:DebuffId(zoneid, 122777, 22, 6, 6) --Nightmares (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 122752, 23, 3, 3, true, true) --Shadow Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 122789, 24, 1, 1) --Sunbeam
		GridStatusRaidDebuff:DebuffId(zoneid, 123012, 25, 6, 6) --Terrorize: 5% (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 123011, 26, 6, 6) --Terrorize: 10% (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 123036, 27, 5, 5) --Fright (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 122858, 28, 2, 2) --Bathed in Light

		--Lei Shi
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Lei Shi")
		GridStatusRaidDebuff:DebuffId(zoneid, 123121, 31, 4, 4, true, true) --Spray (tank stacks)
		GridStatusRaidDebuff:DebuffId(zoneid, 123705, 32, 3, 3, true, true) --Scary Fog ?

		--Sha of Fear
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Sha of Fear")
		GridStatusRaidDebuff:DebuffId(zoneid, 119414, 41, 6, 6) --Breath of Fear
		GridStatusRaidDebuff:DebuffId(zoneid, 129147, 42, 3, 3) --Onimous Cackle
		GridStatusRaidDebuff:DebuffId(zoneid, 119983, 43, 6, 6, true, true) --Dread Spray
		GridStatusRaidDebuff:DebuffId(zoneid, 120669, 44, 3, 3) --Naked and Afraid
		GridStatusRaidDebuff:DebuffId(zoneid, 75683, 45, 6, 6) --Waterspout
		GridStatusRaidDebuff:DebuffId(zoneid, 120629, 46, 3, 3) --Huddle in Terror
		GridStatusRaidDebuff:DebuffId(zoneid, 120394, 47, 6, 6) --Eternal Darkness
		GridStatusRaidDebuff:DebuffId(zoneid, 129189, 48, 3, 4) --Sha Globe
		GridStatusRaidDebuff:DebuffId(zoneid, 119086, 49, 4, 4) --Penetrating Bolt
		GridStatusRaidDebuff:DebuffId(zoneid, 119775, 50, 6, 6) --Reaching Attack
	end

	-- MoP Raid
	-- Siege of Orgrimmar
	do
		--local zone = "Siege of Orgrimmar"
		local zoneid = 557

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Trash

		-- Gates of Orgrimmar
		-- Dragonmaw Bonecrusher
		GridStatusRaidDebuff:DebuffId(zoneid, 147200, 1, 2, 2) -- Fracture (DoT/Stun)
		-- Kor'kron Demolisher
		GridStatusRaidDebuff:DebuffId(zoneid, 148311, 1, 2, 2) -- Bombard (Knocked down)
		-- Lieutenant Krugruk
		GridStatusRaidDebuff:DebuffId(zoneid, 147683, 1, 2, 2) -- Thunder Clap (Magic)

		-- Valley of Strength
		-- Mokvar the Treasurer
		GridStatusRaidDebuff:DebuffId(zoneid, 145553, 1, 2, 2) -- Bribe (Mind Control)
		-- Kor'kron Overseer
		GridStatusRaidDebuff:DebuffId(zoneid, 15708, 1, 2, 2) -- Mortal Strike
		-- Kor'kron Shadowmage
		GridStatusRaidDebuff:DebuffId(zoneid, 145551, 1, 2, 2) -- Shadowflame (Magic)

		-- Vault of Y'Shaar
		-- Lingering Corruption
		GridStatusRaidDebuff:DebuffId(zoneid, 149207, 1, 2, 2) -- Corrupted Touch (Magic, damage when dispelled)

		-- Scarred Vale
		-- Rook Stonetoe
		GridStatusRaidDebuff:DebuffId(zoneid, 144396, 1, 2, 2) -- Vengeful Strikes (DoT/Stun)

		-- The Menagerie
		--  Enraged Mushan Beast
		GridStatusRaidDebuff:DebuffId(zoneid, 148136, 1, 2, 2) -- Lacerating Bite

		-- Immerseus
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Immerseus")
		GridStatusRaidDebuff:DebuffId(zoneid, 143297, 11, 5, 5) --Sha Splash
		GridStatusRaidDebuff:DebuffId(zoneid, 143459, 12, 4, 4, true, true) --Sha Residue
		GridStatusRaidDebuff:DebuffId(zoneid, 143524, 13, 4, 4, true, true) --Purified Residue
		GridStatusRaidDebuff:DebuffId(zoneid, 143286, 14, 4, 4) --Seeping Sha
		GridStatusRaidDebuff:DebuffId(zoneid, 143413, 15, 3, 3) --Swirl
		GridStatusRaidDebuff:DebuffId(zoneid, 143411, 16, 3, 3) --Swirl
		GridStatusRaidDebuff:DebuffId(zoneid, 143436, 17, 2, 2, true, true) --Corrosive Blast (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143579, 18, 3, 3, true, true) --Sha Corruption (Heroic Only)

		-- Fallen Protectors
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Fallen Protectors")
		GridStatusRaidDebuff:DebuffId(zoneid, 143239, 21, 4, 4) --Noxious Poison
		GridStatusRaidDebuff:DebuffId(zoneid, 144176, 22, 2, 2, true, true) --Lingering Anguish
		GridStatusRaidDebuff:DebuffId(zoneid, 143023, 23, 3, 3) --Corrupted Brew
		GridStatusRaidDebuff:DebuffId(zoneid, 143301, 24, 2, 2) --Gouge
		GridStatusRaidDebuff:DebuffId(zoneid, 143564, 25, 3, 3) --Meditative Field
		GridStatusRaidDebuff:DebuffId(zoneid, 143010, 26, 3, 3) --Corruptive Kick
		GridStatusRaidDebuff:DebuffId(zoneid, 143434, 27, 6, 6) --Shadow Word:Bane (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 143840, 28, 6, 6) --Mark of Anguish
		GridStatusRaidDebuff:DebuffId(zoneid, 143959, 29, 4, 4) --Defiled Ground
		GridStatusRaidDebuff:DebuffId(zoneid, 143423, 30, 6, 6) --Sha Sear
		GridStatusRaidDebuff:DebuffId(zoneid, 143292, 31, 5, 5) --Fixate
		GridStatusRaidDebuff:DebuffId(zoneid, 144176, 32, 5, 5, true, true) --Shadow Weakness
		GridStatusRaidDebuff:DebuffId(zoneid, 147383, 33, 4, 4) --Debilitation (Heroic Only)
		GridStatusRaidDebuff:DebuffId(zoneid, 143198, 34, 2, 2) --Garrote

		-- Norushen
		GridStatusRaidDebuff:BossNameId(zoneid, 35, "Norushen")
		GridStatusRaidDebuff:DebuffId(zoneid, 146124, 36, 2, 2, true, true) --Self Doubt (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 146324, 37, 4, 4, true, true) --Jealousy
		GridStatusRaidDebuff:DebuffId(zoneid, 144639, 38, 6, 6) --Corruption
		GridStatusRaidDebuff:DebuffId(zoneid, 144850, 39, 5, 5) --Test of Reliance
		GridStatusRaidDebuff:DebuffId(zoneid, 145861, 40, 6, 6) --Self-Absorbed (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 144851, 41, 2, 2) --Test of Confiidence (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 146703, 42, 3, 3) --Bottomless Pit
		GridStatusRaidDebuff:DebuffId(zoneid, 144514, 43, 6, 6) --Lingering Corruption
		GridStatusRaidDebuff:DebuffId(zoneid, 144849, 44, 4, 4) --Test of Serenity
		GridStatusRaidDebuff:DebuffId(zoneid, 145725, 45, 3, 3) --Despair

		-- Sha of Pride
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Sha of Pride")
		GridStatusRaidDebuff:DebuffId(zoneid, 144358, 51, 2, 2) --Wounded Pride (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 144843, 52, 3, 3) --Overcome
		GridStatusRaidDebuff:DebuffId(zoneid, 146594, 53, 4, 4) --Gift of the Titans
		GridStatusRaidDebuff:DebuffId(zoneid, 144351, 54, 6, 6, true, true) --Mark of Arrogance
		GridStatusRaidDebuff:DebuffId(zoneid, 144364, 55, 4, 4) --Power of the Titans
		GridStatusRaidDebuff:DebuffId(zoneid, 146822, 56, 6, 6) --Projection
		GridStatusRaidDebuff:DebuffId(zoneid, 146817, 57, 5, 5) --Aura of Pride
		GridStatusRaidDebuff:DebuffId(zoneid, 144774, 58, 2, 2) --Reaching Attacks (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 144636, 59, 5, 5) --Corrupted Prison
		GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison
		GridStatusRaidDebuff:DebuffId(zoneid, 145215, 61, 4, 4) --Banishment (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 147207, 62, 4, 4) --Weakened Resolve (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison
		GridStatusRaidDebuff:DebuffId(zoneid, 144574, 60, 6, 6) --Corrupted Prison

		-- Galakras
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Galakras")
		GridStatusRaidDebuff:DebuffId(zoneid, 146765, 71, 5, 5) --Flame Arrows
		GridStatusRaidDebuff:DebuffId(zoneid, 147705, 72, 5, 5) --Poison Cloud
		GridStatusRaidDebuff:DebuffId(zoneid, 146902, 73, 2, 2) --Poison Tipped blades
		GridStatusRaidDebuff:DebuffId(zoneid, 147068, 74, 2, 2) --Flames of Galakrond

		-- Iron Juggernaut
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Iron Juggernaut")
		GridStatusRaidDebuff:DebuffId(zoneid, 144467, 81, 2, 2, true, true) --Ignite Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 144459, 82, 5, 5) --Laser Burn
		GridStatusRaidDebuff:DebuffId(zoneid, 144498, 83, 5, 5) --Napalm Oil
		GridStatusRaidDebuff:DebuffId(zoneid, 144918, 84, 5, 5) --Cutter Laser
		GridStatusRaidDebuff:DebuffId(zoneid, 146325, 84, 6, 6) --Cutter Laser Target

		-- Kor'kron Dark Shaman
		GridStatusRaidDebuff:BossNameId(zoneid, 90, "Kor'kron Dark Shaman")
		GridStatusRaidDebuff:DebuffId(zoneid, 144089, 91, 6, 6) --Toxic Mist
		GridStatusRaidDebuff:DebuffId(zoneid, 144215, 92, 2, 2) --Froststorm Strike (Tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 143990, 93, 2, 2) --Foul Geyser (Tank only)
		GridStatusRaidDebuff:DebuffId(zoneid, 144304, 94, 2, 2) --Rend
		GridStatusRaidDebuff:DebuffId(zoneid, 144330, 95, 6, 6) --Iron Prison (Heroic)

		-- General Nazgrim
		GridStatusRaidDebuff:BossNameId(zoneid, 100, "General Nazgrim")
		GridStatusRaidDebuff:DebuffId(zoneid, 143638, 101, 6, 6) --Bonecracker
		GridStatusRaidDebuff:DebuffId(zoneid, 143480, 102, 5, 5) --Assassin's Mark
		GridStatusRaidDebuff:DebuffId(zoneid, 143431, 103, 6, 6) --Magistrike (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 143494, 104, 2, 2, true, true) --Sundering Blow (Tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143882, 105, 5, 5) --Hunter's Mark

		-- Malkorok
		GridStatusRaidDebuff:BossNameId(zoneid, 110, "Malkorok")
		GridStatusRaidDebuff:DebuffId(zoneid, 142990, 111, 6, 6, true, true) --Fatal Strike (Tank debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 142913, 112, 5, 5) --Displaced Energy (Dispell)
		GridStatusRaidDebuff:DebuffId(zoneid, 143919, 113, 3, 3) --Languish (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 142861, 114, 2, 2) --Ancient Miasma
		GridStatusRaidDebuff:DebuffId(zoneid, 142863, 115, 4, 4) --Weak Ancient Barrier - Red
		GridStatusRaidDebuff:DebuffId(zoneid, 142864, 116, 4, 4) --Ancient Barrier - Orange
		GridStatusRaidDebuff:DebuffId(zoneid, 142865, 117, 4, 4) --Strong Ancient Barrier - Green

		-- Spoils of Pandaria
		GridStatusRaidDebuff:BossNameId(zoneid, 120, "Spoils of Pandaria")
		GridStatusRaidDebuff:DebuffId(zoneid, 145685, 121, 2, 2) --Unstable Defensive System
		GridStatusRaidDebuff:DebuffId(zoneid, 144853, 122, 3, 3, true, true) --Carnivorous Bite
		GridStatusRaidDebuff:DebuffId(zoneid, 145987, 123, 5, 5) --Set to Blow
		GridStatusRaidDebuff:DebuffId(zoneid, 145218, 124, 4, 4, true, true) --Harden Flesh
		GridStatusRaidDebuff:DebuffId(zoneid, 145230, 125, 1, 1) --Forbidden Magic
		GridStatusRaidDebuff:DebuffId(zoneid, 146217, 126, 4, 4) --Keg Toss
		GridStatusRaidDebuff:DebuffId(zoneid, 146235, 127, 4, 4) --Breath of Fire
		GridStatusRaidDebuff:DebuffId(zoneid, 145523, 128, 4, 4) --Animated Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 142983, 129, 6, 6) --Torment (the new Wrack)
		GridStatusRaidDebuff:DebuffId(zoneid, 145715, 130, 3, 3) --Blazing Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 145747, 131, 5, 5) --Bubbling Amber
		GridStatusRaidDebuff:DebuffId(zoneid, 146289, 132, 4, 4) --Mass Paralysis

		-- Thok the Bloodthirsty
		GridStatusRaidDebuff:BossNameId(zoneid, 140, "Thok the Bloodthirsty")
		GridStatusRaidDebuff:DebuffId(zoneid, 143766, 141, 2, 2, true, true) --Panic (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143773, 142, 2, 2, true, true) --Freezing Breath (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143452, 143, 1, 1) --Bloodied
		GridStatusRaidDebuff:DebuffId(zoneid, 146589, 144, 5, 5) --Skeleton Key (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143445, 145, 6, 6) --Fixate
		GridStatusRaidDebuff:DebuffId(zoneid, 143791, 146, 5, 5) --Corrosive Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 143777, 147, 3, 3) --Frozen Solid (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 143780, 148, 4, 4, true, true) --Acid Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 143800, 149, 5, 5, true, true) --Icy Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 143428, 150, 4, 4) --Tail Lash
		GridStatusRaidDebuff:DebuffId(zoneid, 143784, 151, 2, 2) --Burning Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 143767, 152, 1, 1) --Scorching Breath
		-- This is good, don't need to show it
		GridStatusRaidDebuff:DebuffId(zoneid, 144115, 153, 1, 1, false, false, 0, true) --Flame Coating

		-- Siegecrafter Blackfuse
		GridStatusRaidDebuff:BossNameId(zoneid, 160, "Siegecrafter Blackfuse")
		GridStatusRaidDebuff:DebuffId(zoneid, 144236, 161, 4, 4) --Pattern Recognition
		GridStatusRaidDebuff:DebuffId(zoneid, 144466, 162, 5, 5) --Magnetic Crush
		GridStatusRaidDebuff:DebuffId(zoneid, 143385, 163, 2, 2, true, true) --Electrostatic Charge (tank)
		GridStatusRaidDebuff:DebuffId(zoneid, 143856, 164, 6, 6, true, true) --Superheated

		-- Paragons of the Klaxxi
		GridStatusRaidDebuff:BossNameId(zoneid, 170, "Paragons of the Klaxxi")
		GridStatusRaidDebuff:DebuffId(zoneid, 143617, 171, 5, 5, true, true) --Blue Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 143701, 172, 5, 5) --Whirling (stun)
		GridStatusRaidDebuff:DebuffId(zoneid, 143702, 173, 5, 5) --Whirling
		GridStatusRaidDebuff:DebuffId(zoneid, 142808, 174, 6, 6) --Fiery Edge
		GridStatusRaidDebuff:DebuffId(zoneid, 143609, 175, 5, 5, true, true) --Yellow Sword
		GridStatusRaidDebuff:DebuffId(zoneid, 143610, 176, 5, 5, true, true) --Red Drum
		GridStatusRaidDebuff:DebuffId(zoneid, 142931, 177, 2, 2, true, true) --Exposed Veins
		GridStatusRaidDebuff:DebuffId(zoneid, 143619, 178, 5, 5, true, true) --Yellow Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 143735, 179, 6, 6) --Caustic Amber
		GridStatusRaidDebuff:DebuffId(zoneid, 146452, 180, 5, 5) --Resonating Amber
		GridStatusRaidDebuff:DebuffId(zoneid, 142929, 181, 2, 2, true, true) --Tenderizing Strikes
		GridStatusRaidDebuff:DebuffId(zoneid, 142797, 182, 5, 5) --Noxious Vapors
		GridStatusRaidDebuff:DebuffId(zoneid, 143939, 183, 5, 5) --Gouge
		GridStatusRaidDebuff:DebuffId(zoneid, 143275, 184, 2, 2, true, true) --Hewn
		GridStatusRaidDebuff:DebuffId(zoneid, 143768, 185, 2, 2) --Sonic Projection
		GridStatusRaidDebuff:DebuffId(zoneid, 142532, 186, 6, 6) --Toxin: Blue
		GridStatusRaidDebuff:DebuffId(zoneid, 142534, 187, 6, 6) --Toxin: Yellow
		GridStatusRaidDebuff:DebuffId(zoneid, 143279, 188, 2, 2, true, true) --Genetic Alteration
		GridStatusRaidDebuff:DebuffId(zoneid, 143339, 189, 6, 6, true, true) --Injection
		GridStatusRaidDebuff:DebuffId(zoneid, 142649, 190, 4, 4) --Devour
		GridStatusRaidDebuff:DebuffId(zoneid, 146556, 191, 6, 6) --Pierce
		GridStatusRaidDebuff:DebuffId(zoneid, 142671, 192, 6, 6) --Mesmerize
		GridStatusRaidDebuff:DebuffId(zoneid, 143979, 193, 2, 2, true, true) --Vicious Assault
		GridStatusRaidDebuff:DebuffId(zoneid, 143607, 194, 5, 5, true, true) --Blue Sword
		GridStatusRaidDebuff:DebuffId(zoneid, 143614, 195, 5, 5, true, true) --Yellow Drum
		GridStatusRaidDebuff:DebuffId(zoneid, 143612, 196, 5, 5, true, true) --Blue Drum
		GridStatusRaidDebuff:DebuffId(zoneid, 142533, 197, 6, 6) --Toxin: Red
		GridStatusRaidDebuff:DebuffId(zoneid, 143615, 198, 5, 5, true, true) --Red Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 143974, 199, 2, 2) --Shield Bash (tanks)

		-- Garrosh Hellscream
		GridStatusRaidDebuff:BossNameId(zoneid, 210, "Garrosh Hellscream")
		GridStatusRaidDebuff:DebuffId(zoneid, 144582, 211, 4, 4) --Hamstring
		GridStatusRaidDebuff:DebuffId(zoneid, 144954, 212, 4, 4) --Realm of Y'Shaarj
		GridStatusRaidDebuff:DebuffId(zoneid, 145183, 213, 2, 2, true, true) --Gripping Despair (tanks)
		GridStatusRaidDebuff:DebuffId(zoneid, 144762, 214, 4, 4) --Desecrated
		GridStatusRaidDebuff:DebuffId(zoneid, 145071, 215, 5, 5) --Touch of Y'Sharrj
		GridStatusRaidDebuff:DebuffId(zoneid, 148718, 216, 4, 4) --Fire Pit
	end

	-- MoP Raid
	-- Kun-Lai Summit
	do
		-- local zone = "Kun-Lai Summit"
		local zoneid = 379

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Sha of Anger
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Sha of Anger")
		GridStatusRaidDebuff:DebuffId(zoneid, 119626, 11, 3, 3) --Aggressive Behavior [NOTE: this is the MC]
		GridStatusRaidDebuff:DebuffId(zoneid, 119488, 12, 3, 3) --Unleashed Wrath [NOTE: Must heal these people. Lots of shadow dmg]
		GridStatusRaidDebuff:DebuffId(zoneid, 119610, 13, 3, 3) --Bitter Thoughts (Silence) [NOTE: There are 2 spell IDs in the logs for Bitter Thoughts. which one will Blizzard go with?]
		GridStatusRaidDebuff:DebuffId(zoneid, 119601, 14, 3, 3) --Bitter Thoughts (Silence) [NOTE: There are 2 spell IDs in the logs for Bitter Thoughts. which one will Blizzard go with?]
	end

	-- MoP Raid
	-- Mogu'shan Vaults
	do
		--local zone = "Mogu'shan Vaults"
		local zoneid = 471

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Trash

		-- Dais of Conquerors
		-- Stone Guard trash
		-- Enormous Stone Quilen
		GridStatusRaidDebuff:DebuffId(zoneid, 125092, 1, 6, 6, true, true) --Petrification
		-- Stone Quilen
		GridStatusRaidDebuff:DebuffId(zoneid, 116970, 1, 1, 1, true, true) --Sundering Bite

		-- The Repository
		-- Feng trash
		-- Cursed Mogu Sculpture
		GridStatusRaidDebuff:DebuffId(zoneid, 121087, 2, 1, 1) --Ground Slam
		GridStatusRaidDebuff:DebuffId(zoneid, 121245, 2, 1, 1) --Curse of Vitality (Curse)
		GridStatusRaidDebuff:DebuffId(zoneid, 121247, 2, 1, 1) --Impale

		-- Gara'jal trash
		-- Zandalari Infiltrator
		GridStatusRaidDebuff:DebuffId(zoneid, 116596, 3, 1, 1) --Smoke Bomb
		-- Zandalari Fire-Dancer
		GridStatusRaidDebuff:DebuffId(zoneid, 120670, 3, 1, 1) --Pyroblast
		-- Zandalari Skullcharger
		GridStatusRaidDebuff:DebuffId(zoneid, 116606, 3, 3, 3) --Troll Rush

		-- Forge of the Endless
		-- Elegon trash
		-- Mogu'shan Secret-Keeper
		GridStatusRaidDebuff:DebuffId(zoneid, 118552, 4, 6, 6, true, true) --Flesh to Stone (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 118562, 4, 6, 6) --Petrified

		--The Stone Guard
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "The Stone Guard")
		GridStatusRaidDebuff:DebuffId(zoneid, 130395, 11, 6, 6, true, true) --Jasper Chains: Stacks
		GridStatusRaidDebuff:DebuffId(zoneid, 130774, 13, 5, 5) --Amethyst Pool
		GridStatusRaidDebuff:DebuffId(zoneid, 116281, 14, 4, 4) --Cobalt Mine Blast (dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 125206, 15, 3, 3) --Rend Flesh: Tank only
		GridStatusRaidDebuff:DebuffId(zoneid, 116038, 16, 1, 1, true, true) --Jasper Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
		GridStatusRaidDebuff:DebuffId(zoneid, 115861, 17, 1, 1, true, true) --Cobalt Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
		GridStatusRaidDebuff:DebuffId(zoneid, 116060, 18, 1, 1, true, true) --Amethyst Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
		GridStatusRaidDebuff:DebuffId(zoneid, 116008, 19, 1, 1, true, true) --Jade Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]

		--Feng The Accursed
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Feng The Accursed")
		GridStatusRaidDebuff:DebuffId(zoneid, 131788, 21, 4, 4, true, true) --Lightning Lash: Tank Only: Stacks (Spirit of the Fist)
		GridStatusRaidDebuff:DebuffId(zoneid, 116942, 22, 4, 4, true, true) --Flaming Spear: Tank Only
		GridStatusRaidDebuff:DebuffId(zoneid, 131790, 23, 4, 4, true, true) --Arcane Shock: Stack : Tank Only
		GridStatusRaidDebuff:DebuffId(zoneid, 131792, 24, 4, 4, true, true) --Shadowburn: Tank only: Stacks: HEROIC ONLY
		GridStatusRaidDebuff:DebuffId(zoneid, 116784, 25, 6, 6) --Wildfire Spark: Super Super Important! Like Holy jesus important!
		GridStatusRaidDebuff:DebuffId(zoneid, 116417, 26, 6, 6, true, true) --Arcane Resonance: [Note: Do we care it stacks? Yes I think you lose a stack each time you explode but I was too busy healing to notice]
		GridStatusRaidDebuff:DebuffId(zoneid, 116374, 27, 5, 5) --Lightning Charge: Stun effect
		GridStatusRaidDebuff:DebuffId(zoneid, 116364, 28, 1, 1) --Arcane Velocity
		GridStatusRaidDebuff:DebuffId(zoneid, 116040, 29, 1, 1) --Epicenter
		GridStatusRaidDebuff:DebuffId(zoneid, 102464, 30, 3, 3) --Arcane Shock: AOE [Note: Not sure this is needed. It appeared on wowhead but I have yet to see it in game]

		--Gara'jal the Spiritbinder : [NOTE: Combat events from the second realm do not show in combat logs for those not phased]
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Gara'jal the Spiritbinder")
		GridStatusRaidDebuff:DebuffId(zoneid, 122151, 41, 6, 6) --Voodoo doll: Super Super Important! Like Holy jesus important!
		GridStatusRaidDebuff:DebuffId(zoneid, 117723, 42, 3, 3) --Frail Soul: HEROIC ONLY
		GridStatusRaidDebuff:DebuffId(zoneid, 116260, 43, 5, 5) --Crossed Over [NOTE: Putting this incase events fire between both realms]
		-- Severer of Souls (Heroic) (adds that kill the tank if not killed)
		GridStatusRaidDebuff:DebuffId(zoneid, 116278, 44, 6, 6, true, true) -- Soul Sever

		--The Spirit Kings
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "The Spirit Kings")
		-- Meng the Demented
		GridStatusRaidDebuff:DebuffId(zoneid, 117708, 51, 6, 6) --Maddening Shout (unhealable)
		-- Subetai the Swift
		GridStatusRaidDebuff:DebuffId(zoneid, 118048, 52, 3, 3) --Pillaged
		GridStatusRaidDebuff:DebuffId(zoneid, 118047, 53, 3, 3) --Pillage: Target
		GridStatusRaidDebuff:DebuffId(zoneid, 118135, 54, 3, 3) --Pinned Down
		GridStatusRaidDebuff:DebuffId(zoneid, 118163, 55, 1, 1) --Robbed Blind
		-- Zian of the Endless Shadow
		GridStatusRaidDebuff:DebuffId(zoneid, 118303, 56, 5, 5) --Undying Shadow: Fixate

		--Elegon
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Elegon")
		GridStatusRaidDebuff:DebuffId(zoneid, 117878, 61, 1, 1, true, true) --Overcharged (debuff from standing in circle)
		GridStatusRaidDebuff:DebuffId(zoneid, 117949, 62, 6, 6) --Closed circuit (dispellable debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 117945, 63, 3, 3) --Arcing Energy
		-- Celestial Protector (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 132222, 64, 8, 8) --Destabilizing Energies

		--Will of the Emperor
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Will of the Emperor")
		-- Jan-xi and Qin-xi
		GridStatusRaidDebuff:DebuffId(zoneid, 116835, 71, 4, 4, true, true) -- Devastating Arc
		GridStatusRaidDebuff:DebuffId(zoneid, 132425, 72, 4, 4) -- Stomp
		-- Rage
		GridStatusRaidDebuff:DebuffId(zoneid, 116525, 73, 6, 6) --Focused Assault (Rage fixate)
		-- Courage
		GridStatusRaidDebuff:DebuffId(zoneid, 116778, 74, 6, 6) --Focused Defense (fixate)
		GridStatusRaidDebuff:DebuffId(zoneid, 117485, 75, 1, 1) --Impeding Thrust (slow debuff)
		-- Strength
		GridStatusRaidDebuff:DebuffId(zoneid, 116550, 76, 4, 4) --Energizing Smash (knock down)
		-- Titan Spark (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 116829, 77, 3, 3) --Focused Energy (fixate)
	end

	-- MoP Raid
	-- Heart of Fear
	do
		--local zone = "Heart of Fear"
		local zoneid = 474

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash

		-- Imperial Vizier Zor'lok trash
		-- Sra'thik Shield Master
		GridStatusRaidDebuff:DebuffId(zoneid, 123417, 1, 1, 1, true, true) --Dismantled Armor (armor)
		-- Kor'thik Slicer
		GridStatusRaidDebuff:DebuffId(zoneid, 123422, 1, 1, 1) -- Arterial Bleeding (dot)
		GridStatusRaidDebuff:DebuffId(zoneid, 123434, 1, 2, 2) -- Gouge Throat (silence)
		-- Set'thik Swiftblade
		GridStatusRaidDebuff:DebuffId(zoneid, 123436, 1, 1, 1) -- Riposte (disarm)
		-- Set'thik Fanatic
		GridStatusRaidDebuff:DebuffId(zoneid, 123497, 1, 1, 1) -- Gale Force Winds (slows casting)

		-- Blade Lord Ta'yak trash
		-- Instructor Kli'thak
		GridStatusRaidDebuff:DebuffId(zoneid, 123180, 2, 1, 1) --Wind Step (dot)
		-- Sra'thik Shield Master
		GridStatusRaidDebuff:DebuffId(zoneid, 123420, 2, 2, 2) --Stunning Strike (stun)

		-- Amber-Shaper trash
		-- Amber-Ridden Mushan
		GridStatusRaidDebuff:DebuffId(zoneid, 125081, 5, 1, 1) --Slam (stun)
		-- Amber Searsting
		GridStatusRaidDebuff:DebuffId(zoneid, 125490, 5, 1, 1) --Burning Sting (dot)
		-- Kor'thik Fleshrender
		GridStatusRaidDebuff:DebuffId(zoneid, 126901, 5, 2, 2, true, true) --Mortal Rend (tank, stackable healing debuff)
		GridStatusRaidDebuff:DebuffId(zoneid, 126912, 5, 6, 6) --Grievous Whirl (dot removed when target healed to 90%)

		-- Grand Empress Trash
		-- Kor'thik Warsinger
		GridStatusRaidDebuff:DebuffId(zoneid, 125907, 6, 1, 1) --Cry Havoc

		--Imperial Vizier Zor'lok
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Imperial Vizier Zor'lok")
		GridStatusRaidDebuff:DebuffId(zoneid, 122761, 11, 4, 4) --Exhale
		GridStatusRaidDebuff:DebuffId(zoneid, 123812, 12, 1, 1) --Pheromones of Zeal
		GridStatusRaidDebuff:DebuffId(zoneid, 122740, 13, 6, 6) --Convert (MC)
		GridStatusRaidDebuff:DebuffId(zoneid, 122706, 14, 3, 3) --Noise Cancelling (AMZ)

		--Blade Lord Ta'yak
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Blade Lord Ta'yak")
		GridStatusRaidDebuff:DebuffId(zoneid, 123474, 21, 1, 1, true, true) --Overwhelming Assault (tank stacks)
		GridStatusRaidDebuff:DebuffId(zoneid, 122949, 22, 6, 6) --Unseen Strike (group up on target)
		GridStatusRaidDebuff:DebuffId(zoneid, 124783, 23, 4, 4) --Storm Unleashed
		GridStatusRaidDebuff:DebuffId(zoneid, 123180, 24, 5, 5) --Windstep
		--GridStatusRaidDebuff:DebuffId(zoneid, 123600, 24, 5, 5) --Storm Unleashed?

		--Garalon
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Garalon")
		GridStatusRaidDebuff:DebuffId(zoneid, 122835, 31, 5, 5) --Pheromones (fixate/dot/passable)
		GridStatusRaidDebuff:DebuffId(zoneid, 123081, 32, 6, 6, true, true) --Pungency (Pheromones stacks)
		GridStatusRaidDebuff:DebuffId(zoneid, 122774, 33, 2, 2) --Crush (knocked down)
		GridStatusRaidDebuff:DebuffId(zoneid, 123423, 34, 1, 1) --Weak Points (damage increase)
		--GridStatusRaidDebuff:DebuffId(zoneid, 123120, 33, 4, 4) --Pheromone Trail

		--Wind Lord Mel'jarak
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Wind Lord Mel'jarak")
		-- Sra-thik Amber-Trappers
		GridStatusRaidDebuff:DebuffId(zoneid, 121881, 41, 6, 6) --Amber Prison
		GridStatusRaidDebuff:DebuffId(zoneid, 122055, 42, 1, 1) --Residue
		GridStatusRaidDebuff:DebuffId(zoneid, 122064, 43, 3, 3, true, true) --Corrosive Resin
		-- Kor'thik Elite Blademaster
		GridStatusRaidDebuff:DebuffId(zoneid, 123963, 44, 7, 7) --Kor'thik Strike

		--Amber-Shaper Un'sok
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Amber-Shaper Un'sok")
		GridStatusRaidDebuff:DebuffId(zoneid, 121949, 51, 6, 6) --Parasitic Growth
		GridStatusRaidDebuff:DebuffId(zoneid, 122784, 52, 3, 3) --Reshape Life
		--GridStatusRaidDebuff:DebuffId(zoneid, 122504, 54, 5, 5) --Burning Amber (not a debuff)

		--Grand Empress Shek'zeer
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Grand Empress Shek'zeer")
		GridStatusRaidDebuff:DebuffId(zoneid, 123707, 61, 5, 5, true, true) --Eyes of the Empress (tank stacks)
		GridStatusRaidDebuff:DebuffId(zoneid, 125390, 62, 6, 6) --Fixate
		GridStatusRaidDebuff:DebuffId(zoneid, 123788, 63, 5, 5) --Cry of Terror (debuff that causes AoE)
		GridStatusRaidDebuff:DebuffId(zoneid, 124097, 64, 4, 4) --Sticky Resin
		GridStatusRaidDebuff:DebuffId(zoneid, 123184, 65, 7, 7) --Dissonance Field (unhealable)
		--GridStatusRaidDebuff:DebuffId(zoneid, 125824, 65, 3, 3) --Trapped!
		GridStatusRaidDebuff:DebuffId(zoneid, 124777, 66, 4, 4) --Poison Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 124821, 67, 3, 3) --Poison-Drenched Armor
		--GridStatusRaidDebuff:DebuffId(zoneid, 124827, 68, 1, 1) --Poison Fumes Is actually a buff
		GridStatusRaidDebuff:DebuffId(zoneid, 124849, 69, 6, 6) --Consuming Terror (fear, dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 124863, 70, 6, 6) --Visions of Demise (fear/AoE, dispellable)
		GridStatusRaidDebuff:DebuffId(zoneid, 124862, 71, 5, 5) --Visions of Demise: Target
		GridStatusRaidDebuff:DebuffId(zoneid, 123845, 72, 5, 5) --Heart of Fear: Chosen
		GridStatusRaidDebuff:DebuffId(zoneid, 123846, 73, 5, 5) --Heart of Fear: Lure
		GridStatusRaidDebuff:DebuffId(zoneid, 125283, 74, 1, 1) --Sha Corruption
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
