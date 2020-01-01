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
							["宝石"] = true,
							["配方"] = true
						}
					}
				}
			},
			["NewItem"] = {},
			["AdiBags_TooltipInfo"] = {},
			["MoneyFrame"] = {},
			["CurrencyFrame"] = {},
			["DataSource"] = {},
			["ItemSets"] = {},
			["Junk"] = {},
			["Equipment"] = {
				["profiles"] = {
					["Default"] = {
						["armorTypes"] = true
					}
				}
			}
		},
		["profileKeys"] = {},
		["profiles"] = {
			["Default"] = {
				["virtualStacks"] = {
					["freeSpace"] = false
				},
				["scale"] = 1,
				["maxHeight"] = 0.90,
				["skin"] = {
					["border"] = "1 Pixel",
					["borderWidth"] = 1,
					["insets"] = 0
				},
				["bagFont"] = {
					["size"] = 12
				},
				["sectionFont"] = {
					["size"] = 12
				},
				["columnWidth"] = {
					["Backpack"] = 14,
					["Bank"] = 14
				},
				["positionMode"] = "manual",
				["compactLayout"] = true,
				["modules"] = {
					["CurrencyFrame"] = false
				}
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
