-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnInitialize(self, event, ...)
	C.UnitFrame = C.UnitFrame or {}
	C.UnitFrame.RaidAuras = C.UnitFrame.RaidAuras or {}
end

local function OnPlayerLogin(self, event, ...)
	-- 优先级数值越大，越优先显示
	-- 10000 副本技能
	-- 20000 通用技能
	-- 30000 职业技能

	-- Season Spell
	C.UnitFrame.RaidAuras[46392] = -65535 -- 专注打击
	C.UnitFrame.RaidAuras[209858] = -65535 -- 死疽
	C.UnitFrame.RaidAuras[240443] = -65535 -- 爆裂
	C.UnitFrame.RaidAuras[373391] = -65535 -- 梦魇
	C.UnitFrame.RaidAuras[373429] = -65535 -- 腐臭虫群

	-- Common
	C.UnitFrame.RaidAuras[160029] = 20000 -- 正在复活

	-- Mage
	C.UnitFrame.RaidAuras[45438] = 30000 + 1 -- 寒冰屏障

	-- Mook
	C.UnitFrame.RaidAuras[115176] = 30000 + 5 -- 禅悟冥想
	C.UnitFrame.RaidAuras[115203] = 30000 + 4 -- 壮胆酒
	C.UnitFrame.RaidAuras[122278] = 30000 + 3 -- 躯不坏
	C.UnitFrame.RaidAuras[122783] = 30000 + 2 -- 散魔功
	C.UnitFrame.RaidAuras[125174] = 30000 + 1 -- 业报之触

	-- Druid
	C.UnitFrame.RaidAuras[61336] = 30000 + 3 -- 生存本能
	C.UnitFrame.RaidAuras[22812] = 30000 + 2 -- 树皮术
	C.UnitFrame.RaidAuras[22842] = 30000 + 1 -- 狂暴回复

	-- Rogue
	C.UnitFrame.RaidAuras[1966] = 30000 + 3 -- 佯攻
	C.UnitFrame.RaidAuras[5277] = 30000 + 2 -- 闪避
	C.UnitFrame.RaidAuras[31224] = 30000 + 1 -- 暗影斗篷

	-- Evoker
	C.UnitFrame.RaidAuras[363916] = 30000 + 2 -- 黑曜鳞片
	C.UnitFrame.RaidAuras[374348] = 30000 + 2 -- 新生光焰
	C.UnitFrame.RaidAuras[370960] = 30000 + 1 -- 翡翠交融

	-- Hunter
	C.UnitFrame.RaidAuras[186265] = 30000 + 2 -- 灵龟守护
	C.UnitFrame.RaidAuras[264735] = 30000 + 1 -- 优胜劣汰

	-- Priest
	C.UnitFrame.RaidAuras[47585] = 30000 + 4 -- 消散
	C.UnitFrame.RaidAuras[19236] = 30000 + 3 -- 绝望祷言
	C.UnitFrame.RaidAuras[586] = 30000 + 2 -- 渐隐术
	C.UnitFrame.RaidAuras[193065] = 30000 + 1 -- 防护圣光

	-- Shaman
	C.UnitFrame.RaidAuras[108271] = 30000 + 2 -- 星界转移
	C.UnitFrame.RaidAuras[210918] = 30000 + 1 -- 灵体形态

	-- Paladin
	C.UnitFrame.RaidAuras[498] = 30000 + 5 -- 圣佑术
	C.UnitFrame.RaidAuras[642] = 30000 + 4 -- 圣盾术
	C.UnitFrame.RaidAuras[31850] = 30000 + 3 -- 炽热防御者
	C.UnitFrame.RaidAuras[212641] = 30000 + 2 -- 远古列王守卫
	C.UnitFrame.RaidAuras[205191] = 30000 + 1 -- 以眼还眼

	-- Warrior
	C.UnitFrame.RaidAuras[871] = 30000 + 5 -- 盾墙
	C.UnitFrame.RaidAuras[12975] = 30000 + 4 -- 破釜沉舟
	C.UnitFrame.RaidAuras[23920] = 30000 + 3 -- 法术反射
	C.UnitFrame.RaidAuras[118038] = 30000 + 2 -- 剑在人在
	C.UnitFrame.RaidAuras[184364] = 30000 + 1 -- 狂怒回复

	-- Warlock
	C.UnitFrame.RaidAuras[104773] = 30000 + 2 -- 不灭决心
	C.UnitFrame.RaidAuras[212295] = 30000 + 1 -- 虚空守卫

	-- Demon Hunter
	C.UnitFrame.RaidAuras[198589] = 30000 + 3 -- 疾影
	C.UnitFrame.RaidAuras[187827] = 30000 + 2 -- 恶魔变形
	C.UnitFrame.RaidAuras[196555] = 30000 + 1 -- 虚空行走

	-- Death Knight
	C.UnitFrame.RaidAuras[48707] = 30000 + 4 -- 反魔法护罩
	C.UnitFrame.RaidAuras[48792] = 30000 + 3 -- 冰封之韧
	C.UnitFrame.RaidAuras[49028] = 30000 + 2 -- 符文刃舞
	C.UnitFrame.RaidAuras[55233] = 30000 + 1 -- 吸血鬼之血
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
