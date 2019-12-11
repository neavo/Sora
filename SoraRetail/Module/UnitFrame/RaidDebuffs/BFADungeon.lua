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

-- BFA Dungeon
-- Waycrest Manor
do
	GridStatusRaidDebuff:DebuffId(zoneid, 264105, 1, 6, 6, true) --Runic Mark
	GridStatusRaidDebuff:DebuffId(zoneid, 271174, 1, 6, 6, true) --Retch
	GridStatusRaidDebuff:DebuffId(zoneid, 264040, 1, 6, 6, true) --Uprooted Thorns
	GridStatusRaidDebuff:DebuffId(zoneid, 260900, 1, 6, 6, true) --Soul Manipulation
	GridStatusRaidDebuff:DebuffId(zoneid, 264378, 1, 6, 6, true) --Fragment Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 271178, 1, 6, 6, true) --Ravaging Leap
	GridStatusRaidDebuff:DebuffId(zoneid, 260569, 1, 6, 6, true) --Wildfire
	GridStatusRaidDebuff:DebuffId(zoneid, 264153, 1, 6, 6, true) --Spit
	GridStatusRaidDebuff:DebuffId(zoneid, 265391, 1, 6, 6, true) --Meaty Rampage
	GridStatusRaidDebuff:DebuffId(zoneid, 264531, 1, 6, 6, true) --Shrapnel Trap
	GridStatusRaidDebuff:DebuffId(zoneid, 265371, 1, 6, 6, true) --Captain's Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 267824, 1, 6, 6, true) --Scar Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 265337, 1, 6, 6, true) --Snout Smack
	GridStatusRaidDebuff:DebuffId(zoneid, 200010, 1, 6, 6, true) --Power Leech
	GridStatusRaidDebuff:DebuffId(zoneid, 266036, 1, 6, 6, true) --Drain Essence
	GridStatusRaidDebuff:DebuffId(zoneid, 265410, 1, 6, 6, true) --Punch
	GridStatusRaidDebuff:DebuffId(zoneid, 263943, 1, 6, 6, true) --Etch
	GridStatusRaidDebuff:DebuffId(zoneid, 268271, 1, 6, 6, true) --Wracking Chord
	GridStatusRaidDebuff:DebuffId(zoneid, 261438, 1, 6, 6, true) --Wasting Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 264111, 1, 6, 6, true) --Darkened Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 265757, 1, 6, 6, true) --Splinter Spike
	GridStatusRaidDebuff:DebuffId(zoneid, 265881, 1, 6, 6, true) --Decaying Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 264556, 1, 6, 6, true) --Tearing Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 264150, 1, 6, 6, true) --Shatter
	GridStatusRaidDebuff:DebuffId(zoneid, 264510, 1, 6, 6, true) --Shoot
	GridStatusRaidDebuff:DebuffId(zoneid, 264456, 1, 6, 6, true) --Tracking Explosive
	GridStatusRaidDebuff:DebuffId(zoneid, 260701, 1, 6, 6, true) --Bramble Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 265882, 1, 6, 6, true) --Lingering Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 265642, 1, 6, 6, true) --Diseased Crunch
	GridStatusRaidDebuff:DebuffId(zoneid, 260699, 1, 6, 6, true) --Soul Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 264520, 1, 6, 6, true) --Severing Serpent
	GridStatusRaidDebuff:DebuffId(zoneid, 260700, 1, 6, 6, true) --Ruinous Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 265407, 1, 6, 6, true) --Dinner Bell
	GridStatusRaidDebuff:DebuffId(zoneid, 260703, 1, 6, 6, true) --Unstable Runic Mark
	GridStatusRaidDebuff:DebuffId(zoneid, 266035, 1, 6, 6, true) --Bone Splinter
	GridStatusRaidDebuff:DebuffId(zoneid, 263959, 1, 6, 6, true) --Soul Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 265352, 1, 6, 6, true) --Toad Blight
	GridStatusRaidDebuff:DebuffId(zoneid, 265880, 1, 6, 6, true) --Dread Mark
	GridStatusRaidDebuff:DebuffId(zoneid, 265372, 1, 6, 6, true) --Shadow Cleave
	GridStatusRaidDebuff:DebuffId(zoneid, 264390, 1, 6, 6, true) --Spellbind
	GridStatusRaidDebuff:DebuffId(zoneid, 278849, 1, 6, 6, true) --Uproot
	GridStatusRaidDebuff:DebuffId(zoneid, 265876, 1, 6, 6, true) --Ruinous Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 264655, 1, 6, 6, true) --Withering Glob
	GridStatusRaidDebuff:DebuffId(zoneid, 265761, 1, 6, 6, true) --Thorned Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 264140, 1, 6, 6, true) --Thorned Claw
	GridStatusRaidDebuff:DebuffId(zoneid, 263905, 1, 6, 6, true) --Marking Cleave
	GridStatusRaidDebuff:DebuffId(zoneid, 264050, 1, 6, 6, true) --Infected Thorn

	GridStatusRaidDebuff:DebuffId(zoneid, 263891, 1, 6, 6, true) --Grasping Thorns
	GridStatusRaidDebuff:DebuffId(zoneid, 268080, 1, 6, 6, true) --Aura of Apathy
	GridStatusRaidDebuff:DebuffId(zoneid, 264407, 1, 6, 6, true) --Horrific Visage
	GridStatusRaidDebuff:DebuffId(zoneid, 259882, 1, 6, 6, true) --Raw Chicken
	GridStatusRaidDebuff:DebuffId(zoneid, 265878, 1, 6, 6, true) --Weeping Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 118905, 1, 6, 6, true) --Static Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 278456, 1, 6, 6, true) --Infest
	GridStatusRaidDebuff:DebuffId(zoneid, 265346, 1, 6, 6, true) --Pallid Glare
	GridStatusRaidDebuff:DebuffId(zoneid, 113746, 1, 6, 6, true) --Mystic Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 268086, 1, 6, 6, true) --Aura of Dread
	GridStatusRaidDebuff:DebuffId(zoneid, 268125, 1, 6, 6, true) --Aura of Thorns
	GridStatusRaidDebuff:DebuffId(zoneid, 30213, 1, 6, 6, true) --Legion Strike

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Heartsbane Triad
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Heartsbane Triad")
	GridStatusRaidDebuff:DebuffId(zoneid, 260741, 11, 6, 6, true) --Jagged Nettles
	GridStatusRaidDebuff:DebuffId(zoneid, 260805, 12, 6, 6, true) --Focusing Iris
	--Soulbound Goliath
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Soulbound Goliath")
	GridStatusRaidDebuff:DebuffId(zoneid, 260512, 21, 6, 6, true) --Soul Harvest
	GridStatusRaidDebuff:DebuffId(zoneid, 260551, 22, 6, 6, true) --Soul Thorns
	GridStatusRaidDebuff:DebuffId(zoneid, 260508, 23, 6, 6, true) --Crush
	GridStatusRaidDebuff:DebuffId(zoneid, 260547, 24, 6, 6, true) --Burning Brush
	--Raal the Glutonous
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Raal the Glutonous")
	GridStatusRaidDebuff:DebuffId(zoneid, 264923, 31, 6, 6, true) --Tenderize
	GridStatusRaidDebuff:DebuffId(zoneid, 264694, 32, 6, 6, true) --Rotten Expulsion
	--Lord and Lady Waycrest
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lord and Lady Waycrest")
	GridStatusRaidDebuff:DebuffId(zoneid, 261439, 41, 6, 6, true) --Virulent Pathogen
	GridStatusRaidDebuff:DebuffId(zoneid, 268306, 42, 6, 6, true) --Discordant Cadenza
	--Gorak Tul
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Gorak Tul")
	GridStatusRaidDebuff:DebuffId(zoneid, 266225, 51, 6, 6, true) --Darkened Lightning
	GridStatusRaidDebuff:DebuffId(zoneid, 266198, 52, 6, 6, true) --Alchemical Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 268202, 53, 6, 6, true) --Death Lens
