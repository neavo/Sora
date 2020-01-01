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

-- WoD Raid
-- Blackrock Foundry
do
	-- Trash

	-- Slagworks/Black Forge trash
	-- Orgron Hauler
	GridStatusRaidDebuff:DebuffId(zoneid, 175752, 1, 3, 3, true) -- Slag Breath (frontal cone debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 175765, 1, 4, 4, true) -- Overhead Smash (tank debuff)
	-- Workshop Guardian
	GridStatusRaidDebuff:DebuffId(zoneid, 175624, 1, 5, 5, false, true) -- Grievous Mortal Wounds (stacking healing debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 175643, 1, 4, 4) -- Spinning Blade (dot, standing in)
	-- Iron Flame Binder
	-- Iron Slag-Shaper
	GridStatusRaidDebuff:DebuffId(zoneid, 175603, 1, 4, 4, true) -- Gripping Slag (AoE dot, root)
	-- Ironworker
	GridStatusRaidDebuff:DebuffId(zoneid, 175668, 1, 3, 3, true) -- Hammer Throw (dam increase)
	-- Slagshop Brute
	-- Slagshop Worker
	GridStatusRaidDebuff:DebuffId(zoneid, 175987, 1, 3, 3, true, true) -- Puncture Wound (stacking dot)

	-- Oregorger trash (Depository)
	-- Darkshard Acidback
	GridStatusRaidDebuff:DebuffId(zoneid, 159686, 1, 4, 4) -- Acidback Puddle (dot, standing in)
	-- Darkshard Gnasher
	GridStatusRaidDebuff:DebuffId(zoneid, 159632, 1, 5, 5, true) -- Insatiable Hunger (fixate)
	GridStatusRaidDebuff:DebuffId(zoneid, 159520, 1, 2, 2, true) -- Shattering Charge (stun)
	-- Darkshard Crystalback
	GridStatusRaidDebuff:DebuffId(zoneid, 159939, 1, 3, 3, true, true) -- Acidmaw (stacking debuff)

	-- Hans'gar and Franzok trash (Slagmill Press)
	-- Blackrock Enforcer
	GridStatusRaidDebuff:DebuffId(zoneid, 160260, 1, 4, 4) -- Fire Bomb (dot, standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 160109, 1, 1, 1, true) -- Intimidation (damage reduction)
	-- Blackrock Forge Specialist

	-- Beastlord Darmac trash (Breaking Grounds)
	-- Iron Assembly Warden
	GridStatusRaidDebuff:DebuffId(zoneid, 162516, 1, 4, 4, true) -- Whirling Steel (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 162508, 1, 2, 2, true) -- Shield Slam (stun)
	-- Iron Marksman
	GridStatusRaidDebuff:DebuffId(zoneid, 162748, 1, 2, 2, true) -- Scatter Shot (disorient)
	GridStatusRaidDebuff:DebuffId(zoneid, 162757, 1, 1, 1, true) -- Ice Trap (attack speed/movement debuff)
	-- Thunderlord Beast-Tender
	GridStatusRaidDebuff:DebuffId(zoneid, 162663, 1, 4, 4) -- Electrical Storm (dot, standing in)
	-- Ornery Ironhoof
	GridStatusRaidDebuff:DebuffId(zoneid, 162672, 1, 4, 4, true) -- Goring Swipe (dot)
	-- Stubborn Ironhoof
	-- Markog Aba'dir

	-- Gruul trash
	-- Gronnling Labroer
	-- Iron Journeyman
	-- Karnor the Cruel (mini-boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 188189, 1, 6, 6, true) -- Fel Poison (dot, dispellable)

	-- Burning Font trash
	-- Enchanted Armament
	-- Iron Flametwister
	-- Iron Journeyman (duplicate)
	-- Iron Taskmaster
	GridStatusRaidDebuff:DebuffId(zoneid, 163126, 1, 6, 6, true) -- Bonk (tank disorient)
	-- Iron Smith

	-- Flamebender Ka'graz trash
	-- Mol'dana Two-Blade (mini-boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 177855, 1, 4, 4, true) -- Ember in the Wind (AoE dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 177891, 1, 2, 2, true, true) -- Rising Flame Kick (tank dot)

	-- Operator Thogar trash
	-- same trash as during the boss fight, trash is listed under the boss
	-- Exhaust vent
	GridStatusRaidDebuff:DebuffId(zoneid, 174773, 1, 6, 6) -- Exhaust Fumes (dot, standing on)

	-- The Blast Furnace trash
	-- Slag Behemoth
	GridStatusRaidDebuff:DebuffId(zoneid, 156345, 1, 6, 6, true) -- Ignite (player explodes)

	-- Kromog trash
	-- just one pack of Burning Font trash between Flamebender and Kromog

	-- The Iron Maidens trash
	-- Aquatic Technician
	-- Iron Dockworker
	-- Iron Earthbinder
	-- Iron Mauler
	-- Iron Cleaver
	GridStatusRaidDebuff:DebuffId(zoneid, 171537, 1, 4, 4, true) -- Reaping Whirl (dot)

	-- Blackhand trash
	-- Flame Jets
	GridStatusRaidDebuff:DebuffId(zoneid, 175577, 1, 4, 4) -- Flame Jets (dot, standing in)
	-- Forgemistress Flamehand
	-- Burning is duplicate to Operator Thogar ability
	GridStatusRaidDebuff:DebuffId(zoneid, 175583, 1, 5, 5, true) -- Living Blaze (AoE dot, dam nearby players)

	-- Unknown trash
	-- Fungal Spores (debuff that is a buff?)
	GridStatusRaidDebuff:DebuffId(zoneid, 174704, 1, 1, 1, true, false, 0, true) -- Fungal Spores (disabled)

	-- GridStatusRaidDebuff versions over 6.11 can handle displaying this debuff
	GridStatusRaidDebuff:DebuffId(zoneid, 163714, 1, 1, 1, true) -- Exhaustion (root)

	-- Bosses

	-- Oregorger
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Oregorger")
	GridStatusRaidDebuff:DebuffId(zoneid, 173471, 11, 5, 5, true) -- Acid Maw (dot, nondispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 156297, 12, 6, 6, true) -- Acid Torrent (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 156374, 13, 2, 2, true) -- Explosive Shard (stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 155900, 14, 2, 2, true) -- Rolling Fury (knocked down)
	-- Retched Blackrock
	GridStatusRaidDebuff:DebuffId(zoneid, 156203, 15, 5, 5) -- Retched Blackrock (standing in pool?)

	-- Hans'gar and Franzok
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Hans'gar and Franzok")
	-- both have these abilities
	GridStatusRaidDebuff:DebuffId(zoneid, 157853, 21, 2, 2, true) -- Aftershock (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 156938, 22, 6, 6) -- Crippling Suplex (picked up)
	GridStatusRaidDebuff:DebuffId(zoneid, 157139, 23, 6, 6, true) -- Shattered Vertebrae (increase dam)
	-- Searing Plates
	GridStatusRaidDebuff:DebuffId(zoneid, 161570, 24, 5, 5) -- Searing Plates (standing on)
	-- Grill
	GridStatusRaidDebuff:DebuffId(zoneid, 155818, 24, 5, 5) -- Scorching Burns (standing on)

	-- Beastlord Darmac
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Beastlord Darmac")
	-- Phase 1
	GridStatusRaidDebuff:DebuffId(zoneid, 154960, 31, 6, 6) -- Pinned Down (stun, dot)
	-- Cruelfang
	GridStatusRaidDebuff:DebuffId(zoneid, 155061, 32, 4, 4, true, true) -- Rend and Tear (dot, increase dam, stacks)
	-- Dreadwing
	GridStatusRaidDebuff:DebuffId(zoneid, 154989, 33, 5, 5, true) -- Inferno Breath (dot, dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 154981, 34, 6, 6, true) -- Conflagration (AoE dot, dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 155030, 35, 4, 4, true, true) -- Seared Flesh (tank dot, stacks)
	-- Ironcrusher
	GridStatusRaidDebuff:DebuffId(zoneid, 155236, 36, 4, 4, true, true) -- Crush Armor (tank stacking debuff)
	-- Phase 3
	GridStatusRaidDebuff:DebuffId(zoneid, 155499, 37, 5, 5, true) -- Superheated Shrapnel (dot, dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 155657, 38, 6, 6) -- Flame Infusion (standing in fire)
	-- Mythic
	-- Faultline
	GridStatusRaidDebuff:DebuffId(zoneid, 159044, 39, 2, 2, true) -- Epicenter (standing in, movement debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 162276, 40, 1, 1, true) -- Unsteady
	-- GridStatusRaidDebuff:DebuffId(zoneid, 155222, 41, 6, 6) --TANTRUM (not a debuff)

	-- Gruul
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Gruul")
	GridStatusRaidDebuff:DebuffId(zoneid, 155080, 51, 3, 3, true) -- Inferno Slice (dot, nondispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 162322, 52, 2, 2, true, true) -- Inferno Strike (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 155078, 53, 4, 4, true, true) -- Overwhelming Blows (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 173192, 54, 6, 6) -- Cave In
	GridStatusRaidDebuff:DebuffId(zoneid, 155323, 55, 5, 5) -- Petrifying Slam (knockback flying)
	GridStatusRaidDebuff:DebuffId(zoneid, 155330, 56, 5, 5, true, true) -- Petrify (movement, petrify)
	GridStatusRaidDebuff:DebuffId(zoneid, 155506, 57, 5, 5, true) -- Petrified
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 165298, 58, 4, 4, true) -- Flare (debuff, nondispellable)

	-- Flamebender Ka'graz
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Flamebender Ka'graz")
	GridStatusRaidDebuff:DebuffId(zoneid, 155277, 61, 5, 5, true) -- Blazing Radiance (AoE dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 163284, 62, 4, 4, true, true) -- Rising Flames (tank dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 154932, 63, 6, 6, true) -- Molten Torrent (split damage)
	-- Lava Slash
	GridStatusRaidDebuff:DebuffId(zoneid, 155314, 64, 3, 3) -- Lava Slash (standing in, not high damage)
	-- Cinder Wolf
	GridStatusRaidDebuff:DebuffId(zoneid, 154952, 65, 5, 5, true) -- Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 155074, 66, 3, 3, true, true) -- Charring Breath (stacking debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 155049, 67, 4, 4, true, true) -- Singe (dot, dispellable)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 162293, 68, 5, 5) --EMPOWEREDARMAMENT -- not a debuff
	-- GridStatusRaidDebuff:DebuffId(zoneid, 155493, 68, 5, 5) --FIRESTORM -- not a debuff
	-- GridStatusRaidDebuff:DebuffId(zoneid, 163633, 68, 5, 5) --MAGMAMONSOON -- not a debuff

	-- Operator Thogar
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Operator Thogar")
	GridStatusRaidDebuff:DebuffId(zoneid, 155921, 71, 3, 3, true, true) -- Enkindle (stacking tank dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 165195, 72, 6, 6) -- Prototype Pulse Grenade (standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 164380, 73, 5, 5, true, true) -- Burning (stacking dot, dispellable)
	-- Iron Raider
	GridStatusRaidDebuff:DebuffId(zoneid, 155701, 74, 2, 2, true) -- Serrated Slash (dot)
	-- Grom'kar Firemender
	GridStatusRaidDebuff:DebuffId(zoneid, 156310, 75, 4, 4) -- Lava Shock (dot, dispellable)
	-- Cauterizing Bolt is an offensive dispel
	-- Iron Gunnery Sergeants
	GridStatusRaidDebuff:DebuffId(zoneid, 159481, 76, 6, 6, true) -- Delayed Siege Bomb (targetted)
	-- Iron Crack-Shots
	-- Grom'kar Men-at-Arms

	-- The Blast Furnace
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "The Blast Furnace")
	-- Heart of the Mountain
	GridStatusRaidDebuff:DebuffId(zoneid, 155240, 81, 3, 3, false, true) -- Tempered (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 155242, 82, 4, 4, true, true) -- Heat (stacking tank dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 155225, 83, 5, 5, true) -- Melt (create void zone)
	-- Furnace Engineer
	GridStatusRaidDebuff:DebuffId(zoneid, 155192, 84, 5, 5, true) -- Bomb (carrying the bomb)
	-- Foreman Feldspar
	GridStatusRaidDebuff:DebuffId(zoneid, 156934, 85, 6, 6, true) -- Rupture (create void zone)
	GridStatusRaidDebuff:DebuffId(zoneid, 158246, 86, 1, 1) -- Hot Blooded (dot from being near)
	-- Firecaller
	GridStatusRaidDebuff:DebuffId(zoneid, 176121, 87, 4, 4, true) -- Volatile Fire (player explodes)
	-- Slag Elemental
	GridStatusRaidDebuff:DebuffId(zoneid, 155196, 88, 4, 4) -- Fixate
	-- Slag Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 155743, 89, 6, 6) -- Slag Pool (standing in)
	-- Unknown
	GridStatusRaidDebuff:DebuffId(zoneid, 175104, 90, 6, 6) -- Melt Armor (is this for this boss?)
	-- Bellows Operator
	-- Security Guard
	-- Primal Elementalist

	-- Kromog
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Kromog")
	GridStatusRaidDebuff:DebuffId(zoneid, 157059, 101, 2, 2) -- Rune of Grasping Earth (dot until killed)
	GridStatusRaidDebuff:DebuffId(zoneid, 156766, 102, 4, 4, true, true) -- Warped Armor (stacking tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 161839, 103, 3, 3, true) -- Rune of Crushing Earth (stun, non-dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 156844, 104, 6, 6, true) -- Stone Breath (dot, no one in melee)

	-- The Iron Maidens
	GridStatusRaidDebuff:BossNameId(zoneid, 110, "The Iron Maidens")
	-- Admiral Gar'an
	GridStatusRaidDebuff:DebuffId(zoneid, 164271, 111, 6, 6, true) -- Penetraing Shot (target, damage split)
	GridStatusRaidDebuff:DebuffId(zoneid, 156631, 112, 4, 4, true) -- Rapid Fire (target, damage)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 159585, 120, 5, 5) --DEPLOYTURRET - not a debuff
	-- Enforcer Sorka
	GridStatusRaidDebuff:DebuffId(zoneid, 158315, 113, 5, 5) -- Dark Hunt (target, teleport to)
	GridStatusRaidDebuff:DebuffId(zoneid, 170395, 114, 2, 2) -- Sorka's Prey (dam increase)
	-- Marak the Blooded
	GridStatusRaidDebuff:DebuffId(zoneid, 159724, 115, 6, 6, true) -- Blood Ritual (target, cone dam)
	GridStatusRaidDebuff:DebuffId(zoneid, 170405, 116, 2, 2) -- Marak's  Bloodcalling (dam increase)
	GridStatusRaidDebuff:DebuffId(zoneid, 158010, 117, 5, 5, true) -- Bloodsoaked Heartseeker (target, bounce damage)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 156601, 113, 6, 6) --SANGUINESTRIKES -- not a debuff
	-- Gorak
	GridStatusRaidDebuff:DebuffId(zoneid, 158692, 118, 1, 1, true) -- Deadly Throw (movement)
	-- Iron Eviscerator
	GridStatusRaidDebuff:DebuffId(zoneid, 158702, 119, 5, 5, true) -- Fixate
	GridStatusRaidDebuff:DebuffId(zoneid, 158686, 120, 3, 3, true) -- Expose Armor (dam increase)
	-- Uk'urogg
	GridStatusRaidDebuff:DebuffId(zoneid, 158683, 121, 6, 6) -- Corrupted Blood (standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 156214, 122, 5, 5, false, true) -- Convulsive Shadows (dot dispellable, dam per stack dispelled)
	-- Dominator Turret
	GridStatusRaidDebuff:DebuffId(zoneid, 158601, 123, 3, 3, true, true) -- Dominator Blast (stacking dot, non-dispellable)
	-- Mythic
	-- Swirling Vortex
	GridStatusRaidDebuff:DebuffId(zoneid, 160436, 124, 1, 1, true) -- Swirling Vortex (stun)

	-- Blackhand
	GridStatusRaidDebuff:BossNameId(zoneid, 130, "Blackhand")
	GridStatusRaidDebuff:DebuffId(zoneid, 156096, 131, 6, 6, true) -- Marked for Death (targetted by Impaling Throw)
	GridStatusRaidDebuff:DebuffId(zoneid, 156743, 132, 4, 4, true, true) -- Impaled (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 156047, 133, 2, 2, true) -- Slagged (dam increase)
	GridStatusRaidDebuff:DebuffId(zoneid, 156401, 134, 4, 4, true, true) -- Molten Slag (dot, nondispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 156404, 135, 3, 3, true, true) -- Burned (stacking debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 158054, 136, 5, 5) -- Massive Shattering Smash (tank dot, dam split)
	GridStatusRaidDebuff:DebuffId(zoneid, 157354, 137, 2, 2, true) -- Broken Bones (tank stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 156888, 138, 1, 1) -- Overheated (phase 3)
	GridStatusRaidDebuff:DebuffId(zoneid, 157000, 139, 5, 5, true) -- Attach Slag Bombs (player explodes)
	GridStatusRaidDebuff:DebuffId(zoneid, 156999, 140, 5, 5, true) -- Throw Slag Bombs (player explodes)
	-- Siegemaker
	GridStatusRaidDebuff:DebuffId(zoneid, 156653, 141, 6, 6, true) -- Fixate
	-- Blaze (from Siegemaker)
	GridStatusRaidDebuff:DebuffId(zoneid, 162490, 142, 5, 5) -- Blaze (standing in)
	GridStatusRaidDebuff:DebuffId(zoneid, 156604, 143, 3, 3, true) -- Burning (dot from Blaze)
	-- Iron Sentry
	GridStatusRaidDebuff:DebuffId(zoneid, 156772, 144, 3, 3, true, true) -- Incendiary Shot (stacking debuff)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 162498, 145, 6, 6, true, true) -- Burning Cinders (stacking dot, dispellable)
