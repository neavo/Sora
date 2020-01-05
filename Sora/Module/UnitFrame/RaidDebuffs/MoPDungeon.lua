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

	-- MoP Dungeon
	-- Gate of the Setting Sun
	do
		--local zone = "Gate of the Setting Sun"
		local zoneid = 437

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Saboteur Kip'tilak
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Saboteur Kip'tilak")
		GridStatusRaidDebuff:DebuffId(zoneid, 107268, 11, 6, 6)

		--Striker Ga'dok
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Striker Ga'dok")
		GridStatusRaidDebuff:DebuffId(zoneid, 106934, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 107047, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 116297, 23, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 115458, 24, 6, 6)
		--Commander Ri'mok
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Commander Ri'mok")
		--Viscous Fluid
		GridStatusRaidDebuff:DebuffId(zoneid, 107120, 31, 6, 6)
		--Raigonn
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Raigonn")
		GridStatusRaidDebuff:DebuffId(zoneid, 107275, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 111600, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 111723, 43, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 111725, 44, 6, 6)
	end

	-- MoP Dungeon
	-- Mogu'shan Palace
	do
		--local zone = "Mogu'shan Palace"
		local zoneid = 453

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 122962, 11, 6, 6) --Carnivorous Bite
		GridStatusRaidDebuff:DebuffId(zoneid, 120562, 11, 6, 6) --Lightning Storm
		GridStatusRaidDebuff:DebuffId(zoneid, 120560, 11, 6, 6) --Rake
		GridStatusRaidDebuff:DebuffId(zoneid, 123648, 11, 6, 6) --Shock
		GridStatusRaidDebuff:DebuffId(zoneid, 119573, 11, 6, 6) --Ring of Fire
		GridStatusRaidDebuff:DebuffId(zoneid, 121185, 11, 6, 6) --Crunch Armor
		GridStatusRaidDebuff:DebuffId(zoneid, 123647, 11, 6, 6) --Demoralizing Roar
		GridStatusRaidDebuff:DebuffId(zoneid, 123646, 11, 6, 6) --Intimidation

		--Trial of the King
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Trial of the King")
		GridStatusRaidDebuff:DebuffId(zoneid, 119946, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 120100, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 17962, 13, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 120195, 14, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 123655, 15, 6, 6)
		--Gekkan
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Gekkan")
		GridStatusRaidDebuff:DebuffId(zoneid, 118963, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 118903, 22, 6, 6)
		--Xin the Weaponmaster
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Xin the Weaponmaster")
		GridStatusRaidDebuff:DebuffId(zoneid, 119684, 31, 6, 6)
		--Blade Trap
		--Death From Above!
	end

	-- MoP Dungeon
	-- Scarlet Halls
	do
		--local zone = "Scarlet Halls"
		local zoneid = 431

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Houndmaster Braun
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Houndmaster Braun")
		GridStatusRaidDebuff:DebuffId(zoneid, 114056, 11, 6, 6)
		--Armsmaster Harlan
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Armsmaster Harlan")
		GridStatusRaidDebuff:DebuffId(zoneid, 111216, 21, 6, 6)
		--Flameweaver Kogler
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Flameweaver Kogler")
		GridStatusRaidDebuff:DebuffId(zoneid, 113364, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 113616, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 113653, 33, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 11366, 34, 6, 6)
	end

	-- MoP Dungeon
	-- Scarlet Monastery
	do
		--local zone = "Scarlet Monastery"
		local zoneid = 435

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 42380, 1, 6, 6) --Conflagration
		GridStatusRaidDebuff:DebuffId(zoneid, 42514, 1, 6, 6) --Squash Soul

		--Thalnos
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Thalnos")
		GridStatusRaidDebuff:DebuffId(zoneid, 115144, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 115289, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 115297, 13, 6, 6)
		--Brother Korloff
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Brother Korloff")
		GridStatusRaidDebuff:DebuffId(zoneid, 113764, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 114460, 22, 6, 6)
		--High Inquisitor Whitemane
	end

	-- MoP Dungeon
	-- Scholomance
	do
		--local zone = "Scholomance"
		local zoneid = 476

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Instructor Chillheart
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Instructor Chillheart")
		GridStatusRaidDebuff:DebuffId(zoneid, 111631, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 111610, 12, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 51498, 13, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 32860, 14, 6, 6)
		--Jandice Barov
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Jandice Barov")
		GridStatusRaidDebuff:DebuffId(zoneid, 114035, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 113775, 22, 6, 6)
		--Rattlegore
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Rattlegore")
		GridStatusRaidDebuff:DebuffId(zoneid, 114007, 31, 6, 6)
		--Lilian Voss
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Lilian Voss")
		GridStatusRaidDebuff:DebuffId(zoneid, 111585, 41, 6, 6)
		--Darkmaster Gandling
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Darkmaster Gandling")
		GridStatusRaidDebuff:DebuffId(zoneid, 348, 51, 6, 6)
	end

	-- MoP Dungeon
	-- Shado-Pan Monastery
	do
		--local zone = "Shado-Pan Monastery"
		local zoneid = 443

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Saboteur Kip'tilak
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Saboteur Kip'tilak")
		GridStatusRaidDebuff:DebuffId(zoneid, 107268, 11, 6, 6)

		--Gu Cloudstrike
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Gu Cloudstrike")
		GridStatusRaidDebuff:DebuffId(zoneid, 106984, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106941, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 107140, 23, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 102573, 24, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 110852, 25, 6, 6)
		--Master Snowdrift
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Master Snowdrift")
		GridStatusRaidDebuff:DebuffId(zoneid, 106853, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106434, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106352, 33, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106422, 34, 6, 6)
		--Sha of Violence
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Sha of Violence")
		GridStatusRaidDebuff:DebuffId(zoneid, 106872, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106827, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 127576, 43, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106871, 44, 6, 6)
		--Taran Zhu
		GridStatusRaidDebuff:BossNameId(zoneid, 50, "Taran Zhu")
		GridStatusRaidDebuff:DebuffId(zoneid, 107087, 51, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 107357, 52, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 112933, 53, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 112918, 54, 6, 6)
	end

	-- MoP Dungeon
	-- Gate of the Setting Sun
	do
		--local zone = "Gate of the Setting Sun"
		local zoneid = 458

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		--Vizier Jin'bak
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Vizier Jin'bak")
		GridStatusRaidDebuff:DebuffId(zoneid, 120593, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 119941, 12, 6, 6)
		--Commander Vo'jak
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Commander Vo'jak")
		GridStatusRaidDebuff:DebuffId(zoneid, 120778, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 120200, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 120789, 23, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 120759, 24, 6, 6)
		--General Pa'valak
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "General Pa'valak")
		GridStatusRaidDebuff:DebuffId(zoneid, 124283, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 119875, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 119388, 33, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 117631, 34, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 119840, 35, 6, 6)
		--Wing Leader Ner'onok
		GridStatusRaidDebuff:BossNameId(zoneid, 40, "Wing Leader Ner'onok")
		GridStatusRaidDebuff:DebuffId(zoneid, 121442, 41, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 121447, 42, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 121284, 43, 6, 6)
	end

	-- MoP Dungeon
	-- Gate of the Setting Sun
	do
		--local zone = "Gate of the Setting Sun"
		local zoneid = 440

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 106857, 1, 6, 6) --Blackout Drunk
		GridStatusRaidDebuff:DebuffId(zoneid, 107046, 1, 6, 6) --Water Strike
		GridStatusRaidDebuff:DebuffId(zoneid, 114291, 1, 6, 6) --Explosive Brew

		--Ook-Ook
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Ook-Ook")
		GridStatusRaidDebuff:DebuffId(zoneid, 106807, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 107351, 12, 6, 6)
		--Hoptallus
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Hoptallus")
		GridStatusRaidDebuff:DebuffId(zoneid, 112992, 21, 6, 6)
		--Yan-Zhu the Uncasked
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Yan-Zhu the Uncasked")
		GridStatusRaidDebuff:DebuffId(zoneid, 114548, 31, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106546, 32, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106851, 33, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 114451, 34, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 115003, 35, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 114466, 36, 6, 6)
	end

	-- MoP Dungeon
	-- Temple of the Jade Serpent
	do
		--local zone = "Temple of the Jade Serpent"
		local zoneid = 429

		-- zoneid, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
		--true, true is for stackable

		GridStatusRaidDebuff:DebuffId(zoneid, 118714, 1, 6, 6) --Purified Water
		GridStatusRaidDebuff:DebuffId(zoneid, 110125, 1, 6, 6) --Shattered Resolve
		GridStatusRaidDebuff:DebuffId(zoneid, 128051, 1, 6, 6) --Serrated Slash
		GridStatusRaidDebuff:DebuffId(zoneid, 114826, 1, 6, 6) --Songbird Serenade
		GridStatusRaidDebuff:DebuffId(zoneid, 110099, 1, 6, 6) --Shadows of Doubt

		--Wise Mari
		GridStatusRaidDebuff:BossNameId(zoneid, 10, "Wise Mari")
		GridStatusRaidDebuff:DebuffId(zoneid, 115167, 11, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 143459, 12, 6, 6)
		--Lorewalker Stonestep
		--Liu Flameheart
		GridStatusRaidDebuff:BossNameId(zoneid, 20, "Liu Flameheart")
		GridStatusRaidDebuff:DebuffId(zoneid, 106823, 21, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 106841, 22, 6, 6)
		GridStatusRaidDebuff:DebuffId(zoneid, 107045, 23, 6, 6)
		--Sha of Doubt
		GridStatusRaidDebuff:BossNameId(zoneid, 30, "Sha of Doubt")
		GridStatusRaidDebuff:DebuffId(zoneid, 106113, 31, 6, 6)
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
