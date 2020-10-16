-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AdiBagsDB = {
		["namespaces"] = {
			["ItemLevel"] = {
			},
			["FilterOverride"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 3,
					},
				},
			},
			["ItemCategory"] = {
				["profiles"] = {
					["Default"] = {
						["splitBySubclass"] = {
							["雕文"] = true,
							["消耗品"] = true,
							["杂项"] = true,
							["商业技能"] = true,
							["宝石"] = true,
							["配方"] = true,
						},
					},
				},
			},
			["NewItem"] = {
			},
			["AdiBags_TooltipInfo"] = {
			},
			["Equipment"] = {
			},
			["ItemSets"] = {
			},
			["CurrencyFrame"] = {
				["profiles"] = {
					["Default"] = {
						["shown"] = {
							["盲目之眼"] = false,
							["战痕命运印记"] = false,
							["抗魔联军战争物资"] = false,
							["腐化的纪念品"] = false,
							["海员达布隆币"] = false,
							["虚空碎片"] = false,
							["古怪硬币"] = false,
							["黯淡的阿古尼特水晶"] = false,
							["上古神器"] = false,
							["棱彩法力珍珠"] = false,
							["职业大厅资源"] = false,
							["凝结幻象"] = false,
							["徘徊之魂碎片"] = false,
							["尼奥罗萨的回响"] = false,
							["破碎命运印记"] = false,
							["战争物资"] = false,
							["觉醒精华"] = false,
							["泰坦残血精华"] = false,
							["第七军团服役勋章"] = false,
							["远古魔力"] = false,
						},
						["text"] = {
							["name"] = "默认",
						},
					},
				},
			},
			["DataSource"] = {
			},
			["Junk"] = {
				["profiles"] = {
					["Default"] = {
						["sources"] = {
							["junkCategory"] = false,
						},
					},
				},
			},
			["MoneyFrame"] = {
			},
		},
		["profiles"] = {
			["Default"] = {
				["virtualStacks"] = {
					["freeSpace"] = false,
				},
				["scale"] = 1,
				["skin"] = {
					["ReagentBankColor"] = {
						0.00, -- [1]
						0.00, -- [2]
						0.00, -- [3]
						0.50, -- [4]
					},
					["BackpackColor"] = {
						0.00, -- [1]
						0.00, -- [2]
						0.00, -- [3]
						0.50, -- [4]
					},
					["BankColor"] = {
						0.00, -- [1]
						0.00, -- [2]
						0.00, -- [3]
						0.50, -- [4]
					},
					["borderWidth"] = 1,
					["background"] = "Solid",
					["border"] = "None",
					["insets"] = 0,
				},
				["bagFont"] = {
					["size"] = 10,
				},
				["positions"] = {
					["Backpack"] = {
						["xOffset"] = -119.5,
						["yOffset"] = 225.5000305175781,
					},
				},
				["compactLayout"] = true,
				["hideAnchor"] = true,
				["sectionFont"] = {
					["size"] = 13,
				},
				["positionMode"] = "manual",
				["columnWidth"] = {
					["Backpack"] = 16,
					["Bank"] = 16,
				},
			},
		},
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