end

-- BFA Dungeon
-- Tol Dagor
do
	--trash
	GridStatusRaidDebuff:DebuffId(zoneid, 258313, 1, 6, 6, true) --Handcuff
	GridStatusRaidDebuff:DebuffId(zoneid, 258938, 1, 6, 6, true) --Inner Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 258864, 1, 6, 6, true) --Suppression Fire
	GridStatusRaidDebuff:DebuffId(zoneid, 185857, 1, 6, 6, true) --Shoot
	GridStatusRaidDebuff:DebuffId(zoneid, 224125, 1, 6, 6, true) --Molten Weapon
	GridStatusRaidDebuff:DebuffId(zoneid, 257028, 1, 6, 6, true) --Fuselighter
	GridStatusRaidDebuff:DebuffId(zoneid, 256083, 1, 6, 6, true) --Cross Ignition
	GridStatusRaidDebuff:DebuffId(zoneid, 258150, 1, 6, 6, true) --Salt Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 257793, 1, 6, 6, true) --Smoke Powder
	GridStatusRaidDebuff:DebuffId(zoneid, 265889, 1, 6, 6, true) --Torch Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 256105, 1, 6, 6, true) --Explosive Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 258917, 1, 6, 6, true) --Righteous Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 258128, 1, 6, 6, true) --Debilitating Shout
	GridStatusRaidDebuff:DebuffId(zoneid, 259711, 1, 6, 6, true) --Lockdown
	GridStatusRaidDebuff:DebuffId(zoneid, 257777, 1, 6, 6, true) --Crippling Shiv
	GridStatusRaidDebuff:DebuffId(zoneid, 272620, 1, 6, 6, true) --Throw Rock
	GridStatusRaidDebuff:DebuffId(zoneid, 265271, 1, 6, 6, true) --Sewer Slime
	GridStatusRaidDebuff:DebuffId(zoneid, 258134, 1, 6, 6, true) --Makeshift Shiv
	GridStatusRaidDebuff:DebuffId(zoneid, 258058, 1, 6, 6, true) --Squeeze
	GridStatusRaidDebuff:DebuffId(zoneid, 258079, 1, 6, 6, true) --Massive Chomp
	GridStatusRaidDebuff:DebuffId(zoneid, 256200, 1, 6, 6, true) --Heartstopper Venom
	GridStatusRaidDebuff:DebuffId(zoneid, 260016, 1, 6, 6, true) --Itchy Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 260067, 1, 6, 6, true) --Vicious Mauling
	GridStatusRaidDebuff:DebuffId(zoneid, 224729, 1, 6, 6, true) --Bursting Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 257791, 1, 6, 6, true) --Howling Fear

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--The Sand Queen
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "The Sand Queen")
	GridStatusRaidDebuff:DebuffId(zoneid, 259975, 11, 6, 6, true) --Enrage
	GridStatusRaidDebuff:DebuffId(zoneid, 257119, 12, 6, 6, true) --Sand Trap
	--Jes Howlis
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Jes Howlis")
	GridStatusRaidDebuff:DebuffId(zoneid, 257785, 21, 6, 6, true) --Flashing Daggers
	GridStatusRaidDebuff:DebuffId(zoneid, 257956, 22, 6, 6, true) --Motivated
	--Knight Captain Valyri
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Knight Captain Valyri")
	GridStatusRaidDebuff:DebuffId(zoneid, 256710, 31, 6, 6, true) --Burning Arsenal
	GridStatusRaidDebuff:DebuffId(zoneid, 257033, 32, 6, 6, true) --Fuselighter
	GridStatusRaidDebuff:DebuffId(zoneid, 256976, 33, 6, 6, true) --Ignition
	GridStatusRaidDebuff:DebuffId(zoneid, 256955, 34, 6, 6, true) --Cinderflame
	--Overseer Korgus
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Overseer Korgus")
	GridStatusRaidDebuff:DebuffId(zoneid, 256201, 41, 6, 6, true) --Incendiary Rounds
	GridStatusRaidDebuff:DebuffId(zoneid, 256044, 42, 6, 6, true) --Deadeye
	GridStatusRaidDebuff:DebuffId(zoneid, 263345, 43, 6, 6, true) --Massive Blast
end

-- BFA Dungeon
-- The Underrot
do
	GridStatusRaidDebuff:DebuffId(zoneid, 272457, 1, 6, 6, true) --Shockwave
	GridStatusRaidDebuff:DebuffId(zoneid, 260312, 1, 6, 6, true) --Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 272180, 1, 6, 6, true) --Death Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 259732, 1, 6, 6, true) --Festering Harvest
	GridStatusRaidDebuff:DebuffId(zoneid, 272469, 1, 6, 6, true) --Abyssal Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 266265, 1, 6, 6, true) --Wicked Assault
	GridStatusRaidDebuff:DebuffId(zoneid, 187647, 1, 6, 6, true) --Bloodletting Pounce
	GridStatusRaidDebuff:DebuffId(zoneid, 272609, 1, 6, 6, true) --Maddening Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 120694, 1, 6, 6, true) --Dire Beast
	GridStatusRaidDebuff:DebuffId(zoneid, 260793, 1, 6, 6, true) --Indigestion
	GridStatusRaidDebuff:DebuffId(zoneid, 266201, 1, 6, 6, true) --Bone Shield
	GridStatusRaidDebuff:DebuffId(zoneid, 261498, 1, 6, 6, true) --Creeping Rot
	GridStatusRaidDebuff:DebuffId(zoneid, 265377, 1, 6, 6, true) --Hooked Snare
	GridStatusRaidDebuff:DebuffId(zoneid, 266107, 1, 6, 6, true) --Thirst For Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 265084, 1, 6, 6, true) --Blood Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 265376, 1, 6, 6, true) --Barbed Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 265540, 1, 6, 6, true) --Rotten Bile
	GridStatusRaidDebuff:DebuffId(zoneid, 265568, 1, 6, 6, true) --Dark Omen
	GridStatusRaidDebuff:DebuffId(zoneid, 278789, 1, 6, 6, true) --Wave of Decay
	GridStatusRaidDebuff:DebuffId(zoneid, 265468, 1, 6, 6, true) --Withering Curse
	GridStatusRaidDebuff:DebuffId(zoneid, 266106, 1, 6, 6, true) --Sonic Screech
	GridStatusRaidDebuff:DebuffId(zoneid, 265511, 1, 6, 6, true) --Spirit Drain
	GridStatusRaidDebuff:DebuffId(zoneid, 265016, 1, 6, 6, true) --Blood Harvest
	GridStatusRaidDebuff:DebuffId(zoneid, 265533, 1, 6, 6, true) --Blood Maw
	GridStatusRaidDebuff:DebuffId(zoneid, 269843, 1, 6, 6, true) --Vile Expulsion
	GridStatusRaidDebuff:DebuffId(zoneid, 278961, 1, 6, 6, true) --Decaying Mind
	GridStatusRaidDebuff:DebuffId(zoneid, 265487, 1, 6, 6, true) --Shadow Bolt Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 265019, 1, 6, 6, true) --Savage Cleave
	GridStatusRaidDebuff:DebuffId(zoneid, 260455, 1, 6, 6, true) --Serrated Fangs
	GridStatusRaidDebuff:DebuffId(zoneid, 339, 1, 6, 6, true) --Entangling Roots
	GridStatusRaidDebuff:DebuffId(zoneid, 164815, 1, 6, 6, true) --Sunfire
	GridStatusRaidDebuff:DebuffId(zoneid, 256445, 1, 6, 6, true) --Venom Spit

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Elder Leaxa
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Saboteur Kip'tilak")
	GridStatusRaidDebuff:DebuffId(zoneid, 260685, 11, 6, 6, true) --Taint of G'huun
	--Cragmaw the Infested
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Saboteur Kip'tilak")
	GridStatusRaidDebuff:DebuffId(zoneid, 260333, 21, 6, 6, true) --Tantrum
	--Sporecaller Zancha
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Saboteur Kip'tilak")
	GridStatusRaidDebuff:DebuffId(zoneid, 259714, 31, 6, 6, true) --Decaying Spores
	GridStatusRaidDebuff:DebuffId(zoneid, 259718, 32, 6, 6, true) --Upheaval
	--Unbound Abomination
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Saboteur Kip'tilak")
	GridStatusRaidDebuff:DebuffId(zoneid, 269301, 41, 6, 6, true) --Putrid Blood
