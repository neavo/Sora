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
						["highlight"] = "none"
					}
				}
			},
			["AdiBags_TooltipInfo"] = {},
			["Equipment"] = {
				["profiles"] = {
					["Default"] = {
						["armorTypes"] = true
					}
				}
			},
			["ItemSets"] = {},
			["CurrencyFrame"] = {},
			["DataSource"] = {},
			["Junk"] = {},
			["MoneyFrame"] = {}
		},
		["profileKeys"] = {},
		["profiles"] = {
			["Default"] = {
				["virtualStacks"] = {
					["freeSpace"] = false
				},
				["columnWidth"] = {
					["Bank"] = 14,
					["Backpack"] = 14
				},
				["modules"] = {
					["CurrencyFrame"] = false
				},
				["skin"] = {
					["BackpackColor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						0.75 -- [4]
					},
					["BankColor"] = {
						nil, -- [1]
						nil, -- [2]
						0, -- [3]
						0.75 -- [4]
					},
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
						["yOffset"] = 128
					}
				},
				["sectionFont"] = {
					["size"] = 12
				},
				["compactLayout"] = true,
				["maxHeight"] = 0.9,
				["scale"] = 1,
				["positionMode"] = "manual",
				["qualityHighlight"] = false
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
