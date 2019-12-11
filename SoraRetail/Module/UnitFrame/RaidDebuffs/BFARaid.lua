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

-- BFA Raid
-- Uldir
do
	-- Taloc
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Taloc")
	GridStatusRaidDebuff:DebuffId(zoneid, 270290, 11, 5, 5) -- Blood Storms
	GridStatusRaidDebuff:DebuffId(zoneid, 271222, 12, 5, 5, true) -- Plasma Discharge
	GridStatusRaidDebuff:DebuffId(zoneid, 271296, 13, 5, 5, true) -- Cudgel of Gore

	-- MOTHER
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "MOTHER")
	GridStatusRaidDebuff:DebuffId(zoneid, 267787, 21, 5, 5, true, true) -- Sanitizing Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 268198, 22, 5, 5, true) -- Clinging Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 267821, 23, 5, 5) -- Defense Grids

	-- Fetid Devourer
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Fetid Devourer")
	GridStatusRaidDebuff:DebuffId(zoneid, 262313, 31, 5, 5, true, true) -- Malodorous Miasma
	GridStatusRaidDebuff:DebuffId(zoneid, 262314, 32, 5, 5, true, true) -- Putrid Paroxysm

	-- Zek'voz, herald of N'zoth
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Zek'voz")
	GridStatusRaidDebuff:DebuffId(zoneid, 265264, 41, 5, 5, true, true) -- Void Lash
	GridStatusRaidDebuff:DebuffId(zoneid, 265646, 42, 5, 5) -- Will of the Corruptor
	GridStatusRaidDebuff:DebuffId(zoneid, 265360, 43, 5, 5, true) -- Roiling Deceit
	GridStatusRaidDebuff:DebuffId(zoneid, 267334, 44, 5, 5) -- Orb of Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 265662, 45, 5, 5) -- Corruptor's Pact
	GridStatusRaidDebuff:DebuffId(zoneid, 265451, 46, 5, 5) -- Surging Darkness

	-- Vectis
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Vectis")
	GridStatusRaidDebuff:DebuffId(zoneid, 265129, 51, 6, 6, true) -- Omega Vector
	GridStatusRaidDebuff:DebuffId(zoneid, 265127, 52, 5, 5, true, true) -- Lingering Infection
	GridStatusRaidDebuff:DebuffId(zoneid, 265178, 53, 5, 5, true) -- Evolving Affliction
	GridStatusRaidDebuff:DebuffId(zoneid, 265206, 54, 6, 6, true) -- Immunosuppression
	GridStatusRaidDebuff:DebuffId(zoneid, 266948, 55, 5, 5, true) -- Plague Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 265212, 56, 6, 6, true) -- Gestate

	-- Zul, Reborn
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Zul, Reborn")
	GridStatusRaidDebuff:DebuffId(zoneid, 274195, 61, 5, 5, false, true) -- Corrupted Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 274358, 62, 5, 5, true, true) -- Rupturing Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 274363, 63, 5, 5) -- Ruptured Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 273365, 64, 5, 5, true) -- Dark Revelation
	GridStatusRaidDebuff:DebuffId(zoneid, 274271, 65, 6, 6) -- Deathwish

	-- Mythrax the Unraveler
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Mythrax the Unraveler")
	GridStatusRaidDebuff:DebuffId(zoneid, 272336, 71, 5, 5) -- Annihilation
	GridStatusRaidDebuff:DebuffId(zoneid, 274113, 72, 5, 5) -- Obliteration Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 273282, 73, 6, 6, true) -- Essence Shear
	GridStatusRaidDebuff:DebuffId(zoneid, 272536, 74, 6, 6, true) -- Imminent Ruin
	GridStatusRaidDebuff:DebuffId(zoneid, 272407, 75, 6, 6) -- Oblivion Sphere

	-- G'huun
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "G'huun")
	GridStatusRaidDebuff:DebuffId(zoneid, 263372, 81, 5, 5) -- Power Matrices
	GridStatusRaidDebuff:DebuffId(zoneid, 263503, 82, 5, 5) -- Reorigination Blasts
	GridStatusRaidDebuff:DebuffId(zoneid, 267409, 83, 5, 5, true, true) -- Dark Bargain
	GridStatusRaidDebuff:DebuffId(zoneid, 270447, 84, 5, 5, true, true) -- Growing Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 263236, 85, 5, 5, true) -- Blood Feast
	GridStatusRaidDebuff:DebuffId(zoneid, 263334, 86, 5, 5, true, true) -- Putrid Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 267700, 87, 5, 5, true) -- Gaze of G'huun
end