end

-- BFA Dungeon
-- The MOTHERLODE
do
	GridStatusRaidDebuff:DebuffId(zoneid, 262515, 1, 6, 6, true) --Azerite Heartseeker
	GridStatusRaidDebuff:DebuffId(zoneid, 267357, 1, 6, 6, true) --Hail of Flechettes
	GridStatusRaidDebuff:DebuffId(zoneid, 269831, 1, 6, 6, true) --Toxic Sludge
	GridStatusRaidDebuff:DebuffId(zoneid, 262347, 1, 6, 6, true) --Static Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 263105, 1, 6, 6, true) --Blowtorch
	GridStatusRaidDebuff:DebuffId(zoneid, 269092, 1, 6, 6, true) --Artillery Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 262811, 1, 6, 6, true) --Leech Globule
	GridStatusRaidDebuff:DebuffId(zoneid, 268365, 1, 6, 6, true) --Mining Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 269298, 1, 6, 6, true) --Widowmaker Toxin
	GridStatusRaidDebuff:DebuffId(zoneid, 262263, 1, 6, 6, true) --Volatile Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 257544, 1, 6, 6, true) --Jagged Cut
	GridStatusRaidDebuff:DebuffId(zoneid, 262287, 1, 6, 6, true) --Concussion Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 260279, 1, 6, 6, true) --Gatling Gun
	GridStatusRaidDebuff:DebuffId(zoneid, 268722, 1, 6, 6, true) --Earth Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 268797, 1, 6, 6, true) --Transmute: Enemy to Goo
	GridStatusRaidDebuff:DebuffId(zoneid, 262066, 1, 6, 6, true) --Charged Claw
	GridStatusRaidDebuff:DebuffId(zoneid, 268865, 1, 6, 6, true) --Force Cannon
	GridStatusRaidDebuff:DebuffId(zoneid, 270882, 1, 6, 6, true) --Blazing Azerite
	GridStatusRaidDebuff:DebuffId(zoneid, 262348, 1, 6, 6, true) --Mine Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 268704, 1, 6, 6, true) --Furious Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 269429, 1, 6, 6, true) --Charged Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 260318, 1, 6, 6, true) --Alpha Cannon
	GridStatusRaidDebuff:DebuffId(zoneid, 259853, 1, 6, 6, true) --Chemical Burn
	GridStatusRaidDebuff:DebuffId(zoneid, 263637, 1, 6, 6, true) --Clothesline
	GridStatusRaidDebuff:DebuffId(zoneid, 262019, 1, 6, 6, true) --Grease Gun
	GridStatusRaidDebuff:DebuffId(zoneid, 262794, 1, 6, 6, true) --Energy Lash
	GridStatusRaidDebuff:DebuffId(zoneid, 260372, 1, 6, 6, true) --Buster Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 268185, 1, 6, 6, true) --Iced Spritzer
	GridStatusRaidDebuff:DebuffId(zoneid, 259474, 1, 6, 6, true) --Searing Reagent
	GridStatusRaidDebuff:DebuffId(zoneid, 262268, 1, 6, 6, true) --Caustic Compound
	GridStatusRaidDebuff:DebuffId(zoneid, 268417, 1, 6, 6, true) --Power Through
	GridStatusRaidDebuff:DebuffId(zoneid, 263074, 1, 6, 6, true) --Festering Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 275435, 1, 6, 6, true) --Azerite Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 258628, 1, 6, 6, true) --Resonant Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 262377, 1, 6, 6, true) --Seek and Destroy
	GridStatusRaidDebuff:DebuffId(zoneid, 263202, 1, 6, 6, true) --Rock Lance
	GridStatusRaidDebuff:DebuffId(zoneid, 268846, 1, 6, 6, true) --Echo Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 258674, 1, 6, 6, true) --Throw Wrench
	GridStatusRaidDebuff:DebuffId(zoneid, 275805, 1, 6, 6, true) --Big Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 12054, 1, 6, 6, true) --Rend
	GridStatusRaidDebuff:DebuffId(zoneid, 275907, 1, 6, 6, true) --Tectonic Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 84366, 1, 6, 6, true) --Repulsive Gaze
	GridStatusRaidDebuff:DebuffId(zoneid, 263344, 1, 6, 6, true) --Subjugate
	GridStatusRaidDebuff:DebuffId(zoneid, 256445, 1, 6, 6, true) --Venom Spit
	GridStatusRaidDebuff:DebuffId(zoneid, 270866, 1, 6, 6, true) --Jeweled Pincher
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 275707, 1, 6, 6, true) --Sticky Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 257371, 1, 6, 6, true) --Tear Gas
	GridStatusRaidDebuff:DebuffId(zoneid, 275885, 1, 6, 6, true) --Massive Streetsweeper
	GridStatusRaidDebuff:DebuffId(zoneid, 280605, 1, 6, 6, true) --Brain Freeze
	GridStatusRaidDebuff:DebuffId(zoneid, 269169, 1, 6, 6, true) --Jagged Hew
	GridStatusRaidDebuff:DebuffId(zoneid, 275616, 1, 6, 6, true) --Azerite Smoke

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Coin-Operated Crowd Pummeler
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Coin-Operated Crowd Pummeler")
	GridStatusRaidDebuff:DebuffId(zoneid, 256137, 11, 6, 6, true) --Timed Detonation
	GridStatusRaidDebuff:DebuffId(zoneid, 257337, 12, 6, 6, true) --Shocking Claw
	--Azerokk
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Azerokk")
	GridStatusRaidDebuff:DebuffId(zoneid, 257582, 21, 6, 6, true) --Raging Gaze
	--Rixxa Fluxflame
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Rixxa Fluxflame")
	GridStatusRaidDebuff:DebuffId(zoneid, 259022, 31, 6, 6, true) --Azerite Catalyst
	GridStatusRaidDebuff:DebuffId(zoneid, 259940, 32, 6, 6, true) --Propellant Blast
	--Mogul Razdunk
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Mogul Razdunk")
	GridStatusRaidDebuff:DebuffId(zoneid, 260838, 41, 6, 6, true) --Homing Missle
	GridStatusRaidDebuff:DebuffId(zoneid, 270277, 42, 6, 6, true) --Big Red Rocket
	GridStatusRaidDebuff:DebuffId(zoneid, 260202, 43, 6, 6, true) --Drill Smash
