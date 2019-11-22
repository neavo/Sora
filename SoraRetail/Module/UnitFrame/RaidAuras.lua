-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.UnitFrame then
	C.UnitFrame = {}
end

C.UnitFrame.RaidAuras = {
	-- GridStatusRaidDebuff2
	-- ".+BossNameId.+" REPLACE ""
	-- ".+\(zoneid, (\d+), (\d+),.*?\)" + REPLACE "[$1] = $2,"

	-- [8936] = 1, -- Test
	-- [227723] = 2, -- Test

	-- BFA/Azeroth
	-- T'zane
	[261552] = 11, -- Terror Wail
	[261632] = 12, -- Consuming Spirits
	-- Ji'arak
	[261509] = 21, -- Clutch
	[260908] = 22, -- Storm Wing
	-- Hailstone Construct
	[274891] = 31, -- Glacial Breath
	-- The Lion's Roar
	[271246] = 41, -- Demolisher Cannon
	-- Azurethos, The Winged Typhoon
	[274839] = 51, -- Azurethos' Fury
	-- Warbringer Yenajz
	[274904] = 61, -- Reality Tear
	[274932] = 62, -- Endless Abyss
	[274842] = 63, -- Void Nova
	-- BFA/Uldir
	-- Taloc
	[270290] = 11, -- Blood Storms
	[271222] = 12, -- Plasma Discharge
	[271296] = 13, -- Cudgel of Gore
	-- MOTHER
	[267787] = 21, -- Sanitizing Strike
	[268198] = 22, -- Clinging Corruption
	[267821] = 23, -- Defense Grids
	-- Fetid Devourer
	[262313] = 31, -- Malodorous Miasma
	[262314] = 32, -- Putrid Paroxysm
	-- Zek'voz, herald of N'zoth
	[265264] = 41, -- Void Lash
	[265646] = 42, -- Will of the Corruptor
	[265360] = 43, -- Roiling Deceit
	[267334] = 44, -- Orb of Corruption
	[265662] = 45, -- Corruptor's Pact
	[265451] = 46, -- Surging Darkness
	-- Vectis
	[265129] = 51, -- Omega Vector
	[265127] = 52, -- Lingering Infection
	[265178] = 53, -- Evolving Affliction
	[265206] = 54, -- Immunosuppression
	[266948] = 55, -- Plague Bomb
	[265212] = 56, -- Gestate
	-- Zul, Reborn
	[274195] = 61, -- Corrupted Blood
	[274358] = 62, -- Rupturing Blood
	[274363] = 63, -- Ruptured Blood
	[273365] = 64, -- Dark Revelation
	[274271] = 65, -- Deathwish
	-- Mythrax the Unraveler
	[272336] = 71, -- Annihilation
	[274113] = 72, -- Obliteration Beam
	[273282] = 73, -- Essence Shear
	[272536] = 74, -- Imminent Ruin
	[272407] = 75, -- Oblivion Sphere
	-- G'huun
	[263372] = 81, -- Power Matrices
	[263503] = 82, -- Reorigination Blasts
	[267409] = 83, -- Dark Bargain
	[270447] = 84, -- Growing Corruption
	[263236] = 85, -- Blood Feast
	[263334] = 86, -- Putrid Blood
	[267700] = 87, -- Gaze of G'huun
	-- LEGION/Antorusthe Burning Throne
	-- Varimathras
	[244042] = 11, -- Marked Prey
	[243999] = 12, -- Dark Fissure
	[244093] = 13, -- Necrotic Embrace
	[243961] = 14, -- Misery
	[243980] = 15, -- Torment of Fel
	[243968] = 16, -- Torment of Flames
	[243977] = 17, -- Torment of Frost
	[243974] = 18, -- Torment of Shadows
	[248732] = 19, -- Echoes of Doom
	-- Aggramar
	[243431] = 21, -- Taeshalach's Reach
	[245995] = 22, -- Scorching Blaze
	[246014] = 23, -- Searing Tempest
	[244912] = 24, -- Blazing Eruption
	[244291] = 25, -- Foe Breaker
	[244736] = 26, -- Wake of Flame
	[245916] = 27, -- Molten Remnants
	[254452] = 28, -- Ravenous Blaze
	[247079] = 29, -- Empowered Flame Rend
	[255062] = 30, -- Empowered Searing Tempest
	[255060] = 31, -- Empowered Foe Breaker
	[255528] = 32, -- Searing Binding
	-- Portal Keeper Hasabel
	[245157] = 41, -- Everburning Light
	[244853] = 42, -- Caustic Detonation
	[245075] = 43, -- Hungering Gloom
	[244016] = 44, -- Reality Tear
	[245240] = 45, -- Oppressive Gloom
	[245118] = 46, -- Cloying Shadows
	[245099] = 47, -- Mind Fog
	[244613] = 48, -- Everburning Flames
	[245050] = 49, -- Delusions
	[245040] = 50, -- Corrupt
	[244849] = 51, -- Caustic Slime
	[244915] = 52, -- Poison Essence
	[244915] = 53, -- Leech Essence
	[244949] = 54, -- Felsilk Wrap
	[246208] = 55, -- Acidic Web
	[244709] = 56, -- Fiery Detonation
	-- Noura, Mother of Flames <Coven of Shivarra>
	[250095] = 61, -- Machinations of Aman'Thul
	[245586] = 62, -- Chilled Blood
	[245518] = 63, -- Flashfreeze
	[244899] = 64, -- Fiery Strike
	[253203] = 65, -- Shivan Pact
	[253520] = 66, -- Fulminating Pulse
	[253752] = 67, -- Sense of Dread
	[245627] = 68, -- Whirling Saber
	[253697] = 69, -- Orb of Frost
	[252861] = 70, -- Storm of Darkness
	[246763] = 71, -- Fury of Golganneth
	[245921] = 72, -- Spectral Army
	[245671] = 73, -- Flames of Khaz'goroth
	[250757] = 74, -- Cosmic Glare
	-- F'harg
	[248815] = 81, -- Enflamed
	[244057] = 82, -- Enflame Corruption
	[244768] = 83, -- Desolate Gaze
	[254760] = 84, -- Corrupting Maw
	[244071] = 85, -- Weight of Darkness
	[248819] = 86, -- Siphoned
	[244056] = 87, -- Siphon Corruption
	[248815] = 88, -- Enflamed
	[251445] = 89, -- Smouldering
	[244091] = 90, -- Singed
	[244517] = 91, -- Lingering Flames
	[245098] = 92, -- Decay
	[251445] = 93, -- Smouldering
	[245024] = 94, -- Consumed
	[244086] = 95, -- Molten Touch
	[244055] = 96, -- Shadowtouched
	[244054] = 97, -- Flametouched
	[245022] = 98, -- Burning Remnant
	-- Garothi Worldbreaker
	[244395] = 101, -- Searing Barrage
	[244410] = 102, -- Decimation
	[246848] = 103, -- Luring Destruction
	[244536] = 104, -- Fel Bombardment
	[246920] = 105, -- Haywire Decimation
	[246848] = 106, -- Luring Destruction
	-- Admiral Svirax
	[244910] = 111, -- Felshield
	[244172] = 112, -- Psychic Assault
	[257974] = 113, -- Chaos Pulse
	[244892] = 114, -- Exploit Weakness
	[245121] = 115, -- Entropic Blast
	[253037] = 116, -- Demonic Charge
	[244388] = 117, -- Psychic Scarring
	[244748] = 118, -- Shocked
	-- Kin'garoth <Engineer of the Apocalypse>
	[248061] = 121, -- Purging Protocol
	[246706] = 122, -- Demolish
	[244312] = 123, -- Forging Strike
	[249535] = 124, -- Demolished
	[246687] = 125, -- Decimation
	[246840] = 126, -- Ruiner
	-- Imonar the Soulhunter
	[248321] = 131, -- Conflagration
	[248424] = 132, -- Gathering Power
	[247641] = 133, -- Stasis Trap
	[247552] = 134, -- Sleep Canister
	[247565] = 135, -- Slumber Gas
	[247367] = 136, -- Shock Lance
	[247687] = 137, -- Sever
	[250255] = 138, -- Empowered Shock Lance
	[250006] = 139, -- Empowered Pulse
	[255029] = 140, -- Asleep
	[247716] = 141, -- Charged Blasts
	[250224] = 142, -- Shocked
	[247949] = 143, -- Shrapnel Blast
	[254181] = 144, -- Seared Skin
	[248255] = 145, -- Infernal Rockets
	-- Essence of Eonar
	[248326] = 151, -- Rain of Fel
	[248333] = 152, -- Meteor Storm
	[248861] = 153, -- Spear of Doom
	[248795] = 154, -- Fel Wake
	[250691] = 155, -- Burning Embers
	[250140] = 156, -- Foul Steps
	[249016] = 157, -- Targeted
	[249017] = 158, -- Arcane Singularity
	[249014] = 159, -- Feedback: Foul Steps
	[249015] = 160, -- Feedback: Burning Embers
	-- Argus the Unmaker
	[248499] = 171, -- Sweeping Scythe
	[255199] = 172, -- Avatar of Aggramar
	[251570] = 173, -- Soulbomb
	[250669] = 174, -- Soulburst
	[257313] = 175, -- Gift of the Sky
	[257306] = 176, -- Gift of the Sea
	[258039] = 177, -- Deadly Scythe
	[248396] = 178, -- Soulblight
	[253901] = 179, -- Strength of Sea
	[253903] = 180, -- Strength of Sky
	[255200] = 181, -- Aggramar’s Boon
	[257299] = 182, -- Ember of Rage
	[252729] = 183, -- Cosmic Ray
	[252634] = 184, -- Cosmic Smash
	[257215] = 185, -- Titanforged
	[248167] = 186, -- Death Fog
	[256899] = 187, -- Soul Detonation
	[251815] = 188, -- Edge of Obliteration
	[257299] = 189, -- Ember of Rage
	[258373] = 190, -- Grasp
	[257961] = 191, -- Chains of Sargeras
	[257966] = 192, -- Sentence of Sargeras
	[258026] = 193, -- Punishment
	[258000] = 194, -- Shattered Bonds
	[257930] = 195, -- Crushing
	[257931] = 196, -- Sargeras Fear
	[257869] = 197, -- Unleashed
	[257911] = 198, -- Sargeras Rage
	-- LEGION/Broken Isles
	-- Ancient Rage: Fire
	[218888] = 21, -- Impish Flames (non-dispellable)
	-- Ancient Rage: Frost
	[217925] = 24, -- Icy Comet (non-dispellable) AoE Slow
	[217966] = 25, -- Howling Gale (non-dispellable)
	-- Ancient Rage: Arcane
	[218012] = 25, -- Arcanopulse (non-dispellable) DMG + Stun
	-- Drugon the Frostblood
	[219602] = 31, -- Snow Plow (non-dispellable) Fixate
	-- Flotsam
	[223373] = 41, -- Yaksam (non-dispellable) Cone AoE
	-- Regurgitated Marshstomper
	[223355] = 42, -- Oozing Bile (non-dispellable)
	-- Humongris
	[216430] = 51, -- Earthshake Stomp (non-dispellable) DMG + Stun
	[216467] = 52, -- Make the Snow (non-dispellable) AoE Frost DMG + Slow
	[216822] = 53, -- You Go Bang! (non-dispellable) Fire Bomb + DMG Increase Debuff
	-- Levantus
	[170196] = 61, -- Rending Whirl (non-dispellable) Rend
	-- Electrify DMG + Stun Dispellable (TODO)
	[217362] = 63, -- Turbulent Vortex (dispellable)
	[217362] = 64, -- Rampaging Torrent (non-dispellable) DMG + DMG Increase Debuff Stacks
	-- Na'zak the Fiend
	[219349] = 71, -- Corroding Spray (non-dispellable) Cone AoE Stacks
	[212867] = 81, -- Electrical Storm (non-dispellable) Ground AoE
	[212852] = 82, -- Storm Breath (non-dispellable) DMG + DMG Increase Debuff
	-- Nightmare Breath Fire Cone AoE (TODO)
	[215876] = 92, -- Burning Earth (non-dispellable) Ground AoE
	[216044] = 93, -- Cry of the Tormented (non-dispellable) AoE Fear
	-- Reaver Jdorn
	[213665] = 93, -- Marauding Mists (non-dispellable) DMG + Disorient
	-- LEGION/Emerald Nightmare
	-- Nythendra
	[221028] = 1, -- Unstable Decay
	-- Nythendra
	-- Infested (Heroic)
	[204504] = 11, -- Infested
	-- Stage One
	-- Infested Ground
	[203045] = 12, -- Infested Ground (standing in pool)
	-- Rot
	[203096] = 13, -- Rot (AoE people around you)
	-- Volatile Rot
	[204463] = 14, -- Volatile Rot (exploding tank)
	-- Stage Two
	-- Heart of the Swarm/Burst of Corruption
	[203646] = 15, -- Burst of Corruption
	-- Il'gynoth, Heart of Corruption
	-- Stage One
	-- Nightmare Corruption
	[212886] = 21, -- Nightmare Corruption (standing in pool)
	-- Dispersed Spores (dot, missed Death Blossom)
	[215845] = 22, -- Dispersed Spores (dot)
	-- The Eye of Il'gynoth
	-- Nightmare Ichor
	-- Fixate
	[210099] = 23, -- Fixate (fixate)
	-- Touch of Corruption
	[209469] = 24, -- (dot, stacks, magic)
	-- Nightmare Explosion (Mythic dot)
	[209471] = 25, -- Nightmare Explosion (dot, stacks)
	-- Forces of Corruption
	-- Nightmare Horror
	-- Eye of Fate (tank debuff, stacks)
	[210984] = 26, -- Eye of Fate (tank debuff, stacks)
	-- Deathglare Tentacle
	-- Mind Flay (interruptable)
	[208697] = 27, -- Mind Flay (dot)
	-- Spew Corruption (dot, player drops pools)
	[208929] = 28, -- Spew Corruption (dot, drops pools)
	-- Dominator Tentacle
	-- Nighmarish Fury (buff?, stacks)
	-- Stage Two
	-- Cursed Blood (dot, weak bomb)
	[215128] = 29, -- Cursed Blood (dot, weak bomb)
	-- Elerethe Renferal
	-- Spider Form
	-- Web of Pain (linked with another player)
	[215307] = 31, -- Web of Pain (link)
	-- Necrotic Venom (dot, drops pools)
	[215460] = 32, -- Necrotic Venom (dot, drops pools)
	-- Venomous Pool
	[213124] = 33, -- Venomous Pool (standing in pool)
	-- Roc Form
	-- Shimmering Feather (buff?)
	-- Twisting Shadows (dot, caught in tornado)
	[210850] = 34, -- Twisting Shadows (dot)
	-- Raking Talons (tank debuff, stacks)
	[215582] = 35, -- Raking Talons (tank debuff, stacks)
	-- Wind Burn (debuff, stacks)
	[218519] = 36, -- Wind Burn (debuff, stacks)
	-- Venomous Spiderling
	-- Dripping Fangs (dot, stacks)
	[210228] = 37, -- Dripping Fangs (dot, stacks)
	-- Ursoc
	-- Overwhelm
	[197943] = 41, -- Overwhelm (tank debuff, stacks)
	-- Rend Flesh
	[204859] = 42, -- Rend Flesh (dot)
	-- Focused Gaze
	[198006] = 43, -- Focused Gaze (fixate)
	-- Momentum
	[198108] = 44, -- Momentum (debuff)
	-- Nightmarish Cacophony (Fear)
	[197980] = 45, -- Nightmarish Cacophony (fear)
	-- Miasma (standing in)
	[205611] = 46, -- Miasma (standing in)
	-- Dragons of Nightmare
	-- Shared
	-- Slumbering Nightmare (stun)
	[203110] = 51, -- Slumbering Nightmare (stun)
	-- Ysondre
	-- Mark of Ysondre (dot, stacks)
	[203102] = 52, -- Mark of Ysondre (dot, stacks)
	-- Nightmare Bloom (standing in, should be at least 1 player)
	[207681] = 53, -- Nightmare Bloom (standing in)
	-- Dread Horror
	-- Wasting Dread (debuff reduces dam 50%) (disabled)
	[204731] = 54, -- Wasting Dread (debuff)
	-- Defiled Spirit
	-- Defiled Vines (root, magic)
	[203770] = 55, -- Defiled Vines (root, magic)
	-- Emeriss
	-- Mark of Emeriss (dot, stacks)
	[203125] = 56, -- Mark of Emeriss (dot, stacks)
	-- Volatile Infection (AoE dot)
	[203787] = 57, -- Volatile Infection (AoE dot)
	-- Lethon
	-- Mark of Lethon (dot, stacks)
	[203086] = 58, -- Mark of Lethon (dot, stacks)
	-- Shadow Burst (dot, stacks)
	[204044] = 59, -- Shadow Burst (dot, stacks)
	-- Taerar
	-- Mark of Taerar (dot, stacks)
	[203121] = 60, -- Mark of Taerar (dot, stacks)
	-- Seeping Fog (dot, sleep, magic)
	[205341] = 61, -- Seeping Fog (dot, sleep, magic)
	-- Bellowing Roar (fear)
	[204078] = 62, -- Bellowing Roar (fear)
	-- Lumbering Mindgorger
	-- Collapsing Nightmare (debuff reduces dam 50%, missed interrupt) (disabled)
	[214543] = 63, -- Collapsing Nightmare (debuff)
	-- Cenarius
	-- Stage One
	-- Malfurion Stormrage
	-- Cleansed Ground (buff)
	[212681] = 71, -- Cleansed Ground (buff)
	-- Cenarius
	-- Creeping Nightmares (debuff, stacks)
	[210279] = 72, -- Creeping Nightmares (debuff, stacks)
	-- Nightmare Brambles (dot, root, magic)
	[210315] = 73, -- Nightmare Brambles (dot, root, magic)
	-- Nightmare Blast (tank debuff, stacks) (Mythic)
	[213162] = 74, -- Nightmare Blast (tank debuff, stacks)
	-- Forces of Nightmare
	-- Corrupted Wisp
	-- Nightmare Ancient
	-- Desiccating Stomp (melee split damage debuf, stacksf)
	[226821] = 75, -- Desiccating Stomp (melee debuff, stacks)
	-- Rotten Drake
	-- Twisted Sister
	-- Nightmare Javelin (dot, magic)
	[211507] = 76, -- Nightmare Javelin (dot, magic)
	-- Scorned Touch (spreading dot, slow)
	[211471] = 77, -- Scorned Touch (dot, spreads)
	-- Allies of Nature
	-- Wisp
	-- Cleansed Ancient
	-- Emerald Drake
	-- Ancient Dream (buff)
	[216516] = 78, -- Ancient Dream (buff)
	-- Redeemed Sister
	-- Unbound Touch (buff, spread Unbound Essence after 4 sec)
	[211989] = 79, -- Unbound Touch (buff, spreads)
	-- Unbound Essence
	[211990] = 80, -- Unbound Essence (buff)
	-- Stage Two
	-- Cenarius
	-- Spear of Nightmares (tank debuff, stacks)
	[214529] = 81, -- Spear of Nightmares (tank debuff, stacks)
	-- Xavius
	-- The Dream (95%, 60%)
	-- Dream Simulacrum (buff)
	[206005] = 91, -- Dream Simulacrum (buff)
	-- Awakening to the Nightmare
	[206109] = 92, -- Awakening to the Nightmare (buff)
	-- Nightmare Corruption
	-- Dread Abomination
	-- Unfathomable Reality
	-- Descent into Madness (buff before mind control)
	[208431] = 93, -- Descent into Madness (buff)
	-- Madness (mind control)
	[207409] = 94, -- Madness (mind control)
	-- Stage One
	-- Darkening Soul (dot, magic, explosion on dispel)
	[206651] = 95, -- Darkening Soul (dot, magic)
	-- Nightmare Blades (fixate)
	[211802] = 96, -- Nightmare Blades (fixate)
	-- Corruption Horror
	-- Lurking Terror
	-- Tormenting Fixation (fixate)
	[205771] = 97, -- Tormenting Fixation (fixate)
	-- Stage Two
	-- Blackening Soul (dot, magic, debuff on dispel)
	[209158] = 98, -- Blackening Soul (dot, magic)
	-- Blackened? (debuff)
	[205612] = 99, -- Blackened? (debuff)
	-- Bonds of Terror (linked with another player)
	[210451] = 100, -- Bonds of Terror (link)
	-- Inconceivable Horror
	-- Tainted Discharge (standing in)
	[208385] = 101, -- Tainted Discharge (standing in)
	-- Stage Three
	-- Nightmare Tentacle
	-- The Infinite Dark? (dot, standing in environment?)
	[211634] = 102, -- The Infinite Dark (standing in?)
	-- LEGION/Nighthold
	-- Crystalline Scorpid
	[204766] = 11, -- Energy Surge (non-dispellable, stacks) (DMG + Debuff)
	-- Chromatic Exoskeleton
	[214657] = 12, -- Acidic Fragments (non-dispellable) (DMG + Debuff)
	[214662] = 13, -- Volatile Fragments (non-dispellable) (DMG + Debuff)
	-- Arcanoslash
	[211659] = 14, -- Arcane Tether (non-dispellable, stacks) (Stacking Ground AoE)
	[204471] = 15, -- Focused Blast (non-dispellable) (Frontal Cone AoE)
	-- Chronomatic Anomaly
	[206607] = 21, -- Chronometric Particles (non-dispellable, stacks) (Stacking DoT)
	[206609] = 22, -- Time Release (non-dispellable) (heal absorb)
	[206617] = 23, -- Time Bomb (non-dispellable) (Not a Debuff?)
	[212099] = 24, -- Temporal Charge (non-dispellable) (DoT)
	-- Trilliax
	[206482] = 31, -- Arcane Seepage (non-dispellable) (Ground AoE)
	-- The Cleaner
	[206788] = 32, -- Toxic Slice (non-dispellable) (DMG + Debuff Stacking DoT)
	[214573] = 32, -- Stuffed (non-dispellable)
	-- Spellblade Aluriel
	-- Chamion of Blades
	[212492] = 41, -- Annihilate (non-dispellable) (DMG + Tank Debuff)
	-- Master of Frost
	[212587] = 42, -- Mark of Frost (non-dispellable) (DMG + Increase DMG taken per stack explodes if two people with it get close)
	[212647] = 43, -- Frostbitten (non-dispellable, Stacks)
	[212736] = 44, -- Pool of Frost (Ground AOE)
	[213083] = 45, -- Frozen Tempest (non-dispellable) (DoT)
	-- Master of Fire
	[213166] = 46, -- Searing Brand (non-dispellable, Stacks)
	[213278] = 47, -- Burning Ground (Ground AOE)
	-- Master of the Arcane
	[213504] = 48, -- Arcane Fog (Ground AOE)
	-- Fel Soul
	[230414] = 49, -- Fel Stomp (Ground AOE)
	-- Tichondrius
	-- Stage One
	[206480] = 51, -- Carrion Plague (non-dispellable) (DoT)
	[213238] = 52, -- Seeker Swarm (non-dispellable) (DMG + Adds Carrion Plague DoT)
	[212795] = 53, -- Brand of Argus (non-dispellable) (Explodes if players clump)
	[208230] = 54, -- Feast of Blood (non-dispellable) (Increases DMG Taken)
	-- The Nightborne Felsworn Spellguard
	[216024] = 55, -- Volatile Wound (non-dispellable, Stacks) (DMG + Increases Future DMG Taken)
	-- The Legion Sightless Watcher
	[216040] = 56, -- Burning Soul (dispellable) (DMG + Mana Drain + Explode on Dispell)
	-- Krosus
	[208203] = 61, -- Isolated Rage (non-dispellable) (Ground AoE Not Avoidable)
	[206677] = 62, -- Searing Brand (non-dispellable, Stacks)
	-- High Botanist Tel'arn
	-- Arcanist Tel'arn
	[218502] = 71, -- Recursive Strikes (non-dispellable, stacks) (Increases DMG Taken)
	-- Naturalist Tel'arn
	[219049] = 72, -- Toxic Spores (non-dispellable) (Ground AoE)
	[218424] = 73, -- Parasitic Fetter (dispellable) (Root + Increaseing DMG)
	[218809] = 74, -- Call of Night
	-- Star Augur Etraeus
	-- Stage Two
	[206585] = 81, -- Absolute Zero (non-dispellable, stacks) (DMG + Dispellable by Player Clump That then causes Chill)
	[206936] = 82, -- Icy Ejection (non-dispellable, stacks) (DoT + Slow-to-Stun)
	-- Stage Three
	[206388] = 83, -- Felburst (non-dispellable, stacks) (DMG + DoT)
	[205649] = 84, -- Fel Ejection (non-dispellable, stacks) (DMG + DoT)
	-- Stage Four
	[206965] = 85, -- Voidburst (non-dispellable) (DoT)
	[207143] = 86, -- Void Ejection (non-dispellable) (DMG + DoT)
	-- Grand Magistrix Elisande
	-- Stage Three
	[211258] = 91, -- Permeliative Torment (non-dispellable) (DoT)
	[209598] = 92, -- Conflexive Burst
	[209971] = 93, -- Ablative Pulse
	-- Gul'dan
	-- Stage One
	-- Inquisitor Vethriz
	[212568] = 101, -- Drain (dispellable) (Life Steal)
	-- D'zorykx the Trapper
	[206883] = 102, -- Soul Vortex (non-dispellable, stacks) (AoE DMG + DoT)
	-- Gul'dan
	[206222] = 103, -- Bonds of Fel (non-dispellable) (chain + Slow + Explosion when seperated)
	[206221] = 104, -- Empowered Bonds of Fel (non-dispellable) (chain + Slow + Explosion when seperated)
	-- Dreadlords of the Twisting Nether
	[208672] = 105, -- Carrion Wave (non-dispellable) (AoE DMG + Sleep)
	-- Gul'dan
	[208903] = 106, -- Burning Claws (non-dispellable) (ground AoE)
	[208802] = 107, -- Soul Corrosion (non-dispellable) (DMG + DoT)
	-- LEGION/Tombof Sargeras
	-- Goroth
	[233279] = 11, -- Shattering Star
	[230345] = 12, -- Crashing Comet
	[231363] = 13, -- Burning Armor
	-- Demonic Inquisition
	[233430] = 21, -- Ubearable Torment
	[233983] = 22, -- Echoing Anguish
	-- Harjatan
	[231770] = 31, -- Drenched
	[231998] = 32, -- Jagged Abrasion
	-- Sisters of the Moon
	[236603] = 41, -- Rapid Shot
	[234996] = 42, -- Umbra Suffusion
	[234995] = 43, -- Lunar Suffusion
	[236519] = 44, -- Moon Burn
	[236697] = 45, -- Deathly Screech
	[236550] = 46, -- Discorporate
	[239264] = 47, -- Lunar Fire
	[233263] = 48, -- Embrace of the Eclipse
	-- Mistress Sassz'ine
	[230959] = 51, -- Concealing Murk
	[232722] = 52, -- Slicing Tornado
	[232913] = 53, -- Befouling Ink
	[234621] = 54, -- Devouring Maw
	[230201] = 55, -- Burden of Pain
	-- The Desolate Host
	[236072] = 61, -- Wailing Souls
	[236449] = 62, -- Soulbind
	[236515] = 63, -- Shattering Scream
	[235989] = 64, -- Tormented Cries
	[236131] = 65, -- Wither
	-- Maiden of Vigilance
	[235117] = 71, -- Unstable Soul
	[235534] = 72, -- Creator's Grace
	[235538] = 73, -- Demon's Vigor
	[234891] = 74, -- Wrath of the Creators
	[235569] = 75, -- Hammer of Creation
	[235573] = 76, -- Hammer of Obliteration
	-- Fallen Avatar
	[239058] = 81, -- Touch of Sargeras
	[239739] = 82, -- Dark Mark
	[234059] = 83, -- Unbound Chaos
	[240213] = 84, -- Chaos Flames
	[236604] = 85, -- Shadowy Blades
	[236494] = 86, -- Desolate
	-- Kil'jaeden
	[238999] = 91, -- Darkness of a Thousand Souls
	[239155] = 92, -- Gravity Squeeze
	[234295] = 93, -- Armageddon Rain
	[240908] = 94, -- Armageddon Blast
	[239932] = 95, -- Felclaws
	[240911] = 96, -- Armageddon Hail
	-- LEGION/Trial of Valor
	-- Trash
	[232450] = 1, -- Corrupted Axion
	[228883] = 1, -- Unholy Reckoning
	-- Guarm
	[228226] = 11, -- Flame Lick
	[228246] = 12, -- Frost Lick
	[228250] = 13, -- Shadow Lick
	[227539] = 14, -- Fiery Phlegm
	[227566] = 15, -- Salty Spittle
	[227570] = 16, -- Dark Discharge
	[228744] = 17, -- Flaming Volatile Foam
	[228810] = 18, -- Briney Volatile Foam
	[228818] = 19, -- Shadowy Volatile Foam
	-- Helya
	[227903] = 21, -- Orb of Corruption
	[228058] = 22, -- Orb of Corrosion
	[228054] = 23, -- Taint of the Sea
	[193367] = 24, -- Fetid Rot
	[227982] = 25, -- Bilewater Redox
	[228519] = 26, -- Anchor Slam
	[202476] = 27, -- Rabid
	[232450] = 28, -- Corrupted Axion
	-- Odyn
	[227959] = 31, -- Storm of Justice
	[227475] = 32, -- Cleansing Flame
	[192044] = 33, -- Expel Light
	[227781] = 34, -- Glowing Fragment
	-- WOD/Blackrock Foundry
	-- Slagworks/Black Forge trash
	-- Orgron Hauler
	[175752] = 1, -- Slag Breath (frontal cone debuff)
	[175765] = 1, -- Overhead Smash (tank debuff)
	-- Workshop Guardian
	[175624] = 1, -- Grievous Mortal Wounds (stacking healing debuff)
	[175643] = 1, -- Spinning Blade (dot, standing in)
	-- Iron Flame Binder
	-- Iron Slag-Shaper
	[175603] = 1, -- Gripping Slag (AoE dot, root)
	-- Ironworker
	[175668] = 1, -- Hammer Throw (dam increase)
	-- Slagshop Brute
	-- Slagshop Worker
	[175987] = 1, -- Puncture Wound (stacking dot)
	-- Oregorger trash (Depository)
	-- Darkshard Acidback
	[159686] = 1, -- Acidback Puddle (dot, standing in)
	-- Darkshard Gnasher
	[159632] = 1, -- Insatiable Hunger (fixate)
	[159520] = 1, -- Shattering Charge (stun)
	-- Darkshard Crystalback
	[159939] = 1, -- Acidmaw (stacking debuff)
	-- Hans'gar and Franzok trash (Slagmill Press)
	-- Blackrock Enforcer
	[160260] = 1, -- Fire Bomb (dot, standing in)
	[160109] = 1, -- Intimidation (damage reduction)
	-- Blackrock Forge Specialist

	-- Beastlord Darmac trash (Breaking Grounds)
	-- Iron Assembly Warden
	[162516] = 1, -- Whirling Steel (dot)
	[162508] = 1, -- Shield Slam (stun)
	-- Iron Marksman
	[162748] = 1, -- Scatter Shot (disorient)
	[162757] = 1, -- Ice Trap (attack speed/movement debuff)
	-- Thunderlord Beast-Tender
	[162663] = 1, -- Electrical Storm (dot, standing in)
	-- Ornery Ironhoof
	[162672] = 1, -- Goring Swipe (dot)
	-- Stubborn Ironhoof
	-- Markog Aba'dir
	-- Gruul trash
	-- Gronnling Labroer
	-- Iron Journeyman
	-- Karnor the Cruel (mini-boss)
	[188189] = 1, -- Fel Poison (dot, dispellable)
	-- Burning Font trash
	-- Enchanted Armament
	-- Iron Flametwister
	-- Iron Journeyman (duplicate)
	-- Iron Taskmaster
	[163126] = 1, -- Bonk (tank disorient)
	-- Iron Smith
	-- Flamebender Ka'graz trash
	-- Mol'dana Two-Blade (mini-boss)
	[177855] = 1, -- Ember in the Wind (AoE dot)
	[177891] = 1, -- Rising Flame Kick (tank dot)
	-- Operator Thogar trash
	-- same trash as during the boss fight, trash is listed under the boss
	-- Exhaust vent
	[174773] = 1, -- Exhaust Fumes (dot, standing on)
	-- The Blast Furnace trash
	-- Slag Behemoth
	[156345] = 1, -- Ignite (player explodes)
	-- Kromog trash
	-- just one pack of Burning Font trash between Flamebender and Kromog
	-- The Iron Maidens trash
	-- Aquatic Technician
	-- Iron Dockworker
	-- Iron Earthbinder
	-- Iron Mauler
	-- Iron Cleaver
	[171537] = 1, -- Reaping Whirl (dot)
	-- Blackhand trash
	-- Flame Jets
	[175577] = 1, -- Flame Jets (dot, standing in)
	-- Forgemistress Flamehand
	-- Burning is duplicate to Operator Thogar ability
	[175583] = 1, -- Living Blaze (AoE dot, dam nearby players)
	-- Unknown trash
	-- Fungal Spores (debuff that is a buff?)
	[174704] = 1, -- Fungal Spores (disabled)
	-- Bosses
	-- Oregorger
	[173471] = 11, -- Acid Maw (dot, nondispellable)
	[156297] = 12, -- Acid Torrent (tank debuff)
	[156374] = 13, -- Explosive Shard (stun)
	[155900] = 14, -- Rolling Fury (knocked down)
	-- Retched Blackrock
	[156203] = 15, -- Retched Blackrock (standing in pool?)
	-- Hans'gar and Franzok
	-- both have these abilities
	[157853] = 21, -- Aftershock (dot)
	[156938] = 22, -- Crippling Suplex (picked up)
	[157139] = 23, -- Shattered Vertebrae (increase dam)
	-- Searing Plates
	[161570] = 24, -- Searing Plates (standing on)
	-- Grill
	[155818] = 24, -- Scorching Burns (standing on)
	-- Beastlord Darmac
	-- Phase 1
	[154960] = 31, -- Pinned Down (stun, dot)
	-- Cruelfang
	[155061] = 32, -- Rend and Tear (dot, increase dam, stacks)
	-- Dreadwing
	[154989] = 33, -- Inferno Breath (dot, dispellable)
	[154981] = 34, -- Conflagration (AoE dot, dispellable)
	[155030] = 35, -- Seared Flesh (tank dot, stacks)
	-- Ironcrusher
	[155236] = 36, -- Crush Armor (tank stacking debuff)
	-- Phase 3
	[155499] = 37, -- Superheated Shrapnel (dot, dispellable)
	[155657] = 38, -- Flame Infusion (standing in fire)
	-- Mythic
	-- Faultline
	[159044] = 39, -- Epicenter (standing in, movement debuff)
	[162276] = 40, -- Unsteady
	[155222] = 41, -- TANTRUM (not a debuff)
	-- Gruul
	[155080] = 51, -- Inferno Slice (dot, nondispellable)
	[162322] = 52, -- Inferno Strike (tank debuff)
	[155078] = 53, -- Overwhelming Blows (tank debuff)
	[173192] = 54, -- Cave In
	[155323] = 55, -- Petrifying Slam (knockback flying)
	[155330] = 56, -- Petrify (movement, petrify)
	[155506] = 57, -- Petrified
	-- Mythic
	[165298] = 58, -- Flare (debuff, nondispellable)
	-- Flamebender Ka'graz
	[155277] = 61, -- Blazing Radiance (AoE dot)
	[163284] = 62, -- Rising Flames (tank dot, stacks)
	[154932] = 63, -- Molten Torrent (split damage)
	-- Lava Slash
	[155314] = 64, -- Lava Slash (standing in, not high damage)
	-- Cinder Wolf
	[154952] = 65, -- Fixate
	[155074] = 66, -- Charring Breath (stacking debuff)
	[155049] = 67, -- Singe (dot, dispellable)
	[162293] = 68, -- EMPOWEREDARMAMENT -- not a debuff
	[155493] = 68, -- FIRESTORM -- not a debuff
	[163633] = 68, -- MAGMAMONSOON -- not a debuff
	-- Operator Thogar
	[155921] = 71, -- Enkindle (stacking tank dot)
	[165195] = 72, -- Prototype Pulse Grenade (standing in)
	[164380] = 73, -- Burning (stacking dot, dispellable)
	-- Iron Raider
	[155701] = 74, -- Serrated Slash (dot)
	-- Grom'kar Firemender
	[156310] = 75, -- Lava Shock (dot, dispellable)
	-- Cauterizing Bolt is an offensive dispel
	-- Iron Gunnery Sergeants
	[159481] = 76, -- Delayed Siege Bomb (targetted)
	-- Iron Crack-Shots
	-- Grom'kar Men-at-Arms
	-- The Blast Furnace
	-- Heart of the Mountain
	[155240] = 81, -- Tempered (tank debuff)
	[155242] = 82, -- Heat (stacking tank dot)
	[155225] = 83, -- Melt (create void zone)
	-- Furnace Engineer
	[155192] = 84, -- Bomb (carrying the bomb)
	-- Foreman Feldspar
	[156934] = 85, -- Rupture (create void zone)
	[158246] = 86, -- Hot Blooded (dot from being near)
	-- Firecaller
	[176121] = 87, -- Volatile Fire (player explodes)
	-- Slag Elemental
	[155196] = 88, -- Fixate
	-- Slag Pool
	[155743] = 89, -- Slag Pool (standing in)
	-- Unknown
	[175104] = 90, -- Melt Armor (is this for this boss?)
	-- Bellows Operator
	-- Security Guard
	-- Primal Elementalist
	-- Kromog
	[157059] = 101, -- Rune of Grasping Earth (dot until killed)
	[156766] = 102, -- Warped Armor (stacking tank debuff)
	[161839] = 103, -- Rune of Crushing Earth (stun, non-dispellable)
	[156844] = 104, -- Stone Breath (dot, no one in melee)
	-- The Iron Maidens
	-- Admiral Gar'an
	[164271] = 111, -- Penetraing Shot (target, damage split)
	[156631] = 112, -- Rapid Fire (target, damage)
	[159585] = 120, -- DEPLOYTURRET - not a debuff
	-- Enforcer Sorka
	[158315] = 113, -- Dark Hunt (target, teleport to)
	[170395] = 114, -- Sorka's Prey (dam increase)
	-- Marak the Blooded
	[159724] = 115, -- Blood Ritual (target, cone dam)
	[170405] = 116, -- Marak's  Bloodcalling (dam increase)
	[158010] = 117, -- Bloodsoaked Heartseeker (target, bounce damage)
	[156601] = 113, -- SANGUINESTRIKES -- not a debuff
	-- Gorak
	[158692] = 118, -- Deadly Throw (movement)
	-- Iron Eviscerator
	[158702] = 119, -- Fixate
	[158686] = 120, -- Expose Armor (dam increase)
	-- Uk'urogg
	[158683] = 121, -- Corrupted Blood (standing in)
	[156214] = 122, -- Convulsive Shadows (dot dispellable, dam per stack dispelled)
	-- Dominator Turret
	[158601] = 123, -- Dominator Blast (stacking dot, non-dispellable)
	-- Mythic
	-- Swirling Vortex
	[160436] = 124, -- Swirling Vortex (stun)
	-- Blackhand
	[156096] = 131, -- Marked for Death (targetted by Impaling Throw)
	[156743] = 132, -- Impaled (dot)
	[156047] = 133, -- Slagged (dam increase)
	[156401] = 134, -- Molten Slag (dot, nondispellable)
	[156404] = 135, -- Burned (stacking debuff)
	[158054] = 136, -- Massive Shattering Smash (tank dot, dam split)
	[157354] = 137, -- Broken Bones (tank stun)
	[156888] = 138, -- Overheated (phase 3)
	[157000] = 139, -- Attach Slag Bombs (player explodes)
	[156999] = 140, -- Throw Slag Bombs (player explodes)
	-- Siegemaker
	[156653] = 141, -- Fixate
	-- Blaze (from Siegemaker)
	[162490] = 142, -- Blaze (standing in)
	[156604] = 143, -- Burning (dot from Blaze)
	-- Iron Sentry
	[156772] = 144, -- Incendiary Shot (stacking debuff)
	-- Mythic
	[162498] = 145, -- Burning Cinders (stacking dot, dispellable)
	-- WOD/Hellfire Citadel
	-- Trash
	-- Hellfire Assault trash
	-- Gorebound Felcaster
	-- Gorebound Terror
	-- Hulking Berserker is listed under Hellfire Assault
	-- Contracted Engineer
	[185806] = 1, -- Conducted Shock Pulse (stun, dispellable)
	-- Iron Dragoon
	-- Felfire Flamebelcher
	-- Felfire Demolisher
	-- Gorebound Fanatic
	-- Gorebound Cauterizer
	-- Felfire Brazier
	[187459] = 1, -- Fel Shock (dot, dispellable)
	-- Gorebound Corruptor - same abilities as Grand Corruptor U'rogg
	-- Siegeworks Technician

	-- Grand Corruptor U'rogg (mini-boss)
	[190735] = 1, -- Corruption Siphon
	-- Grute (mini-boss) - same abilities as Hulking Berserker

	-- Iron Reaver - no trash

	-- Kormrok trash
	-- Hellfire Guardian
	-- Fel Hellweaver
	[188087] = 1, -- Hellweaving (dot, dispellable)
	-- Fel Touched Seer
	[188216] = 1, -- Blaze (dot)
	-- Shambling Hulk
	-- Iron Peon
	-- Gorebound Assassin
	[188148] = 1, -- Cheap Shot (stun)
	[188189] = 1, -- Fel Poison (dot, dispellable)
	-- Fel Extractor
	[187122] = 1, -- Primal Energies (AoE dot)
	[188482] = 1, -- Fel Infection (dot)
	[188484] = 1, -- Fel Sickness (prevents passing Fel Infection)
	-- Shadow Infuser

	[187099] = 1, -- Residual Shadows (standing in puddle)
	-- Shadow Infuser also does Fel Infection/Sickness
	-- Fiery Enkindler
	[187110] = 1, -- Focused Fire (dot, heavy damage split by nearby)
	[188474] = 1, -- Living Bomb (player explodes)
	-- Fiery Enkindler also does Fel Infection/Sickness
	-- Keen-Eyed Gronnstalker
	-- Armored Skullsmasher
	-- Grim Ambusher
	[188282] = 1, -- Ambush (stun)
	[188287] = 1, -- Rupture (dot)
	[188283] = 1, -- Hemorrhage (dot)
	-- Togdrov -- some of Kormrok's abilities
	-- Sovokk -- some of Kormrok's abilities
	-- Morkronn -- some of Kormrok's abilities, plus
	[188104] = 1, -- Explosive Burst (tank root, explosion)
	-- Court of Blood Trash (Hellfire High Council, Kilrogg)
	-- Hellfire High Council trash
	-- (shares some trash mobs with Kormrok)
	-- Fel-Starved Trainee

	-- Graggra (mini-boss, skipable)
	[188476] = 1, -- Bad Breath (tank swap debuff, stacks)
	[188448] = 1, -- Blazing Fel Touch (all players explode)
	[188510] = 1, -- Graggra Smash (stun, AoE on player)
	-- Kilrogg trash
	-- Salivating Bloodthirster (become Hulking Terrors)
	-- Hulking Terror (listed under Kilrogg)
	-- Bleeding Grunt
	-- Bleeding Darkcaster
	[182644] = 1, -- Dark Fate (root, damage split)
	-- Halls of the Sargerei trash (Socrethar and Tyrant)
	-- Eredar Faithbreaker
	[184587] = 1, -- Touch of Mortality
	-- Hellfire Antechamber trash
	-- Gorefiend trash (Maw of Souls)
	-- Gorebound Berserker
	[184300] = 1, -- Fel Blaze (dot)
	-- Gorebound Brute
	-- Fel Fury is listed under Enraged Spirit for Gorefiend, same spell id
	-- Gorebound Bloodletter
	[184102] = 1, -- Corrupted Blood (dot, stacks, dispellable but jumps)
	-- Gorebound Crone (mini-boss)

	-- Grommash's Torment trash (Shadow-Lord Iskar and Fel Lord Zakuun)
	-- Delusional Zealot
	[186046] = 1, -- Solar Chakram (disorient, dispellable)
	-- Fel Raven (listed under Iskar)
	-- Corrupted Talonpriest (listed under Iskar)
	-- Shadowfel Warden

	-- Fel Lord Zakuun trash
	-- Dag'gorath (mini-boss)
	[186197] = 1, -- Demonic Sacrifice (stun, dot)
	[186384] = 1, -- Noxious Cloud (smoke bomb, dot)
	-- Dark Devourer
	-- Shadow Burster
	-- Mek'barash (mini-boss)
	-- Fel Scorcher
	-- Succubus (Glynevere, Cattwen, Bryanda)
	-- Felguards (Zerik'shekor, Shao'ghun, Vazeel'fazag)
	[184388] = 1, -- Whirling (spin AoE)
	-- The Felborne Breach trash (Xhul'horac)
	-- Weaponlord Mehlkhior
	[190043] = 1, -- Felblood Strike (dam buff until 10 stacks)
	[190044] = 1, -- Felblood Corruption (player is bomb)
	[190012] = 1, -- Demonic Leap (stun)
	-- Voidscribe Aathalos
	-- Halls of the Sargerei trash (Socrethar)
	-- Sargerei Enforcer
	[189556] = 1, -- Sunder Armor (tank debuff stack)
	-- Sargerei Soul Cleaver
	[189551] = 1, -- Devouring Spirit (dot, magic dispellable)
	-- Sargerei Adjutant
	[189554] = 1, -- Consuming Pain (dot, stacks, magic dispellable)
	-- Sargerei Bannerman
	[189539] = 1, -- Shockwave (stun)
	-- Construct Peacekeeper
	[189596] = 1, -- Protocol: Crowd Control (short disorient, dispellable)
	-- Korvos
	[189564] = 1, -- Torpor (sleep, dispellable, spreads to nearby players on dispel)
	-- Carrion Swarm (cast on players by Korvos)
	[189560] = 1, -- Carrion Swarm (dot)
	-- Binder Eloah
	[189533] = 1, -- Sever Soul (tank swap debuff)
	-- Binder Hallaani
	[189532] = 1, -- Soulsear (AoE dot)
	-- Mystic Aaran
	[189531] = 1, -- Soulbane (dot, stacks, magic dispellable)
	-- Mystic Velrrun
	-- Amphitheater of the Eternal (Tyrant Velhari)
	-- Portal Guardian
	[184734] = 1, -- Hellfire Slash (cone dot, magic dispellable
	-- Somber Guardian
	-- Darkcaster Adept
	-- Grim Collaborator
	[181962] = 1, -- Corrupting Slash (buff/debuff, dispellable)
	-- Umbral Supplicant
	-- Shadowheart Fiend
	[184725] = 1, -- Shadowflame Blast (healing absorb, dispellable)
	-- Slavering Hound
	[184730] = 1, -- Terrifying Howl (short fear, dispellable)
	-- Lord Aram'el (mini-boss)
	[184721] = 1, -- Shadow Bolt Volley (debuff, stacks, not dispellable)
	-- Eredar Faithbreaker
	[184621] = 1, -- Hellfire Blast (debuff, not dispellable)
	-- Vindicator Bramu
	-- Seal of Decay is also used by Tyrant Velhari
	[184986] = 1, -- Seal of Decay (tank debuff stack, healing reduction)
	-- Protector Bajunt
	-- Seal of Decay is also used by Tyrant Velhari
	-- Adjunct Kuroh
	-- Seal of Decay is also used by Tyrant Velhari
	-- Destructor's Rise trash (Mannoroth)
	-- Archimonde trash
	-- Anetheron
	[189470] = 1, -- Sleep (sleep)
	-- Carrion Swarm is duplicate name
	[189464] = 1, -- Carrion Swarm (healing debuff)
	-- Towering Infernal
	[189488] = 1, -- Impact (stun)
	-- Kaz'rogal
	[189504] = 1, -- Warm Stomp (stun)
	[189512] = 1, -- Mark of Kaz'rogal (debuff, not dispellable, mana drain/AoE)
	-- Azgalor
	[189538] = 1, -- Doom (debuff, not dispellable, summons mob)
	[189550] = 1, -- Rain of Fire (standing in)
	-- Lesser Doomguard
	[189544] = 1, -- Cripple (debuff, not dispellable)
	-- Bosses
	-- Hellfire Assault
	[156096] = 11, -- MARKEDFORDEATH
	-- Siegemaster Mar'tak
	[184369] = 11, -- Howling Axe (targetted)
	-- Hulking Berserker
	[184243] = 12, -- Slam (stackable tank debuff, nondispellable)
	[184238] = 13, -- Cower (movement)
	-- Felfire Crusher
	[180022] = 14, -- Bore (frontal cone damage)
	-- Gorebound Siegeriders (riding on Felfire Crusher)
	[185157] = 15, -- Burn (cone dot)
	-- Felfire Munitions
	[180079] = 16, -- Felfire Munitions (carrying, dot)
	-- Iron Reaver
	[182280] = 21, -- Artillery (targetted)
	[185242] = 22, -- Blitz (carry, silence, dispellable, stacks)
	[182003] = 23, -- Fuel Streak (movement)
	[182074] = 24, -- Immolation (stacking dot)
	[182001] = 25, -- Unstable Orb (stacking dot)
	-- Volatile Firebomb
	[185978] = 26, -- Firebomb Vulnerability (stacking debuff)
	-- Kormrok
	[181306] = 31, -- Explosive Burst (tank stun, explosion)
	[181321] = 32, -- Fel Touch (debuff, not dispellable)
	-- Grasping Hand
	[188081] = 33, -- Crush (dot)
	-- Crushing Hand (grabs tank until it is killed)
	[181345] = 34, -- Foul Crush (tank dot)
	-- Fiery Pool
	[186559] = 35, -- Fiery Pool (standing in pool)
	-- Fiery Globule
	[185519] = 36, -- Fiery Globule (dot)
	-- Shadowy Pool
	[181082] = 37, -- Shadowy Pool (standing in pool)
	-- Shadow Globule
	[180270] = 38, -- Shadow Globule (dot)
	-- Foul Pool
	[186560] = 39, -- Foul Pool (standing in pool)
	-- Foul Globule
	[185521] = 40, -- Foul Globule (dot)
	-- Hellfire High Council
	-- Dia Darkwhisper
	-- Mark of the Necromancer changes colors and increases damage over time
	-- This may be a canditate for priority by spell id when that code is added
	[184450] = 51, -- Mark of the Necromancer (dot, dispellable)
	[184652] = 52, -- Reap (standing in puddle?)
	-- Blademaster Jubei'thos
	-- Gurtogg Bloodboil
	[184847] = 53, -- Acidic Wound (tank dot, stacks)
	[184358] = 54, -- Fel Rage (aggro target)
	[184357] = 55, -- Tainted Blood (debuff, stacks)
	-- Mythic
	[184355] = 56, -- Bloodboil (dot, stacks)
	-- Kilrogg Deadeye
	[188929] = 61, -- Heart Seeker (targetted)
	[188852] = 62, -- Blood Splatter (standing in Heart Seeker pool)
	[182159] = 63, -- Fel Corruption (dot) (on everyone?)
	[180200] = 64, -- Shredded Armor (tank debuff, stacks)
	[181488] = 65, -- Vision of Death (zoned, dot)
	-- Debuffs that are buffs, ignore
	[185563] = 66, -- Undying Salvation (healer buff, disabled)
	[180718] = 67, -- Undying Resolve (dps buff, disabled)
	[187089] = 68, -- Cleansing Aura (disabled)
	-- Hulking Terror
	[189612] = 69, -- Rending Howl (dot)
	-- Hellblaze Imp
	-- Hellblaze Fiend
	[180575] = 62, -- Fel Flames (standing in)
	-- make sure stacks and duration are shown for the other spell with the same name
	[180575] = 70, -- Fel Flames (standing in)
	-- Hellblaze Mistress
	[180033] = 71, -- Cinder Breath (dot)
	-- Mythic
	-- Fel Puddle
	[184067] = 72, -- Fel Puddle (standing in)
	-- Gorefiend
	[179864] = 81, -- Shadow of Death (sent to stomach after 5 sec)
	[181295] = 82, -- Digest (dot, in stomach)
	[179867] = 83, -- Gorefiend's Corruption (stomach debuff, death is permanent)
	[179978] = 84, -- Touch of Doom  (player spawns void zone)
	[179995] = 86, -- Doom Well (standing in puddle)
	[179909] = 85, -- Shared Fate (dot) (179908 non-rooted, 179909 rooted)
	-- Enraged Spirit (tank add in stomach)
	[182601] = 86, -- Fel Fury (standing in puddle, stacks)
	-- Shadowy Construct (dps add in stomach)
	-- Tortured Essence (healer add in stomach)
	-- Gorebound Spirit (Enraged Spirit that made it to center of stomach and spawn outside)
	[185189] = 87, -- Fel Flames (tank dot, stacks) (duplicate name)
	-- Gorebound Construct (Shadowy Construct spawn)
	[180148] = 88, -- Hunger for Life (fixate)
	-- Gorebound Essence (Tortured Essence spawn)
	[180093] = 89, -- Spirit Volley (movement debuff)
	-- Pool of Souls (surrounding boss)
	[186770] = 90, -- Pool of Souls (standing in pool)
	-- Shadow-Lord Iskar
	-- If second debuff is added, might be nice to mark Eye of Anzu for this fight
	[179202] = 101, -- Eye Of Anzu (holding)
	[185239] = 102, -- Radiance of Anzu (Eye of Anzu stacks)
	-- It is important to see who has Phantasmal Winds for passing the Eye of Anzu
	[181957] = 103, -- Phantasmal Winds (player pushed)
	[182325] = 104, -- Phantasmal Wounds (dot)
	[182200] = 105, -- Fel Chakram (targetted)
	[185747] = 106, -- Fel Beam Fixate (fixate)
	[182600] = 107, -- Fel Fire (standing in puddle)
	-- Corrupted Talonpriest
	[179219] = 108, -- Phantasmal Fel Bomb (player is bomb)
	[181753] = 109, -- Fel Bomb (player is bomb, dispellable with eye)
	[179218] = 110, -- Phantasmal Obliteration -- not a debuff
	-- Illusionary Outcast
	-- Fel Raven
	[187990] = 111, -- Phantasmal Corruption (AoE dot)
	[187344] = 112, -- Phantasmal Cremation (dam taken increase)
	-- Mythic
	[185510] = 113, -- Dark Bindings (chained with another player)
	-- Socrethar the Eternal
	[182635] = 121, -- Reverberating Blow not a debuff
	-- Soulbound Construct
	[182038] = 122, -- Shattered Defenses (cone debuff, stacks)
	[189627] = 123, -- Volatile Fel Orb (targetted for explosive orb)
	[189540] = 124, -- Overwhelming Power (dot)
	[182218] = 125, -- Felblaze Residue (standing in fire)
	[180415] = 126, -- Fel Prison (stun, 99% reduction damage taken)
	-- Haunting Soul
	[182769] = 127, -- Ghastly Fixation (targetted)
	[182900] = 128, -- Virulent Haunt (dot, horrify)
	-- Sargerei Dominator
	[184124] = 129, -- Gift Of The Man'ari (dot)
	-- Sargerei Shadowcaller
	[184239] = 130, -- Shadow Word: Agony (dot, stacks, magic dispellable)
	-- Enrage (Soulbound Construct)
	[190922] = 131, -- Unbounded Power (dot, stacks)
	-- Fel Lord Zakuun
	[181508] = 141, -- Seed Of Destruction (player emits waves)
	[179428] = 142, -- Rumbling Fissure (standing in fire)
	[182008] = 143, -- Latent Energy (debuff, explodes if hit)
	[189260] = 144, -- Cloven Soul (tank debuff)
	[179407] = 145, -- Disembodied (Shadow Realm)
	-- Befouled starts red (189030) switches to orange (189031) then to green (189032)
	[179711] = 136, -- Befouled -- not the debuff
	[189030] = 146, -- Befouled (healing absorb)
	[189031] = 136, -- Befouled Orange
	[189032] = 136, -- Befouled Green
	-- Fel Crystal
	[181653] = 147, -- Fel Crystals (standing near)
	-- Mythic
	[188998] = 148, -- Exhausted Soul (debuff, rumbling fissure)
	-- Xhul'horac
	[186134] = 151, -- Feltouched (debuff)
	[186135] = 152, -- Voidtouched (debuff)
	[186407] = 153, -- Fel Surge (dot, drops fire)
	[186333] = 154, -- Void Surge (dot, drops fire)
	[185656] = 155, -- Shadowfel Annihilation (debuff)
	-- Vanguard Akkelion
	[186500] = 156, -- Chains Of Fel
	[186448] = 157, -- Felblaze Flurry (tank debuff stack)
	-- Wild Pyromaniac
	[188208] = 158, -- Ablaze (stacking dot)
	-- Omnus
	[186547] = 159, -- Black Hole (sucking in, dot)
	[186785] = 160, -- Withering Gaze (tank debuff stack)
	-- Unstable Voidfiend
	-- Chaotic Felblaze
	[186073] = 161, -- Felsinged (stacking dot, standing in fire)
	-- Creeping Void
	[186063] = 162, -- Wasting Void (stacking dot, standing in fire)
	-- Tyrant Velhari
	[180166] = 171, -- Touch Of Harm (healing absorb, dispellable, jumps on dispel)
	[180128] = 172, -- Edict Of Condemnation (targetted, split damage)
	[180526] = 173, -- Font of Corruption (targetted by Tainted Shadows)
	[180000] = 174, -- Seal of Decay (tank debuff stack, healing reduction)
	[181683] = 175, -- Aura of Oppression (phase 1 movement causes damage)
	[179987] = 176, -- Aura of Contempt (phase 2 healing debuff)
	[179993] = 177, -- Aura of Malice (phase 3 buff/debuff)
	-- Ancient Enforcer
	-- Ancient Harbinger
	-- Despoiled Ground
	[180604] = 178, -- Despoiled Ground (standing in void zone)
	-- Ancient Sovereign
	-- Mannoroth
	-- Phase 1
	-- Fel Iron Summoner
	-- Demon Portal
	[181099] = 181, -- Mark Of Doom
	[181275] = 182, -- Curse of the Legion (curse, dispellable, summons demon lord)
	-- Doom Lord
	[181119] = 183, -- Doom Spike (tank debuff stack)
	-- Fel Imp
	-- Dread Infernal
	-- Blood of Mannoroth
	[182171] = 184, -- Blood of Mannoroth (standing in pool)
	-- Phase 2
	[181359] = 185, -- Massive Blast (tank debuff)
	[184252] = 186, -- Puncture Wound (tank debuff if no active mitigation)
	[181597] = 187, -- Mannoroth's Gaze (fear, split AoE)
	-- Phase 3
	[181841] = 188, -- Shadowforce (dot, pushback)
	[182113] = 189, -- Lingering Forces (movement buff)
	-- Phase 4
	[182088] = 190, -- Empowered Shadowforce (dot, pushback)
	[182006] = 191, -- Empowered Mannoroth's Gaze (fear, split AoE, leaves puddle)
	-- Gazing Shadows
	[182031] = 192, -- Gazing Shadows (standing in void zone)
	-- Mythic
	[186362] = 193, -- Wrath of Gul'dan (stacked debuff)
	[190482] = 194, -- Gripping Shadows (stacking debuff)
	-- Archimonde
	[185590] = 200, -- Desecrate (not a debuff)
	-- Phase 1
	[183634] = 201, -- Shadowfel Burst (target, thrown in air)
	[183828] = 202, -- Death Brand (tank dot)
	[183963] = 203, -- Light of the Naaru (movement buff, immune to shadow damage)
	-- Doomfire Spirit
	[182879] = 204, -- Doomfire Fixate (target)
	[182878] = 205, -- Doomfire (stacking dot, from stepping in)
	-- Hellfire Deathcaller
	[183864] = 206, -- Shadow Blast (stacking debuff)
	-- Phase 2
	[184964] = 207, -- Shackled Torment (debuff, raid damage when removed)
	[186123] = 208, -- Wrought Chaos (player explodes towards Focused Chaos target)
	[185014] = 209, -- Focused Chaos (target)
	-- Felborne Overfiend
	-- Dreadstalker
	-- Phase 3
	[186961] = 210, -- Nether Banish (tank banish)
	-- Nether Tear
	[189891] = 211, -- Nether Tear (standing in void zone)
	-- Living Shadows
	[187047] = 212, -- Devour Life (healing debuff)
	-- Twisting Nether
	[190341] = 213, -- Nether Corruption (stacking debuff)
	-- Shadowed Netherwalker
	[187255] = 214, -- Nether Storm (standing in)
	-- Void Star
	[189895] = 215, -- Void Star Fixate (fixate)
	-- Mythic
	[190400] = 216, -- Touch of the Legion (debuff)
	[187050] = 217, -- Mark of the Legion (split damage)
	-- Source of Chaos
	[190706] = 218, -- Source of Chaos (stacking debuff)
	-- WOD/Highmaul
	-- Trash
	[175601] = 1, -- Trash TAINTED CLAWS
	[175599] = 1, -- Trash DEVOUR
	[172069] = 1, -- Trash RADIATING POISON
	[172066] = 1, -- Trash RADIATING POISON
	[166779] = 1, -- Trash STAGGERING BLOW
	[56037] = 1, -- Trash RUNE OF DESTRUCTION
	[175654] = 1, -- Trash RUNE OF DISINTEGRATION
	[166185] = 1, -- Trash RENDING SLASH
	[166175] = 1, -- Trash EARTHDEVASTATING SLAM
	[174404] = 1, -- Trash FROZEN CORE
	[173763] = 1, -- Trash WILD FLAMES
	[174500] = 1, -- Trash RENDING THROW
	[174939] = 1, -- Trash Time Stop
	[172115] = 1, -- Trash Earthen Thrust
	[166200] = 1, -- Trash ARCANEVOLATILITY
	[174473] = 1, -- Trash Corrupted Blood
	-- The Butcher
	[156152] = 11, -- GUSHING WOUNDS
	[156151] = 12, -- THE TENDERIZER
	[156143] = 13, -- THE CLEAVER
	[163046] = 14, -- PALE VITRIOL
	-- Kargath Bladefist
	[159113] = 21, -- IMPALE
	[159178] = 22, -- OPENWOUNDS
	[159213] = 23, -- MONSTERS BRAWL
	[158986] = 24, -- BERSERKER RUSH
	[159410] = 25, -- MAULING BREW
	[160521] = 26, -- VILE BREATH
	[159386] = 27, -- IRON BOMB
	[159188] = 28, -- GRAPPLE
	[162497] = 29, -- ON THE HUNT
	[159202] = 30, -- FLAME JET
	-- Twin Ogron
	[158026] = 41, -- ENFEEBLING ROAR
	[158241] = 42, -- BLAZE
	[155569] = 43, -- INJURED
	[167200] = 44, -- ARCANE WOUND
	[159709] = 45, -- WEAKENED DEFENSES 159709 167179
	[163374] = 46, -- ARCANE VOLATILITY
	[158200] = 47, -- QUAKE
	-- Ko'ragh
	[161242] = 51, -- CAUSTIC ENERGY
	[161358] = 52, -- SUPPRESSION FIELD
	[162184] = 53, -- EXPEL MAGIC SHADOW
	[162186] = 54, -- EXPEL MAGIC ARCANE
	[161411] = 55, -- EXPEL MAGIC FROST
	[163472] = 56, -- DOMINATING POWER
	[162185] = 57, -- EXPEL MAGIC FEL
	[156803] = 57, -- NULLIFICATION BARRIER
	-- Tectus
	[162346] = 61, -- CRYSTALLINE BARRAGE
	[162892] = 62, -- PETRIFICATION
	[162475] = 63, -- Tectonic Upheaval
	-- Brackenspore
	[163242] = 71, -- INFESTING SPORES
	[163590] = 72, -- CREEPING MOSS
	[163241] = 73, -- ROT
	[159220] = 74, -- NECROTIC BREATH
	[160179] = 75, -- MIND FUNGUS
	[159972] = 76, -- FLESHEATER
	-- Imperator Mar'gok
	[156238] = 81, -- BRANDED  156238 163990 163989 163988
	[156467] = 82, -- DESTRUCTIVE RESONANCE  156467 164075 164076 164077
	[158605] = 83, -- MARK OF CHAOS  158605 164176 164178 164191
	[164004] = 84, -- BRANDED DISPLACEMENT
	[164075] = 85, -- DESTRUCTIVE RESONANCE DISPLACEMENT
	[164176] = 86, -- MARK OF CHAOS DISPLACEMENT
	[164005] = 87, -- BRANDED FORTIFICATION
	[164076] = 88, -- DESTRUCTIVE RESONANCE FORTIFICATION
	[164178] = 89, -- MARK OF CHAOS FORTIFICATION
	[164006] = 90, -- BRANDED REPLICATION
	[164077] = 91, -- DESTRUCTIVE RESONANCE REPLICATION
	[164191] = 92, -- MARK OF CHAOS REPLICATION
	[157349] = 93, -- FORCE NOVA  157349 164232 164235 164240
	[157763] = 94, -- FIXATE
	[158553] = 95, -- CRUSH ARMOR
	[165102] = 96, -- Infinite Darkness
	[157801] = 97 -- Slow
}