-- BFA Raid
-- The Eternal Palace
do
	GridStatusRaidDebuff:DebuffId(zoneid, 299705, 1, 5, 5, true) --Dark Passage
	GridStatusRaidDebuff:DebuffId(zoneid, 303550, 1, 5, 5, true) --Frost Bolt Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 300743, 1, 5, 5, true) --Void Touched
	GridStatusRaidDebuff:DebuffId(zoneid, 118905, 1, 5, 5, true) --Static Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 304771, 1, 5, 5, true) --Queen's Disgust
	GridStatusRaidDebuff:DebuffId(zoneid, 295822, 1, 5, 5, true) --Conductive Pulse

	-- Trash
	GridStatusRaidDebuff:DebuffId(zoneid, 303298, 1, 5, 5, true) --Hunter's Quarry
	GridStatusRaidDebuff:DebuffId(zoneid, 303296, 1, 5, 5, true) --Poison-Dipped Arrow
	GridStatusRaidDebuff:DebuffId(zoneid, 304245, 1, 5, 5, true) --Toxic Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 301968, 1, 4, 4, true) --Bioluminescence
	GridStatusRaidDebuff:DebuffId(zoneid, 304189, 1, 5, 5, true) --Frostbolt
	GridStatusRaidDebuff:DebuffId(zoneid, 303316, 1, 6, 6, true) --Hindering Resonance
	GridStatusRaidDebuff:DebuffId(zoneid, 292127, 1, 6, 6, true) --Darkest Depths
	GridStatusRaidDebuff:DebuffId(zoneid, 304026, 1, 6, 6, true) --Arcane Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 304297, 1, 5, 5, true) --Disgusting Mucus
	GridStatusRaidDebuff:DebuffId(zoneid, 302989, 1, 5, 5, true) --Briny Bubble
	GridStatusRaidDebuff:DebuffId(zoneid, 302992, 1, 5, 5, true) --Briny Bubble
	GridStatusRaidDebuff:DebuffId(zoneid, 304027, 1, 5, 5, true) --Arcane Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 295779, 1, 5, 5, true) --Aqua Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 292307, 1, 5, 5, true) --Gaze from Below
	GridStatusRaidDebuff:DebuffId(zoneid, 298459, 1, 5, 5, true) --Amniotic Eruption
	GridStatusRaidDebuff:DebuffId(zoneid, 300244, 1, 5, 5, true) --Raging Rapids
	GridStatusRaidDebuff:DebuffId(zoneid, 303630, 1, 5, 5, true) --Explosive Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 303422, 1, 5, 5, true) --Blizzard
	GridStatusRaidDebuff:DebuffId(zoneid, 303625, 1, 5, 5, true) --Aura of Suffering
	GridStatusRaidDebuff:DebuffId(zoneid, 303747, 1, 5, 5, true) --Ice Tomb
	GridStatusRaidDebuff:DebuffId(zoneid, 303373, 1, 5, 5, true) --Toxic Bolt Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 304765, 1, 5, 5, true) --Filth
	GridStatusRaidDebuff:DebuffId(zoneid, 303382, 1, 5, 5, true) --Venom Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 303619, 1, 5, 5, true) --Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 303501, 1, 5, 5, true) --Rending Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 303958, 1, 5, 5, true) --Nightmare Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 6136, 1, 5, 5, true) --Chilled
	GridStatusRaidDebuff:DebuffId(zoneid, 303942, 1, 5, 5, true) --Coalesced Nightmares
	GridStatusRaidDebuff:DebuffId(zoneid, 303913, 1, 5, 5, true) --Lingering Soul

	-- Abyssal Commander Sivara
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Abyssal Commander Sivara")
	GridStatusRaidDebuff:DebuffId(zoneid, 294715, 11, 5, 5, true, true) --Toxic Brand
	GridStatusRaidDebuff:DebuffId(zoneid, 294711, 12, 5, 5, true, true) --Frost Mark
	GridStatusRaidDebuff:DebuffId(zoneid, 300705, 13, 5, 5, true, true) --Septic Taint
	GridStatusRaidDebuff:DebuffId(zoneid, 300701, 14, 5, 5, true, true) --Rimefrost
	GridStatusRaidDebuff:DebuffId(zoneid, 294847, 15, 5, 5, true) --Unstable Mixture
	GridStatusRaidDebuff:DebuffId(zoneid, 295348, 16, 5, 5, true) --Overflowing Chill
	GridStatusRaidDebuff:DebuffId(zoneid, 295421, 17, 5, 5, true) --Overflowing Venom
	GridStatusRaidDebuff:DebuffId(zoneid, 300961, 18, 5, 5, true) --Frozen Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 300962, 19, 5, 5, true) --Septic Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 300883, 20, 5, 5, true) --Inversion Sickness
	GridStatusRaidDebuff:DebuffId(zoneid, 300882, 21, 5, 5, true) --Inversion Sickness
	GridStatusRaidDebuff:DebuffId(zoneid, 295705, 22, 5, 5, true) --Toxic Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 295704, 23, 5, 5, true) --Frost Bolt

	-- Radiance of Azshara
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Radiance of Azshara")
	GridStatusRaidDebuff:DebuffId(zoneid, 296566, 31, 5, 5, true) --Tide Fist
	GridStatusRaidDebuff:DebuffId(zoneid, 296737, 32, 5, 5, true) --Arcane Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 295920, 33, 5, 5, true) --Ancient Tempest
	GridStatusRaidDebuff:DebuffId(zoneid, 296746, 34, 5, 5, true) --Arcane Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 299152, 35, 5, 5, true) --Waterlogged

	-- Blackwater Behemoth
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Blackwater Behemoth")
	GridStatusRaidDebuff:DebuffId(zoneid, 292138, 41, 5, 5, true) --Radiant Biomass
	GridStatusRaidDebuff:DebuffId(zoneid, 292133, 42, 5, 5, true) --Bioluminescence
	GridStatusRaidDebuff:DebuffId(zoneid, 292127, 43, 5, 5, true) --Darkest Depths
	GridStatusRaidDebuff:DebuffId(zoneid, 292167, 44, 5, 5, true) --Toxic Spine
	GridStatusRaidDebuff:DebuffId(zoneid, 292307, 45, 5, 5, true) --Gaze from Below
	GridStatusRaidDebuff:DebuffId(zoneid, 305085, 46, 5, 5, true) --Slipstream
	GridStatusRaidDebuff:DebuffId(zoneid, 298595, 47, 5, 5, true) --Glowing Stinger

	-- Lady Ashvane
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Lady Ashvane")
	GridStatusRaidDebuff:DebuffId(zoneid, 296725, 61, 5, 5, true) --Barnacle Bash
	GridStatusRaidDebuff:DebuffId(zoneid, 296693, 62, 5, 5, true) --Waterlogged
	GridStatusRaidDebuff:DebuffId(zoneid, 302992, 63, 5, 5, true) --Briny Bubble
	GridStatusRaidDebuff:DebuffId(zoneid, 296752, 64, 5, 5, true) --Cutting Coral
	GridStatusRaidDebuff:DebuffId(zoneid, 296942, 65, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 296939, 66, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 296938, 67, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 296941, 68, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 296940, 69, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 296943, 70, 5, 5, true) --Arcing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 302989, 71, 5, 5, true) --Briny Bubble

	-- Orgozoa
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Orgozoa")
	GridStatusRaidDebuff:DebuffId(zoneid, 298156, 81, 5, 5, true, true) --Desensitizing Sting
	GridStatusRaidDebuff:DebuffId(zoneid, 298306, 82, 5, 5, true) --Incubation Fluid
	GridStatusRaidDebuff:DebuffId(zoneid, 296101, 83, 5, 5, true) --Rewind

	-- The Queen's Court
	GridStatusRaidDebuff:BossNameId(zoneid, 90, "The Queen's Court")
	GridStatusRaidDebuff:DebuffId(zoneid, 301830, 91, 5, 5, true) --Pashmar's Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 296851, 92, 5, 5, true) --Fanatical Verdict
	GridStatusRaidDebuff:DebuffId(zoneid, 300545, 93, 5, 5, true) --Mighty Rupture
	GridStatusRaidDebuff:DebuffId(zoneid, 297585, 94, 5, 5, true) --Obey or Suffer
	GridStatusRaidDebuff:DebuffId(zoneid, 304409, 95, 5, 5, true) --Repeat Performance
	GridStatusRaidDebuff:DebuffId(zoneid, 304128, 96, 5, 5, true) --Deferred Sentence
	GridStatusRaidDebuff:DebuffId(zoneid, 303188, 97, 5, 5, true) --In Formation

	-- Za'qul
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Za'qul")
	GridStatusRaidDebuff:DebuffId(zoneid, 296018, 101, 5, 5, true) --Manic Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 303619, 102, 5, 5, true) --Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 293509, 103, 5, 5, true) --Manifest Nightmares
	GridStatusRaidDebuff:DebuffId(zoneid, 292971, 104, 5, 5, true) --Hysteria
	GridStatusRaidDebuff:DebuffId(zoneid, 298192, 105, 5, 5, true) --Dark Beyond
	GridStatusRaidDebuff:DebuffId(zoneid, 295327, 106, 5, 5, true) --Shattered Psyche
	GridStatusRaidDebuff:DebuffId(zoneid, 296015, 107, 5, 5, true) --Caustic Delirium
	GridStatusRaidDebuff:DebuffId(zoneid, 303981, 108, 5, 5, true) --Nether Portal

	-- Queen Azshara
	GridStatusRaidDebuff:BossNameId(zoneid, 120, "Queen Azshara")
	GridStatusRaidDebuff:DebuffId(zoneid, 302999, 121, 5, 5, true) --Arcane Vulnerability
	GridStatusRaidDebuff:DebuffId(zoneid, 299276, 122, 5, 5, true) --Sanction
	GridStatusRaidDebuff:DebuffId(zoneid, 300001, 123, 5, 5, true) --Devotion
	GridStatusRaidDebuff:DebuffId(zoneid, 298781, 124, 5, 5, true) --Arcane Orb
	GridStatusRaidDebuff:DebuffId(zoneid, 299251, 125, 5, 5, true) --Obey!
	GridStatusRaidDebuff:DebuffId(zoneid, 297656, 126, 5, 5, true) --Stand Alone
	GridStatusRaidDebuff:DebuffId(zoneid, 299255, 127, 5, 5, true) --Stand Alone!
	GridStatusRaidDebuff:DebuffId(zoneid, 299249, 128, 5, 5, true) --Suffer!
	GridStatusRaidDebuff:DebuffId(zoneid, 299254, 129, 5, 5, true) --Stand Together!
	GridStatusRaidDebuff:DebuffId(zoneid, 297907, 130, 5, 5, true) --Cursed Heart
	GridStatusRaidDebuff:DebuffId(zoneid, 303657, 131, 5, 5, true) --Arcane Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 299094, 132, 5, 5, true) --Beckon
	GridStatusRaidDebuff:DebuffId(zoneid, 298569, 133, 5, 5, true) --Drained Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 298756, 134, 5, 5, true) --Serrated Edge
	GridStatusRaidDebuff:DebuffId(zoneid, 301078, 135, 5, 5, true) --Charged Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 298018, 136, 5, 5, true) --Frozen
	GridStatusRaidDebuff:DebuffId(zoneid, 300492, 137, 5, 5, true) --Static Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 298014, 138, 5, 5, true) --Cold Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 303825, 139, 5, 5, true) --Crushing Depths
