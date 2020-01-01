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

-- WoD Dungeon
--Auchindoun
do
	--local zone = "Auchindoun"
	local zoneid = 593

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Vigilant Kaathar
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Vigilant Kaathar")
	GridStatusRaidDebuff:DebuffId(zoneid, 153480, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153006, 12, 5, 5)
	GridStatusRaidDebuff:DebuffId(zoneid, 152954, 13, 4, 4)
	GridStatusRaidDebuff:DebuffId(zoneid, 154526, 14, 3, 3)
	GridStatusRaidDebuff:DebuffId(zoneid, 157465, 15, 1, 1)

	--Soulbinder Nyami
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Soulbinder Nyami")
	GridStatusRaidDebuff:DebuffId(zoneid, 154415, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154477, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153477, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154218, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154261, 25, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154241, 26, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154173, 27, 6, 6)

	--Azzakel
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Azzakel")
	GridStatusRaidDebuff:DebuffId(zoneid, 153234, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153396, 32, 6, 6)
	--Claws of Argus
	GridStatusRaidDebuff:DebuffId(zoneid, 154221, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154018, 34, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 157173, 35, 6, 6)
	--Malevolent Crash
	GridStatusRaidDebuff:DebuffId(zoneid, 153500, 36, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153725, 37, 6, 6)

	--Teron'gor
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Teron'gor")
	GridStatusRaidDebuff:DebuffId(zoneid, 156829, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156842, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156854, 43, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156974, 44, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156829, 45, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164841, 46, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156921, 47, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156925, 48, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156854, 49, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156954, 50, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164846, 51, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156964, 52, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156960, 53, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156974, 54, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156963, 55, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164841, 56, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 157041, 57, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156965, 58, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156842, 59, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 157001, 60, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 156968, 61, 6, 6)
end

-- WoD Dungeon
-- Bloodmaul Slag Mines
do
	--local zone = "Bloodmaul Slag Mines"
	local zoneid = 573

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Magmolatus
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Magmolatus")
	GridStatusRaidDebuff:DebuffId(zoneid, 150011, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150344, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 149941, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 149975, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 149997, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150290, 16, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150032, 17, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150034, 18, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150023, 19, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150045, 20, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150011, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150055, 22, 6, 6)

	--Slave Watcher Crushto
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Slave Watcher Crushto")
	GridStatusRaidDebuff:DebuffId(zoneid, 153679, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150759, 32, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150753, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150745, 34, 6, 6)
	--Raise the Miners
	GridStatusRaidDebuff:DebuffId(zoneid, 150807, 35, 6, 6)

	--Roltall
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Roltall")
	GridStatusRaidDebuff:DebuffId(zoneid, 153247, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 152897, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153227, 43, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 167739, 44, 6, 6)

	--Gug'rokk
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Gug'rokk")
	GridStatusRaidDebuff:DebuffId(zoneid, 150677, 51, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150682, 52, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150784, 53, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 150734, 54, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 152091, 55, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163802, 56, 6, 6)
end

-- WoD Dungeon
-- Grimrail Depot
do
	local zoneid = 606

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Rocketspark and Borka
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Rocketspark and Borka")
	GridStatusRaidDebuff:DebuffId(zoneid, 162500, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162407, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161091, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161087, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162617, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161089, 16, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161092, 17, 6, 6)

	--Nitrogg Thundertower
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Nitrogg Thundertower")
	GridStatusRaidDebuff:DebuffId(zoneid, 163550, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163539, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 160681, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166570, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 160702, 25, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 160703, 26, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163550, 27, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 160703, 28, 6, 6)

	--Skylord Tovra
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Skylord Tovra")
	GridStatusRaidDebuff:DebuffId(zoneid, 162066, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162058, 32, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161588, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161801, 34, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163447, 35, 6, 6)
end

-- WoD Dungeon
-- Shadowmoon Burial Grounds
do
	--local zone = "Shadowmoon Burial Grounds"
	local zoneid = 574

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Sadana Bloodfury
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Sadana Bloodfury")
	GridStatusRaidDebuff:DebuffId(zoneid, 162696, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153153, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153240, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153093, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164686, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162652, 16, 6, 6)

	--Nhallish
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Nhallish")
	GridStatusRaidDebuff:DebuffId(zoneid, 153623, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 152801, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 152792, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153067, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153268, 25, 6, 6)
	--Soul Possession
	GridStatusRaidDebuff:DebuffId(zoneid, 152979, 26, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153033, 27, 6, 6)

	--Bonemaw
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Bonemaw")
	GridStatusRaidDebuff:DebuffId(zoneid, 153692, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 165578, 32, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153681, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154175, 34, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153804, 35, 6, 6)
	--Carrion Centipede
	GridStatusRaidDebuff:DebuffId(zoneid, 153681, 36, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154175, 37, 6, 6)

	--Ner'zhul
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ner'zhul")
	GridStatusRaidDebuff:DebuffId(zoneid, 154442, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154353, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154469, 43, 6, 6)
end