end

-- BFA Dungeon
-- Temple of Sethraliss
do
	GridStatusRaidDebuff:DebuffId(zoneid, 272657, 1, 6, 6, true) --Noxious Breath
	GridStatusRaidDebuff:DebuffId(zoneid, 273274, 1, 6, 6, true) --Polarized Field
	GridStatusRaidDebuff:DebuffId(zoneid, 268024, 1, 6, 6, true) --Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 264574, 1, 6, 6, true) --Power Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 272670, 1, 6, 6, true) --Shoot
	GridStatusRaidDebuff:DebuffId(zoneid, 262046, 1, 6, 6, true) --Krolusk Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 269670, 1, 6, 6, true) --Empowerment
	GridStatusRaidDebuff:DebuffId(zoneid, 279014, 1, 6, 6, true) --Cardiac Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 268061, 1, 6, 6, true) --Chain Lightning
	GridStatusRaidDebuff:DebuffId(zoneid, 263573, 1, 6, 6, true) --Cyclone Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 264587, 1, 6, 6, true) --Head Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 263927, 1, 6, 6, true) --Toxic Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 264206, 1, 6, 6, true) --Burrow
	GridStatusRaidDebuff:DebuffId(zoneid, 268703, 1, 6, 6, true) --Lightning Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 272699, 1, 6, 6, true) --Venomous Spit
	GridStatusRaidDebuff:DebuffId(zoneid, 272696, 1, 6, 6, true) --Lightning in a Bottle
	GridStatusRaidDebuff:DebuffId(zoneid, 267278, 1, 6, 6, true) --Electrocute
	GridStatusRaidDebuff:DebuffId(zoneid, 272654, 1, 6, 6, true) --Head Butt
	GridStatusRaidDebuff:DebuffId(zoneid, 268007, 1, 6, 6, true) --Heart Attack
	GridStatusRaidDebuff:DebuffId(zoneid, 272655, 1, 6, 6, true) --Scouring Sand
	GridStatusRaidDebuff:DebuffId(zoneid, 268993, 1, 6, 6, true) --Cheap Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 272658, 1, 6, 6, true) --Electrified Scales
	GridStatusRaidDebuff:DebuffId(zoneid, 263778, 1, 6, 6, true) --Gale Force
	GridStatusRaidDebuff:DebuffId(zoneid, 268008, 1, 6, 6, true) --Snake Charm
	GridStatusRaidDebuff:DebuffId(zoneid, 255595, 1, 6, 6, true) --Chomp
	GridStatusRaidDebuff:DebuffId(zoneid, 208086, 1, 6, 6, true) --Colossus Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 270686, 1, 6, 6, true) --Typhus
	GridStatusRaidDebuff:DebuffId(zoneid, 270017, 1, 6, 6, true) --Enforcing Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 273563, 1, 6, 6, true) --Neurotoxin

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Adderis and Aspix
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Adderis and Aspix")
	GridStatusRaidDebuff:DebuffId(zoneid, 263371, 11, 6, 6, true) --Conduction
	GridStatusRaidDebuff:DebuffId(zoneid, 263257, 12, 6, 6, true) --Static Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 263425, 13, 6, 6, true) --Arc Dash
	GridStatusRaidDebuff:DebuffId(zoneid, 263234, 14, 6, 6, true) --Arcing Blade
	--Merektha
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Merektha")
	GridStatusRaidDebuff:DebuffId(zoneid, 267027, 21, 6, 6, true) --Cytotoxin
	GridStatusRaidDebuff:DebuffId(zoneid, 263914, 22, 6, 6, true) --Blinding Sand
	GridStatusRaidDebuff:DebuffId(zoneid, 263958, 23, 6, 6, true) --A Knot of Snakes
	--Galvazzt
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Galvazzt")
	GridStatusRaidDebuff:DebuffId(zoneid, 265973, 31, 6, 6, true) --Galvanize
	GridStatusRaidDebuff:DebuffId(zoneid, 266511, 32, 6, 6, true) --Capacitance
	GridStatusRaidDebuff:DebuffId(zoneid, 266512, 33, 6, 6, true) --Consume Charge
	--Avatar of Sethraliss
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Avatar of Sethraliss")
	GridStatusRaidDebuff:DebuffId(zoneid, 269686, 41, 6, 6, true) --Plague
	GridStatusRaidDebuff:DebuffId(zoneid, 273677, 42, 6, 6, true) --Taint
end