end

-- BFA Raid
-- Cruicible of Storms
do
	-- Trash
	GridStatusRaidDebuff:DebuffId(zoneid, 294009, 1, 5, 5, true) --Mind Sear
	GridStatusRaidDebuff:DebuffId(zoneid, 293957, 1, 5, 5, true) --Maddening Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 294141, 1, 5, 5, true) --Embrace Madness
	GridStatusRaidDebuff:DebuffId(zoneid, 293796, 1, 5, 5, true) --Dark Corruption
	GridStatusRaidDebuff:DebuffId(zoneid, 294175, 1, 5, 5, true) --Mind Shatter

	-- The Restless Cabal
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "The Restless Cabal")
	GridStatusRaidDebuff:DebuffId(zoneid, 283524, 11, 3, 3, true) --Aphotic Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 282384, 12, 4, 4, true, true) --Shear Mind
	GridStatusRaidDebuff:DebuffId(zoneid, 282561, 13, 5, 5, true) --Dark Herald
	GridStatusRaidDebuff:DebuffId(zoneid, 282432, 14, 5, 5, true) --Crushing Doubt
	GridStatusRaidDebuff:DebuffId(zoneid, 282589, 15, 5, 5, true) --Cerebral Assault
	GridStatusRaidDebuff:DebuffId(zoneid, 282566, 16, 5, 5, true) --Promises of Power
	GridStatusRaidDebuff:DebuffId(zoneid, 282743, 17, 5, 5, true) --Storm of Annihilation
	GridStatusRaidDebuff:DebuffId(zoneid, 282738, 18, 5, 5, true) --Embrace of the Void

	-- Uu'nat, Harbinger of the Void
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Uu'nat, Harbinger of the Void")
	GridStatusRaidDebuff:DebuffId(zoneid, 284851, 21, 5, 5, true) --Touch of the End
	GridStatusRaidDebuff:DebuffId(zoneid, 285652, 22, 5, 5, true) --Insatiable Torment
	GridStatusRaidDebuff:DebuffId(zoneid, 285685, 23, 5, 5, true) --Gift of N'Zoth: Lunacy
	GridStatusRaidDebuff:DebuffId(zoneid, 285367, 24, 5, 5, true) --Piercing Gaze of N'Zoth
	GridStatusRaidDebuff:DebuffId(zoneid, 285345, 25, 5, 5, true) --Maddening Eyes of N'Zoth
	GridStatusRaidDebuff:DebuffId(zoneid, 285477, 26, 5, 5, true) --Obscurity
