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

	-- WLK Raid
	-- Naxxramas
	do
		-- local zone = "Naxxramas"
		local zoneid = 163

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 55314, 1, 5, 5) --Strangulate

		--Anub'Rekhan
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Anub'Rekhan")
		GridStatusRaidDebuff:DebuffId(zoneid, 28786, 11, 5, 5, true, true) --Locust Swarm

		--Grand Widow Faerlina
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Grand Widow Faerlina")
		GridStatusRaidDebuff:DebuffId(zoneid, 28796, 21, 5, 5, false, true) --Poison Bolt Volley
		GridStatusRaidDebuff:DebuffId(zoneid, 28794, 22, 5, 5) --Rain of Fire

		--Maexxna
		GridStatusRaidDebuff:BossNameId(zoneid, 25, "Maexxna")
		GridStatusRaidDebuff:DebuffId(zoneid, 28622, 26, 5, 5) --Web Wrap
		GridStatusRaidDebuff:DebuffId(zoneid, 54121, 27, 5, 5) --Necrotic Poison

		--Noth the Plaguebringer
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Noth the Plaguebringer")
		GridStatusRaidDebuff:DebuffId(zoneid, 29213, 31, 5, 5, true) --Curse of the Plaguebringer
		GridStatusRaidDebuff:DebuffId(zoneid, 29214, 32, 5, 5, true) --Wrath of the Plaguebringer
		GridStatusRaidDebuff:DebuffId(zoneid, 29212, 33, 5, 5) --Cripple

		--Heigan the Unclean
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Heigan the Unclean")
		GridStatusRaidDebuff:DebuffId(zoneid, 29998, 41, 5, 5) --Decrepit Fever
		GridStatusRaidDebuff:DebuffId(zoneid, 29310, 42, 5, 5, false, false, nil, true) --Spell Disruption

		--Grobbulus
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Grobbulus")
		GridStatusRaidDebuff:DebuffId(zoneid, 28169, 51, 5, 5, true) --Mutating Injection

		--Gluth
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Gluth")
		GridStatusRaidDebuff:DebuffId(zoneid, 54378, 61, 5, 5, true) --Mortal Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 29306, 62, 5, 5) --Infected Wound

		--Thaddius
		GridStatusRaidDebuff:BossNameId(zoneid, 65, "Thaddius")
		GridStatusRaidDebuff:DebuffId(zoneid, 28084, 66, 5, 5, false, false, {r = 1, g = 0, b = 0}, true) --Negative Charge
		GridStatusRaidDebuff:DebuffId(zoneid, 28059, 67, 5, 5, false, false, {r = 0, g = 0, b = 1}, true) --Positive Charge

		--Instructor Razuvious
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Instructor Razuvious")
		GridStatusRaidDebuff:DebuffId(zoneid, 55550, 71, 5, 5, true) --Jagged Knife

		--Sapphiron
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Sapphiron")
		GridStatusRaidDebuff:DebuffId(zoneid, 28522, 81, 5, 5) --Icebolt
		GridStatusRaidDebuff:DebuffId(zoneid, 28542, 82, 5, 5) --Life Drain

		--Kel'Thuzad
		GridStatusRaidDebuff:BossNameId(zoneid, 100, "Kel'Thuzad")
		GridStatusRaidDebuff:DebuffId(zoneid, 28410, 101, 5, 5, true) --Chains of Kel'Thuzad
		GridStatusRaidDebuff:DebuffId(zoneid, 27819, 102, 5, 5) --Detonate Mana
		GridStatusRaidDebuff:DebuffId(zoneid, 27808, 103, 5, 5) --Frost Blast
	end

	-- WLK Raid
	-- The Obsidian Sanctum
	do
		-- local zone = "The Obsidian Sanctum"
		local zoneid = 155

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 39647, 1, 5, 5) --Curse of Mending
		GridStatusRaidDebuff:DebuffId(zoneid, 58936, 2, 5, 5) --Rain of Fire

		--Sartharion
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Sartharion")
		GridStatusRaidDebuff:DebuffId(zoneid, 60708, 11, 10, 5, false, true) --Fade Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 57491, 12, 5, 5, true, false) --Flame Tsunami
	end

	-- WLK Raid
	-- The Eye of Eternity
	do
		-- local zone = "The Eye of Eternity"
		local zoneid = 141
		-- Note: confirmed spell IDs as of WoD 6.1 3/8/2015

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Malygos
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Malygos")
		GridStatusRaidDebuff:DebuffId(zoneid, 57407, 11, 5, 5) --Surge of Power
		GridStatusRaidDebuff:DebuffId(zoneid, 56272, 12, 5, 5, true) --Arcane Breath
	end

	-- WLK Raid
	-- Ulduar
	do
		-- local zone = "Ulduar"
		local zoneid = 147

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 63612, 2, 5, 5, true, true) --Lightning Brand
		GridStatusRaidDebuff:DebuffId(zoneid, 63615, 3, 10, 5, true, true) --Ravage Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 63169, 6, 5, 5, true, true) --Petrify Joints

		--Razorscale
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Razorscale")
		GridStatusRaidDebuff:DebuffId(zoneid, 64771, 11, 5, 5, true) --Fuse Armor

		--Ignis the Furnace Master
		GridStatusRaidDebuff:BossNameId(zoneid, 15, "Ignis the Furnace Master")
		GridStatusRaidDebuff:DebuffId(zoneid, 62548, 16, 5, 5, true) --Scorch
		GridStatusRaidDebuff:DebuffId(zoneid, 62680, 17, 5, 5) --Flame Jet
		GridStatusRaidDebuff:DebuffId(zoneid, 62717, 18, 6, 5, true) --Slag Pot

		--XT-002
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "XT-002 Deconstructor")
		GridStatusRaidDebuff:DebuffId(zoneid, 63024, 21, 5, 5, true) --Gravity Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 63018, 22, 5, 5, true) --Light Bomb

		--The Assembly of Iron
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "The Iron Council")
		GridStatusRaidDebuff:DebuffId(zoneid, 61888, 31, 5, 5, true) --Overwhelming Power
		GridStatusRaidDebuff:DebuffId(zoneid, 62269, 32, 6, 5) --Rune of Death
		GridStatusRaidDebuff:DebuffId(zoneid, 61903, 33, 5, 5) --Fusion Punch
		GridStatusRaidDebuff:DebuffId(zoneid, 61912, 34, 5, 5, true) --Static Disruption

		--Kologarn
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Kologarn")
		GridStatusRaidDebuff:DebuffId(zoneid, 64290, 41, 5, 5, true) --Stone Grip
		GridStatusRaidDebuff:DebuffId(zoneid, 63355, 42, 10, 5, true, true) --Crunch Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 62055, 43, 5, 5, false, true) --Brittle Skin

		--Hodir
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Hodir")
		GridStatusRaidDebuff:DebuffId(zoneid, 62469, 51, 5, 5) --Freeze
		GridStatusRaidDebuff:DebuffId(zoneid, 61969, 52, 10, 5) --Flash Freeze
		GridStatusRaidDebuff:DebuffId(zoneid, 62188, 53, 5, 5, false, true, nil, true) --Biting Cold

		--Thorim
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Thorim")
		GridStatusRaidDebuff:DebuffId(zoneid, 62042, 61, 5, 5) --Stormhammer
		GridStatusRaidDebuff:DebuffId(zoneid, 62130, 62, 10, 5, true) --Unbalancing Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 62526, 63, 5, 5, true) --Rune Detonation
		GridStatusRaidDebuff:DebuffId(zoneid, 62470, 64, 5, 5, false, false, nil, true) --Deafening Thunder
		GridStatusRaidDebuff:DebuffId(zoneid, 62331, 65, 5, 5) --Impale

		--Freya
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Freya")
		GridStatusRaidDebuff:DebuffId(zoneid, 62589, 71, 5, 5, true) --Nature's Fury
		GridStatusRaidDebuff:DebuffId(zoneid, 62861, 73, 5, 5) --Iron Roots

		--Mimiron
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Mimiron")
		GridStatusRaidDebuff:DebuffId(zoneid, 63666, 81, 5, 5, true) --Napalm Shell
		GridStatusRaidDebuff:DebuffId(zoneid, 62997, 82, 5, 5, true) --Plasma Blast
		GridStatusRaidDebuff:DebuffId(zoneid, 64668, 83, 5, 5) --Magnetic Field

		--General Vezax
		GridStatusRaidDebuff:BossNameId(zoneid, 90, "General Vezax")
		GridStatusRaidDebuff:DebuffId(zoneid, 63276, 91, 10, 5, true) --Mark of the Faceless
		GridStatusRaidDebuff:DebuffId(zoneid, 63322, 92, 5, 5, false, true) --Saronite Vapors

		--Yogg-Saron
		GridStatusRaidDebuff:BossNameId(zoneid, 100, "Yogg-Saron")
		GridStatusRaidDebuff:DebuffId(zoneid, 63134, 101, 10, 5, true) --Sara's Bless
		GridStatusRaidDebuff:DebuffId(zoneid, 63138, 102, 5, 10, true, false, {r = 1, g = 0, b = 0}) --Sara's Fevor
		GridStatusRaidDebuff:DebuffId(zoneid, 63830, 103, 5, 5, true) --Malady of the Mind
		GridStatusRaidDebuff:DebuffId(zoneid, 63802, 104, 5, 5) --Brain Link(Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 63042, 105, 5, 5, true) --Dominate Mind
		GridStatusRaidDebuff:DebuffId(zoneid, 64156, 106, 5, 7) --Apathy
		GridStatusRaidDebuff:DebuffId(zoneid, 64153, 107, 5, 7) --Black Plague
		GridStatusRaidDebuff:DebuffId(zoneid, 64157, 108, 5, 7) --Curse of Doom
		GridStatusRaidDebuff:DebuffId(zoneid, 64152, 109, 5, 7) --Draining Poison (Heroic)
		GridStatusRaidDebuff:DebuffId(zoneid, 64125, 110, 10, 5) --Squeeze
		GridStatusRaidDebuff:DebuffId(zoneid, 63050, 111, 5, 5, false, false, nil, true) --Sanity

		--Algalon
		GridStatusRaidDebuff:BossNameId(zoneid, 120, "Algalon the Observer")
		GridStatusRaidDebuff:DebuffId(zoneid, 64412, 121, 5, 5, true, true) --Phase Punch
	end

	-- WLK Raid
	-- Trial of the Crusader
	do
		-- zone = "Trial of the Crusader"
		local zoneid = 172

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--<< Beast of Northrend >>
		--Gormok the Impaler
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Gormok the Impaler")
		GridStatusRaidDebuff:DebuffId(zoneid, 66331, 11, 5, 5, true, true) --Impale
		GridStatusRaidDebuff:DebuffId(zoneid, 67475, 13, 5, 5, true) --Fire Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 66406, 14, 5, 5) --Snowbolled!

		--Acidmaw --Dreadscale
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Jormungar Behemoth")
		GridStatusRaidDebuff:DebuffId(zoneid, 67618, 23, 5, 5, true) --Paralytic Toxin
		GridStatusRaidDebuff:DebuffId(zoneid, 66869, 24, 5, 5, true) --Burning Bile

		--Icehowl
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Icehowl")
		GridStatusRaidDebuff:DebuffId(zoneid, 67654, 31, 5, 5, true) --Ferocious Butt
		GridStatusRaidDebuff:DebuffId(zoneid, 66689, 32, 5, 5) --Arctic Breathe
		GridStatusRaidDebuff:DebuffId(zoneid, 66683, 33, 5, 5) --Massive Crash

		--Lord Jaraxxus
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lord Jaraxxus")
		GridStatusRaidDebuff:DebuffId(zoneid, 66532, 41, 5, 5) --Fel Fireball
		GridStatusRaidDebuff:DebuffId(zoneid, 66237, 42, 8, 10, true, false, {r = 1, g = 0, b = 0}) --Incinerate Flesh
		GridStatusRaidDebuff:DebuffId(zoneid, 66242, 43, 7, 5, true) --Burning Inferno
		GridStatusRaidDebuff:DebuffId(zoneid, 66197, 44, 5, 5) --Legion Flame
		GridStatusRaidDebuff:DebuffId(zoneid, 66283, 45, 9, 5, true) --Spinning Pain Spike
		GridStatusRaidDebuff:DebuffId(zoneid, 66209, 46, 5, 5, true) --Touch of Jaraxxus(hard)
		GridStatusRaidDebuff:DebuffId(zoneid, 66211, 47, 5, 5, true) --Curse of the Nether(hard)
		GridStatusRaidDebuff:DebuffId(zoneid, 67906, 48, 5, 5) --Mistress's Kiss 10H

		--Faction Champions
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Faction Champions")
		GridStatusRaidDebuff:DebuffId(zoneid, 65812, 51, 10, 10, true, false, {r = 1, g = 0, b = 0}) --Unstable Affliction
		GridStatusRaidDebuff:DebuffId(zoneid, 65960, 52, 5, 5, true) --Blind
		GridStatusRaidDebuff:DebuffId(zoneid, 65801, 53, 5, 7) --Polymorph
		GridStatusRaidDebuff:DebuffId(zoneid, 65543, 54, 5, 7) --Psychic Scream
		GridStatusRaidDebuff:DebuffId(zoneid, 66054, 55, 5, 7) --Hex
		GridStatusRaidDebuff:DebuffId(zoneid, 65809, 56, 5, 7) --Fear

		--The Twin Val'kyr
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "The Twin Val'kyr")
		GridStatusRaidDebuff:DebuffId(zoneid, 67176, 61, 5, 10, false, false, {r = 1, g = 0, b = 0}, true) --Dark Essence
		GridStatusRaidDebuff:DebuffId(zoneid, 67222, 62, 5, 10, false, false, {r = 0, g = 0, b = 1}, true) --Light Essence
		GridStatusRaidDebuff:DebuffId(zoneid, 67283, 63, 7, 5, true) --Dark Touch
		GridStatusRaidDebuff:DebuffId(zoneid, 67298, 64, 7, 5, true) --Ligth Touch
		GridStatusRaidDebuff:DebuffId(zoneid, 67309, 65, 5, 5, false, true) --Twin Spike

		--Anub'arak
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Anub'arak")
		GridStatusRaidDebuff:DebuffId(zoneid, 67574, 71, 10, 10) --Pursued by Anub'arak
		GridStatusRaidDebuff:DebuffId(zoneid, 66013, 72, 7, 10, true, false, {r = 1, g = 0, b = 0}) --Penetrating Cold (10?)
		GridStatusRaidDebuff:DebuffId(zoneid, 67847, 73, 5, 5, false, true) --Expose Weakness
		GridStatusRaidDebuff:DebuffId(zoneid, 66012, 74, 5, 5) --Freezing Slash
		GridStatusRaidDebuff:DebuffId(zoneid, 67863, 75, 8, 5, false, true) --Acid-Drenched Mandibles(25H)
	end

	-- WLK Raid
	-- Icecrown Citadel
	do
		-- local zone = "Icecrown Citadel"
		local zoneid = 186

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--The Lower Spire
		GridStatusRaidDebuff:DebuffId(zoneid, 70980, 1, 6, 5) --Web Wrap
		GridStatusRaidDebuff:DebuffId(zoneid, 69483, 1, 6, 5, true) --Dark Reckoning
		GridStatusRaidDebuff:DebuffId(zoneid, 69969, 1, 5, 5, true) --Curse of Doom

		--The Plagueworks
		GridStatusRaidDebuff:DebuffId(zoneid, 71089, 2, 5, 5, true) --Bubbling Pus
		GridStatusRaidDebuff:DebuffId(zoneid, 71127, 2, 7, 5, true, true) --Mortal Wound
		GridStatusRaidDebuff:DebuffId(zoneid, 71163, 2, 6, 5, true) --Devour Humanoid
		GridStatusRaidDebuff:DebuffId(zoneid, 71103, 2, 6, 5) --Combobulating Spray
		GridStatusRaidDebuff:DebuffId(zoneid, 71157, 2, 5, 5, false, true)
		--Infested Wound

		--The Crimson Hall
		GridStatusRaidDebuff:DebuffId(zoneid, 70645, 3, 9, 5, true, false, {r = 1, g = 0, b = 0}) --Chains of Shadow
		GridStatusRaidDebuff:DebuffId(zoneid, 70671, 3, 5, 5)
		-- Leeching Rot
		GridStatusRaidDebuff:DebuffId(zoneid, 70432, 3, 6, 5, true) --Blood Sap
		GridStatusRaidDebuff:DebuffId(zoneid, 70435, 3, 7, 5, true, true) --Rend Flesh

		--Frostwing Hall
		GridStatusRaidDebuff:DebuffId(zoneid, 71257, 4, 6, 5, true, true) --Barbaric Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 71252, 4, 5, 5, true) --Volley

		GridStatusRaidDebuff:DebuffId(zoneid, 71327, 4, 6, 5) -- Web
		GridStatusRaidDebuff:DebuffId(zoneid, 36922, 4, 5, 5, true) --Bellowing Roar

		--Lord Marrowgar
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Lord Marrowgar")
		GridStatusRaidDebuff:DebuffId(zoneid, 70823, 11, 5, 5, true) --Coldflame
		GridStatusRaidDebuff:DebuffId(zoneid, 69065, 12, 8, 5) --Impaled
		GridStatusRaidDebuff:DebuffId(zoneid, 70835, 13, 5, 5) --Bone Storm

		--Lady Deathwhisper
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Lady Deathwhisper")
		GridStatusRaidDebuff:DebuffId(zoneid, 72109, 21, 5, 5) --Death and Decay
		GridStatusRaidDebuff:DebuffId(zoneid, 71289, 22, 9, 9, true) --Dominate Mind
		GridStatusRaidDebuff:DebuffId(zoneid, 71204, 23, 4, 4, true, true) --Touch of Insignificance
		GridStatusRaidDebuff:DebuffId(zoneid, 67934, 24, 5, 5, true) --Frost Fever
		GridStatusRaidDebuff:DebuffId(zoneid, 71237, 25, 5, 5, true, false, nil, true) --Curse of Torpor
		GridStatusRaidDebuff:DebuffId(zoneid, 72491, 26, 5, 5, true) --Necrotic Strike

		--Gunship Battle
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Icecrown Gunship Battle")
		GridStatusRaidDebuff:DebuffId(zoneid, 69651, 31, 5, 5, true) --Wounding Strike

		--Deathbringer Saurfang
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Deathbringer Saurfang")
		GridStatusRaidDebuff:DebuffId(zoneid, 72293, 41, 6, 8, false, false, {r = 1, g = 0, b = 0}) --Mark of the Fallen Champion
		GridStatusRaidDebuff:DebuffId(zoneid, 72442, 42, 8, 5, true) --Boiling Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 72449, 43, 5, 5, true) --Rune of Blood
		GridStatusRaidDebuff:DebuffId(zoneid, 72769, 44, 5, 5, true) --Scent of Blood (heroic)

		--Rotface
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Rotface")
		GridStatusRaidDebuff:DebuffId(zoneid, 71224, 51, 5, 7, true) --Mutated Infection
		GridStatusRaidDebuff:DebuffId(zoneid, 71215, 52, 5, 5) --Ooze Flood
		GridStatusRaidDebuff:DebuffId(zoneid, 69774, 53, 5, 5) --Sticky Ooze

		--Festergut
		GridStatusRaidDebuff:BossNameId(zoneid, 60, "Festergut")
		GridStatusRaidDebuff:DebuffId(zoneid, 69279, 61, 5, 5, true) --Gas Spore
		GridStatusRaidDebuff:DebuffId(zoneid, 71218, 62, 5, 5, true) --Vile Gas
		GridStatusRaidDebuff:DebuffId(zoneid, 72219, 63, 5, 5, true, true) --Gastric Bloat

		--Proffessor
		GridStatusRaidDebuff:BossNameId(zoneid, 70, "Professor Putricide")
		GridStatusRaidDebuff:DebuffId(zoneid, 70341, 71, 5, 5, true) --Slime Puddle
		GridStatusRaidDebuff:DebuffId(zoneid, 72549, 72, 5, 5, true) --Malleable Goo
		GridStatusRaidDebuff:DebuffId(zoneid, 71278, 73, 5, 5, true) --Choking Gas Bomb
		GridStatusRaidDebuff:DebuffId(zoneid, 70215, 74, 5, 5, true) --Gaseous Bloat
		GridStatusRaidDebuff:DebuffId(zoneid, 70447, 75, 5, 5, true) --Volatile Ooze Adhesive
		GridStatusRaidDebuff:DebuffId(zoneid, 72454, 76, 5, 5, true, true) --Mutated Plague
		GridStatusRaidDebuff:DebuffId(zoneid, 70405, 77, 5, 5, false, false, {r = 1, g = 0, b = 0}) --Mutated Transformation
		GridStatusRaidDebuff:DebuffId(zoneid, 72856, 78, 6, 4, true) --Unbound Plague
		GridStatusRaidDebuff:DebuffId(zoneid, 70953, 79, 4, 6, true, true, {r = 0, g = 0, b = 1}) --Plague Sickness
		--Blood Princes
		GridStatusRaidDebuff:BossNameId(zoneid, 80, "Blood Princes")
		GridStatusRaidDebuff:DebuffId(zoneid, 72796, 81, 7, 5, true) --Glittering Sparks
		GridStatusRaidDebuff:DebuffId(zoneid, 71822, 82, 5, 7) --Shadow Resonance

		--Blood-Queen Lana'thel
		GridStatusRaidDebuff:BossNameId(zoneid, 90, "Blood-Queen Lana'thel")
		GridStatusRaidDebuff:DebuffId(zoneid, 70838, 91, 5, 5) --Blood Mirror
		GridStatusRaidDebuff:DebuffId(zoneid, 72265, 92, 6, 5, true) --Delirious Slash
		GridStatusRaidDebuff:DebuffId(zoneid, 71473, 93, 5, 7, true) --Essence of the Blood Queen
		GridStatusRaidDebuff:DebuffId(zoneid, 71474, 94, 6, 5, true) --Frenzied Bloodthirst
		GridStatusRaidDebuff:DebuffId(zoneid, 73070, 95, 5, 5, true) --Incite Terror
		GridStatusRaidDebuff:DebuffId(zoneid, 71340, 96, 7, 5) --Pact of the Darkfallen
		GridStatusRaidDebuff:DebuffId(zoneid, 71265, 97, 6, 5) --Swarming Shadows
		GridStatusRaidDebuff:DebuffId(zoneid, 70923, 98, 10, 10) --Uncontrollable Frenzy

		--Valithria Dreamwalker
		GridStatusRaidDebuff:BossNameId(zoneid, 100, "Valithria Dreamwalker")
		GridStatusRaidDebuff:DebuffId(zoneid, 70873, 101, 1, 5, true, true) --Emerald Vigor
		GridStatusRaidDebuff:DebuffId(zoneid, 71746, 102, 5, 5) --Column of Frost
		GridStatusRaidDebuff:DebuffId(zoneid, 71741, 103, 4, 5) --Mana Void
		GridStatusRaidDebuff:DebuffId(zoneid, 71738, 104, 7, 5, true, true) --Corrosion
		GridStatusRaidDebuff:DebuffId(zoneid, 71733, 105, 6, 5, true) --Acid Burst
		GridStatusRaidDebuff:DebuffId(zoneid, 71283, 106, 6, 5, true) --Gut Spray
		GridStatusRaidDebuff:DebuffId(zoneid, 71941, 107, 1, 5, true, true) --Twisted Nightmares

		--Sindragosa
		GridStatusRaidDebuff:BossNameId(zoneid, 110, "Sindragosa")
		GridStatusRaidDebuff:DebuffId(zoneid, 69762, 111, 5, 5, true) --Unchained Magic
		GridStatusRaidDebuff:DebuffId(zoneid, 70106, 112, 6, 5, true, true) --Chlled to the Bone
		GridStatusRaidDebuff:DebuffId(zoneid, 69766, 113, 6, 5, true, true) --Instability
		GridStatusRaidDebuff:DebuffId(zoneid, 70126, 114, 9, 5, true) --Frost Beacon
		GridStatusRaidDebuff:DebuffId(zoneid, 70157, 115, 8, 5, true) --Ice Tomb
		GridStatusRaidDebuff:DebuffId(zoneid, 70127, 116, 7, 5, false, true) --Mystic Buffet

		--The Lich King
		GridStatusRaidDebuff:BossNameId(zoneid, 120, "The Lich King")
		GridStatusRaidDebuff:DebuffId(zoneid, 70337, 121, 8, 5, true, true) --Necrotic plague
		GridStatusRaidDebuff:DebuffId(zoneid, 72149, 122, 5, 5, true) --Shockwave
		GridStatusRaidDebuff:DebuffId(zoneid, 70541, 123, 7, 5) --Infest
		GridStatusRaidDebuff:DebuffId(zoneid, 69242, 124, 5, 5, true) --Soul Shriek  -- 69200 Raging Spirit
		GridStatusRaidDebuff:DebuffId(zoneid, 69409, 125, 9, 5, true) --Soul Reaper
		GridStatusRaidDebuff:DebuffId(zoneid, 72762, 126, 5, 5) --Defile
		GridStatusRaidDebuff:DebuffId(zoneid, 68980, 127, 8, 5) --Harvest Soul
	end

	-- WLK Raid
	-- Vault of Archavon
	do
		-- local zone = "Vault of Archavon"
		local zoneid = 156
		-- Note: updated spell ids as of WoD 6.1 3/7/2015

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		-- Trash
		-- Archavon Warder
		GridStatusRaidDebuff:DebuffId(zoneid, 60919, 1, 1, 1) -- Rock Shower (dot)
		GridStatusRaidDebuff:DebuffId(zoneid, 60897, 1, 2, 2) -- Shield Crush

		-- Archavon the Stone Watcher
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Archavon the Stone Watcher")
		GridStatusRaidDebuff:DebuffId(zoneid, 58678, 11, 5, 5) -- Rock Shards
		GridStatusRaidDebuff:DebuffId(zoneid, 61672, 12, 4, 4) -- Chocking Cloud
		GridStatusRaidDebuff:DebuffId(zoneid, 60880, 13, 3, 3) -- Stomp (Stun)

		-- Emalon
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Emalon the Storm Watcher")
		-- no debuffs

		--Koralon
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Koralon the Flame Watcher")
		GridStatusRaidDebuff:DebuffId(zoneid, 66684, 31, 5, 5) -- Flaming Cinder

		--Toravon
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Toravon the Ice Watcher")
		GridStatusRaidDebuff:DebuffId(zoneid, 71993, 41, 5, 5, true, true) --Frozen Mallet
		GridStatusRaidDebuff:DebuffId(zoneid, 72004, 42, 5, 5, true, true) --Frostbite
		GridStatusRaidDebuff:DebuffId(zoneid, 72090, 43, 5, 5) --Freezing Ground
		GridStatusRaidDebuff:DebuffId(zoneid, 72090, 44, 1, 1) --Whiteout
	end

	-- WLK Raid
	-- The Ruby Sanctum
	do
		-- local zone = "The Ruby Sanctum"
		local zoneid = 200

		--zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

		--Trash
		GridStatusRaidDebuff:DebuffId(zoneid, 13737, 1, 5, 5, true) --Mortal Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 15621, 2, 5, 5) --Skull Crack
		GridStatusRaidDebuff:DebuffId(zoneid, 75413, 3, 5, 5, true) --Flame Wave
		GridStatusRaidDebuff:DebuffId(zoneid, 75418, 4, 5, 5) --Shockwave

		--Saviana Ragefire
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Saviana Ragefire")
		GridStatusRaidDebuff:DebuffId(zoneid, 74453, 11, 5, 5, true) --Flame Beacon
		GridStatusRaidDebuff:DebuffId(zoneid, 74456, 12, 5, 5, true) --Conflagration

		--Baltharus the Warborn
		GridStatusRaidDebuff:BossNameId(zoneid, 15, "Baltharus the Warborn")
		GridStatusRaidDebuff:DebuffId(zoneid, 74505, 16, 5, 5, false, true) --Enervating Brand
		GridStatusRaidDebuff:DebuffId(zoneid, 74509, 17, 5, 5) --Repelling Wave

		--General Zarithrian
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "General Zarithrian")
		GridStatusRaidDebuff:DebuffId(zoneid, 74384, 21, 5, 5, true) --Intimidating Roar
		GridStatusRaidDebuff:DebuffId(zoneid, 74367, 22, 5, 5, false, true) --Cleave Armor

		--Halion
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Halion")
		GridStatusRaidDebuff:DebuffId(zoneid, 74567, 31, 5, 5, true, true) --Mark of Combustion
		GridStatusRaidDebuff:DebuffId(zoneid, 74795, 32, 5, 5, true, true) --Mark of Consumption
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
