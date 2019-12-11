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

-- Legion Dungeon
-- Trial of Valor
do
	--Trash
	GridStatusRaidDebuff:DebuffId(zoneid, 232450, 1, 5, 5) -- Corrupted Axion
	GridStatusRaidDebuff:DebuffId(zoneid, 228883, 1, 5, 5) -- Unholy Reckoning

	-- Guarm
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Guarm")
	GridStatusRaidDebuff:DebuffId(zoneid, 228226, 11, 6, 6) -- Flame Lick
	GridStatusRaidDebuff:DebuffId(zoneid, 228246, 12, 6, 6) -- Frost Lick
	GridStatusRaidDebuff:DebuffId(zoneid, 228250, 13, 6, 6) -- Shadow Lick
	GridStatusRaidDebuff:DebuffId(zoneid, 227539, 14, 5, 5) -- Fiery Phlegm
	GridStatusRaidDebuff:DebuffId(zoneid, 227566, 15, 5, 5) -- Salty Spittle
	GridStatusRaidDebuff:DebuffId(zoneid, 227570, 16, 5, 5) -- Dark Discharge
	GridStatusRaidDebuff:DebuffId(zoneid, 228744, 17, 5, 5) -- Flaming Volatile Foam
	GridStatusRaidDebuff:DebuffId(zoneid, 228810, 18, 5, 5) -- Briney Volatile Foam
	GridStatusRaidDebuff:DebuffId(zoneid, 228818, 19, 5, 5) -- Shadowy Volatile Foam

	-- Helya
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Helya")
	GridStatusRaidDebuff:DebuffId(zoneid, 227903, 21, 5, 5) -- Orb of Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 228058, 22, 5, 5) -- Orb of Corrosion
	GridStatusRaidDebuff:DebuffId(zoneid, 228054, 23, 6, 6) -- Taint of the Sea
	GridStatusRaidDebuff:DebuffId(zoneid, 193367, 24, 5, 5) -- Fetid Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 227982, 25, 5, 5) -- Bilewater Redox
	GridStatusRaidDebuff:DebuffId(zoneid, 228519, 26, 5, 5) -- Anchor Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 202476, 27, 5, 5) -- Rabid
	GridStatusRaidDebuff:DebuffId(zoneid, 232450, 28, 5, 5) -- Corrupted Axion

	-- Odyn
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Odyn")
	GridStatusRaidDebuff:DebuffId(zoneid, 227959, 31, 5, 5) -- Storm of Justice
	GridStatusRaidDebuff:DebuffId(zoneid, 227475, 32, 5, 5) -- Cleansing Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 192044, 33, 5, 5) -- Expel Light
	GridStatusRaidDebuff:DebuffId(zoneid, 227781, 34, 5, 5) -- Glowing Fragment
end

-- Legion Dungeon
-- Tomb of Sargeras
do
	-- Goroth
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Goroth")
	GridStatusRaidDebuff:DebuffId(zoneid, 233279, 11, 6, 6, true) -- Shattering Star
	GridStatusRaidDebuff:DebuffId(zoneid, 230345, 12, 6, 6, true) -- Crashing Comet
	GridStatusRaidDebuff:DebuffId(zoneid, 231363, 13, 6, 6, true) -- Burning Armor

	-- Demonic Inquisition
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Demonic Inquisition")
	GridStatusRaidDebuff:DebuffId(zoneid, 233430, 21, 5, 5) -- Ubearable Torment
	GridStatusRaidDebuff:DebuffId(zoneid, 233983, 22, 6, 6, true) -- Echoing Anguish

	-- Harjatan
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Harjatan")
	GridStatusRaidDebuff:DebuffId(zoneid, 231770, 31, 5, 5, false, true) -- Drenched
	GridStatusRaidDebuff:DebuffId(zoneid, 231998, 32, 6, 6, true, true) -- Jagged Abrasion

	-- Sisters of the Moon
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Sisters of the Moon")
	GridStatusRaidDebuff:DebuffId(zoneid, 236603, 41, 6, 6, true) -- Rapid Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 234996, 42, 6, 6, false, true) -- Umbra Suffusion
	GridStatusRaidDebuff:DebuffId(zoneid, 234995, 43, 6, 6, false, true) -- Lunar Suffusion
	GridStatusRaidDebuff:DebuffId(zoneid, 236519, 44, 6, 6, true) -- Moon Burn
	GridStatusRaidDebuff:DebuffId(zoneid, 236697, 45, 7, 7, false, true) -- Deathly Screech
	GridStatusRaidDebuff:DebuffId(zoneid, 236550, 46, 6, 6, true) -- Discorporate
	GridStatusRaidDebuff:DebuffId(zoneid, 239264, 47, 6, 6, true, true) -- Lunar Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 233263, 48, 7, 7, true) -- Embrace of the Eclipse

	-- Mistress Sassz'ine
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Mistress Sassz'ine")
	GridStatusRaidDebuff:DebuffId(zoneid, 230959, 51, 6, 6, true) -- Concealing Murk
	GridStatusRaidDebuff:DebuffId(zoneid, 232722, 52, 6, 6, true) -- Slicing Tornado
	GridStatusRaidDebuff:DebuffId(zoneid, 232913, 53, 6, 6) -- Befouling Ink
	GridStatusRaidDebuff:DebuffId(zoneid, 234621, 54, 6, 6) -- Devouring Maw
	GridStatusRaidDebuff:DebuffId(zoneid, 230201, 55, 6, 6) -- Burden of Pain

	-- The Desolate Host
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "The Desolate Host")
	GridStatusRaidDebuff:DebuffId(zoneid, 236072, 61, 6, 6) -- Wailing Souls
	GridStatusRaidDebuff:DebuffId(zoneid, 236449, 62, 7, 7) -- Soulbind
	GridStatusRaidDebuff:DebuffId(zoneid, 236515, 63, 6, 6, true) -- Shattering Scream
	GridStatusRaidDebuff:DebuffId(zoneid, 235989, 64, 6, 6) -- Tormented Cries
	GridStatusRaidDebuff:DebuffId(zoneid, 236131, 65, 7, 7, true) -- Wither

	-- Maiden of Vigilance
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Maiden of Vigilance")
	GridStatusRaidDebuff:DebuffId(zoneid, 235117, 71, 6, 6, true) -- Unstable Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 235534, 72, 6, 6, false, true) -- Creator's Grace
	GridStatusRaidDebuff:DebuffId(zoneid, 235538, 73, 6, 6, false, true) -- Demon's Vigor
	GridStatusRaidDebuff:DebuffId(zoneid, 234891, 74, 6, 6) -- Wrath of the Creators
	GridStatusRaidDebuff:DebuffId(zoneid, 235569, 75, 6, 6) -- Hammer of Creation
	GridStatusRaidDebuff:DebuffId(zoneid, 235573, 76, 6, 6) -- Hammer of Obliteration

	-- Fallen Avatar
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Fallen Avatar")
	GridStatusRaidDebuff:DebuffId(zoneid, 239058, 81, 6, 6) -- Touch of Sargeras
	GridStatusRaidDebuff:DebuffId(zoneid, 239739, 82, 6, 6, true) -- Dark Mark
	GridStatusRaidDebuff:DebuffId(zoneid, 234059, 83, 6, 6, true) -- Unbound Chaos
	GridStatusRaidDebuff:DebuffId(zoneid, 240213, 84, 6, 6, true) -- Chaos Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 236604, 85, 6, 6) -- Shadowy Blades
	GridStatusRaidDebuff:DebuffId(zoneid, 236494, 86, 6, 6, true, true) -- Desolate

	-- Kil'jaeden
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "Kil'jaeden")
	GridStatusRaidDebuff:DebuffId(zoneid, 238999, 91, 6, 6) -- Darkness of a Thousand Souls
	GridStatusRaidDebuff:DebuffId(zoneid, 239155, 92, 7, 7) -- Gravity Squeeze
	GridStatusRaidDebuff:DebuffId(zoneid, 234295, 93, 6, 6, true, true) -- Armageddon Rain
	GridStatusRaidDebuff:DebuffId(zoneid, 240908, 94, 6, 6, true) -- Armageddon Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 239932, 95, 6, 6, true, true) -- Felclaws
	GridStatusRaidDebuff:DebuffId(zoneid, 240911, 96, 6, 6, true, true) -- Armageddon Hail