end

-- BFA Raid
-- Battle of Dazar'alor
do
	-- Trash
	GridStatusRaidDebuff:DebuffId(zoneid, 289384, 1, 5, 5, true) --Savage Swipe
	GridStatusRaidDebuff:DebuffId(zoneid, 287437, 1, 5, 5, true) --Frozen Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 287294, 1, 5, 5, true) --Blizzard
	GridStatusRaidDebuff:DebuffId(zoneid, 286740, 1, 5, 5, true) --Light's Fury
	GridStatusRaidDebuff:DebuffId(zoneid, 285250, 1, 5, 5, true) --Sundering Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 289645, 1, 5, 5, true) --Polymorph
	GridStatusRaidDebuff:DebuffId(zoneid, 289578, 1, 5, 5, true) --Lit Torch
	GridStatusRaidDebuff:DebuffId(zoneid, 287325, 1, 5, 5, true) --Comet Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 289772, 1, 5, 5, true) --Impale
	GridStatusRaidDebuff:DebuffId(zoneid, 285292, 1, 5, 5, true) --Frozen Tides
	GridStatusRaidDebuff:DebuffId(zoneid, 285280, 1, 5, 5, true) --Searing Waves
	GridStatusRaidDebuff:DebuffId(zoneid, 287147, 1, 5, 5, true) --Dread Reaping
	GridStatusRaidDebuff:DebuffId(zoneid, 284573, 1, 5, 5, true) --Tailwinds
	GridStatusRaidDebuff:DebuffId(zoneid, 253562, 1, 5, 5, true) --Wildfire
	GridStatusRaidDebuff:DebuffId(zoneid, 289917, 1, 5, 5, true) --Bwonsamdi's Pact
	GridStatusRaidDebuff:DebuffId(zoneid, 289418, 1, 5, 5, true) --Predator's Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 287295, 1, 5, 5, true) --Chilled
	GridStatusRaidDebuff:DebuffId(zoneid, 289937, 1, 5, 5, true) --Thundering Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 289514, 1, 5, 5, true) --Molten Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 289512, 1, 5, 5, true) --Molten Punch
	GridStatusRaidDebuff:DebuffId(zoneid, 289373, 1, 5, 5, true) --Lacerating Pounce
	GridStatusRaidDebuff:DebuffId(zoneid, 287456, 1, 5, 5, true) --Frost Nova
	GridStatusRaidDebuff:DebuffId(zoneid, 287556, 1, 5, 5, true) --Soul Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 289484, 1, 5, 5, true) --Burning Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 289918, 1, 5, 5, true) --Bwonsamdi's Bargain

	-- Champion of the Light
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Champion of the Light")
	GridStatusRaidDebuff:DebuffId(zoneid, 283573, 11, 5, 5, true) --Sacred Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 284595, 12, 5, 5, true) --Penance
	GridStatusRaidDebuff:DebuffId(zoneid, 283617, 13, 5, 5, true) --Wave of Light
	GridStatusRaidDebuff:DebuffId(zoneid, 283651, 14, 5, 5, true) --Blinding Faith
	GridStatusRaidDebuff:DebuffId(zoneid, 283582, 15, 5, 5, true) --Consecration

	-- Grong
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Grong")
	GridStatusRaidDebuff:DebuffId(zoneid, 282010, 21, 5, 5, true) --Shattered
	GridStatusRaidDebuff:DebuffId(zoneid, 285875, 22, 5, 5, true) --Rending Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 289307, 23, 5, 5, true) --Bestial Throw Target
	GridStatusRaidDebuff:DebuffId(zoneid, 283069, 24, 5, 5, true) --Megatomic Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 289292, 25, 5, 5, true) --Bestial Throw
	GridStatusRaidDebuff:DebuffId(zoneid, 285998, 26, 5, 5, true) --Ferocious Roar
	GridStatusRaidDebuff:DebuffId(zoneid, 285671, 27, 5, 5, true) --Crushed
	GridStatusRaidDebuff:DebuffId(zoneid, 285659, 28, 5, 5, true) --Apetagonizer Core
	GridStatusRaidDebuff:DebuffId(zoneid, 289412, 29, 5, 5, true) --Bestial Impact

	-- Jadefire Masters
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Jadefire Masters")
	GridStatusRaidDebuff:DebuffId(zoneid, 284374, 41, 5, 5, true) --Magma Trap
	GridStatusRaidDebuff:DebuffId(zoneid, 282037, 42, 5, 5, true) --Rising Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 286503, 43, 5, 5, true) --Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 288151, 44, 5, 5, true) --Tested
	GridStatusRaidDebuff:DebuffId(zoneid, 284089, 45, 5, 5, true) --Successful Defense
	GridStatusRaidDebuff:DebuffId(zoneid, 285632, 46, 5, 5, true) --Stalking
	GridStatusRaidDebuff:DebuffId(zoneid, 286369, 47, 5, 5, true) --Chi-Ji's Song
	GridStatusRaidDebuff:DebuffId(zoneid, 287747, 48, 5, 5, true) --Force Orb
	GridStatusRaidDebuff:DebuffId(zoneid, 286988, 49, 7, 7, true, true) --Searing Embers
	GridStatusRaidDebuff:DebuffId(zoneid, 284453, 50, 5, 5, true) --Chi-Ji's Song
	GridStatusRaidDebuff:DebuffId(zoneid, 288051, 51, 5, 5, true) --Dragon's Breath

	-- Opulence
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Opulence")
	GridStatusRaidDebuff:DebuffId(zoneid, 284881, 61, 5, 5, true) --Opal of Unleashed Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 284611, 62, 5, 5, true) --Ruby of Focused Animus
	GridStatusRaidDebuff:DebuffId(zoneid, 284883, 63, 5, 5, true) --Unleashed Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 284567, 64, 5, 5, true) --Tailwind Sapphire
	GridStatusRaidDebuff:DebuffId(zoneid, 284558, 65, 5, 5, true) --Amethyst of the Shadow King
	GridStatusRaidDebuff:DebuffId(zoneid, 284537, 66, 5, 5, true) --Tailwinds
	GridStatusRaidDebuff:DebuffId(zoneid, 284556, 67, 5, 5, true) --Shadow-Touched
	GridStatusRaidDebuff:DebuffId(zoneid, 284814, 68, 5, 5, true) --Emerald of Earthen Roots
	GridStatusRaidDebuff:DebuffId(zoneid, 284527, 69, 5, 5, true) --Diamond of the Unshakeable Protector
	GridStatusRaidDebuff:DebuffId(zoneid, 284645, 70, 5, 5, true) --Topaz of Brilliant Sunlight
	GridStatusRaidDebuff:DebuffId(zoneid, 284664, 71, 5, 5, true) --Incandescence
	GridStatusRaidDebuff:DebuffId(zoneid, 284817, 72, 5, 5, true) --Earthen Roots
	GridStatusRaidDebuff:DebuffId(zoneid, 283507, 73, 5, 5, true) --Volatile Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 284546, 74, 5, 5, true) --Depleted Diamond
	GridStatusRaidDebuff:DebuffId(zoneid, 290654, 75, 5, 5, true) --Soothing Breeze
	GridStatusRaidDebuff:DebuffId(zoneid, 287072, 76, 5, 5, true) --Liquid Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 284798, 77, 5, 5, true) --Grossly Incandescent!
	GridStatusRaidDebuff:DebuffId(zoneid, 284802, 78, 5, 5, true) --Brilliant Aura
	GridStatusRaidDebuff:DebuffId(zoneid, 284493, 79, 5, 5, true) --Pulse-quickening Toxin
	GridStatusRaidDebuff:DebuffId(zoneid, 287424, 80, 5, 5, true) --Thief's Bane
	GridStatusRaidDebuff:DebuffId(zoneid, 285014, 81, 5, 5, true) --Coin Shower
	GridStatusRaidDebuff:DebuffId(zoneid, 284519, 82, 5, 5, true) --Quickened Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 287648, 83, 5, 5, true) --Volatile Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 283610, 84, 5, 5, true) --Crush
	GridStatusRaidDebuff:DebuffId(zoneid, 284424, 85, 5, 5, true) --Scorching Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 284470, 86, 5, 5, true) --Hex of Lethargy
	GridStatusRaidDebuff:DebuffId(zoneid, 284472, 87, 5, 5, true) --Deadly Hex
	GridStatusRaidDebuff:DebuffId(zoneid, 286501, 88, 5, 5, true) --Creeping Blaze
	GridStatusRaidDebuff:DebuffId(zoneid, 285479, 89, 5, 5, true) --Flame Jet
	GridStatusRaidDebuff:DebuffId(zoneid, 287074, 90, 5, 5, true) --Molten Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 283063, 91, 5, 5, true) --Flames of Punishment

	-- Conclave of the Chosen
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Conclave of the Chosen")
	GridStatusRaidDebuff:DebuffId(zoneid, 282592, 101, 5, 5, true) --Bleeding Wounds
	GridStatusRaidDebuff:DebuffId(zoneid, 282444, 102, 5, 5, true) --Lacerating Claws
	GridStatusRaidDebuff:DebuffId(zoneid, 71909, 103, 5, 5, true) --Heartbroken
	GridStatusRaidDebuff:DebuffId(zoneid, 282209, 104, 5, 5, true) --Mark of Prey
	GridStatusRaidDebuff:DebuffId(zoneid, 285879, 105, 5, 5, true) --Mind Wipe
	GridStatusRaidDebuff:DebuffId(zoneid, 282135, 106, 5, 5, true) --Crawling Hex
	GridStatusRaidDebuff:DebuffId(zoneid, 282834, 107, 5, 5, true) --Kimbul's Wrath
	GridStatusRaidDebuff:DebuffId(zoneid, 286060, 108, 5, 5, true) --Cry of the Fallen
	GridStatusRaidDebuff:DebuffId(zoneid, 286811, 109, 5, 5, true) --Akunda's Wrath
	GridStatusRaidDebuff:DebuffId(zoneid, 286838, 111, 5, 5, true) --Static Orb

	-- King Rastakhan
	GridStatusRaidDebuff:BossNameId(zoneid, 120, "King Rastakhan")
	GridStatusRaidDebuff:DebuffId(zoneid, 285195, 121, 5, 5, true) --Deathly Withering
	GridStatusRaidDebuff:DebuffId(zoneid, 286742, 122, 5, 5, true) --Necrotic Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 288449, 123, 5, 5, true) --Death's Door
	GridStatusRaidDebuff:DebuffId(zoneid, 284455, 124, 5, 5, true) --Realm of Death
	GridStatusRaidDebuff:DebuffId(zoneid, 285044, 125, 5, 5, true) --Toad Toxin
	GridStatusRaidDebuff:DebuffId(zoneid, 284831, 126, 5, 5, true) --Scorching Detonation
	GridStatusRaidDebuff:DebuffId(zoneid, 288415, 127, 5, 5, true) --Caress of Death
	GridStatusRaidDebuff:DebuffId(zoneid, 285349, 128, 5, 5, true) --Plague of Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 289858, 129, 5, 5, true) --Crushed
	GridStatusRaidDebuff:DebuffId(zoneid, 284995, 130, 5, 5, true) --Zombie Dust
	GridStatusRaidDebuff:DebuffId(zoneid, 286779, 131, 5, 5, true) --Focused Demise
	GridStatusRaidDebuff:DebuffId(zoneid, 285213, 132, 5, 5, true) --Caress of Death
	GridStatusRaidDebuff:DebuffId(zoneid, 284376, 133, 5, 5, true) --Death's Presence
	GridStatusRaidDebuff:DebuffId(zoneid, 290450, 134, 5, 5, true) --Seal of Purification
	GridStatusRaidDebuff:DebuffId(zoneid, 285178, 135, 5, 5, true) --Serpent's Breath
	GridStatusRaidDebuff:DebuffId(zoneid, 285010, 136, 5, 5, true) --Poison Toad Slime
	GridStatusRaidDebuff:DebuffId(zoneid, 284781, 127, 5, 5, true) --Grievous Axe
	GridStatusRaidDebuff:DebuffId(zoneid, 290448, 138, 5, 5, true) --Seal of Purification

	-- Mekkatorque
	GridStatusRaidDebuff:BossNameId(zoneid, 150, "Mekkatorque")
	GridStatusRaidDebuff:DebuffId(zoneid, 288806, 151, 5, 5, true) --Gigavolt Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 286646, 152, 5, 5, true) --Gigavolt Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 286105, 153, 5, 5, true) --Tampering!
	GridStatusRaidDebuff:DebuffId(zoneid, 284168, 154, 5, 5, true) --Shrunk
	GridStatusRaidDebuff:DebuffId(zoneid, 287891, 155, 5, 5, true) --Sheep Shrapnel
	GridStatusRaidDebuff:DebuffId(zoneid, 282182, 156, 5, 5, true) --Buster Cannon
	GridStatusRaidDebuff:DebuffId(zoneid, 282408, 157, 5, 5, true) --Spark Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 284214, 158, 5, 5, true) --Trample

	-- Stormwall Blockade
	GridStatusRaidDebuff:BossNameId(zoneid, 170, "Stormwall Blockade")
	GridStatusRaidDebuff:DebuffId(zoneid, 285000, 171, 5, 5, true) --Kelp-Wrapped
	GridStatusRaidDebuff:DebuffId(zoneid, 285075, 172, 5, 5, true) --Freezing Tidepool
	GridStatusRaidDebuff:DebuffId(zoneid, 285382, 173, 5, 5, true) --Kelp Wrapping
	GridStatusRaidDebuff:DebuffId(zoneid, 285426, 174, 5, 5, true) --Storm's Wail
	GridStatusRaidDebuff:DebuffId(zoneid, 285420, 175, 5, 5, true) --Unbound Energy
	GridStatusRaidDebuff:DebuffId(zoneid, 285350, 176, 5, 5, true) --Storm's Wail
	GridStatusRaidDebuff:DebuffId(zoneid, 284369, 177, 5, 5, true) --Sea Storm
	GridStatusRaidDebuff:DebuffId(zoneid, 284405, 178, 5, 5, true) --Tempting Song
	GridStatusRaidDebuff:DebuffId(zoneid, 284121, 179, 5, 5, true) --Thunderous Boom
	GridStatusRaidDebuff:DebuffId(zoneid, 290437, 180, 5, 5, true) --Reaching Attack
	GridStatusRaidDebuff:DebuffId(zoneid, 286680, 181, 5, 5, true) --Roiling Tides

	-- Lady Jaina Proudmoore
	GridStatusRaidDebuff:BossNameId(zoneid, 190, "Lady Jaina Proudmoore")
	GridStatusRaidDebuff:DebuffId(zoneid, 287993, 191, 5, 5, true) --Chilling Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 285253, 192, 5, 5, true) --Ice Shard
	GridStatusRaidDebuff:DebuffId(zoneid, 288169, 193, 5, 5, true) --Howling Winds
	GridStatusRaidDebuff:DebuffId(zoneid, 287490, 194, 5, 5, true) --Frozen Solid
	GridStatusRaidDebuff:DebuffId(zoneid, 288297, 195, 5, 5, true) --Arctic Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 287365, 196, 5, 5, true) --Searing Pitch
	GridStatusRaidDebuff:DebuffId(zoneid, 288394, 197, 5, 5, true) --Warmth
	GridStatusRaidDebuff:DebuffId(zoneid, 287626, 198, 5, 5, true) --Grasp of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 289220, 199, 5, 5, true) --Heart of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 288212, 200, 5, 5, true) --Broadside
	GridStatusRaidDebuff:DebuffId(zoneid, 285254, 201, 5, 5, true) --Avalanche
	GridStatusRaidDebuff:DebuffId(zoneid, 288374, 202, 5, 5, true) --Siegebreaker Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 288038, 203, 5, 5, true) --Marked Target
	GridStatusRaidDebuff:DebuffId(zoneid, 288434, 204, 5, 5, true) --Hand of Frost
	GridStatusRaidDebuff:DebuffId(zoneid, 287199, 205, 5, 5, true) --Ring of Ice