-- BFA Dungeon
-- Siege of Boralus
do
	GridStatusRaidDebuff:DebuffId(zoneid, 272588, 1, 6, 6, true) --Rotting Wounds
	GridStatusRaidDebuff:DebuffId(zoneid, 257168, 1, 6, 6, true) --Cursed Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 257036, 1, 6, 6, true) --Feral Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 272140, 1, 6, 6, true) --Iron Volley
	GridStatusRaidDebuff:DebuffId(zoneid, 273930, 1, 6, 6, true) --Hindering Cut
	GridStatusRaidDebuff:DebuffId(zoneid, 272421, 1, 6, 6, true) --Sighted Artillery
	GridStatusRaidDebuff:DebuffId(zoneid, 272144, 1, 6, 6, true) --Cover
	GridStatusRaidDebuff:DebuffId(zoneid, 256663, 1, 6, 6, true) --Burning Tar
	GridStatusRaidDebuff:DebuffId(zoneid, 272834, 1, 6, 6, true) --Viscous Slobber
	GridStatusRaidDebuff:DebuffId(zoneid, 256866, 1, 6, 6, true) --Iron Ambush
	GridStatusRaidDebuff:DebuffId(zoneid, 272571, 1, 6, 6, true) --Choking Waters
	GridStatusRaidDebuff:DebuffId(zoneid, 272874, 1, 6, 6, true) --Trample
	GridStatusRaidDebuff:DebuffId(zoneid, 257169, 1, 6, 6, true) --Terrifying Roar
	GridStatusRaidDebuff:DebuffId(zoneid, 274942, 1, 6, 6, true) --Banana Rampage
	GridStatusRaidDebuff:DebuffId(zoneid, 256897, 1, 6, 6, true) --Clamping Jaws
	GridStatusRaidDebuff:DebuffId(zoneid, 257292, 1, 6, 6, true) --Heavy Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 257886, 1, 6, 6, true) --Brine Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 261428, 1, 6, 6, true) --Hangman's Noose
	GridStatusRaidDebuff:DebuffId(zoneid, 270624, 1, 6, 6, true) --Crushing Embrace
	GridStatusRaidDebuff:DebuffId(zoneid, 275836, 1, 6, 6, true) --Stinging Venom
	GridStatusRaidDebuff:DebuffId(zoneid, 257069, 1, 6, 6, true) --Watertight Shell

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Sergeant Bainbridge
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Sergeant Bainbridge")
	GridStatusRaidDebuff:DebuffId(zoneid, 273716, 11, 6, 6, true) --Heavy Ordnance
	GridStatusRaidDebuff:DebuffId(zoneid, 260954, 12, 6, 6, true) --Iron Gaze
	--Dread Captain Lockwood
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Dread Captain Lockwood")
	GridStatusRaidDebuff:DebuffId(zoneid, 273470, 21, 6, 6, true) --Gut Shot
	--Hadal Darkfathom
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Hadal Darkfathom")
	GridStatusRaidDebuff:DebuffId(zoneid, 257882, 31, 6, 6, true) --Break Water
	GridStatusRaidDebuff:DebuffId(zoneid, 276068, 32, 6, 6, true) --Tidal Surge
	--Viq'Goth
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Viq'Goth")
	GridStatusRaidDebuff:DebuffId(zoneid, 274991, 41, 6, 6, true) --Putrid Waters
end

-- BFA Dungeon
-- Shrine of the Storm
do
	GridStatusRaidDebuff:DebuffId(zoneid, 268317, 1, 6, 6, true) --Rip Mind
	GridStatusRaidDebuff:DebuffId(zoneid, 268322, 1, 6, 6, true) --Touch of the Drowned
	GridStatusRaidDebuff:DebuffId(zoneid, 268233, 1, 6, 6, true) --Electrifying Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 268273, 1, 6, 6, true) --Deep Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 267969, 1, 6, 6, true) --Water Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 267973, 1, 6, 6, true) --Wash Away
	GridStatusRaidDebuff:DebuffId(zoneid, 265001, 1, 6, 6, true) --Sea Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 274703, 1, 6, 6, true) --Void Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 224729, 1, 6, 6, true) --Bursting Shot
	GridStatusRaidDebuff:DebuffId(zoneid, 276286, 1, 6, 6, true) --Slicing Hurricane
	GridStatusRaidDebuff:DebuffId(zoneid, 269104, 1, 6, 6, true) --Explosive Void
	GridStatusRaidDebuff:DebuffId(zoneid, 274438, 1, 6, 6, true) --Tempest
	GridStatusRaidDebuff:DebuffId(zoneid, 277373, 1, 6, 6, true) --Massive Glaive
	GridStatusRaidDebuff:DebuffId(zoneid, 268028, 1, 6, 6, true) --Crushing Waters
	GridStatusRaidDebuff:DebuffId(zoneid, 268391, 1, 6, 6, true) --Mental Assault
	GridStatusRaidDebuff:DebuffId(zoneid, 268309, 1, 6, 6, true) --Unending Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 268280, 1, 6, 6, true) --Tidal Pod
	GridStatusRaidDebuff:DebuffId(zoneid, 267956, 1, 6, 6, true) --Zap
	GridStatusRaidDebuff:DebuffId(zoneid, 268315, 1, 6, 6, true) --Lash
	GridStatusRaidDebuff:DebuffId(zoneid, 274720, 1, 6, 6, true) --Abyssal Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 269419, 1, 6, 6, true) --Yawning Gate
	GridStatusRaidDebuff:DebuffId(zoneid, 268348, 1, 6, 6, true) --Colossal Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 268214, 1, 6, 6, true) --Carve Flesh
	GridStatusRaidDebuff:DebuffId(zoneid, 268059, 1, 6, 6, true) --Anchor of Binding
	GridStatusRaidDebuff:DebuffId(zoneid, 268027, 1, 6, 6, true) --Rising Tides
	GridStatusRaidDebuff:DebuffId(zoneid, 274633, 1, 6, 6, true) --Sundering Blow
	GridStatusRaidDebuff:DebuffId(zoneid, 267818, 1, 6, 6, true) --Slicing Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 274792, 1, 6, 6, true) --Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 265056, 1, 6, 6, true) --Invigorating Freehold Brew
	GridStatusRaidDebuff:DebuffId(zoneid, 264526, 1, 6, 6, true) --Grasp from the Depths
	GridStatusRaidDebuff:DebuffId(zoneid, 12054, 1, 6, 6, true) --Rend
	GridStatusRaidDebuff:DebuffId(zoneid, 276268, 1, 6, 6, true) --Heaving Blow
	GridStatusRaidDebuff:DebuffId(zoneid, 276297, 1, 6, 6, true) --Void Seed
	GridStatusRaidDebuff:DebuffId(zoneid, 274714, 1, 6, 6, true) --Twisting Void
	GridStatusRaidDebuff:DebuffId(zoneid, 259618, 1, 6, 6, true) --Gruesome Tear

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Aqu'sirr
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Aqu'sirr")
	GridStatusRaidDebuff:DebuffId(zoneid, 264560, 11, 6, 6, true) --Choking Brine
	GridStatusRaidDebuff:DebuffId(zoneid, 264155, 12, 6, 6, true) --Surging Rush
	GridStatusRaidDebuff:DebuffId(zoneid, 264166, 13, 6, 6, true) --Undertow
	--Tidesage Council
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Tidesage Council")
	GridStatusRaidDebuff:DebuffId(zoneid, 267905, 21, 6, 6, true) --Reinforcing Ward
	GridStatusRaidDebuff:DebuffId(zoneid, 267891, 22, 6, 6, true) --Swiftness Ward
	GridStatusRaidDebuff:DebuffId(zoneid, 267899, 23, 6, 6, true) --Hindering Cleave
	GridStatusRaidDebuff:DebuffId(zoneid, 267830, 24, 6, 6, true) --Blessing of the Tempest
	GridStatusRaidDebuff:DebuffId(zoneid, 267841, 25, 6, 6, true) --Blowback
	--Lord Stormsong
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Lord Stormsong")
	GridStatusRaidDebuff:DebuffId(zoneid, 269097, 31, 6, 6, true) --Waken the Void
	GridStatusRaidDebuff:DebuffId(zoneid, 269131, 32, 6, 6, true) --Ancient mindbender
	GridStatusRaidDebuff:DebuffId(zoneid, 268896, 33, 6, 6, true) --Mind Rend
	--Vol'zith the Whisperer
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Vol'zith the Whisperer")
	GridStatusRaidDebuff:DebuffId(zoneid, 267548, 41, 6, 6, true) --Leviathan's Wake
	GridStatusRaidDebuff:DebuffId(zoneid, 267360, 42, 6, 6, true) --Grasp of the Sunken City
	GridStatusRaidDebuff:DebuffId(zoneid, 267034, 43, 6, 6, true) --Whispers of Power