end

-- WoD Raid
-- Hellfire Citadel
do
	--Trash

	-- Hellfire Assault trash
	-- Gorebound Felcaster
	-- Gorebound Terror
	-- Hulking Berserker is listed under Hellfire Assault
	-- Contracted Engineer
	GridStatusRaidDebuff:DebuffId(zoneid, 185806, 1, 5, 5, true) -- Conducted Shock Pulse (stun, dispellable)
	-- Iron Dragoon
	-- Felfire Flamebelcher
	-- Felfire Demolisher
	-- Gorebound Fanatic
	-- Gorebound Cauterizer
	-- Felfire Brazier
	GridStatusRaidDebuff:DebuffId(zoneid, 187459, 1, 4, 4, true) -- Fel Shock (dot, dispellable)
	-- Gorebound Corruptor - same abilities as Grand Corruptor U'rogg
	-- Siegeworks Technician

	-- Grand Corruptor U'rogg (mini-boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 190735, 1, 6, 6, true) -- Corruption Siphon

	-- Grute (mini-boss) - same abilities as Hulking Berserker

	-- Iron Reaver - no trash

	-- Kormrok trash
	-- Hellfire Guardian
	-- Fel Hellweaver
	GridStatusRaidDebuff:DebuffId(zoneid, 188087, 1, 6, 6) -- Hellweaving (dot, dispellable)
	-- Fel Touched Seer
	GridStatusRaidDebuff:DebuffId(zoneid, 188216, 1, 5, 5, true) -- Blaze (dot)
	-- Shambling Hulk
	-- Iron Peon
	-- Gorebound Assassin
	GridStatusRaidDebuff:DebuffId(zoneid, 188148, 1, 1, 1, true) -- Cheap Shot (stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 188189, 1, 4, 4, true) -- Fel Poison (dot, dispellable)
	-- Fel Extractor
	GridStatusRaidDebuff:DebuffId(zoneid, 187122, 1, 5, 5, true) -- Primal Energies (AoE dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 188482, 1, 3, 3, true) -- Fel Infection (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 188484, 1, 1, 1, true) -- Fel Sickness (prevents passing Fel Infection)

	-- Shadow Infuser

	-- Insanity is also the name of the debuff from hunter pet's Ancient Hysteria
	-- This causes that Insanity to show up with GridSTatusRaidDebuff prior to r33 (6.22)
	-- GridStatusRaidDebuff versions over 6.22 can handle displaying this debuff
	GridStatusRaidDebuff:DebuffId(zoneid, 188541, 1, 6, 6, true) -- Insanity (mind control)

	GridStatusRaidDebuff:DebuffId(zoneid, 187099, 1, 5, 5) -- Residual Shadows (standing in puddle)
	-- Shadow Infuser also does Fel Infection/Sickness
	-- Fiery Enkindler
	GridStatusRaidDebuff:DebuffId(zoneid, 187110, 1, 6, 6, true) -- Focused Fire (dot, heavy damage split by nearby)
	GridStatusRaidDebuff:DebuffId(zoneid, 188474, 1, 6, 6, true) -- Living Bomb (player explodes)
	-- Fiery Enkindler also does Fel Infection/Sickness
	-- Keen-Eyed Gronnstalker
	-- Armored Skullsmasher
	-- Grim Ambusher
	GridStatusRaidDebuff:DebuffId(zoneid, 188282, 1, 1, 1, true) -- Ambush (stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 188287, 1, 2, 2, true) -- Rupture (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 188283, 1, 2, 2, true) -- Hemorrhage (dot)
	-- Togdrov -- some of Kormrok's abilities
	-- Sovokk -- some of Kormrok's abilities
	-- Morkronn -- some of Kormrok's abilities, plus
	GridStatusRaidDebuff:DebuffId(zoneid, 188104, 1, 6, 6, true) -- Explosive Burst (tank root, explosion)

	-- Court of Blood Trash (Hellfire High Council, Kilrogg)
	-- Hellfire High Council trash
	-- (shares some trash mobs with Kormrok)
	-- Fel-Starved Trainee

	-- Graggra (mini-boss, skipable)
	GridStatusRaidDebuff:DebuffId(zoneid, 188476, 1, 4, 4, true, true) -- Bad Breath (tank swap debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 188448, 1, 2, 2, true) -- Blazing Fel Touch (all players explode)
	GridStatusRaidDebuff:DebuffId(zoneid, 188510, 1, 5, 5, true) -- Graggra Smash (stun, AoE on player)

	-- Kilrogg trash
	-- Salivating Bloodthirster (become Hulking Terrors)
	-- Hulking Terror (listed under Kilrogg)
	-- Bleeding Grunt
	-- Bleeding Darkcaster
	GridStatusRaidDebuff:DebuffId(zoneid, 182644, 1, 6, 6, true) -- Dark Fate (root, damage split)

	-- Halls of the Sargerei trash (Socrethar and Tyrant)
	-- Eredar Faithbreaker
	GridStatusRaidDebuff:DebuffId(zoneid, 184587, 1, 5, 5) -- Touch of Mortality

	-- Hellfire Antechamber trash
	-- Gorefiend trash (Maw of Souls)
	-- Gorebound Berserker
	GridStatusRaidDebuff:DebuffId(zoneid, 184300, 1, 2, 2, true) -- Fel Blaze (dot)
	-- Gorebound Brute
	-- Fel Fury is listed under Enraged Spirit for Gorefiend, same spell id
	-- Gorebound Bloodletter
	GridStatusRaidDebuff:DebuffId(zoneid, 184102, 1, 2, 2, true, true) -- Corrupted Blood (dot, stacks, dispellable but jumps)
	-- Gorebound Crone (mini-boss)

	-- Grommash's Torment trash (Shadow-Lord Iskar and Fel Lord Zakuun)
	-- Delusional Zealot
	GridStatusRaidDebuff:DebuffId(zoneid, 186046, 1, 5, 5, true) -- Solar Chakram (disorient, dispellable)
	-- Fel Raven (listed under Iskar)
	-- Corrupted Talonpriest (listed under Iskar)
	-- Shadowfel Warden

	-- Fel Lord Zakuun trash
	-- Dag'gorath (mini-boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 186197, 1, 5, 5) -- Demonic Sacrifice (stun, dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 186384, 1, 2, 2) -- Noxious Cloud (smoke bomb, dot)
	-- Dark Devourer
	-- Shadow Burster
	-- Mek'barash (mini-boss)
	-- Fel Scorcher
	-- Succubus (Glynevere, Cattwen, Bryanda)
	-- Felguards (Zerik'shekor, Shao'ghun, Vazeel'fazag)
	GridStatusRaidDebuff:DebuffId(zoneid, 184388, 1, 2, 2) -- Whirling (spin AoE)

	-- The Felborne Breach trash (Xhul'horac)
	-- Weaponlord Mehlkhior
	GridStatusRaidDebuff:DebuffId(zoneid, 190043, 1, 2, 2, true, true) -- Felblood Strike (dam buff until 10 stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 190044, 1, 6, 6, true) -- Felblood Corruption (player is bomb)
	GridStatusRaidDebuff:DebuffId(zoneid, 190012, 1, 1, 1, true) -- Demonic Leap (stun)
	-- Voidscribe Aathalos

	-- Halls of the Sargerei trash (Socrethar)
	-- Sargerei Enforcer
	GridStatusRaidDebuff:DebuffId(zoneid, 189556, 1, 4, 4, true, true) -- Sunder Armor (tank debuff stack)
	-- Sargerei Soul Cleaver
	GridStatusRaidDebuff:DebuffId(zoneid, 189551, 1, 5, 5, true) -- Devouring Spirit (dot, magic dispellable)
	-- Sargerei Adjutant
	GridStatusRaidDebuff:DebuffId(zoneid, 189554, 1, 6, 6, true, true) -- Consuming Pain (dot, stacks, magic dispellable)
	-- Sargerei Bannerman
	GridStatusRaidDebuff:DebuffId(zoneid, 189539, 1, 1, 1, true) -- Shockwave (stun)
	-- Construct Peacekeeper
	GridStatusRaidDebuff:DebuffId(zoneid, 189596, 1, 3, 3, true) -- Protocol: Crowd Control (short disorient, dispellable)
	-- Korvos
	GridStatusRaidDebuff:DebuffId(zoneid, 189564, 1, 5, 5, true) -- Torpor (sleep, dispellable, spreads to nearby players on dispel)
	-- Carrion Swarm (cast on players by Korvos)
	GridStatusRaidDebuff:DebuffId(zoneid, 189560, 1, 2, 2, true) -- Carrion Swarm (dot)
	-- Binder Eloah
	GridStatusRaidDebuff:DebuffId(zoneid, 189533, 1, 4, 4, true) -- Sever Soul (tank swap debuff)
	-- Binder Hallaani
	GridStatusRaidDebuff:DebuffId(zoneid, 189532, 1, 5, 5, true) -- Soulsear (AoE dot)
	-- Mystic Aaran
	GridStatusRaidDebuff:DebuffId(zoneid, 189531, 1, 2, 2, false, true) -- Soulbane (dot, stacks, magic dispellable)
	-- Mystic Velrrun

	-- Amphitheater of the Eternal (Tyrant Velhari)
	-- Portal Guardian
	GridStatusRaidDebuff:DebuffId(zoneid, 184734, 1, 5, 5, true) -- Hellfire Slash (cone dot, magic dispellable
	-- Somber Guardian
	-- Darkcaster Adept
	-- Grim Collaborator
	GridStatusRaidDebuff:DebuffId(zoneid, 181962, 1, 1, 1, true) -- Corrupting Slash (buff/debuff, dispellable)
	-- Umbral Supplicant
	-- Shadowheart Fiend
	GridStatusRaidDebuff:DebuffId(zoneid, 184725, 1, 4, 4, true) -- Shadowflame Blast (healing absorb, dispellable)
	-- Slavering Hound
	GridStatusRaidDebuff:DebuffId(zoneid, 184730, 1, 3, 3, true) -- Terrifying Howl (short fear, dispellable)
	-- Lord Aram'el (mini-boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 184721, 1, 1, 1, true, true) -- Shadow Bolt Volley (debuff, stacks, not dispellable)
	-- Eredar Faithbreaker
	GridStatusRaidDebuff:DebuffId(zoneid, 184621, 1, 1, 1, true) -- Hellfire Blast (debuff, not dispellable)
	-- Vindicator Bramu
	-- Seal of Decay is also used by Tyrant Velhari
	-- GridStatusRaidDebuff:DebuffId(zoneid, 184986, 1, 2, 2, true, true) -- Seal of Decay (tank debuff stack, healing reduction)
	-- Protector Bajunt
	-- Seal of Decay is also used by Tyrant Velhari
	-- Adjunct Kuroh
	-- Seal of Decay is also used by Tyrant Velhari

	-- Destructor's Rise trash (Mannoroth)

	-- Archimonde trash
	-- Anetheron
	GridStatusRaidDebuff:DebuffId(zoneid, 189470, 1, 3, 3, true) -- Sleep (sleep)
	-- Carrion Swarm is duplicate name
	-- GridStatusRaidDebuff:DebuffId(zoneid, 189464, 1, 2, 2, true) -- Carrion Swarm (healing debuff)
	-- Towering Infernal
	GridStatusRaidDebuff:DebuffId(zoneid, 189488, 1, 1, 1, true) -- Impact (stun)
	-- Kaz'rogal
	GridStatusRaidDebuff:DebuffId(zoneid, 189504, 1, 1, 1, true) -- Warm Stomp (stun)
	GridStatusRaidDebuff:DebuffId(zoneid, 189512, 1, 4, 4, true) -- Mark of Kaz'rogal (debuff, not dispellable, mana drain/AoE)
	-- Azgalor
	GridStatusRaidDebuff:DebuffId(zoneid, 189538, 1, 1, 1, true) -- Doom (debuff, not dispellable, summons mob)
	GridStatusRaidDebuff:DebuffId(zoneid, 189550, 1, 5, 5) -- Rain of Fire (standing in)
	-- Lesser Doomguard
	GridStatusRaidDebuff:DebuffId(zoneid, 189544, 1, 1, 1, true) -- Cripple (debuff, not dispellable)

	-- Bosses

	-- Hellfire Assault
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Hellfire Assault")
	--GridStatusRaidDebuff:DebuffId(zoneid, 156096, 11, 4, 4) --MARKEDFORDEATH
	-- Siegemaster Mar'tak
	GridStatusRaidDebuff:DebuffId(zoneid, 184369, 11, 6, 6, true) -- Howling Axe (targetted)
	-- Hulking Berserker
	GridStatusRaidDebuff:DebuffId(zoneid, 184243, 12, 4, 4, true, true) -- Slam (stackable tank debuff, nondispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 184238, 13, 1, 1, true) -- Cower (movement)
	-- Felfire Crusher
	GridStatusRaidDebuff:DebuffId(zoneid, 180022, 14, 2, 2) -- Bore (frontal cone damage)
	-- Gorebound Siegeriders (riding on Felfire Crusher)
	GridStatusRaidDebuff:DebuffId(zoneid, 185157, 15, 6, 6) -- Burn (cone dot)
	-- Felfire Munitions
	GridStatusRaidDebuff:DebuffId(zoneid, 180079, 16, 6, 6) -- Felfire Munitions (carrying, dot)

	-- Iron Reaver
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Iron Reaver")
	GridStatusRaidDebuff:DebuffId(zoneid, 182280, 21, 6, 6) -- Artillery (targetted)
	GridStatusRaidDebuff:DebuffId(zoneid, 185242, 22, 5, 5, true, true) -- Blitz (carry, silence, dispellable, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 182003, 23, 1, 1) -- Fuel Streak (movement)
	GridStatusRaidDebuff:DebuffId(zoneid, 182074, 24, 3, 3, true, true) -- Immolation (stacking dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 182001, 25, 4, 4, true, true) -- Unstable Orb (stacking dot)
	-- Volatile Firebomb
	GridStatusRaidDebuff:DebuffId(zoneid, 185978, 26, 2, 2, true, true) -- Firebomb Vulnerability (stacking debuff)

	-- Kormrok
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Kormrok")
	GridStatusRaidDebuff:DebuffId(zoneid, 181306, 31, 6, 6, true) -- Explosive Burst (tank stun, explosion)
	GridStatusRaidDebuff:DebuffId(zoneid, 181321, 32, 1, 1, true) -- Fel Touch (debuff, not dispellable)
	-- Grasping Hand
	GridStatusRaidDebuff:DebuffId(zoneid, 188081, 33, 2, 2) -- Crush (dot)
	-- Crushing Hand (grabs tank until it is killed)
	GridStatusRaidDebuff:DebuffId(zoneid, 181345, 34, 5, 5) -- Foul Crush (tank dot)
	-- Fiery Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 186559, 35, 6, 6) -- Fiery Pool (standing in pool)
	-- Fiery Globule
	GridStatusRaidDebuff:DebuffId(zoneid, 185519, 36, 2, 2, true) -- Fiery Globule (dot)
	-- Shadowy Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 181082, 37, 6, 6) -- Shadowy Pool (standing in pool)
	-- Shadow Globule
	GridStatusRaidDebuff:DebuffId(zoneid, 180270, 38, 2, 2, true) -- Shadow Globule (dot)
	-- Foul Pool
	GridStatusRaidDebuff:DebuffId(zoneid, 186560, 39, 6, 6) -- Foul Pool (standing in pool)
	-- Foul Globule
	GridStatusRaidDebuff:DebuffId(zoneid, 185521, 40, 2, 2, true) -- Foul Globule (dot)

	-- Hellfire High Council
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Hellfire High Council")
	-- Dia Darkwhisper
	-- Mark of the Necromancer changes colors and increases damage over time
	-- This may be a canditate for priority by spell id when that code is added
	GridStatusRaidDebuff:DebuffId(zoneid, 184450, 51, 5, 5) -- Mark of the Necromancer (dot, dispellable)
	GridStatusRaidDebuff:DebuffId(zoneid, 184652, 52, 6, 6) -- Reap (standing in puddle?)
	-- Blademaster Jubei'thos
	-- Gurtogg Bloodboil
	GridStatusRaidDebuff:DebuffId(zoneid, 184847, 53, 4, 4, true, true) -- Acidic Wound (tank dot, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 184358, 54, 5, 5) -- Fel Rage (aggro target)
	GridStatusRaidDebuff:DebuffId(zoneid, 184357, 55, 1, 1, false, true) -- Tainted Blood (debuff, stacks)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 184355, 56, 4, 4, true, true) -- Bloodboil (dot, stacks)

	-- Kilrogg Deadeye
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Kilrogg Deadeye")
	GridStatusRaidDebuff:DebuffId(zoneid, 188929, 61, 6, 6, true) -- Heart Seeker (targetted)
	GridStatusRaidDebuff:DebuffId(zoneid, 188852, 62, 5, 5) -- Blood Splatter (standing in Heart Seeker pool)
	GridStatusRaidDebuff:DebuffId(zoneid, 182159, 63, 2, 2) -- Fel Corruption (dot) (on everyone?)
	GridStatusRaidDebuff:DebuffId(zoneid, 180200, 64, 4, 4, true, true) -- Shredded Armor (tank debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 181488, 65, 3, 3, true) -- Vision of Death (zoned, dot)
	-- Debuffs that are buffs, ignore
	GridStatusRaidDebuff:DebuffId(zoneid, 185563, 66, 1, 1, true, false, 0, true) -- Undying Salvation (healer buff, disabled)
	GridStatusRaidDebuff:DebuffId(zoneid, 180718, 67, 1, 1, true, false, 0, true) -- Undying Resolve (dps buff, disabled)
	GridStatusRaidDebuff:DebuffId(zoneid, 187089, 68, 1, 1, true, false, 0, true) -- Cleansing Aura (disabled)
	-- Hulking Terror
	GridStatusRaidDebuff:DebuffId(zoneid, 189612, 69, 3, 3, true) -- Rending Howl (dot)
	-- Hellblaze Imp
	-- Hellblaze Fiend
	-- GridStatusRaidDebuff:DebuffId(zoneid, 180575, 62, 5, 5) -- Fel Flames (standing in)
	-- make sure stacks and duration are shown for the other spell with the same name
	GridStatusRaidDebuff:DebuffId(zoneid, 180575, 70, 5, 5, true, true) -- Fel Flames (standing in)
	-- Hellblaze Mistress
	GridStatusRaidDebuff:DebuffId(zoneid, 180033, 71, 3, 3, true) -- Cinder Breath (dot)
	-- Mythic
	-- Fel Puddle
	GridStatusRaidDebuff:DebuffId(zoneid, 184067, 72, 5, 5) -- Fel Puddle (standing in)

	-- Gorefiend
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Gorefiend")
	GridStatusRaidDebuff:DebuffId(zoneid, 179864, 81, 5, 5, true) -- Shadow of Death (sent to stomach after 5 sec)
	GridStatusRaidDebuff:DebuffId(zoneid, 181295, 82, 3, 3, true) -- Digest (dot, in stomach)
	GridStatusRaidDebuff:DebuffId(zoneid, 179867, 83, 2, 2, true) -- Gorefiend's Corruption (stomach debuff, death is permanent)
	GridStatusRaidDebuff:DebuffId(zoneid, 179978, 84, 6, 6, true) -- Touch of Doom  (player spawns void zone)
	GridStatusRaidDebuff:DebuffId(zoneid, 179995, 86, 5, 5) -- Doom Well (standing in puddle)
	GridStatusRaidDebuff:DebuffId(zoneid, 179909, 85, 6, 6, true) -- Shared Fate (dot) (179908 non-rooted, 179909 rooted)
	-- Enraged Spirit (tank add in stomach)
	GridStatusRaidDebuff:DebuffId(zoneid, 182601, 86, 5, 5, true, true) -- Fel Fury (standing in puddle, stacks)
	-- Shadowy Construct (dps add in stomach)
	-- Tortured Essence (healer add in stomach)
	-- Gorebound Spirit (Enraged Spirit that made it to center of stomach and spawn outside)
	GridStatusRaidDebuff:DebuffId(zoneid, 185189, 87, 5, 5, true, true) -- Fel Flames (tank dot, stacks) (duplicate name)
	-- Gorebound Construct (Shadowy Construct spawn)
	GridStatusRaidDebuff:DebuffId(zoneid, 180148, 88, 6, 6, true) -- Hunger for Life (fixate)
	-- Gorebound Essence (Tortured Essence spawn)
	GridStatusRaidDebuff:DebuffId(zoneid, 180093, 89, 1, 1, true) -- Spirit Volley (movement debuff)
	-- Pool of Souls (surrounding boss)
	GridStatusRaidDebuff:DebuffId(zoneid, 186770, 90, 5, 5) -- Pool of Souls (standing in pool)

	-- Shadow-Lord Iskar
	GridStatusRaidDebuff:BossNameId(zoneid, 100, "Shadow-Lord Iskar")
	-- If second debuff is added, might be nice to mark Eye of Anzu for this fight
	GridStatusRaidDebuff:DebuffId(zoneid, 179202, 101, 5, 5) -- Eye Of Anzu (holding)
	GridStatusRaidDebuff:DebuffId(zoneid, 185239, 102, 6, 6, false, true) -- Radiance of Anzu (Eye of Anzu stacks)
	-- It is important to see who has Phantasmal Winds for passing the Eye of Anzu
	GridStatusRaidDebuff:DebuffId(zoneid, 181957, 103, 5, 5, true) -- Phantasmal Winds (player pushed)
	GridStatusRaidDebuff:DebuffId(zoneid, 182325, 104, 2, 2, true) -- Phantasmal Wounds (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 182200, 105, 3, 3, true) -- Fel Chakram (targetted)
	GridStatusRaidDebuff:DebuffId(zoneid, 185747, 106, 3, 3, true) -- Fel Beam Fixate (fixate)
	GridStatusRaidDebuff:DebuffId(zoneid, 182600, 107, 2, 2) -- Fel Fire (standing in puddle)
	-- Corrupted Talonpriest
	GridStatusRaidDebuff:DebuffId(zoneid, 179219, 108, 4, 4, true) -- Phantasmal Fel Bomb (player is bomb)
	GridStatusRaidDebuff:DebuffId(zoneid, 181753, 109, 7, 7, true) -- Fel Bomb (player is bomb, dispellable with eye)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 179218, 110, 5, 5) --Phantasmal Obliteration -- not a debuff
	-- Illusionary Outcast
	-- Fel Raven
	GridStatusRaidDebuff:DebuffId(zoneid, 187990, 111, 4, 4, true) -- Phantasmal Corruption (AoE dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 187344, 112, 1, 1, true, true) -- Phantasmal Cremation (dam taken increase)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 185510, 113, 2, 2, true) -- Dark Bindings (chained with another player)

	-- Socrethar the Eternal
	GridStatusRaidDebuff:BossNameId(zoneid, 120, "Socrethar the Eternal")
	-- GridStatusRaidDebuff:DebuffId(zoneid, 182635, 121, 5, 5) --Reverberating Blow not a debuff
	-- Soulbound Construct
	GridStatusRaidDebuff:DebuffId(zoneid, 182038, 122, 3, 3, true, true) -- Shattered Defenses (cone debuff, stacks)
	GridStatusRaidDebuff:DebuffId(zoneid, 189627, 123, 5, 5, true) -- Volatile Fel Orb (targetted for explosive orb)
	GridStatusRaidDebuff:DebuffId(zoneid, 189540, 124, 2, 2, true) -- Overwhelming Power (dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 182218, 125, 5, 5) -- Felblaze Residue (standing in fire)
	GridStatusRaidDebuff:DebuffId(zoneid, 180415, 126, 1, 1, true) -- Fel Prison (stun, 99% reduction damage taken)
	-- Haunting Soul
	GridStatusRaidDebuff:DebuffId(zoneid, 182769, 127, 6, 6) -- Ghastly Fixation (targetted)
	GridStatusRaidDebuff:DebuffId(zoneid, 182900, 128, 4, 4, true) -- Virulent Haunt (dot, horrify)
	-- Sargerei Dominator
	GridStatusRaidDebuff:DebuffId(zoneid, 184124, 129, 3, 3, true) -- Gift Of The Man'ari (dot)
	-- Sargerei Shadowcaller
	GridStatusRaidDebuff:DebuffId(zoneid, 184239, 130, 4, 4, true, true) -- Shadow Word: Agony (dot, stacks, magic dispellable)
	-- Enrage (Soulbound Construct)
	GridStatusRaidDebuff:DebuffId(zoneid, 190922, 131, 2, 2, true, true) -- Unbounded Power (dot, stacks)

	-- Fel Lord Zakuun
	GridStatusRaidDebuff:BossNameId(zoneid, 140, "Fel Lord Zakuun")
	GridStatusRaidDebuff:DebuffId(zoneid, 181508, 141, 6, 6, true) --Seed Of Destruction (player emits waves)
	GridStatusRaidDebuff:DebuffId(zoneid, 179428, 142, 5, 5) -- Rumbling Fissure (standing in fire)
	GridStatusRaidDebuff:DebuffId(zoneid, 182008, 143, 2, 2, true) -- Latent Energy (debuff, explodes if hit)
	GridStatusRaidDebuff:DebuffId(zoneid, 189260, 144, 3, 3, true) -- Cloven Soul (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 179407, 145, 1, 1, true) -- Disembodied (Shadow Realm)
	-- Befouled starts red (189030) switches to orange (189031) then to green (189032)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 179711, 136, 6, 6) --Befouled -- not the debuff
	GridStatusRaidDebuff:DebuffId(zoneid, 189030, 146, 6, 6) -- Befouled (healing absorb)
	-- GridStatusRaidDebuff:DebuffId(zoneid, 189031, 136, 6, 6) --Befouled Orange
	-- GridStatusRaidDebuff:DebuffId(zoneid, 189032, 136, 6, 6) --Befouled Green
	-- Fel Crystal
	GridStatusRaidDebuff:DebuffId(zoneid, 181653, 147, 5, 5) -- Fel Crystals (standing near)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 188998, 148, 2, 2, true) -- Exhausted Soul (debuff, rumbling fissure)

	-- Xhul'horac
	GridStatusRaidDebuff:BossNameId(zoneid, 150, "Xhul'horac")
	GridStatusRaidDebuff:DebuffId(zoneid, 186134, 151, 2, 2, true) -- Feltouched (debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 186135, 152, 2, 2, true) -- Voidtouched (debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 186407, 153, 7, 7, true) -- Fel Surge (dot, drops fire)
	GridStatusRaidDebuff:DebuffId(zoneid, 186333, 154, 7, 7, true) -- Void Surge (dot, drops fire)
	GridStatusRaidDebuff:DebuffId(zoneid, 185656, 155, 1, 1, true, true) -- Shadowfel Annihilation (debuff)
	-- Vanguard Akkelion
	GridStatusRaidDebuff:DebuffId(zoneid, 186500, 156, 6, 6, false, true) --Chains Of Fel
	GridStatusRaidDebuff:DebuffId(zoneid, 186448, 157, 4, 4, true, true) -- Felblaze Flurry (tank debuff stack)
	-- Wild Pyromaniac
	GridStatusRaidDebuff:DebuffId(zoneid, 188208, 158, 3, 3, true, true) -- Ablaze (stacking dot)
	-- Omnus
	GridStatusRaidDebuff:DebuffId(zoneid, 186547, 159, 5, 5) -- Black Hole (sucking in, dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 186785, 160, 4, 4, true, true) -- Withering Gaze (tank debuff stack)
	-- Unstable Voidfiend
	-- Chaotic Felblaze
	GridStatusRaidDebuff:DebuffId(zoneid, 186073, 161, 3, 3, true, true) -- Felsinged (stacking dot, standing in fire)
	-- Creeping Void
	GridStatusRaidDebuff:DebuffId(zoneid, 186063, 162, 3, 3, true, true) -- Wasting Void (stacking dot, standing in fire)

	-- Tyrant Velhari
	GridStatusRaidDebuff:BossNameId(zoneid, 170, "Tyrant Velhari")
	GridStatusRaidDebuff:DebuffId(zoneid, 180166, 171, 5, 5) -- Touch Of Harm (healing absorb, dispellable, jumps on dispel)
	GridStatusRaidDebuff:DebuffId(zoneid, 180128, 172, 6, 6, true) -- Edict Of Condemnation (targetted, split damage)
	GridStatusRaidDebuff:DebuffId(zoneid, 180526, 173, 6, 6, true) -- Font of Corruption (targetted by Tainted Shadows)
	GridStatusRaidDebuff:DebuffId(zoneid, 180000, 174, 4, 4, true, true) -- Seal of Decay (tank debuff stack, healing reduction)
	GridStatusRaidDebuff:DebuffId(zoneid, 181683, 175, 1, 1) -- Aura of Oppression (phase 1 movement causes damage)
	GridStatusRaidDebuff:DebuffId(zoneid, 179987, 176, 1, 1) -- Aura of Contempt (phase 2 healing debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 179993, 177, 1, 1) -- Aura of Malice (phase 3 buff/debuff)
	-- Ancient Enforcer
	-- Ancient Harbinger
	-- Despoiled Ground
	GridStatusRaidDebuff:DebuffId(zoneid, 180604, 178, 3, 3) -- Despoiled Ground (standing in void zone)
	-- Ancient Sovereign

	-- Mannoroth
	GridStatusRaidDebuff:BossNameId(zoneid, 180, "Mannoroth")
	-- Phase 1
	-- Fel Iron Summoner
	-- Demon Portal
	GridStatusRaidDebuff:DebuffId(zoneid, 181099, 181, 6, 6) -- Mark Of Doom
	GridStatusRaidDebuff:DebuffId(zoneid, 181275, 182, 3, 3, true) -- Curse of the Legion (curse, dispellable, summons demon lord)
	-- Doom Lord
	GridStatusRaidDebuff:DebuffId(zoneid, 181119, 183, 4, 4, true, true) -- Doom Spike (tank debuff stack)
	-- Fel Imp
	-- Dread Infernal
	-- Blood of Mannoroth
	GridStatusRaidDebuff:DebuffId(zoneid, 182171, 184, 2, 2) -- Blood of Mannoroth (standing in pool)
	-- Phase 2
	GridStatusRaidDebuff:DebuffId(zoneid, 181359, 185, 5, 5) -- Massive Blast (tank debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 184252, 186, 3, 3) -- Puncture Wound (tank debuff if no active mitigation)
	GridStatusRaidDebuff:DebuffId(zoneid, 181597, 187, 4, 4) -- Mannoroth's Gaze (fear, split AoE)
	-- Phase 3
	GridStatusRaidDebuff:DebuffId(zoneid, 181841, 188, 6, 6) -- Shadowforce (dot, pushback)
	GridStatusRaidDebuff:DebuffId(zoneid, 182113, 189, 1, 1, true, false, 0, true) -- Lingering Forces (movement buff)
	-- Phase 4
	GridStatusRaidDebuff:DebuffId(zoneid, 182088, 190, 6, 6) -- Empowered Shadowforce (dot, pushback)
	GridStatusRaidDebuff:DebuffId(zoneid, 182006, 191, 4, 4) -- Empowered Mannoroth's Gaze (fear, split AoE, leaves puddle)
	-- Gazing Shadows
	GridStatusRaidDebuff:DebuffId(zoneid, 182031, 192, 3, 3) -- Gazing Shadows (standing in void zone)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 186362, 193, 6, 6, false, true) -- Wrath of Gul'dan (stacked debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 190482, 194, 2, 2, true, true) -- Gripping Shadows (stacking debuff)

	-- Archimonde
	GridStatusRaidDebuff:BossNameId(zoneid, 200, "Archimonde")
	-- GridStatusRaidDebuff:DebuffId(zoneid, 185590, 200, 6, 6) -- Desecrate (not a debuff)
	-- Phase 1
	GridStatusRaidDebuff:DebuffId(zoneid, 183634, 201, 6, 6, true) -- Shadowfel Burst (target, thrown in air)
	GridStatusRaidDebuff:DebuffId(zoneid, 183828, 202, 4, 4) -- Death Brand (tank dot)
	GridStatusRaidDebuff:DebuffId(zoneid, 183963, 203, 1, 1, true, false, 0, true) -- Light of the Naaru (movement buff, immune to shadow damage)
	-- Doomfire Spirit
	GridStatusRaidDebuff:DebuffId(zoneid, 182879, 204, 6, 6, true) -- Doomfire Fixate (target)
	GridStatusRaidDebuff:DebuffId(zoneid, 182878, 205, 2, 2, true, true) -- Doomfire (stacking dot, from stepping in)
	-- Hellfire Deathcaller
	GridStatusRaidDebuff:DebuffId(zoneid, 183864, 206, 3, 3, true, true) -- Shadow Blast (stacking debuff)
	-- Phase 2
	GridStatusRaidDebuff:DebuffId(zoneid, 184964, 207, 6, 6) -- Shackled Torment (debuff, raid damage when removed)
	GridStatusRaidDebuff:DebuffId(zoneid, 186123, 208, 5, 5, true, true) -- Wrought Chaos (player explodes towards Focused Chaos target)
	GridStatusRaidDebuff:DebuffId(zoneid, 185014, 209, 5, 5, true) -- Focused Chaos (target)
	-- Felborne Overfiend
	-- Dreadstalker
	-- Phase 3
	GridStatusRaidDebuff:DebuffId(zoneid, 186961, 210, 6, 6, true) -- Nether Banish (tank banish)
	-- Nether Tear
	GridStatusRaidDebuff:DebuffId(zoneid, 189891, 211, 3, 3) -- Nether Tear (standing in void zone)
	-- Living Shadows
	GridStatusRaidDebuff:DebuffId(zoneid, 187047, 212, 2, 2, true) -- Devour Life (healing debuff)
	-- Twisting Nether
	GridStatusRaidDebuff:DebuffId(zoneid, 190341, 213, 2, 2, true, true) -- Nether Corruption (stacking debuff)
	-- Shadowed Netherwalker
	GridStatusRaidDebuff:DebuffId(zoneid, 187255, 214, 3, 3) -- Nether Storm (standing in)
	-- Void Star
	GridStatusRaidDebuff:DebuffId(zoneid, 189895, 215, 5, 5) -- Void Star Fixate (fixate)
	-- Mythic
	GridStatusRaidDebuff:DebuffId(zoneid, 190400, 216, 3, 3, true, true) -- Touch of the Legion (debuff)
	GridStatusRaidDebuff:DebuffId(zoneid, 187050, 217, 6, 6, true) -- Mark of the Legion (split damage)
	-- Source of Chaos
	GridStatusRaidDebuff:DebuffId(zoneid, 190706, 218, 2, 2, true, true) -- Source of Chaos (stacking debuff)
