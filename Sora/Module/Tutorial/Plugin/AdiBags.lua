-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AdiBagsDB = {
		["namespaces"] = {
			["MoneyFrame"] = {
				["profiles"] = {
					["Default"] = {
						["small"] = true
					}
				}
			},
			["NewItem"] = {
				["profiles"] = {
					["Default"] = {
						["highlight"] = "none"
					}
				}
			},
			["CurrencyFrame"] = {
				["profiles"] = {
					["Default"] = {
						["shown"] = {
							["幽魂碎片"] = false,
							["战痕命运印记"] = false,
							["次级好运护符"] = false,
							["腐化的纪念品"] = false,
							["战争物资"] = false,
							["尼奥罗萨的回响"] = false,
							["要塞物资"] = false,
							["古怪硬币"] = false,
							["黯淡的阿古尼特水晶"] = false,
							["远古魔力"] = false,
							["原油"] = false,
							["觉醒精华"] = false,
							["黑暗之尘"] = false,
							["虚空碎片"] = false,
							["破碎命运印记"] = false,
							["盲目之眼"] = false,
							["海员达布隆币"] = false,
							["凝结幻象"] = false,
							["泰坦残血精华"] = false,
							["职业大厅资源"] = false,
							["死亡之翼的堕落精华"] = false,
							["徘徊之魂碎片"] = false,
							["抗魔联军战争物资"] = false,
							["上古神器"] = false,
							["埃匹希斯水晶"] = false,
							["银色嘉奖"] = false,
							["神器碎片"] = false,
							["第七军团服役勋章"] = false,
							["棱彩法力珍珠"] = false
						}
					}
				}
			}
		},
		["profiles"] = {
			["Default"] = {
				["hideAnchor"] = true,
				["virtualStacks"] = {
					["freeSpace"] = false,
					["stackable"] = true
				},
				["columnWidth"] = {
					["Bank"] = 18,
					["Backpack"] = 18
				},
				["maxHeight"] = 0.90,
				["skin"] = {
					["BankColor"] = {0.00, 0.00, 0.00, 0.80},
					["BackpackColor"] = {0.00, 0.00, 0.00, 0.80},
					["ReagentBankColor"] = {0.00, 0.00, 0.00, 0.80},
					["borderWidth"] = 1,
					["border"] = "None",
					["insets"] = 0
				},
				["bagFont"] = {
					["size"] = 12
				},
				["positions"] = {
					["Backpack"] = {
						["xOffset"] = -128,
						["point"] = "TOPRIGHT",
						["yOffset"] = -384
					}
				},
				["compactLayout"] = true,
				["sectionFont"] = {
					["size"] = 12
				},
				["positionMode"] = "manual",
				["scale"] = 1
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
