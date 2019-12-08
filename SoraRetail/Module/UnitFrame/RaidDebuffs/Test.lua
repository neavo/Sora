-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
if not C.UnitFrame then
	C.UnitFrame = {}
end
if not C.UnitFrame.RaidAuras then
	C.UnitFrame.RaidAuras = {}
end

-- Hack
local zoneid = 0
local GridStatusRaidDebuff = {}
GridStatusRaidDebuff.DebuffId = function(self, zoneid, spellId, priority)
	C.UnitFrame.RaidAuras[spellId] = priority
end
GridStatusRaidDebuff.BossNameId = function(self, zoneid, _, name)
	-- do nothing
end

-- For Debug
do
	-- GridStatusRaidDebuff:DebuffId(zoneid, 119611, 1)
end
