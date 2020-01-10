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

    -- 各职业减伤、保命技能
    do
        -- MONK
        GridStatusRaidDebuff:DebuffId(zoneid, 115203, 1) -- 壮胆酒
        GridStatusRaidDebuff:DebuffId(zoneid, 116849, 2) -- 作茧缚命

        -- DRUID
        GridStatusRaidDebuff:DebuffId(zoneid, 61336, 1) -- 生存本能
        GridStatusRaidDebuff:DebuffId(zoneid, 22812, 2) -- 树皮术
        GridStatusRaidDebuff:DebuffId(zoneid, 22842, 3) -- 狂暴回复
        GridStatusRaidDebuff:DebuffId(zoneid, 102342, 4) -- 铁木树皮

        -- PRIEST
        GridStatusRaidDebuff:DebuffId(zoneid, 47788, 1) -- 守护之魂
        GridStatusRaidDebuff:DebuffId(zoneid, 33206, 2) -- 痛苦压制

        -- PALADIN
        GridStatusRaidDebuff:DebuffId(zoneid, 642, 1) -- 圣盾术
        GridStatusRaidDebuff:DebuffId(zoneid, 1022, 2) -- 保护祝福
        GridStatusRaidDebuff:DebuffId(zoneid, 204018, 3) -- 破咒祝福
        GridStatusRaidDebuff:DebuffId(zoneid, 86659, 4) -- 远古列王守卫
        GridStatusRaidDebuff:DebuffId(zoneid, 204150, 5) -- 圣光护盾

        -- WARRIOR
        GridStatusRaidDebuff:DebuffId(zoneid, 871, 1) -- 盾墙
        GridStatusRaidDebuff:DebuffId(zoneid, 12975, 2) -- 破釜沉舟

        -- DEMONHUNTER
        GridStatusRaidDebuff:DebuffId(zoneid, 187827, 4) -- 恶魔变形

        -- DEATHKNIGHT
        GridStatusRaidDebuff:DebuffId(zoneid, 48792, 1) -- 冰封之韧
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
