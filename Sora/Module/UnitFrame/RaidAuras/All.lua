-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	-- Initialize
	C.UnitFrame = C.UnitFrame or {}
	C.UnitFrame.RaidAuras = C.UnitFrame.RaidAuras or {}

	-- Season Spell
	C.UnitFrame.RaidAuras[209858] = -65535 -- 死疽
	C.UnitFrame.RaidAuras[240443] = -65535 -- 爆裂
	C.UnitFrame.RaidAuras[240559] = -65535 -- 重伤
	C.UnitFrame.RaidAuras[342494] = -65535 -- 狂妄吹嘘

	-- Class Spell
	-- Mook
	C.UnitFrame.RaidAuras[115203] = 65535 + 2 -- 壮胆酒
	C.UnitFrame.RaidAuras[116849] = 65535 + 1 -- 作茧缚命

	-- Class Spell
	-- Druid
	C.UnitFrame.RaidAuras[61336] = 65535 + 4 -- 生存本能
	C.UnitFrame.RaidAuras[22812] = 65535 + 3 -- 树皮术
	C.UnitFrame.RaidAuras[102342] = 65535 + 2 -- 铁木树皮
	C.UnitFrame.RaidAuras[22842] = 65535 + 1 -- 狂暴回复

	-- Class Spell
	-- Priest
	C.UnitFrame.RaidAuras[47788] = 65535 + 4 -- 守护之魂
	C.UnitFrame.RaidAuras[33206] = 65535 + 3 -- 痛苦压制
	C.UnitFrame.RaidAuras[27827] = 65535 + 2 -- 救赎之魂
	C.UnitFrame.RaidAuras[47585] = 65535 + 1 -- 消散

	-- Class Spell
	-- Paladin
	C.UnitFrame.RaidAuras[642] = 65535 + 5 -- 圣盾术
	C.UnitFrame.RaidAuras[1022] = 65535 + 4 -- 保护祝福
	C.UnitFrame.RaidAuras[86659] = 65535 + 3 -- 远古列王守卫
	C.UnitFrame.RaidAuras[31850] = 65535 + 2 -- 炽热防御者
	C.UnitFrame.RaidAuras[204018] = 65535 + 1 -- 破咒祝福

	-- Class Spell
	-- Warrior
	C.UnitFrame.RaidAuras[871] = 65535 + 3 -- 盾墙
	C.UnitFrame.RaidAuras[12975] = 65535 + 2 -- 破釜沉舟
	C.UnitFrame.RaidAuras[118038] = 65535 + 1 -- 剑在人在

	-- Class Spell
	-- Demon Hunter
	C.UnitFrame.RaidAuras[187827] = 65535 + 2 -- 恶魔变形
	C.UnitFrame.RaidAuras[196555] = 65535 + 1 -- 虚空行走

	-- Class Spell
	-- Death Knight
	C.UnitFrame.RaidAuras[48792] = 65535 + 1 -- 冰封之韧

	-- Class Spell
	-- Others
	C.UnitFrame.RaidAuras[31224] = 65535 -- 暗影斗篷
	C.UnitFrame.RaidAuras[45438] = 65535 -- 冰箱
	C.UnitFrame.RaidAuras[104773] = 65535 -- 不灭决心
	C.UnitFrame.RaidAuras[108271] = 65535 -- 星界转移
	C.UnitFrame.RaidAuras[160029] = 65535 -- 正在复活
	C.UnitFrame.RaidAuras[186265] = 65535 -- 灵龟守护
	C.UnitFrame.RaidAuras[264735] = 65535 -- 优胜劣汰
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