end

-- Legion Dungeon
-- The Nighthold
do
	-- Skorpyron
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Skorpyron")
	-- Crystalline Scorpid
	GridStatusRaidDebuff:DebuffId(zoneid, 204766, 11, 5, 5, false, true) -- Energy Surge (non-dispellable, stacks) (DMG + Debuff)
	-- Chromatic Exoskeleton
	GridStatusRaidDebuff:DebuffId(zoneid, 214657, 12, 5, 5) -- Acidic Fragments (non-dispellable) (DMG + Debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 214662, 13, 5, 5) -- Volatile Fragments (non-dispellable) (DMG + Debuff)
	-- Arcanoslash
	GridStatusRaidDebuff:DebuffId(zoneid, 211659, 14, 5, 5, true, true) -- Arcane Tether (non-dispellable, stacks) (Stacking Ground AoE)

	GridStatusRaidDebuff:DebuffId(zoneid, 204471, 15, 5, 5) -- Focused Blast (non-dispellable) (Frontal Cone AoE)

	-- Chronomatic Anomaly
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Chronomatic Anomaly")
	GridStatusRaidDebuff:DebuffId(zoneid, 206607, 21, 5, 5, false, true) -- Chronometric Particles (non-dispellable, stacks) (Stacking DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 206609, 22, 5, 5) -- Time Release (non-dispellable) (heal absorb)
	GridStatusRaidDebuff:DebuffId(zoneid, 206617, 23, 5, 5, true, false) -- Time Bomb (non-dispellable) (Not a Debuff?)
	GridStatusRaidDebuff:DebuffId(zoneid, 212099, 24, 5, 5) -- Temporal Charge (non-dispellable) (DoT)

	-- Trilliax
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Trilliax")
	GridStatusRaidDebuff:DebuffId(zoneid, 206482, 31, 5, 5) -- Arcane Seepage (non-dispellable) (Ground AoE)
	-- The Cleaner
	GridStatusRaidDebuff:DebuffId(zoneid, 206788, 32, 6, 6, false, true) -- Toxic Slice (non-dispellable) (DMG + Debuff Stacking DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 214573, 32, 5, 5, false, true) -- Stuffed (non-dispellable)

	-- Spellblade Aluriel
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Spellblade Aluriel")
	-- Chamion of Blades
	GridStatusRaidDebuff:DebuffId(zoneid, 212492, 41, 5, 5) -- Annihilate (non-dispellable) (DMG + Tank Debuff)
	-- Master of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 212587, 42, 7, 7, true, false) -- Mark of Frost (non-dispellable) (DMG + Increase DMG taken per stack explodes if two people with it get close)
	GridStatusRaidDebuff:DebuffId(zoneid, 212647, 43, 6, 6, false, true) -- Frostbitten (non-dispellable, Stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 212736, 44, 5, 5) -- Pool of Frost (Ground AOE)
	GridStatusRaidDebuff:DebuffId(zoneid, 213083, 45, 5, 5, true, false) -- Frozen Tempest (non-dispellable) (DoT)
	-- Master of Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 213166, 46, 7, 7, true, true) -- Searing Brand (non-dispellable, Stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 213278, 47, 5, 5) -- Burning Ground (Ground AOE)
	-- Master of the Arcane
	GridStatusRaidDebuff:DebuffId(zoneid, 213504, 48, 5, 5) -- Arcane Fog (Ground AOE)
	-- Fel Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 230414, 49, 5, 5) -- Fel Stomp (Ground AOE)

	-- Tichondrius
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Tichondrius")
	-- Stage One
	GridStatusRaidDebuff:DebuffId(zoneid, 206480, 51, 5, 5, true, false) -- Carrion Plague (non-dispellable) (DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 213238, 52, 5, 5, true, false) -- Seeker Swarm (non-dispellable) (DMG + Adds Carrion Plague DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 212795, 53, 5, 5) -- Brand of Argus (non-dispellable) (Explodes if players clump)
	GridStatusRaidDebuff:DebuffId(zoneid, 208230, 54, 5, 5) -- Feast of Blood (non-dispellable) (Increases DMG Taken)
	-- The Nightborne Felsworn Spellguard
	GridStatusRaidDebuff:DebuffId(zoneid, 216024, 55, 5, 5, false, true) -- Volatile Wound (non-dispellable, Stacks) (DMG + Increases Future DMG Taken)
	-- The Legion Sightless Watcher
	GridStatusRaidDebuff:DebuffId(zoneid, 216040, 56, 5, 5, true, false) -- Burning Soul (dispellable) (DMG + Mana Drain + Explode on Dispell)

	-- Krosus
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Krosus")
	GridStatusRaidDebuff:DebuffId(zoneid, 208203, 61, 5, 5) -- Isolated Rage (non-dispellable) (Ground AoE Not Avoidable)
	GridStatusRaidDebuff:DebuffId(zoneid, 206677, 62, 5, 5, true, true) -- Searing Brand (non-dispellable, Stacks)

	-- High Botanist Tel'arn
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "High Botanist Tel'arn")
	--Arcanist Tel'arn
	GridStatusRaidDebuff:DebuffId(zoneid, 218502, 71, 5, 5, false, true) -- Recursive Strikes (non-dispellable, stacks) (Increases DMG Taken)
	-- Naturalist Tel'arn
	GridStatusRaidDebuff:DebuffId(zoneid, 219049, 72, 5, 5, false, true) -- Toxic Spores (non-dispellable) (Ground AoE)
	GridStatusRaidDebuff:DebuffId(zoneid, 218424, 73, 5, 5, false, true) -- Parasitic Fetter (dispellable) (Root + Increaseing DMG)
	GridStatusRaidDebuff:DebuffId(zoneid, 218809, 74, 5, 5, true, false) -- Call of Night

	-- Star Augur Etraeus
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Star Augur Etraeus")
	-- Stage Two
	GridStatusRaidDebuff:DebuffId(zoneid, 206585, 81, 5, 5, false, true) -- Absolute Zero (non-dispellable, stacks) (DMG + Dispellable by Player Clump That then causes Chill)
	GridStatusRaidDebuff:DebuffId(zoneid, 206936, 82, 5, 5, true) -- Icy Ejection (non-dispellable, stacks) (DoT + Slow-to-Stun)
	-- Stage Three
	GridStatusRaidDebuff:DebuffId(zoneid, 206388, 83, 5, 5, false, true) -- Felburst (non-dispellable, stacks) (DMG + DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 205649, 84, 5, 5, false, true) -- Fel Ejection (non-dispellable, stacks) (DMG + DoT)
	-- Stage Four
	GridStatusRaidDebuff:DebuffId(zoneid, 206965, 85, 5, 5, true, false) -- Voidburst (non-dispellable) (DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 207143, 86, 5, 5) -- Void Ejection (non-dispellable) (DMG + DoT)

	-- Grand Magistrix Elisande
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "Grand Magistrix Elisande")
	-- Stage Three
	GridStatusRaidDebuff:DebuffId(zoneid, 211258, 91, 5, 5, true, false) -- Permeliative Torment (non-dispellable) (DoT)
	GridStatusRaidDebuff:DebuffId(zoneid, 209598, 92, 5, 5, true, false) -- Conflexive Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 209971, 93, 5, 5, true, false) -- Ablative Pulse

	-- Gul'dan
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Gul'dan")
	-- Stage One
	-- Inquisitor Vethriz
	GridStatusRaidDebuff:DebuffId(zoneid, 212568, 101, 5, 5, true, false) -- Drain (dispellable) (Life Steal)
	-- D'zorykx the Trapper
	GridStatusRaidDebuff:DebuffId(zoneid, 206883, 102, 5, 5, false, true) -- Soul Vortex (non-dispellable, stacks) (AoE DMG + DoT)
	-- Gul'dan
	GridStatusRaidDebuff:DebuffId(zoneid, 206222, 103, 5, 5) -- Bonds of Fel (non-dispellable) (chain + Slow + Explosion when seperated)
	GridStatusRaidDebuff:DebuffId(zoneid, 206221, 104, 5, 5) -- Empowered Bonds of Fel (non-dispellable) (chain + Slow + Explosion when seperated)
	-- Dreadlords of the Twisting Nether
	GridStatusRaidDebuff:DebuffId(zoneid, 208672, 105, 5, 5) -- Carrion Wave (non-dispellable) (AoE DMG + Sleep)
	-- Gul'dan
	GridStatusRaidDebuff:DebuffId(zoneid, 208903, 106, 5, 5) -- Burning Claws (non-dispellable) (ground AoE)
	GridStatusRaidDebuff:DebuffId(zoneid, 208802, 107, 5, 5, false, true) -- Soul Corrosion (non-dispellable) (DMG + DoT)
