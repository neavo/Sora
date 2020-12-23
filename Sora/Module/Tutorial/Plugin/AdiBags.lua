-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AdiBagsDB = {
		["namespaces"] = {
			["ItemLevel"] = {},
			["FilterOverride"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 3
					}
				}
			},
			["ItemCategory"] = {
				["profiles"] = {
					["Default"] = {
						["splitBySubclass"] = {
							["雕文"] = true,
							["消耗品"] = true,
							["杂项"] = true,
							["商业技能"] = true,
							["配方"] = true,
							["宝石"] = true
						}
					}
				}
			},
			["NewItem"] = {
				["profiles"] = {
					["Default"] = {
						["highlight"] = "none",
						["glowScale"] = 1
					}
				}
			},
			["AdiBags_TooltipInfo"] = {},
			["MoneyFrame"] = {},
			["DataSource"] = {},
			["ItemSets"] = {},
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
							["要塞物资"] = false,
							["古怪硬币"] = false,
							["黯淡的阿古尼特水晶"] = false,
							["战争物资"] = false,
							["上古神器"] = false,
							["神器碎片"] = false,
							["黑暗之尘"] = false,
							["死亡之翼的堕落精华"] = false,
							["时空扭曲徽章"] = false,
							["幽魂碎片"] = false,
							["埃匹希斯水晶"] = false,
							["凝结幻象"] = false,
							["原油"] = false,
							["职业大厅资源"] = false,
							["远古魔力"] = false,
							["徘徊之魂碎片"] = false,
							["棱彩法力珍珠"] = false,
							["尼奥罗萨的回响"] = false,
							["破碎命运印记"] = false,
							["觉醒精华"] = false,
							["泰坦残血精华"] = false,
							["第七军团服役勋章"] = false,
							["次级好运护符"] = false
						},
						["text"] = {
							["name"] = "默认"
						}
					}
				}
			},
			["Junk"] = {},
			["Equipment"] = {}
		},
		["profileKeys"] = {},
		["profiles"] = {
			["Default"] = {
				["virtualStacks"] = {
					["freeSpace"] = false,
					["others"] = true,
					["stackable"] = true,
					["incomplete"] = true
				},
				["scale"] = 1,
				["skin"] = {
					["ReagentBankColor"] = {
						nil, -- [1]
						0, -- [2]
						nil, -- [3]
						0.5 -- [4]
					},
					["BackpackColor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						0.5 -- [4]
					},
					["BankColor"] = {
						nil, -- [1]
						nil, -- [2]
						0, -- [3]
						0.5 -- [4]
					},
					["border"] = "None",
					["background"] = "Solid",
					["borderWidth"] = 1,
					["insets"] = 0
				},
				["bagFont"] = {
					["size"] = 11
				},
				["compactLayout"] = true,
				["hideAnchor"] = true,
				["sectionFont"] = {
					["size"] = 11
				},
				["positionMode"] = "manual",
				["columnWidth"] = {
					["Bank"] = 16,
					["Backpack"] = 16
				}
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