end

-- BFA Dungeon
-- Operation: Mechagon
do
	--trash
	GridStatusRaidDebuff:DebuffId(zoneid, 295170, 1, 6, 6, true) --Capacitor Discharge
	GridStatusRaidDebuff:DebuffId(zoneid, 299572, 1, 6, 6, true) --Shrink
	GridStatusRaidDebuff:DebuffId(zoneid, 297283, 1, 6, 6, true) --Cave In
	GridStatusRaidDebuff:DebuffId(zoneid, 294180, 1, 6, 6, true) --Flaming Refuse
	GridStatusRaidDebuff:DebuffId(zoneid, 299502, 1, 6, 6, true) --Nanoslicer
	GridStatusRaidDebuff:DebuffId(zoneid, 296560, 1, 6, 6, true) --Clinging Static
	GridStatusRaidDebuff:DebuffId(zoneid, 301712, 1, 6, 6, true) --Pounce
	GridStatusRaidDebuff:DebuffId(zoneid, 299475, 1, 6, 6, true) --B.O.R.K
	GridStatusRaidDebuff:DebuffId(zoneid, 299438, 1, 6, 6, true) --Sledgehammer
	GridStatusRaidDebuff:DebuffId(zoneid, 293986, 1, 6, 6, true) --Sonic Pulse
	GridStatusRaidDebuff:DebuffId(zoneid, 301299, 1, 6, 6, true) --Furnace Flames
	GridStatusRaidDebuff:DebuffId(zoneid, 300650, 1, 6, 6, true) --Suffocating Smog
	GridStatusRaidDebuff:DebuffId(zoneid, 293670, 1, 6, 6, true) --Chainblade
	GridStatusRaidDebuff:DebuffId(zoneid, 300659, 1, 6, 6, true) --Consuming Slime
	GridStatusRaidDebuff:DebuffId(zoneid, 300675, 1, 6, 6, true) --Toxic Fog
	GridStatusRaidDebuff:DebuffId(zoneid, 295130, 1, 6, 6, true) --Neutralize Threat
	GridStatusRaidDebuff:DebuffId(zoneid, 291974, 1, 6, 6, true) --Obnoxious Monologue
	GridStatusRaidDebuff:DebuffId(zoneid, 300436, 1, 6, 6, true) --Grasping Hex
	GridStatusRaidDebuff:DebuffId(zoneid, 300764, 1, 6, 6, true) --Slimebolt
	GridStatusRaidDebuff:DebuffId(zoneid, 297257, 1, 6, 6, true) --Electrical Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 293724, 1, 6, 6, true) --Shield Generator
	GridStatusRaidDebuff:DebuffId(zoneid, 294198, 1, 6, 6, true) --Stealthy Steam Vent
	GridStatusRaidDebuff:DebuffId(zoneid, 294195, 1, 6, 6, true) --Arcing Zap

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--King Gobbamak
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "King Gobbamak")

	--Gunker
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Gunker")
	GridStatusRaidDebuff:DebuffId(zoneid, 298259, 21, 5, 5, true) --Gooped

	--Trixie & Naeno
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Trixie & Naeno")
	GridStatusRaidDebuff:DebuffId(zoneid, 298669, 31, 5, 5, true) --Taze
	GridStatusRaidDebuff:DebuffId(zoneid, 302681, 32, 5, 5, true) --Mega Taze
	GridStatusRaidDebuff:DebuffId(zoneid, 298602, 33, 5, 5, true) --Smoke Cloud

	--HK-8 Aerial Oppression Unit
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "HK-8 Aerial Oppression Unit")
	GridStatusRaidDebuff:DebuffId(zoneid, 295445, 41, 5, 5, true) --Wreck
	GridStatusRaidDebuff:DebuffId(zoneid, 302274, 42, 5, 5, true) --Fulminating Zap
	GridStatusRaidDebuff:DebuffId(zoneid, 296150, 43, 5, 5, true) --Vent Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 296279, 44, 5, 5, true) --Anti-Trespassing Teleport

	--Tussle Tonks
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Tussle Tonks")
	GridStatusRaidDebuff:DebuffId(zoneid, 282943, 51, 5, 5, true) --Piston Smasher

	--K.U.-J.O.
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "K.U.-J.O.")
	GridStatusRaidDebuff:DebuffId(zoneid, 291972, 61, 5, 5, true) --Explosive Leap
	GridStatusRaidDebuff:DebuffId(zoneid, 294929, 62, 5, 5, true) --Blazing Chomp

	--Machinist's Garden
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Machinist's Garden")
	GridStatusRaidDebuff:DebuffId(zoneid, 285460, 71, 5, 5, true) --Discom-BOMB-ulator
	GridStatusRaidDebuff:DebuffId(zoneid, 285443, 72, 5, 5, true) --\"Hidden\" Flame Cannon

	--King Mechagon
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "King Mechagon")
	GridStatusRaidDebuff:DebuffId(zoneid, 291928, 81, 5, 5, true) --Giga-Zap
end