end

-- Legion Dungeon
-- The Emerald Nightmare
do
	-- Trash
	-- Nythendra
	GridStatusRaidDebuff:DebuffId(zoneid, 221028, 1, 2, 2, true) -- Unstable Decay

	-- Nythendra
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Nythendra")
	-- Infested (Heroic)
	GridStatusRaidDebuff:DebuffId(zoneid, 204504, 11, 2, 2, false, true) -- Infested
	-- Stage One
	-- Infested Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 203045, 12, 5, 5) -- Infested Ground (standing in pool)
	-- Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 203096, 13, 6, 6, true) -- Rot (AoE people around you)
	-- Volatile Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 204463, 14, 6, 6, true) -- Volatile Rot (exploding tank)
	-- Stage Two
	-- Heart of the Swarm/Burst of Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 203646, 15, 5, 5, true, true) -- Burst of Corruption

	-- Il'gynoth, Heart of Corruption
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Il'gynoth, Heart of Corruption")
	-- Stage One
	-- Nightmare Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 212886, 21, 4, 4) -- Nightmare Corruption (standing in pool)
	-- Dispersed Spores (dot, missed Death Blossom)
	GridStatusRaidDebuff:DebuffId(zoneid, 215845, 22, 1, 1, true) -- Dispersed Spores (dot)
	-- The Eye of Il'gynoth
	-- Nightmare Ichor
	-- Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 210099, 23, 7, 7) -- Fixate (fixate)
	-- Touch of Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 209469, 24, 8, 8, true, true) -- (dot, stacks, magic)
	-- Nightmare Explosion (Mythic dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 209471, 25, 1, 1, true, true) -- Nightmare Explosion (dot, stacks)
	-- Forces of Corruption
	-- Nightmare Horror
	-- Eye of Fate (tank debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 210984, 26, 3, 3, true, true) -- Eye of Fate (tank debuff, stacks)
	-- Deathglare Tentacle
	-- Mind Flay (interruptable)
	GridStatusRaidDebuff:DebuffId(zoneid, 208697, 27, 2, 2, true) -- Mind Flay (dot)
	-- Spew Corruption (dot, player drops pools)
	GridStatusRaidDebuff:DebuffId(zoneid, 208929, 28, 5, 5, true) -- Spew Corruption (dot, drops pools)
	-- Dominator Tentacle
	-- Nighmarish Fury (buff?, stacks)
	-- Stage Two
	-- Cursed Blood (dot, weak bomb)
	GridStatusRaidDebuff:DebuffId(zoneid, 215128, 29, 5, 5, true) -- Cursed Blood (dot, weak bomb)

	-- Elerethe Renferal
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Erethe Renferal")
	-- Spider Form
	-- Web of Pain (linked with another player)
	GridStatusRaidDebuff:DebuffId(zoneid, 215307, 31, 6, 6, true) -- Web of Pain (link)
	-- Necrotic Venom (dot, drops pools)
	GridStatusRaidDebuff:DebuffId(zoneid, 215460, 32, 5, 5, true) -- Necrotic Venom (dot, drops pools)
	-- Venomous Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 213124, 33, 4, 4) -- Venomous Pool (standing in pool)
	-- Roc Form
	-- Shimmering Feather (buff?)
	-- Twisting Shadows (dot, caught in tornado)
	GridStatusRaidDebuff:DebuffId(zoneid, 210850, 34, 3, 3, true) -- Twisting Shadows (dot)
	-- Raking Talons (tank debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 215582, 35, 3, 3, true, true) -- Raking Talons (tank debuff, stacks)
	-- Wind Burn (debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 218519, 36, 1, 1, true, true) -- Wind Burn (debuff, stacks)
	-- Venomous Spiderling
	-- Dripping Fangs (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 210228, 37, 2, 2, true, true) -- Dripping Fangs (dot, stacks)

	-- Ursoc
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ursoc")
	-- Overwhelm
	GridStatusRaidDebuff:DebuffId(zoneid, 197943, 41, 5, 5, true, true) -- Overwhelm (tank debuff, stacks)
	-- Rend Flesh
	GridStatusRaidDebuff:DebuffId(zoneid, 204859, 42, 3, 3, true) -- Rend Flesh (dot)
	-- Focused Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 198006, 43, 7, 7) -- Focused Gaze (fixate)
	-- Momentum
	GridStatusRaidDebuff:DebuffId(zoneid, 198108, 44, 1, 1, true) -- Momentum (debuff)
	-- Nightmarish Cacophony (Fear)
	GridStatusRaidDebuff:DebuffId(zoneid, 197980, 45, 2, 2, true) -- Nightmarish Cacophony (fear)
	-- Miasma (standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 205611, 46, 4, 4, true) -- Miasma (standing in)

	-- Dragons of Nightmare
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Dragons of Nightmare")
	-- Shared
	-- Slumbering Nightmare (stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 203110, 51, 3, 3, true) -- Slumbering Nightmare (stun)
	-- Ysondre
	-- Mark of Ysondre (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 203102, 52, 2, 2, true, true) -- Mark of Ysondre (dot, stacks)
	-- Nightmare Bloom (standing in, should be at least 1 player)
	GridStatusRaidDebuff:DebuffId(zoneid, 207681, 53, 4, 4, true) -- Nightmare Bloom (standing in)
	-- Dread Horror
	-- Wasting Dread (debuff reduces dam 50%) (disabled)
	GridStatusRaidDebuff:DebuffId(zoneid, 204731, 54, 1, 1, true, false, 0, true) -- Wasting Dread (debuff)
	-- Defiled Spirit
	-- Defiled Vines (root, magic)
	GridStatusRaidDebuff:DebuffId(zoneid, 203770, 55, 8, 8, true) -- Defiled Vines (root, magic)
	-- Emeriss
	-- Mark of Emeriss (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 203125, 56, 2, 2, true, true) -- Mark of Emeriss (dot, stacks)
	-- Volatile Infection (AoE dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 203787, 57, 5, 5, true) -- Volatile Infection (AoE dot)
	-- Lethon
	-- Mark of Lethon (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 203086, 58, 2, 2, true, true) -- Mark of Lethon (dot, stacks)
	-- Shadow Burst (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 204044, 59, 4, 4, true, true) -- Shadow Burst (dot, stacks)
	-- Taerar
	-- Mark of Taerar (dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 203121, 60, 2, 2, true, true) -- Mark of Taerar (dot, stacks)
	-- Seeping Fog (dot, sleep, magic)
	GridStatusRaidDebuff:DebuffId(zoneid, 205341, 61, 6, 6, true) -- Seeping Fog (dot, sleep, magic)
	-- Bellowing Roar (fear)
	GridStatusRaidDebuff:DebuffId(zoneid, 204078, 62, 2, 2, true) -- Bellowing Roar (fear)
	-- Lumbering Mindgorger
	-- Collapsing Nightmare (debuff reduces dam 50%, missed interrupt) (disabled)
	GridStatusRaidDebuff:DebuffId(zoneid, 214543, 63, 1, 1, true, false, 0, true) -- Collapsing Nightmare (debuff)

	-- Cenarius
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Cenarius")
	-- Stage One
	-- Malfurion Stormrage
	-- Cleansed Ground (buff)
	GridStatusRaidDebuff:DebuffId(zoneid, 212681, 71, 1, 1, true) -- Cleansed Ground (buff)
	-- Cenarius
	-- Creeping Nightmares (debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 210279, 72, 2, 2, true, true) -- Creeping Nightmares (debuff, stacks)
	-- Nightmare Brambles (dot, root, magic)
	GridStatusRaidDebuff:DebuffId(zoneid, 210315, 73, 8, 8, true) -- Nightmare Brambles (dot, root, magic)
	-- Nightmare Blast (tank debuff, stacks) (Mythic)
	GridStatusRaidDebuff:DebuffId(zoneid, 213162, 74, 5, 5, true, true) -- Nightmare Blast (tank debuff, stacks)
	-- Forces of Nightmare
	-- Corrupted Wisp
	-- Nightmare Ancient
	-- Desiccating Stomp (melee split damage debuf, stacksf)
	GridStatusRaidDebuff:DebuffId(zoneid, 226821, 75, 4, 4, true, true) -- Desiccating Stomp (melee debuff, stacks)
	-- Rotten Drake
	-- Twisted Sister
	-- Nightmare Javelin (dot, magic)
	GridStatusRaidDebuff:DebuffId(zoneid, 211507, 76, 6, 6, true) -- Nightmare Javelin (dot, magic)
	-- Scorned Touch (spreading dot, slow)
	GridStatusRaidDebuff:DebuffId(zoneid, 211471, 77, 5, 5, true) -- Scorned Touch (dot, spreads)
	-- Allies of Nature
	-- Wisp
	-- Cleansed Ancient
	-- Emerald Drake
	-- Ancient Dream (buff)
	GridStatusRaidDebuff:DebuffId(zoneid, 216516, 78, 1, 1, true, false, 0, true) -- Ancient Dream (buff)
	-- Redeemed Sister
	-- Unbound Touch (buff, spread Unbound Essence after 4 sec)
	GridStatusRaidDebuff:DebuffId(zoneid, 211989, 79, 5, 5, true) -- Unbound Touch (buff, spreads)
	-- Unbound Essence
	GridStatusRaidDebuff:DebuffId(zoneid, 211990, 80, 1, 1, true, false, 0, true) -- Unbound Essence (buff)
	-- Stage Two
	-- Cenarius
	-- Spear of Nightmares (tank debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 214529, 81, 5, 5, true, true) -- Spear of Nightmares (tank debuff, stacks)

	-- Xavius
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "Xavius")
	-- The Dream (95%, 60%)
	-- Dream Simulacrum (buff)
	GridStatusRaidDebuff:DebuffId(zoneid, 206005, 91, 1, 1, true) -- Dream Simulacrum (buff)
	-- Awakening to the Nightmare
	GridStatusRaidDebuff:DebuffId(zoneid, 206109, 92, 2, 2, true) -- Awakening to the Nightmare (buff)
	-- Nightmare Corruption
	-- Dread Abomination
	-- Unfathomable Reality
	-- Descent into Madness (buff before mind control)
	GridStatusRaidDebuff:DebuffId(zoneid, 208431, 93, 3, 3, true) -- Descent into Madness (buff)
	-- Madness (mind control)
	GridStatusRaidDebuff:DebuffId(zoneid, 207409, 94, 6, 6) -- Madness (mind control)
	-- Stage One
	-- Darkening Soul (dot, magic, explosion on dispel)
	GridStatusRaidDebuff:DebuffId(zoneid, 206651, 95, 8, 8, true) -- Darkening Soul (dot, magic)
	-- Nightmare Blades (fixate)
	GridStatusRaidDebuff:DebuffId(zoneid, 211802, 96, 7, 7, true) -- Nightmare Blades (fixate)
	-- Corruption Horror
	-- Lurking Terror
	-- Tormenting Fixation (fixate)
	GridStatusRaidDebuff:DebuffId(zoneid, 205771, 97, 7, 7) -- Tormenting Fixation (fixate)
	-- Stage Two
	-- Blackening Soul (dot, magic, debuff on dispel)
	GridStatusRaidDebuff:DebuffId(zoneid, 209158, 98, 8, 8) -- Blackening Soul (dot, magic)
	-- Blackened? (debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 205612, 99, 2, 2, true) -- Blackened? (debuff)
	-- Bonds of Terror (linked with another player)
	GridStatusRaidDebuff:DebuffId(zoneid, 210451, 100, 6, 6) -- Bonds of Terror (link)
	-- Inconceivable Horror
	-- Tainted Discharge (standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 208385, 101, 4, 4) -- Tainted Discharge (standing in)
	-- Stage Three
	-- Nightmare Tentacle
	-- The Infinite Dark? (dot, standing in environment?)
	GridStatusRaidDebuff:DebuffId(zoneid, 211634, 102, 4, 4) -- The Infinite Dark (standing in?)
