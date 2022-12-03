-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local debuffs = {
	[75] = {
		-- 巴拉丁监狱
		["general"] = {
			105859 -- 穿刺
		},
		[139] = {},
		[140] = {},
		[339] = {}
	},
	[72] = {
		-- 暮光堡垒
		["general"] = {},
		[156] = {},
		[157] = {},
		[158] = {},
		[167] = {}
	},
	[74] = {
		-- 风神王座
		["general"] = {},
		[154] = {},
		[155] = {}
	},
	[73] = {
		-- 黑翼血环
		["general"] = {},
		[169] = {},
		[170] = {},
		[171] = {},
		[172] = {},
		[173] = {},
		[174] = {}
	},
	[78] = {
		-- 火焰之地
		["general"] = {},
		[192] = {},
		[193] = {},
		[194] = {},
		[195] = {},
		[196] = {},
		[197] = {},
		[198] = {}
	},
	[187] = {
		-- 巨龙之魂
		["general"] = {},
		[311] = {},
		[324] = {},
		[325] = {},
		[317] = {},
		[331] = {},
		[332] = {},
		[318] = {},
		[333] = {}
	},
	[67] = {
		-- 巨石之核
		["general"] = {},
		[110] = {},
		[111] = {},
		[112] = {},
		[113] = {}
	},
	[64] = {
		-- 影牙城堡
		["general"] = {},
		[96] = {},
		[97] = {},
		[98] = {},
		[99] = {},
		[100] = {}
	},
	[69] = {
		-- 托维尔失落之城
		["general"] = {},
		[117] = {},
		[118] = {},
		[119] = {},
		[122] = {}
	},
	[68] = {
		-- 旋云之巅
		["general"] = {},
		[114] = {},
		[115] = {},
		[116] = {}
	},
	[184] = {
		-- 时光之末
		["general"] = {},
		[340] = {},
		[285] = {},
		[323] = {},
		[283] = {},
		[289] = {}
	},
	[186] = {
		-- 暮光审判
		["general"] = {},
		[322] = {},
		[342] = {},
		[341] = {}
	},
	[71] = {
		-- 格瑞姆巴托
		["general"] = {},
		[131] = {},
		[132] = {},
		[133] = {},
		[134] = {}
	},
	[63] = {
		-- 死亡矿井
		["general"] = {},
		[89] = {},
		[90] = {},
		[91] = {},
		[92] = {},
		[93] = {}
	},
	[185] = {
		-- 永恒之井
		["general"] = {},
		[290] = {},
		[291] = {},
		[292] = {}
	},
	[65] = {
		-- 潮汐王座
		["general"] = {},
		[101] = {},
		[102] = {},
		[103] = {},
		[104] = {}
	},
	[76] = {
		-- 祖尔格拉布
		["general"] = {},
		[175] = {},
		[176] = {},
		[177] = {},
		[178] = {},
		[179] = {},
		[180] = {},
		[181] = {},
		[184] = {},
		[185] = {}
	},
	[77] = {
		-- 祖阿曼
		["general"] = {},
		[186] = {},
		[187] = {},
		[188] = {},
		[189] = {},
		[190] = {},
		[191] = {}
	},
	[70] = {
		-- 起源大厅
		["general"] = {},
		[124] = {},
		[125] = {},
		[126] = {},
		[127] = {},
		[128] = {},
		[129] = {},
		[130] = {}
	},
	[66] = {
		-- 黑石岩窟
		["general"] = {},
		[105] = {},
		[106] = {},
		[107] = {},
		[108] = {},
		[109] = {}
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
