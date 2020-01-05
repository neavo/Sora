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

	-- TBC Raid
	-- Karazhan
	do
		-- local zone = "Karazhan"
		local zoneid = 350

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Moroes
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Moroes")
		GridStatusRaidDebuff:DebuffId(zoneid, 37066, 11, 5, 5) --Garrote

		--Maiden
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Maiden of Virtue")
		GridStatusRaidDebuff:DebuffId(zoneid, 29522, 21, 5, 5) --Holy Fire
		GridStatusRaidDebuff:DebuffId(zoneid, 29511, 22, 5, 5) --Repentance

		--Opera : Bigbad wolf
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "The Big Bad Wolf")
		GridStatusRaidDebuff:DebuffId(zoneid, 30753, 31, 5, 5, true) --Red riding hood

		--Illhoof
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Terestian Illhoof")
		GridStatusRaidDebuff:DebuffId(zoneid, 30115, 41, 5, 5) --Sacrifice

		--Malche
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Prince Malchezaar")
		GridStatusRaidDebuff:DebuffId(zoneid, 30843, 51, 5, 5) --Enfeeble
	end

	-- TBC Raid
	-- Serpentshrine Cavern
	do
		-- local zone = "Serpentshrine Cavern"
		local zoneid = 332

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 39042, 1, 5, 5) --Rampent Infection
		GridStatusRaidDebuff:DebuffId(zoneid, 39044, 2, 5, 5, true) --Serpentshrine Parasite

		--Hydross
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Hydross the Unstable")
		GridStatusRaidDebuff:DebuffId(zoneid, 38235, 11, 5, 5, true) --Water Tomb
		GridStatusRaidDebuff:DebuffId(zoneid, 38246, 12, 5, 5) --Vile Sludge

		--Morogrim
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Morogrim Tidewalker")
		GridStatusRaidDebuff:DebuffId(zoneid, 37850, 21, 5, 5, true) --Watery Grave

		--Leotheras
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Leotheras the Blind")
		GridStatusRaidDebuff:DebuffId(zoneid, 37676, 31, 5, 5) --insidious whisper
		GridStatusRaidDebuff:DebuffId(zoneid, 37641, 32, 5, 5, true) --Whirl wind
		GridStatusRaidDebuff:DebuffId(zoneid, 37749, 33, 5, 5) --Madness

		--Vashj
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lady Vashj")
		GridStatusRaidDebuff:DebuffId(zoneid, 38280, 34, 5, 5, true) --Static Charge
	end

	-- TBC Raid
	-- Tempest Keep
	do
		-- local zone = "Tempest Keep"
		local zoneid = 334

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 37123, 1, 5, 5) --Saw Blade
		GridStatusRaidDebuff:DebuffId(zoneid, 37120, 2, 5, 5) --Fragmentation Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 37118, 3, 5, 5) --Shell Shock

		--Solarian
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "High Astromancer Solarian")
		GridStatusRaidDebuff:DebuffId(zoneid, 42783, 31, 5, 5, true) --Wrath of the Astromancer

		--Kaeltahas
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Kael'thas Sunstrider")
		GridStatusRaidDebuff:DebuffId(zoneid, 37027, 41, 5, 5) --Remote Toy
		GridStatusRaidDebuff:DebuffId(zoneid, 36798, 42, 5, 5) --Mind Control
	end

	-- TBC Raid
	-- Hyjal Summit
	do
		-- local zone = "Hyjal Summit"
		local zoneid = 329

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Winterchill
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Rage Winterchill")
		GridStatusRaidDebuff:DebuffId(zoneid, 31249, 11, 5, 5, true) --Ice Bolt

		--Aneteron
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Anetheron")
		GridStatusRaidDebuff:DebuffId(zoneid, 31306, 21, 5, 5) --Carrion Swarm
		GridStatusRaidDebuff:DebuffId(zoneid, 31298, 22, 5, 5, true) --Sleep

		--Azgalor
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Azgalor")
		GridStatusRaidDebuff:DebuffId(zoneid, 31347, 31, 5, 5, true) --Doom
		GridStatusRaidDebuff:DebuffId(zoneid, 31341, 32, 5, 5, true) --Unquenchable Flames
		GridStatusRaidDebuff:DebuffId(zoneid, 31344, 33, 5, 5, true) --Howl of Azgalor

		--Achimonde
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Archimonde")
		GridStatusRaidDebuff:DebuffId(zoneid, 31944, 41, 5, 5, true) --Doomfire
		GridStatusRaidDebuff:DebuffId(zoneid, 31972, 42, 5, 5) --Grip
	end

	-- TBC Raid
	-- Black Temple
	do
		-- local zone = "Black Temple"
		local zoneid = 340
		-- Note: updated spell ids as of WoD 6.1 3/8/2015

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 34654, 1, 4, 4, true) --Blind (poison)

		-- Illidari Defiler
		GridStatusRaidDebuff:DebuffId(zoneid, 39674, 1, 4, 4, true) --Banish (magic)

		-- Illidari Nightlord
		GridStatusRaidDebuff:DebuffId(zoneid, 41150, 1, 4, 4, true) --Fear (magic)

		-- Illidari Centurion
		GridStatusRaidDebuff:DebuffId(zoneid, 41168, 1, 4, 4, true) --Sonic Strike (silence)

		-- Illidari Battle-mage
		GridStatusRaidDebuff:DebuffId(zoneid, 41382, 1, 3, 3) --Blizzard (mana drain)
		-- This spell is listed under High Nethermancer Zerevor instead
		-- GridStatusRaidDebuff:DebuffId(zoneid, 41379, 1, 1, 1) --Flamestrike
		GridStatusRaidDebuff:DebuffId(zoneid, 41384, 1, 2, 2, true) -- Frostbolt (magic)

		-- Illidari Heartseeker
		GridStatusRaidDebuff:DebuffId(zoneid, 41171, 1, 3, 3, true) -- Skeleton Shot (dot)
		GridStatusRaidDebuff:DebuffId(zoneid, 41170, 1, 4, 4, true) -- Curse of the Bleakheart (curse, stun)

		-- Illidari Assassin
		GridStatusRaidDebuff:DebuffId(zoneid, 3609, 1, 4, 4, true) --Paralyzing Poison (poison, stun)

		-- Illidari Boneslicer
		GridStatusRaidDebuff:DebuffId(zoneid, 24698, 1, 2, 2, true) --Gouge (stun)

		-- Bonechewer Spectator
		GridStatusRaidDebuff:DebuffId(zoneid, 25646, 1, 2, 2, true) --Mortal Wound (healing reduction)

		-- Bonechewer Behemoth
		GridStatusRaidDebuff:DebuffId(zoneid, 41274, 1, 2, 2, true) --Fel Stomp (stun)

		-- Bonechewer Shield Disciple
		GridStatusRaidDebuff:DebuffId(zoneid, 41197, 1, 2, 2, true) --Shield Bash (stun)

		-- Temple Concubine
		GridStatusRaidDebuff:DebuffId(zoneid, 41338, 1, 2, 2, true) --Love Tap (stun)

		-- Priestess of Delight
		GridStatusRaidDebuff:DebuffId(zoneid, 41351, 1, 4, 4, true) --Curse of Virtality (curse, dot)

		-- Priestess of Dementia
		GridStatusRaidDebuff:DebuffId(zoneid, 41404, 1, 2, 2, true) -- Dementia

		-- Charming Courtesan
		GridStatusRaidDebuff:DebuffId(zoneid, 41345, 1, 4, 4, true) --Infatuation (charm)

		-- Mutant War Hound
		GridStatusRaidDebuff:DebuffId(zoneid, 41193, 1, 3, 3, true) -- Cloud of Disease (dot)

		-- Unknown trash
		GridStatusRaidDebuff:DebuffId(zoneid, 41392, 1, 1, 1) --Riposte (disarm)
		GridStatusRaidDebuff:DebuffId(zoneid, 41272, 1, 2, 2, true) --Behemoth Charge (stun)
		GridStatusRaidDebuff:DebuffId(zoneid, 41397, 1, 2, 2, true) --Confusion (blind)
		GridStatusRaidDebuff:DebuffId(zoneid, 41541, 1, 2, 2) --Consecration
		GridStatusRaidDebuff:DebuffId(zoneid, 41389, 1, 2, 2, true) --Kidney shot (stun)

		--Najentus
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "High Warlord Naj'entus")
		GridStatusRaidDebuff:DebuffId(zoneid, 39837, 11, 5, 5) --Impaling Spine

		--Terron
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Teron Gorefiend")
		GridStatusRaidDebuff:DebuffId(zoneid, 40239, 21, 5, 5, true) --Incinerate
		GridStatusRaidDebuff:DebuffId(zoneid, 40251, 22, 5, 5, true) --Shadow of death
		GridStatusRaidDebuff:DebuffId(zoneid, 40243, 23, 5, 5) --Crushing Shadows

		--Gurtogg
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Gurtogg Bloodboil")
		GridStatusRaidDebuff:DebuffId(zoneid, 40604, 31, 5, 5, true) --Fel Rage
		GridStatusRaidDebuff:DebuffId(zoneid, 40481, 32, 5, 5, true, true) --Acidic Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 40508, 33, 5, 5) --Fel-Acid Breath
		GridStatusRaidDebuff:DebuffId(zoneid, 42005, 34, 5, 5, true, true) --Bloodboil

		--ROS
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Reliquary of Souls")
		-- Essence of Suffering
		GridStatusRaidDebuff:DebuffId(zoneid, 41303, 41, 5, 5) --Soul Drain
		GridStatusRaidDebuff:DebuffId(zoneid, 41294, 42, 5, 5, true) --Fixate
		GridStatusRaidDebuff:DebuffId(zoneid, 41292, 43, 1, 1) -- Aura of Suffering
		-- Essence of Desire
		GridStatusRaidDebuff:DebuffId(zoneid, 41410, 44, 5, 5, true) --Deaden
		GridStatusRaidDebuff:DebuffId(zoneid, 41426, 45, 4, 4, true) --Spirit Shock (stun)
		GridStatusRaidDebuff:DebuffId(zoneid, 41350, 46, 1, 1) --Aura of Desire
		-- Essence of Anger
		GridStatusRaidDebuff:DebuffId(zoneid, 41376, 47, 5, 5, true) --Spite
		GridStatusRaidDebuff:DebuffId(zoneid, 41337, 48, 1, 1) --Aura of Anger

		--Mother Shahraz
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Mother Shahraz")
		GridStatusRaidDebuff:DebuffId(zoneid, 40860, 51, 5, 5, true) --Vile Beam
		GridStatusRaidDebuff:DebuffId(zoneid, 41001, 52, 5, 5) --Fatal Attraction
		GridStatusRaidDebuff:DebuffId(zoneid, 40823, 53, 1, 1, true) --Silencing Shriek

		--Council
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "The Illidari Council")
		-- Veras Darkshadow
		GridStatusRaidDebuff:DebuffId(zoneid, 41485, 61, 5, 5, true) --Deadly Poison
		-- Lady Malande
		GridStatusRaidDebuff:DebuffId(zoneid, 41472, 62, 5, 5, true) --Divine Wrath
		-- Gathios the Shatterer
		GridStatusRaidDebuff:DebuffId(zoneid, 13005, 63, 5, 5, true) --Hammer of Justice (stun)
		-- High Nethermancer Zerevor
		GridStatusRaidDebuff:DebuffId(zoneid, 41481, 64, 5, 5) --Flamestrike

		--Illidan
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Illidan Stormrage")
		GridStatusRaidDebuff:DebuffId(zoneid, 41914, 71, 5, 5, true) --Parasitic Shadowfiend
		GridStatusRaidDebuff:DebuffId(zoneid, 40585, 72, 5, 5, true) --Dark Barrage
		GridStatusRaidDebuff:DebuffId(zoneid, 41032, 73, 4, 4) --Shear
		GridStatusRaidDebuff:DebuffId(zoneid, 40932, 74, 5, 5, true) --Agonizing Flames
		GridStatusRaidDebuff:DebuffId(zoneid, 41142, 75, 1, 1, true) --Aura of Dread
		GridStatusRaidDebuff:DebuffId(zoneid, 40647, 76, 6, 6, true) --Shadow Prison
	end

	-- TBC Raid
	-- Sunwell Plateau
	do
		-- local zone = "Sunwell Plateau"
		local zoneid = 335

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 46561, 1, 5, 5) --Fear
		GridStatusRaidDebuff:DebuffId(zoneid, 46562, 2, 5, 5) --Mind Flay
		GridStatusRaidDebuff:DebuffId(zoneid, 46266, 3, 5, 5) --Burn Mana
		GridStatusRaidDebuff:DebuffId(zoneid, 46557, 4, 5, 5) --Slaying Shot
		GridStatusRaidDebuff:DebuffId(zoneid, 46560, 5, 5, 5) --Shadow Word: Pain
		GridStatusRaidDebuff:DebuffId(zoneid, 46543, 6, 5, 5) --Ignite Mana
		GridStatusRaidDebuff:DebuffId(zoneid, 46427, 7, 5, 5) --Domination

		--Kalecgos
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Kalecgos")
		GridStatusRaidDebuff:DebuffId(zoneid, 45032, 11, 5, 5, true) --Curse of Boundless Agony
		GridStatusRaidDebuff:DebuffId(zoneid, 45018, 12, 5, 5) --Arcane Buffet

		--Brutallus
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Brutallus")
		GridStatusRaidDebuff:DebuffId(zoneid, 46394, 21, 5, 5, true) --Burn
		GridStatusRaidDebuff:DebuffId(zoneid, 45150, 22, 5, 5, false, true) --Meteor Slash

		--Felmyst
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Felmyst")
		GridStatusRaidDebuff:DebuffId(zoneid, 45855, 31, 5, 5) --Gas Nova
		GridStatusRaidDebuff:DebuffId(zoneid, 45662, 32, 5, 5, true) --Encapsulate(dosen't have Combat Log)
		GridStatusRaidDebuff:DebuffId(zoneid, 45402, 33, 5, 5) --Demonic Vapor
		GridStatusRaidDebuff:DebuffId(zoneid, 45717, 34, 5, 5) --Fog of Corruption*unit is hostile in comabtlog event)

		--Twins
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "The Eredar Twins")
		GridStatusRaidDebuff:DebuffId(zoneid, 45256, 41, 5, 5) --Confounding Blow
		GridStatusRaidDebuff:DebuffId(zoneid, 45333, 42, 5, 5) --Conflagration
		GridStatusRaidDebuff:DebuffId(zoneid, 46771, 43, 5, 5) --Flame Sear
		GridStatusRaidDebuff:DebuffId(zoneid, 45270, 44, 5, 5) --Shadowfury
		GridStatusRaidDebuff:DebuffId(zoneid, 45347, 45, 5, 5, false, false, {r = 1, g = 0, b = 0}, true) --Dark Touched
		GridStatusRaidDebuff:DebuffId(zoneid, 45348, 46, 5, 5, false, false, {r = 0, g = 0, b = 1}, true) --Fire Touched

		--Muru
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "M'uru")
		GridStatusRaidDebuff:DebuffId(zoneid, 45996, 51, 5, 5) --Darkness

		--Kiljaeden
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Kil'jaeden")
		GridStatusRaidDebuff:DebuffId(zoneid, 45442, 61, 5, 5) --Soul Flay
		GridStatusRaidDebuff:DebuffId(zoneid, 45641, 62, 5, 5, true) --Fire Bloom
		GridStatusRaidDebuff:DebuffId(zoneid, 45885, 63, 5, 5, true) --Shadow Spike
		GridStatusRaidDebuff:DebuffId(zoneid, 45737, 64, 5, 5, true) --Flame Dart
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
