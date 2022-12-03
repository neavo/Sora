-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local debuffs = {
	[322] = {
		-- 潘达利亚
		[691] = {},
		[725] = {},
		[814] = {},
		[826] = {},
		[857] = {},
		[858] = {},
		[859] = {},
		[860] = {},
		[861] = {}
	},
	[317] = {
		-- 魔古山宝库
		["general"] = {},
		[679] = {},
		[689] = {},
		[682] = {},
		[687] = {},
		[726] = {},
		[677] = {}
	},
	[330] = {
		-- 恐惧之心
		["general"] = {},
		[745] = {},
		[744] = {},
		[713] = {},
		[741] = {},
		[737] = {},
		[743] = {}
	},
	[320] = {
		-- 永春台
		["general"] = {},
		[683] = {},
		[742] = {},
		[729] = {},
		[709] = {}
	},
	[362] = {
		-- 雷电王座
		["general"] = {},
		[827] = {},
		[819] = {},
		[816] = {},
		[825] = {},
		[821] = {},
		[828] = {},
		[818] = {},
		[820] = {},
		[824] = {},
		[817] = {},
		[829] = {},
		[832] = {}
	},
	[369] = {
		-- 决战奥格瑞玛
		["general"] = {},
		[852] = {},
		[849] = {},
		[866] = {},
		[867] = {},
		[868] = {},
		[864] = {},
		[856] = {},
		[850] = {},
		[846] = {},
		[870] = {},
		[851] = {},
		[865] = {},
		[853] = {},
		[869] = {}
	},
	[324] = {
		-- 围攻砮皂寺
		["general"] = {},
		[693] = {},
		[738] = {},
		[692] = {},
		[727] = {}
	},
	[312] = {
		-- 影踪禅院
		["general"] = {},
		[673] = {},
		[657] = {},
		[685] = {},
		[686] = {}
	},
	[303] = {
		-- 残阳关
		["general"] = {},
		[655] = {},
		[675] = {},
		[676] = {},
		[649] = {}
	},
	[316] = {
		-- 血色修道院
		["general"] = {},
		[688] = {},
		[671] = {},
		[674] = {}
	},
	[311] = {
		-- 血色大厅
		["general"] = {},
		[660] = {},
		[654] = {},
		[656] = {}
	},
	[246] = {
		-- 通灵学院
		["general"] = {},
		[659] = {},
		[663] = {},
		[665] = {},
		[666] = {},
		[684] = {}
	},
	[313] = {
		-- 青龙寺
		["general"] = {},
		[672] = {},
		[664] = {},
		[658] = {},
		[335] = {}
	},
	[302] = {
		-- 风暴烈酒酿造厂
		["general"] = {},
		[668] = {},
		[669] = {},
		[670] = {}
	},
	[321] = {
		-- 魔古山宫殿
		["general"] = {},
		[708] = {},
		[690] = {},
		[698] = {}
	}
}

-- Event
local function OnInitialize(self, event, ...)
	C.UnitFrame = C.UnitFrame or {}
	C.UnitFrame.RaidAuras = C.UnitFrame.RaidAuras or {}
end

local function OnPlayerLogin(self, event, ...)
	local num = 19999
	local auras = C.UnitFrame.RaidAuras
	local k1, v1, k2, v2, k3, v3 = nil, nil, nil, nil, nil, nil

	for k1, v1 in pairs(debuffs) do
		for k2, v2 in pairs(v1) do
			for k3, v3 in pairs(v2) do
				num = num - 1
				auras[v3] = num
			end
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
