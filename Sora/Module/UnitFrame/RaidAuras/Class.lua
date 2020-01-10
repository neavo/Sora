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

    -- 各职业减伤/保命技能
    do
        GridStatusRaidDebuff:DebuffId(zoneid, 642, 1) -- 圣盾术
        GridStatusRaidDebuff:DebuffId(zoneid, 871, 1) -- 盾墙
        GridStatusRaidDebuff:DebuffId(zoneid, 1022, 1) -- 保护祝福
        GridStatusRaidDebuff:DebuffId(zoneid, 27827, 1) -- 救赎之魂
        GridStatusRaidDebuff:DebuffId(zoneid, 31224, 1) -- 暗影斗篷
        GridStatusRaidDebuff:DebuffId(zoneid, 33206, 1) -- 痛苦压制
        GridStatusRaidDebuff:DebuffId(zoneid, 45438, 1) -- 冰箱
        GridStatusRaidDebuff:DebuffId(zoneid, 47585, 1) -- 消散
        GridStatusRaidDebuff:DebuffId(zoneid, 47788, 1) -- 守护之魂
        GridStatusRaidDebuff:DebuffId(zoneid, 48792, 1) -- 冰封之韧
        GridStatusRaidDebuff:DebuffId(zoneid, 86659, 1) -- 远古列王守卫
        GridStatusRaidDebuff:DebuffId(zoneid, 102342, 1) -- 铁木树皮
        GridStatusRaidDebuff:DebuffId(zoneid, 104773, 1) -- 不灭决心
        GridStatusRaidDebuff:DebuffId(zoneid, 108271, 1) -- 星界转移
        GridStatusRaidDebuff:DebuffId(zoneid, 115203, 1) -- 壮胆酒
        GridStatusRaidDebuff:DebuffId(zoneid, 116849, 1) -- 作茧缚命
        GridStatusRaidDebuff:DebuffId(zoneid, 118038, 1) -- 剑在人在
        GridStatusRaidDebuff:DebuffId(zoneid, 160029, 1) -- 正在复活
        GridStatusRaidDebuff:DebuffId(zoneid, 186265, 1) -- 灵龟守护
        GridStatusRaidDebuff:DebuffId(zoneid, 196555, 1) -- 虚空行走
        GridStatusRaidDebuff:DebuffId(zoneid, 204018, 1) -- 破咒祝福
        GridStatusRaidDebuff:DebuffId(zoneid, 204150, 1) -- 圣光护盾
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