end

-- Legion Dungeon
-- Broken Isles
do
	-- Ana-Mouz
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Ana-Mouz")

	-- Calamir
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Calamir")
	-- Ancient Rage: Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 218888, 21, 5, 5) -- Impish Flames (non-dispellable)
	-- Burning Bomb (dispellable)(TODO)
	-- Wrathful Flames Ground AoE(TODO)
	-- Ancient Rage: Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 217925, 24, 5, 5) -- Icy Comet (non-dispellable) AoE Slow
	GridStatusRaidDebuff:DebuffId(zoneid, 217966, 25, 5, 5) -- Howling Gale (non-dispellable)
	-- Ancient Rage: Arcane
	GridStatusRaidDebuff:DebuffId(zoneid, 218012, 25, 5, 5) -- Arcanopulse (non-dispellable) DMG + Stun

	-- Drugon the Frostblood
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Drugon the Frostblood")
	GridStatusRaidDebuff:DebuffId(zoneid, 219602, 31, 5, 5) -- Snow Plow (non-dispellable) Fixate

	-- Flotsam
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Flotsam")
	GridStatusRaidDebuff:DebuffId(zoneid, 223373, 41, 5, 5) -- Yaksam (non-dispellable) Cone AoE
	-- Regurgitated Marshstomper
	GridStatusRaidDebuff:DebuffId(zoneid, 223355, 42, 5, 5) -- Oozing Bile (non-dispellable)

	-- Humongris
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Humongris")
	GridStatusRaidDebuff:DebuffId(zoneid, 216430, 51, 5, 5) -- Earthshake Stomp (non-dispellable) DMG + Stun
	GridStatusRaidDebuff:DebuffId(zoneid, 216467, 52, 5, 5) -- Make the Snow (non-dispellable) AoE Frost DMG + Slow
	GridStatusRaidDebuff:DebuffId(zoneid, 216822, 53, 5, 5) -- You Go Bang! (non-dispellable) Fire Bomb + DMG Increase Debuff

	-- Levantus
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Levantus")
	GridStatusRaidDebuff:DebuffId(zoneid, 170196, 61, 5, 5) -- Rending Whirl (non-dispellable) Rend
	-- Electrify DMG + Stun Dispellable (TODO)
	GridStatusRaidDebuff:DebuffId(zoneid, 217362, 63, 5, 5, true, false) -- Turbulent Vortex (dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 217362, 64, 5, 5, false, true) -- Rampaging Torrent (non-dispellable) DMG + DMG Increase Debuff Stacks

	-- Na'zak the Fiend
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Na'zak the Fiend")
	GridStatusRaidDebuff:DebuffId(zoneid, 219349, 71, 5, 5, false, true) -- Corroding Spray (non-dispellable) Cone AoE Stacks

	-- Nithogg
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Nithogg")
	GridStatusRaidDebuff:DebuffId(zoneid, 212867, 81, 5, 5, false, true) -- Electrical Storm (non-dispellable) Ground AoE
	GridStatusRaidDebuff:DebuffId(zoneid, 212852, 82, 5, 5, false, true) -- Storm Breath (non-dispellable) DMG + DMG Increase Debuff
	-- Static Charge DMG after 5 Sec (TODO)

	-- Shar'thos
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "Shar'thos")
	-- Nightmare Breath Fire Cone AoE (TODO)
	GridStatusRaidDebuff:DebuffId(zoneid, 215876, 92, 5, 5, false, true) -- Burning Earth (non-dispellable) Ground AoE
	GridStatusRaidDebuff:DebuffId(zoneid, 216044, 93, 5, 5, false, true) -- Cry of the Tormented (non-dispellable) AoE Fear

	-- The Soultakers
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "The Soultakers")
	-- Reaver Jdorn
	GridStatusRaidDebuff:DebuffId(zoneid, 213665, 93, 5, 5, false, true) -- Marauding Mists (non-dispellable) DMG + Disorient

	-- Withered J'im
	GridStatusRaidDebuff:BossNameId(zoneid, 110, "Withered J'im")