-- BFA Dungeon
-- Kings Rest
do
	GridStatusRaidDebuff:DebuffId(zoneid, 270931, 11, 6, 6, true) --Darkshot
	GridStatusRaidDebuff:DebuffId(zoneid, 267874, 11, 6, 6, true) --Burning Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 274387, 11, 6, 6, true) --Absorbed in Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 270507, 11, 6, 6, true) --Poison Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 269932, 11, 6, 6, true) --Gust Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 277340, 11, 6, 6, true) --Unleashed Power
	GridStatusRaidDebuff:DebuffId(zoneid, 270292, 11, 6, 6, true) --Purifying Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 267618, 11, 6, 6, true) --Drain Fluids
	GridStatusRaidDebuff:DebuffId(zoneid, 271564, 11, 6, 6, true) --Embalming Fluid
	GridStatusRaidDebuff:DebuffId(zoneid, 270499, 11, 6, 6, true) --Frost Shock
	GridStatusRaidDebuff:DebuffId(zoneid, 270865, 11, 6, 6, true) --Hidden Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 268796, 11, 6, 6, true) --Impaling Spear
	GridStatusRaidDebuff:DebuffId(zoneid, 266238, 11, 6, 6, true) --Shattered Defenses
	GridStatusRaidDebuff:DebuffId(zoneid, 267273, 11, 6, 6, true) --Poison Nova
	GridStatusRaidDebuff:DebuffId(zoneid, 270927, 11, 6, 6, true) --Bladestorm
	GridStatusRaidDebuff:DebuffId(zoneid, 270868, 11, 6, 6, true) --Lingering Poison
	GridStatusRaidDebuff:DebuffId(zoneid, 276031, 11, 6, 6, true) --Pit of Despair
	GridStatusRaidDebuff:DebuffId(zoneid, 266191, 11, 6, 6, true) --Whirling Axe
	GridStatusRaidDebuff:DebuffId(zoneid, 269369, 11, 6, 6, true) --Deathly Roar
	GridStatusRaidDebuff:DebuffId(zoneid, 267763, 11, 6, 6, true) --Wretched Discharge
	GridStatusRaidDebuff:DebuffId(zoneid, 270487, 11, 6, 6, true) --Severing Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 11, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 270492, 11, 6, 6, true) --Hex
	GridStatusRaidDebuff:DebuffId(zoneid, 272388, 11, 6, 6, true) --Shadow Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 270920, 11, 6, 6, true) --Seduction
	GridStatusRaidDebuff:DebuffId(zoneid, 270289, 11, 6, 6, true) --Purification Beam
	GridStatusRaidDebuff:DebuffId(zoneid, 270003, 11, 6, 6, true) --Suppression Slam
	GridStatusRaidDebuff:DebuffId(zoneid, 277225, 11, 6, 6, true) --Tormented Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 265914, 11, 6, 6, true) --Molten Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 115804, 11, 6, 6, true) --Mortal Wounds
	GridStatusRaidDebuff:DebuffId(zoneid, 270084, 11, 6, 6, true) --Axe Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 269936, 11, 6, 6, true) --Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 268419, 11, 6, 6, true) --Gale Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 271640, 11, 6, 6, true) --Dark Revelation
	GridStatusRaidDebuff:DebuffId(zoneid, 277469, 11, 6, 6, true) --Focused Fire

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--The Golden Serpent
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "The Golden Serpent")
	GridStatusRaidDebuff:DebuffId(zoneid, 265773, 11, 6, 6, true) --split gold
	--Mchimba the Embalmer
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Mchimba the Embalmer")
	GridStatusRaidDebuff:DebuffId(zoneid, 267626, 21, 6, 6, true) --Dessication
	GridStatusRaidDebuff:DebuffId(zoneid, 267702, 22, 6, 6, true) --Entomb
	GridStatusRaidDebuff:DebuffId(zoneid, 267764, 23, 6, 6, true) --Struggle
	--The Council of Tribes
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "The Council of Tribes")
	GridStatusRaidDebuff:DebuffId(zoneid, 266237, 31, 6, 6, true) --Debilitating Backhand
	GridStatusRaidDebuff:DebuffId(zoneid, 266231, 32, 6, 6, true) --Severing Axe
	GridStatusRaidDebuff:DebuffId(zoneid, 267257, 33, 6, 6, true) --Thundering Crash
	--Dazar, The First King
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Dazar, The First King")
	GridStatusRaidDebuff:DebuffId(zoneid, 268586, 41, 6, 6, true) --Blade Combo
	GridStatusRaidDebuff:DebuffId(zoneid, 268932, 42, 6, 6, true) --Quaking Leap
end

-- BFA Dungeon
-- Freehold
do
	GridStatusRaidDebuff:DebuffId(zoneid, 257460, 1, 6, 6, true) --Fiery Debris
	GridStatusRaidDebuff:DebuffId(zoneid, 272374, 1, 6, 6, true) --Whirlpool of Blades
	GridStatusRaidDebuff:DebuffId(zoneid, 276061, 1, 6, 6, true) --Boulder Throw
	GridStatusRaidDebuff:DebuffId(zoneid, 281420, 1, 6, 6, true) --Water Bolt
	GridStatusRaidDebuff:DebuffId(zoneid, 257274, 1, 6, 6, true) --Vile Coating
	GridStatusRaidDebuff:DebuffId(zoneid, 257437, 1, 6, 6, true) --Poisoning Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 257314, 1, 6, 6, true) --Black Powder Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 257478, 1, 6, 6, true) --Crippling Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 281329, 1, 6, 6, true) --Trade Wind's Vigor
	GridStatusRaidDebuff:DebuffId(zoneid, 274400, 1, 6, 6, true) --Duelist Dash
	GridStatusRaidDebuff:DebuffId(zoneid, 257308, 1, 6, 6, true) --Flaming Shrapnel
	GridStatusRaidDebuff:DebuffId(zoneid, 257871, 1, 6, 6, true) --Blade Barrage
	GridStatusRaidDebuff:DebuffId(zoneid, 257908, 1, 6, 6, true) --Oiled Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 256363, 1, 6, 6, true) --Ripper Punch
	GridStatusRaidDebuff:DebuffId(zoneid, 257949, 1, 6, 6, true) --Slippery
	GridStatusRaidDebuff:DebuffId(zoneid, 274507, 1, 6, 6, true) --Slippery Suds
	GridStatusRaidDebuff:DebuffId(zoneid, 258875, 1, 6, 6, true) --Blackout Barrel
	GridStatusRaidDebuff:DebuffId(zoneid, 268440, 1, 6, 6, true) --Shoot
	GridStatusRaidDebuff:DebuffId(zoneid, 256594, 1, 6, 6, true) --Barrel Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 257775, 1, 6, 6, true) --Plague Step
	GridStatusRaidDebuff:DebuffId(zoneid, 258199, 1, 6, 6, true) --Ground Shatter
	GridStatusRaidDebuff:DebuffId(zoneid, 257739, 1, 6, 6, true) --Blind Rage
	GridStatusRaidDebuff:DebuffId(zoneid, 257747, 1, 6, 6, true) --Earth Shaker
	GridStatusRaidDebuff:DebuffId(zoneid, 257784, 1, 6, 6, true) --Frost Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 257732, 1, 6, 6, true) --Shattering Bellow
	GridStatusRaidDebuff:DebuffId(zoneid, 258352, 1, 6, 6, true) --Grapeshot
	GridStatusRaidDebuff:DebuffId(zoneid, 258323, 1, 6, 6, true) --Infected Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 257426, 1, 6, 6, true) --Brutal Backhand
	GridStatusRaidDebuff:DebuffId(zoneid, 257757, 1, 6, 6, true) --Goin' Bananas
	GridStatusRaidDebuff:DebuffId(zoneid, 267523, 1, 6, 6, true) --Cutting Surge
	GridStatusRaidDebuff:DebuffId(zoneid, 274389, 1, 6, 6, true) --Rat Traps
	GridStatusRaidDebuff:DebuffId(zoneid, 258779, 1, 6, 6, true) --Sea Spout
	GridStatusRaidDebuff:DebuffId(zoneid, 265056, 1, 6, 6, true) --Invigorating Freehold Brew
	GridStatusRaidDebuff:DebuffId(zoneid, 272197, 1, 6, 6, true) --Shadow Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 265799, 1, 6, 6, true) --Electrical Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 265085, 1, 6, 6, true) --Confidence-Boosting Freehold Brew
	GridStatusRaidDebuff:DebuffId(zoneid, 113746, 1, 6, 6, true) --Mystic Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 268283, 1, 6, 6, true) --Obscured Vision
	GridStatusRaidDebuff:DebuffId(zoneid, 272554, 1, 6, 6, true) --Bloody Mess
	GridStatusRaidDebuff:DebuffId(zoneid, 265681, 1, 6, 6, true) --Drowning Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 278467, 1, 6, 6, true) --Caustic Freehold Brew
	GridStatusRaidDebuff:DebuffId(zoneid, 274555, 1, 6, 6, true) --Scabrous Bite
	GridStatusRaidDebuff:DebuffId(zoneid, 34914, 1, 6, 6, true) --Vampiric Touch
	GridStatusRaidDebuff:DebuffId(zoneid, 224729, 1, 6, 6, true) --Bursting Shot

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Skycap'n Kragg
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Skycap'n Kragg")
	GridStatusRaidDebuff:DebuffId(zoneid, 256106, 11, 6, 6, true) --Azerite Powder Shot
	--Council o'Captains
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Council o'Captains")
	GridStatusRaidDebuff:DebuffId(zoneid, 265979, 21, 6, 6, true) --Powder Shot
	--Ring of Booty
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Ring of Booty")
	GridStatusRaidDebuff:DebuffId(zoneid, 256706, 31, 6, 6, true) --Rearm
	GridStatusRaidDebuff:DebuffId(zoneid, 256552, 32, 6, 6, true) --Flailing Shark
	--Harlan Sweete
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Harlan Sweete")
	GridStatusRaidDebuff:DebuffId(zoneid, 257305, 42, 6, 6, true) --Cannon Barrage