end

-- WoD Raid
-- Highmaul
do
	--Trash
	GridStatusRaidDebuff:DebuffId(zoneid, 175601, 1, 5, 5) -- Trash TAINTED CLAWS
	GridStatusRaidDebuff:DebuffId(zoneid, 175599, 1, 4, 4) -- Trash DEVOUR
	GridStatusRaidDebuff:DebuffId(zoneid, 172069, 1, 5, 5) -- Trash RADIATING POISON
	GridStatusRaidDebuff:DebuffId(zoneid, 172066, 1, 4, 4) -- Trash RADIATING POISON
	GridStatusRaidDebuff:DebuffId(zoneid, 166779, 1, 5, 5) -- Trash STAGGERING BLOW
	GridStatusRaidDebuff:DebuffId(zoneid, 56037, 1, 4, 4) -- Trash RUNE OF DESTRUCTION
	GridStatusRaidDebuff:DebuffId(zoneid, 175654, 1, 5, 5) -- Trash RUNE OF DISINTEGRATION
	GridStatusRaidDebuff:DebuffId(zoneid, 166185, 1, 5, 5) -- Trash RENDING SLASH
	GridStatusRaidDebuff:DebuffId(zoneid, 166175, 1, 5, 5) -- Trash EARTHDEVASTATING SLAM
	GridStatusRaidDebuff:DebuffId(zoneid, 174404, 1, 5, 5) -- Trash FROZEN CORE
	GridStatusRaidDebuff:DebuffId(zoneid, 173763, 1, 5, 5) -- Trash WILD FLAMES
	GridStatusRaidDebuff:DebuffId(zoneid, 174500, 1, 5, 5) -- Trash RENDING THROW
	GridStatusRaidDebuff:DebuffId(zoneid, 174939, 1, 4, 4) -- Trash Time Stop
	GridStatusRaidDebuff:DebuffId(zoneid, 172115, 1, 4, 4) -- Trash Earthen Thrust
	GridStatusRaidDebuff:DebuffId(zoneid, 166200, 1, 4, 4) -- Trash ARCANEVOLATILITY
	GridStatusRaidDebuff:DebuffId(zoneid, 174473, 1, 5, 5) -- Trash Corrupted Blood

	--The Butcher
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "The Butcher")
	GridStatusRaidDebuff:DebuffId(zoneid, 156152, 11, 5, 5, true, true) --GUSHING WOUNDS
	GridStatusRaidDebuff:DebuffId(zoneid, 156151, 12, 6, 6) --THE TENDERIZER
	GridStatusRaidDebuff:DebuffId(zoneid, 156143, 13, 5, 5, true, true) --THE CLEAVER
	GridStatusRaidDebuff:DebuffId(zoneid, 163046, 14, 5, 5) --PALE VITRIOL

	--Kargath Bladefist
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Kargath Bladefist")
	GridStatusRaidDebuff:DebuffId(zoneid, 159113, 21, 5, 5) --IMPALE
	GridStatusRaidDebuff:DebuffId(zoneid, 159178, 22, 6, 6) --OPENWOUNDS
	GridStatusRaidDebuff:DebuffId(zoneid, 159213, 23, 7, 7) --MONSTERS BRAWL
	GridStatusRaidDebuff:DebuffId(zoneid, 158986, 24, 4, 4) --BERSERKER RUSH
	GridStatusRaidDebuff:DebuffId(zoneid, 159410, 25, 5, 5) --MAULING BREW
	GridStatusRaidDebuff:DebuffId(zoneid, 160521, 26, 6, 6) --VILE BREATH
	GridStatusRaidDebuff:DebuffId(zoneid, 159386, 27, 5, 5) --IRON BOMB
	GridStatusRaidDebuff:DebuffId(zoneid, 159188, 28, 5, 5) --GRAPPLE
	GridStatusRaidDebuff:DebuffId(zoneid, 162497, 29, 4, 4) --ON THE HUNT
	GridStatusRaidDebuff:DebuffId(zoneid, 159202, 30, 5, 5) --FLAME JET

	--Twin Ogron
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Twin Ogron")
	GridStatusRaidDebuff:DebuffId(zoneid, 158026, 41, 6, 6) --ENFEEBLING ROAR
	GridStatusRaidDebuff:DebuffId(zoneid, 158241, 42, 5, 5, true, true) --BLAZE
	GridStatusRaidDebuff:DebuffId(zoneid, 155569, 43, 5, 5) --INJURED
	GridStatusRaidDebuff:DebuffId(zoneid, 167200, 44, 5, 5, true, true) --ARCANE WOUND
	GridStatusRaidDebuff:DebuffId(zoneid, 159709, 45, 6, 6, true, true) --WEAKENED DEFENSES 159709 167179
	GridStatusRaidDebuff:DebuffId(zoneid, 163374, 46, 4, 4) --ARCANE VOLATILITY
	GridStatusRaidDebuff:DebuffId(zoneid, 158200, 47, 4, 4) --QUAKE

	--Ko'ragh
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Ko'ragh")
	GridStatusRaidDebuff:DebuffId(zoneid, 161242, 51, 4, 4) --CAUSTIC ENERGY
	GridStatusRaidDebuff:DebuffId(zoneid, 161358, 52, 4, 4) --SUPPRESSION FIELD
	GridStatusRaidDebuff:DebuffId(zoneid, 162184, 53, 6, 6) --EXPEL MAGIC SHADOW
	GridStatusRaidDebuff:DebuffId(zoneid, 162186, 54, 6, 6) --EXPEL MAGIC ARCANE
	GridStatusRaidDebuff:DebuffId(zoneid, 161411, 55, 6, 6) --EXPEL MAGIC FROST
	GridStatusRaidDebuff:DebuffId(zoneid, 163472, 56, 4, 4) --DOMINATING POWER
	GridStatusRaidDebuff:DebuffId(zoneid, 162185, 57, 7, 7) --EXPEL MAGIC FEL
	--GridStatusRaidDebuff:DebuffId(zoneid, 156803, 57, 7, 7) --NULLIFICATION BARRIER

	--Tectus
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Tectus")
	GridStatusRaidDebuff:DebuffId(zoneid, 162346, 61, 5, 5) --CRYSTALLINE BARRAGE
	GridStatusRaidDebuff:DebuffId(zoneid, 162892, 62, 5, 5) --PETRIFICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 162475, 63, 5, 5) --Tectonic Upheaval

	--Brackenspore
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Brackenspore")
	GridStatusRaidDebuff:DebuffId(zoneid, 163242, 71, 5, 5, true, true) --INFESTING SPORES
	GridStatusRaidDebuff:DebuffId(zoneid, 163590, 72, 5, 5) --CREEPING MOSS
	GridStatusRaidDebuff:DebuffId(zoneid, 163241, 73, 5, 5, true, true) --ROT
	GridStatusRaidDebuff:DebuffId(zoneid, 159220, 74, 6, 6) --NECROTIC BREATH
	GridStatusRaidDebuff:DebuffId(zoneid, 160179, 75, 6, 6) --MIND FUNGUS
	GridStatusRaidDebuff:DebuffId(zoneid, 159972, 76, 6, 6, true, true) --FLESHEATER

	--Imperator Mar'gok
	GridStatusRaidDebuff:BossNameId(zoneid, 80, "Imperator Mar'gok")
	GridStatusRaidDebuff:DebuffId(zoneid, 156238, 81, 4, 4) --BRANDED  156238 163990 163989 163988
	GridStatusRaidDebuff:DebuffId(zoneid, 156467, 82, 5, 5) --DESTRUCTIVE RESONANCE  156467 164075 164076 164077
	GridStatusRaidDebuff:DebuffId(zoneid, 158605, 83, 4, 4) --MARK OF CHAOS  158605 164176 164178 164191
	GridStatusRaidDebuff:DebuffId(zoneid, 164004, 84, 4, 4) --BRANDED DISPLACEMENT
	GridStatusRaidDebuff:DebuffId(zoneid, 164075, 85, 4, 4) --DESTRUCTIVE RESONANCE DISPLACEMENT
	GridStatusRaidDebuff:DebuffId(zoneid, 164176, 86, 4, 4) --MARK OF CHAOS DISPLACEMENT
	GridStatusRaidDebuff:DebuffId(zoneid, 164005, 87, 4, 4) --BRANDED FORTIFICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 164076, 88, 4, 4) --DESTRUCTIVE RESONANCE FORTIFICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 164178, 89, 4, 4) --MARK OF CHAOS FORTIFICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 164006, 90, 4, 4) --BRANDED REPLICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 164077, 91, 4, 4) --DESTRUCTIVE RESONANCE REPLICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 164191, 92, 4, 4) --MARK OF CHAOS REPLICATION
	GridStatusRaidDebuff:DebuffId(zoneid, 157349, 93, 5, 5) --FORCE NOVA  157349 164232 164235 164240
	GridStatusRaidDebuff:DebuffId(zoneid, 157763, 94, 4, 4) --FIXATE
	GridStatusRaidDebuff:DebuffId(zoneid, 158553, 95, 6, 6, true, true) --CRUSH ARMOR
	GridStatusRaidDebuff:DebuffId(zoneid, 165102, 96, 7, 7) --Infinite Darkness
	GridStatusRaidDebuff:DebuffId(zoneid, 157801, 97, 7, 7) --Slow
end