end

-- Legion Dungeon
-- Antorus, the Burning Throne
do
	-- Varimathras
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Varimathras")
	GridStatusRaidDebuff:DebuffId(zoneid, 244042, 11, 6, 6, false, true) -- Marked Prey
	GridStatusRaidDebuff:DebuffId(zoneid, 243999, 12, 6, 6, false, true) -- Dark Fissure
	GridStatusRaidDebuff:DebuffId(zoneid, 244093, 13, 6, 6, false, true) -- Necrotic Embrace
	GridStatusRaidDebuff:DebuffId(zoneid, 243961, 14, 6, 6) -- Misery
	GridStatusRaidDebuff:DebuffId(zoneid, 243980, 15, 6, 6) -- Torment of Fel
	GridStatusRaidDebuff:DebuffId(zoneid, 243968, 16, 6, 6) -- Torment of Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 243977, 17, 6, 6) -- Torment of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 243974, 18, 6, 6) -- Torment of Shadows
	GridStatusRaidDebuff:DebuffId(zoneid, 248732, 19, 6, 6) -- Echoes of Doom

	-- Aggramar
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Aggramar")
	GridStatusRaidDebuff:DebuffId(zoneid, 243431, 21, 6, 6, true, true) -- Taeshalach's Reach
	GridStatusRaidDebuff:DebuffId(zoneid, 245995, 22, 6, 6, false, true) -- Scorching Blaze
	GridStatusRaidDebuff:DebuffId(zoneid, 246014, 23, 6, 6, false, true) -- Searing Tempest
	GridStatusRaidDebuff:DebuffId(zoneid, 244912, 24, 6, 6, false, true) -- Blazing Eruption
	GridStatusRaidDebuff:DebuffId(zoneid, 244291, 25, 6, 6) -- Foe Breaker
	GridStatusRaidDebuff:DebuffId(zoneid, 244736, 26, 6, 6) -- Wake of Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 245916, 27, 6, 6) -- Molten Remnants
	GridStatusRaidDebuff:DebuffId(zoneid, 254452, 28, 6, 6) -- Ravenous Blaze
	GridStatusRaidDebuff:DebuffId(zoneid, 247079, 29, 6, 6) -- Empowered Flame Rend
	GridStatusRaidDebuff:DebuffId(zoneid, 255062, 30, 6, 6) -- Empowered Searing Tempest
	GridStatusRaidDebuff:DebuffId(zoneid, 255060, 31, 6, 6) -- Empowered Foe Breaker
	GridStatusRaidDebuff:DebuffId(zoneid, 255528, 32, 6, 6) -- Searing Binding

	-- Portal Keeper Hasabel
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Portal Keeper Hasabel")
	GridStatusRaidDebuff:DebuffId(zoneid, 245157, 41, 6, 6) -- Everburning Light
	GridStatusRaidDebuff:DebuffId(zoneid, 244853, 42, 6, 6) -- Caustic Detonation
	GridStatusRaidDebuff:DebuffId(zoneid, 245075, 43, 6, 6) -- Hungering Gloom
	GridStatusRaidDebuff:DebuffId(zoneid, 244016, 44, 6, 6, true, true) -- Reality Tear
	GridStatusRaidDebuff:DebuffId(zoneid, 245240, 45, 6, 6) -- Oppressive Gloom
	GridStatusRaidDebuff:DebuffId(zoneid, 245118, 46, 6, 6) -- Cloying Shadows
	GridStatusRaidDebuff:DebuffId(zoneid, 245099, 47, 6, 6) -- Mind Fog
	GridStatusRaidDebuff:DebuffId(zoneid, 244613, 48, 6, 6) -- Everburning Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 245050, 49, 6, 6) -- Delusions
	GridStatusRaidDebuff:DebuffId(zoneid, 245040, 50, 6, 6) -- Corrupt
	GridStatusRaidDebuff:DebuffId(zoneid, 244849, 51, 6, 6) -- Caustic Slime
	GridStatusRaidDebuff:DebuffId(zoneid, 244915, 52, 6, 6) -- Poison Essence
	GridStatusRaidDebuff:DebuffId(zoneid, 244915, 53, 6, 6) -- Leech Essence
	GridStatusRaidDebuff:DebuffId(zoneid, 244949, 54, 6, 6) -- Felsilk Wrap
	GridStatusRaidDebuff:DebuffId(zoneid, 246208, 55, 6, 6) -- Acidic Web
	GridStatusRaidDebuff:DebuffId(zoneid, 244709, 56, 6, 6) -- Fiery Detonation

	-- Noura, Mother of Flames <Coven of Shivarra>
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Noura")
	GridStatusRaidDebuff:DebuffId(zoneid, 250095, 61, 6, 6, true, true) -- Machinations of Aman'Thul
	GridStatusRaidDebuff:DebuffId(zoneid, 245586, 62, 6, 6, false, true) -- Chilled Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 245518, 63, 6, 6, true, true) -- Flashfreeze
	GridStatusRaidDebuff:DebuffId(zoneid, 244899, 64, 6, 6, true, true) -- Fiery Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 253203, 65, 6, 6) -- Shivan Pact
	GridStatusRaidDebuff:DebuffId(zoneid, 253520, 66, 6, 6) -- Fulminating Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 253752, 67, 6, 6) -- Sense of Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 245627, 68, 6, 6) -- Whirling Saber
	GridStatusRaidDebuff:DebuffId(zoneid, 253697, 69, 6, 6) -- Orb of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 252861, 70, 6, 6) -- Storm of Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 246763, 71, 6, 6) -- Fury of Golganneth
	GridStatusRaidDebuff:DebuffId(zoneid, 245921, 72, 6, 6) -- Spectral Army
	GridStatusRaidDebuff:DebuffId(zoneid, 245671, 73, 6, 6) -- Flames of Khaz'goroth
	GridStatusRaidDebuff:DebuffId(zoneid, 250757, 74, 6, 6) -- Cosmic Glare

	-- F'harg
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "F'harg")
	GridStatusRaidDebuff:DebuffId(zoneid, 248815, 81, 6, 6, false, true) -- Enflamed
	GridStatusRaidDebuff:DebuffId(zoneid, 244057, 82, 6, 6) -- Enflame Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 244768, 83, 6, 6) -- Desolate Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 254760, 84, 6, 6) -- Corrupting Maw
	GridStatusRaidDebuff:DebuffId(zoneid, 244071, 85, 6, 6, false, true) -- Weight of Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 248819, 86, 6, 6) -- Siphoned
	GridStatusRaidDebuff:DebuffId(zoneid, 244056, 87, 6, 6) -- Siphon Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 248815, 88, 6, 6) -- Enflamed
	GridStatusRaidDebuff:DebuffId(zoneid, 251445, 89, 6, 6) -- Smouldering
	GridStatusRaidDebuff:DebuffId(zoneid, 244091, 90, 6, 6, true, true) -- Singed
	GridStatusRaidDebuff:DebuffId(zoneid, 244517, 91, 6, 6, true, true) -- Lingering Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 245098, 92, 6, 6, true, true) -- Decay
	GridStatusRaidDebuff:DebuffId(zoneid, 251445, 93, 6, 6) -- Smouldering
	GridStatusRaidDebuff:DebuffId(zoneid, 245024, 94, 6, 6) -- Consumed
	GridStatusRaidDebuff:DebuffId(zoneid, 244086, 95, 6, 6) -- Molten Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 244055, 96, 6, 6) -- Shadowtouched
	GridStatusRaidDebuff:DebuffId(zoneid, 244054, 97, 6, 6) -- Flametouched
	GridStatusRaidDebuff:DebuffId(zoneid, 245022, 98, 6, 6) -- Burning Remnant

	-- Garothi Worldbreaker
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Garothi Worldbreaker")
	GridStatusRaidDebuff:DebuffId(zoneid, 244395, 101, 6, 6) -- Searing Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 244410, 102, 6, 6) -- Decimation
	GridStatusRaidDebuff:DebuffId(zoneid, 246848, 103, 6, 6) -- Luring Destruction
	GridStatusRaidDebuff:DebuffId(zoneid, 244536, 104, 6, 6) -- Fel Bombardment
	GridStatusRaidDebuff:DebuffId(zoneid, 246920, 105, 6, 6) -- Haywire Decimation
	GridStatusRaidDebuff:DebuffId(zoneid, 246848, 106, 6, 6) -- Luring Destruction

	-- Admiral Svirax
	GridStatusRaidDebuff:BossNameId(zoneid, 110, "Admiral Svirax")
	GridStatusRaidDebuff:DebuffId(zoneid, 244910, 111, 6, 6) -- Felshield
	GridStatusRaidDebuff:DebuffId(zoneid, 244172, 112, 6, 6) -- Psychic Assault
	GridStatusRaidDebuff:DebuffId(zoneid, 257974, 113, 6, 6, true, true) -- Chaos Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 244892, 114, 6, 6, false, true) -- Exploit Weakness
	GridStatusRaidDebuff:DebuffId(zoneid, 245121, 115, 6, 6) -- Entropic Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 253037, 116, 6, 6) -- Demonic Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 244388, 117, 6, 6) -- Psychic Scarring
	GridStatusRaidDebuff:DebuffId(zoneid, 244748, 118, 6, 6) -- Shocked

	-- Kin'garoth <Engineer of the Apocalypse>
	GridStatusRaidDebuff:BossNameId(zoneid, 120, "Kin'garoth")
	GridStatusRaidDebuff:DebuffId(zoneid, 248061, 121, 6, 6) -- Purging Protocol
	GridStatusRaidDebuff:DebuffId(zoneid, 246706, 122, 6, 6) -- Demolish
	GridStatusRaidDebuff:DebuffId(zoneid, 244312, 123, 6, 6) -- Forging Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 249535, 124, 6, 6) -- Demolished
	GridStatusRaidDebuff:DebuffId(zoneid, 246687, 125, 6, 6) -- Decimation
	GridStatusRaidDebuff:DebuffId(zoneid, 246840, 126, 6, 6) -- Ruiner

	-- Imonar the Soulhunter
	GridStatusRaidDebuff:BossNameId(zoneid, 130, "Imonar the Soulhunter")
	GridStatusRaidDebuff:DebuffId(zoneid, 248321, 131, 6, 6, false, true) -- Conflagration
	GridStatusRaidDebuff:DebuffId(zoneid, 248424, 132, 6, 6) -- Gathering Power
	GridStatusRaidDebuff:DebuffId(zoneid, 247641, 133, 6, 6) -- Stasis Trap
	GridStatusRaidDebuff:DebuffId(zoneid, 247552, 134, 6, 6) -- Sleep Canister
	GridStatusRaidDebuff:DebuffId(zoneid, 247565, 135, 6, 6) -- Slumber Gas
	GridStatusRaidDebuff:DebuffId(zoneid, 247367, 136, 6, 6, true, true) -- Shock Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 247687, 137, 6, 6, true, true) -- Sever
	GridStatusRaidDebuff:DebuffId(zoneid, 250255, 138, 6, 6, true, true) -- Empowered Shock Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 250006, 139, 6, 6, true, true) -- Empowered Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 255029, 140, 6, 6, true, true) -- Asleep
	GridStatusRaidDebuff:DebuffId(zoneid, 247716, 141, 6, 6, true, true) -- Charged Blasts
	GridStatusRaidDebuff:DebuffId(zoneid, 250224, 142, 6, 6, true, true) -- Shocked
	GridStatusRaidDebuff:DebuffId(zoneid, 247949, 143, 6, 6, true, true) -- Shrapnel Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 254181, 144, 6, 6, true, true) -- Seared Skin
	GridStatusRaidDebuff:DebuffId(zoneid, 248255, 145, 6, 6, true, true) -- Infernal Rockets

	-- Essence of Eonar
	GridStatusRaidDebuff:BossNameId(zoneid, 150, "Essence of Eonar")
	GridStatusRaidDebuff:DebuffId(zoneid, 248326, 151, 6, 6) -- Rain of Fel
	GridStatusRaidDebuff:DebuffId(zoneid, 248333, 152, 6, 6) -- Meteor Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 248861, 153, 6, 6) -- Spear of Doom
	GridStatusRaidDebuff:DebuffId(zoneid, 248795, 154, 6, 6) -- Fel Wake
	GridStatusRaidDebuff:DebuffId(zoneid, 250691, 155, 6, 6) -- Burning Embers
	GridStatusRaidDebuff:DebuffId(zoneid, 250140, 156, 6, 6) -- Foul Steps
	GridStatusRaidDebuff:DebuffId(zoneid, 249016, 157, 6, 6) -- Targeted
	GridStatusRaidDebuff:DebuffId(zoneid, 249017, 158, 6, 6) -- Arcane Singularity
	GridStatusRaidDebuff:DebuffId(zoneid, 249014, 159, 6, 6) -- Feedback: Foul Steps
	GridStatusRaidDebuff:DebuffId(zoneid, 249015, 160, 6, 6) -- Feedback: Burning Embers

	-- Argus the Unmaker
	GridStatusRaidDebuff:BossNameId(zoneid, 170, "Argus the Unmaker")
	GridStatusRaidDebuff:DebuffId(zoneid, 248499, 171, 6, 6, true, true) -- Sweeping Scythe
	GridStatusRaidDebuff:DebuffId(zoneid, 255199, 172, 6, 6, false, true) -- Avatar of Aggramar
	GridStatusRaidDebuff:DebuffId(zoneid, 251570, 173, 6, 6, false, true) -- Soulbomb
	GridStatusRaidDebuff:DebuffId(zoneid, 250669, 174, 6, 6, false, true) -- Soulburst
	GridStatusRaidDebuff:DebuffId(zoneid, 257313, 175, 6, 6, false, true) -- Gift of the Sky
	GridStatusRaidDebuff:DebuffId(zoneid, 257306, 176, 6, 6, false, true) -- Gift of the Sea
	GridStatusRaidDebuff:DebuffId(zoneid, 258039, 177, 6, 6) -- Deadly Scythe
	GridStatusRaidDebuff:DebuffId(zoneid, 248396, 178, 6, 6) -- Soulblight
	GridStatusRaidDebuff:DebuffId(zoneid, 253901, 179, 6, 6) -- Strength of Sea
	GridStatusRaidDebuff:DebuffId(zoneid, 253903, 180, 6, 6) -- Strength of Sky
	GridStatusRaidDebuff:DebuffId(zoneid, 255200, 181, 6, 6) -- Aggramar’s Boon
	GridStatusRaidDebuff:DebuffId(zoneid, 257299, 182, 6, 6) -- Ember of Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 252729, 183, 6, 6) -- Cosmic Ray
	GridStatusRaidDebuff:DebuffId(zoneid, 252634, 184, 6, 6) -- Cosmic Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 257215, 185, 6, 6) -- Titanforged
	GridStatusRaidDebuff:DebuffId(zoneid, 248167, 186, 6, 6) -- Death Fog
	GridStatusRaidDebuff:DebuffId(zoneid, 256899, 187, 6, 6) -- Soul Detonation
	GridStatusRaidDebuff:DebuffId(zoneid, 251815, 188, 6, 6) -- Edge of Obliteration
	GridStatusRaidDebuff:DebuffId(zoneid, 257299, 189, 6, 6) -- Ember of Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 258373, 190, 6, 6) -- Grasp
	GridStatusRaidDebuff:DebuffId(zoneid, 257961, 191, 6, 6) -- Chains of Sargeras
	GridStatusRaidDebuff:DebuffId(zoneid, 257966, 192, 6, 6) -- Sentence of Sargeras
	GridStatusRaidDebuff:DebuffId(zoneid, 258026, 193, 6, 6) -- Punishment
	GridStatusRaidDebuff:DebuffId(zoneid, 258000, 194, 6, 6) -- Shattered Bonds
	GridStatusRaidDebuff:DebuffId(zoneid, 257930, 195, 6, 6) -- Crushing
	GridStatusRaidDebuff:DebuffId(zoneid, 257931, 196, 6, 6) -- Sargeras Fear
	GridStatusRaidDebuff:DebuffId(zoneid, 257869, 197, 6, 6) -- Unleashed
	GridStatusRaidDebuff:DebuffId(zoneid, 257911, 198, 6, 6) -- Sargeras Rage
end