end

-- BFA Dungeon
-- Atal'Dazar
do
	GridStatusRaidDebuff:DebuffId(zoneid, 254959, 1, 6, 6, true) --Soulburn
	GridStatusRaidDebuff:DebuffId(zoneid, 250372, 1, 6, 6, true) --Lingering Nausea
	GridStatusRaidDebuff:DebuffId(zoneid, 250096, 1, 6, 6, true) --Wracking Pain
	GridStatusRaidDebuff:DebuffId(zoneid, 250036, 1, 6, 6, true) --Shadowy Remains
	GridStatusRaidDebuff:DebuffId(zoneid, 257692, 1, 6, 6, true) --Tiki Blaze
	GridStatusRaidDebuff:DebuffId(zoneid, 257483, 1, 6, 6, true) --Pile of Bones
	GridStatusRaidDebuff:DebuffId(zoneid, 249919, 1, 6, 6, true) --Skewer
	GridStatusRaidDebuff:DebuffId(zoneid, 253562, 1, 6, 6, true) --Wildfire
	GridStatusRaidDebuff:DebuffId(zoneid, 253279, 1, 6, 6, true) --Merciless Assault
	GridStatusRaidDebuff:DebuffId(zoneid, 272631, 1, 6, 6, true) --Battering Maul
	GridStatusRaidDebuff:DebuffId(zoneid, 256138, 1, 6, 6, true) --Fervent Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 255581, 1, 6, 6, true) --Gilded Claws
	GridStatusRaidDebuff:DebuffId(zoneid, 279118, 1, 6, 6, true) --Unstable Hex
	GridStatusRaidDebuff:DebuffId(zoneid, 273185, 1, 6, 6, true) --Shield Bash
	GridStatusRaidDebuff:DebuffId(zoneid, 255620, 1, 6, 6, true) --Festering Eruption
	GridStatusRaidDebuff:DebuffId(zoneid, 251187, 1, 6, 6, true) --Leaping Thrash
	GridStatusRaidDebuff:DebuffId(zoneid, 255895, 1, 6, 6, true) --Poisoned Claws
	GridStatusRaidDebuff:DebuffId(zoneid, 256959, 1, 6, 6, true) --Rotting Decay
	GridStatusRaidDebuff:DebuffId(zoneid, 252923, 1, 6, 6, true) --Venom Blast
	GridStatusRaidDebuff:DebuffId(zoneid, 252687, 1, 6, 6, true) --Venomfang Strike
	GridStatusRaidDebuff:DebuffId(zoneid, 252666, 1, 6, 6, true) --Venom-Tipped Blade
	GridStatusRaidDebuff:DebuffId(zoneid, 255041, 1, 6, 6, true) --Terrifying Screech
	GridStatusRaidDebuff:DebuffId(zoneid, 256577, 1, 6, 6, true) --Soulfeast
	GridStatusRaidDebuff:DebuffId(zoneid, 252692, 1, 6, 6, true) --Waylaying Jab
	GridStatusRaidDebuff:DebuffId(zoneid, 255567, 1, 6, 6, true) --Frenzied Charge
	GridStatusRaidDebuff:DebuffId(zoneid, 277072, 1, 6, 6, true) --Corrupted Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 258986, 1, 6, 6, true) --Stink Bomb
	GridStatusRaidDebuff:DebuffId(zoneid, 196189, 1, 6, 6, true) --Bloody Talons
	GridStatusRaidDebuff:DebuffId(zoneid, 255814, 1, 6, 6, true) --Rending Maul
	GridStatusRaidDebuff:DebuffId(zoneid, 259130, 1, 6, 6, true) --Tiki Flame
	GridStatusRaidDebuff:DebuffId(zoneid, 255842, 1, 6, 6, true) --Blood-Tainted Cauldron of Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 258723, 1, 6, 6, true) --Grotesque Pool

	--M+
	GridStatusRaidDebuff:DebuffId(zoneid, 240447, 1, 6, 6, true) --Quake
	GridStatusRaidDebuff:DebuffId(zoneid, 240559, 1, 6, 6, true, true) --Grievous Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 209858, 1, 6, 6, true, true) --Necrotic Wound
	GridStatusRaidDebuff:DebuffId(zoneid, 240443, 1, 6, 6, true, true) --Burst
	GridStatusRaidDebuff:DebuffId(zoneid, 288694, 1, 6, 6, true, true) --Shadow Smash
	GridStatusRaidDebuff:DebuffId(zoneid, 226512, 1, 6, 6, true) --Sanguine Ichor
	GridStatusRaidDebuff:DebuffId(zoneid, 288388, 1, 6, 6, true, true) --Reap Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 290085, 1, 6, 6, true) --Expel Soul

	--Priestess Alun'az
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Priestess Alun'az")
	GridStatusRaidDebuff:DebuffId(zoneid, 255582, 11, 6, 6, true) --Molten Gold
	GridStatusRaidDebuff:DebuffId(zoneid, 255558, 12, 6, 6, true) --Tainted Blood
	GridStatusRaidDebuff:DebuffId(zoneid, 255577, 13, 6, 6, true) --Transfusion
	--Val'Kaal
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Val'Kaal")
	GridStatusRaidDebuff:DebuffId(zoneid, 250258, 21, 6, 6, true) --Toxic Leap
	GridStatusRaidDebuff:DebuffId(zoneid, 250585, 22, 6, 6, true) --Toxic Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 250368, 23, 6, 6, true) --Noxious Stench
	--Rezan
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Rezan")
	GridStatusRaidDebuff:DebuffId(zoneid, 255434, 31, 6, 6, true) --Serrated Teeth
	GridStatusRaidDebuff:DebuffId(zoneid, 255421, 32, 6, 6, true) --Devour
	GridStatusRaidDebuff:DebuffId(zoneid, 255371, 33, 6, 6, true) --Terrifying Visage
	GridStatusRaidDebuff:DebuffId(zoneid, 257407, 34, 6, 6, true) --Pursuit
	GridStatusRaidDebuff:DebuffId(zoneid, 255365, 35, 6, 6, true) --Ancient Dry Bones
	--Yazma
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Yazma")
	GridStatusRaidDebuff:DebuffId(zoneid, 250050, 41, 6, 6, true) --Echoes of Shadra
	GridStatusRaidDebuff:DebuffId(zoneid, 249924, 42, 6, 6, true) --Soulrend
end