end

-- BFA Raid
-- Azeroth
do
	-- T'zane
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "T'zane")
	GridStatusRaidDebuff:DebuffId(zoneid, 261552, 11, 5, 5, true) -- Terror Wail
	GridStatusRaidDebuff:DebuffId(zoneid, 261632, 12, 5, 5, true) -- Consuming Spirits

	-- Ji'arak
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Ji'arak")
	GridStatusRaidDebuff:DebuffId(zoneid, 261509, 21, 5, 5, true) -- Clutch
	GridStatusRaidDebuff:DebuffId(zoneid, 260908, 22, 5, 5) -- Storm Wing

	-- Hailstone Construct
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Hailstone Construct")
	GridStatusRaidDebuff:DebuffId(zoneid, 274891, 31, 5, 5) -- Glacial Breath

	-- The Lion's Roar
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "The Lion's Roar")
	GridStatusRaidDebuff:DebuffId(zoneid, 271246, 41, 5, 5, true) -- Demolisher Cannon

	-- Azurethos, The Winged Typhoon
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Azurethos")
	GridStatusRaidDebuff:DebuffId(zoneid, 274839, 51, 5, 5, true) -- Azurethos' Fury

	-- Warbringer Yenajz
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Warbringer Yenajz")
	GridStatusRaidDebuff:DebuffId(zoneid, 274904, 61, 5, 5, true) -- Reality Tear
	GridStatusRaidDebuff:DebuffId(zoneid, 274932, 62, 5, 5) -- Endless Abyss
	GridStatusRaidDebuff:DebuffId(zoneid, 274842, 63, 5, 5) -- Void Nova

	-- Dunegorger Kraulok
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Dunegorger Kraulok")
end