-- WoD Dungeon
-- Skyreach
do
	--local zone = "Skyreach"
	local zoneid = 601

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Ranjit
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Ranjit")
	GridStatusRaidDebuff:DebuffId(zoneid, 156793, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153544, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153757, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153315, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 158085, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154043, 16, 6, 6)

	--Araknath
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Araknath")
	GridStatusRaidDebuff:DebuffId(zoneid, 165985, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154135, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 157304, 23, 6, 6)

	--Rukhran
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Rukhran")
	GridStatusRaidDebuff:DebuffId(zoneid, 153794, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153795, 32, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153827, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153828, 34, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169810, 35, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 159381, 36, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 153898, 37, 6, 6)

	--High Sage Viryx --Unknown
	--Cast Down --Unknown
	--Lens Flare --Unknown
	--Solar Burst --Unknown
	--Shielding --Unknown
end

-- WoD Dungeon
-- The Everbloom
do
	--local zone = "The Everbloom"
	local zoneid = 620

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Withrbark
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Withrbark")
	GridStatusRaidDebuff:DebuffId(zoneid, 164275, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164357, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169495, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164294, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164538, 15, 6, 6)

	--Ancient Protectors
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Ancient Protectors")
	GridStatusRaidDebuff:DebuffId(zoneid, 168520, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 173263, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168092, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168082, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168105, 25, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168040, 26, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 167966, 27, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168041, 28, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168187, 29, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168375, 30, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168383, 31, 6, 6)

	--Archmage Sol
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Archmage Sol")
	GridStatusRaidDebuff:DebuffId(zoneid, 166464, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166489, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166465, 43, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166726, 44, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166466, 45, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166751, 46, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168885, 47, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168894, 48, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168895, 49, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166891, 50, 6, 6)

	--Xeri'tac
	GridStatusRaidDebuff:BossNameId(zoneid, 60, "Xeri'tac")
	GridStatusRaidDebuff:DebuffId(zoneid, 169275, 61, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169375, 62, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169376, 63, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169382, 64, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169249, 65, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169218, 66, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169224, 67, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169371, 68, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169233, 69, 6, 6)

	--Yalnu
	GridStatusRaidDebuff:BossNameId(zoneid, 70, "Yalnu")
	GridStatusRaidDebuff:DebuffId(zoneid, 169179, 71, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169120, 72, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169876, 73, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169878, 74, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169929, 75, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169613, 76, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 173536, 77, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 173563, 78, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169251, 79, 6, 6)
end

-- WoD Dungeon
-- Upper Blackrock Spire
do
	--local zone = "Upper Blackrock Spire"
	local zoneid = 617

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Orebender Gor'ashan
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Orebender Gor'ashan")
	GridStatusRaidDebuff:DebuffId(zoneid, 166168, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154417, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154448, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154435, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154899, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 154335, 16, 6, 6)

	--Kyrak
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Kyrak")
	GridStatusRaidDebuff:DebuffId(zoneid, 161199, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161203, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161288, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162644, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155033, 25, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155037, 26, 6, 6)

	--Commander Tharbek
	GridStatusRaidDebuff:BossNameId(zoneid, 30, "Commander Tharbek")
	GridStatusRaidDebuff:DebuffId(zoneid, 161765, 31, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162000, 32, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162097, 33, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161985, 34, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161772, 35, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161833, 36, 6, 6)

	--Ragewing the Untamed
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Ragewing the Untamed")
	GridStatusRaidDebuff:DebuffId(zoneid, 155031, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155051, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155065, 43, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155081, 44, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155620, 45, 6, 6)

	--Warlord Zaela
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Warlord Zaela")
	GridStatusRaidDebuff:DebuffId(zoneid, 155673, 51, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169158, 52, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155705, 53, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 155720, 54, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 166041, 55, 6, 6)
end

-- WoD Dungeon
-- Iron Docks
do
	--local zone = "Iron Docks"
	local zoneid = 595

	-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
	--true, true is for stackable

	--Fleshrender Nok'gar
	GridStatusRaidDebuff:BossNameId(zoneid, 10, "Fleshrender Nok'gar")
	GridStatusRaidDebuff:DebuffId(zoneid, 164648, 11, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164632, 12, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164426, 13, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164835, 14, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164837, 15, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 164734, 16, 6, 6)

	--Grimrail Enforcers
	GridStatusRaidDebuff:BossNameId(zoneid, 20, "Grimrail Enforcers")
	GridStatusRaidDebuff:DebuffId(zoneid, 163689, 21, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163705, 22, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163740, 23, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163668, 24, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 165152, 25, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163376, 26, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163390, 27, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163276, 28, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163376, 29, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163379, 30, 6, 6)

	--Oshir
	GridStatusRaidDebuff:BossNameId(zoneid, 40, "Oshir")
	GridStatusRaidDebuff:DebuffId(zoneid, 163166, 41, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162418, 42, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 162415, 43, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163054, 44, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 163059, 45, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 161256, 46, 6, 6)

	--Skulloc, Son of Gruul
	GridStatusRaidDebuff:BossNameId(zoneid, 50, "Skulloc, Son of Gruul")
	GridStatusRaidDebuff:DebuffId(zoneid, 168929, 51, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 169129, 52, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168399, 53, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168955, 54, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168401, 55, 6, 6)
	GridStatusRaidDebuff:DebuffId(zoneid, 168348, 56, 6, 6)
end
