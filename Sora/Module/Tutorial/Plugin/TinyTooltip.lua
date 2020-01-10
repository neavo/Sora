-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	BigTipDB = {
		["spell"] = {
			["background"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.8 -- [4]
			},
			["showIcon"] = true,
			["borderColor"] = {
				0.6, -- [1]
				0.6, -- [2]
				0.6, -- [3]
				0.8 -- [4]
			}
		},
		["general"] = {
			["SavedVariablesPerCharacter"] = false,
			["statusbarFontSize"] = 10,
			["scale"] = 1,
			["mask"] = true,
			["bgfile"] = "dark",
			["headerFont"] = "default",
			["borderSize"] = "1",
			["borderColor"] = {
				0.6, -- [1]
				0.6, -- [2]
				0.6, -- [3]
				0.8 -- [4]
			},
			["anchor"] = {
				["returnOnUnitFrame"] = false,
				["position"] = "cursorRight",
				["hiddenInCombat"] = true,
				["cp"] = "BOTTOM",
				["p"] = "BOTTOMRIGHT",
				["returnInCombat"] = false
			},
			["background"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.7 -- [4]
			},
			["statusbarPosition"] = "bottom",
			["statusbarOffsetX"] = 0,
			["statusbarHeight"] = 0,
			["bodyFontSize"] = "default",
			["bodyFontFlag"] = "default",
			["bodyFont"] = "default",
			["statusbarOffsetY"] = 0,
			["statusbarTexture"] = "Interface\\AddOns\\TinyTooltip\\texture\\StatusBar",
			["headerFontSize"] = "default",
			["statusbarText"] = false,
			["skinMoreFrames"] = false,
			["headerFontFlag"] = "default",
			["borderCorner"] = "angular",
			["statusbarColor"] = "auto",
			["statusbarFontFlag"] = "THINOUTLINE",
			["alwaysShowIdInfo"] = true
		},
		["version"] = 2.6,
		["variables"] = {},
		["item"] = {
			["coloredItemBorder"] = true,
			["showItemIcon"] = false
		},
		["quest"] = {
			["coloredQuestBorder"] = true
		},
		["unit"] = {
			["player"] = {
				["elements"] = {
					{
						"raidIcon", -- [1]
						"roleIcon", -- [2]
						"pvpIcon", -- [3]
						"factionIcon", -- [4]
						"classIcon", -- [5]
						"title", -- [6]
						"name", -- [7]
						"realm", -- [8]
						"statusAFK", -- [9]
						"statusDND", -- [10]
						"statusDC" -- [11]
					}, -- [1]
					{
						"guildName", -- [1]
						"guildIndex", -- [2]
						"guildRank", -- [3]
						"guildRealm" -- [4]
					}, -- [2]
					{
						"levelValue", -- [1]
						"factionName", -- [2]
						"gender", -- [3]
						"raceName", -- [4]
						"className", -- [5]
						"isPlayer", -- [6]
						"role", -- [7]
						"moveSpeed" -- [8]
					}, -- [3]
					{
						"zone" -- [1]
					}, -- [4]
					["guildRank"] = {
						["enable"] = true,
						["color"] = "cc88ff",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["statusAFK"] = {
						["enable"] = true,
						["color"] = "ffd200",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["guildIndex"] = {
						["enable"] = false,
						["color"] = "cc88ff",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["zone"] = {
						["enable"] = true,
						["color"] = "ffffff",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["statusDC"] = {
						["enable"] = true,
						["color"] = "999999",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["raceName"] = {
						["enable"] = true,
						["color"] = "cccccc",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["role"] = {
						["enable"] = false,
						["color"] = "ffffff",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["factionName"] = {
						["enable"] = true,
						["color"] = "faction",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["raidIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["levelValue"] = {
						["enable"] = true,
						["color"] = "level",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["realm"] = {
						["enable"] = true,
						["color"] = "00eeee",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["roleIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["pvpIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["moveSpeed"] = {
						["enable"] = false,
						["color"] = "e8e7a8",
						["wildcard"] = "%d%%",
						["filter"] = "none"
					},
					["gender"] = {
						["enable"] = false,
						["color"] = "999999",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["guildRealm"] = {
						["enable"] = true,
						["color"] = "00cccc",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["statusDND"] = {
						["enable"] = true,
						["color"] = "ffd200",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["isPlayer"] = {
						["enable"] = false,
						["color"] = "ffffff",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["factionIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["factionBig"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["guildName"] = {
						["enable"] = true,
						["color"] = "ff00ff",
						["wildcard"] = "<%s>",
						["filter"] = "none"
					},
					["title"] = {
						["enable"] = true,
						["color"] = "ccffff",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["name"] = {
						["enable"] = true,
						["color"] = "class",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["className"] = {
						["enable"] = true,
						["color"] = "ffffff",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["classIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					}
				},
				["showModel"] = false,
				["showTargetBy"] = true,
				["coloredBorder"] = "class",
				["showTarget"] = true,
				["background"] = {
					["colorfunc"] = "class",
					["alpha"] = 0.9
				},
				["anchor"] = {
					["returnOnUnitFrame"] = false,
					["position"] = "inherit",
					["hiddenInCombat"] = false,
					["cp"] = "BOTTOM",
					["p"] = "BOTTOMRIGHT",
					["returnInCombat"] = false
				},
				["grayForDead"] = false
			},
			["npc"] = {
				["coloredBorder"] = "reaction",
				["elements"] = {
					{
						"raidIcon", -- [1]
						"classIcon", -- [2]
						"questIcon", -- [3]
						"name" -- [4]
					}, -- [1]
					{
						"levelValue", -- [1]
						"classifBoss", -- [2]
						"classifElite", -- [3]
						"classifRare", -- [4]
						"creature", -- [5]
						"reactionName", -- [6]
						"moveSpeed" -- [7]
					}, -- [2]
					["creature"] = {
						["enable"] = true,
						["color"] = "selection",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["classifElite"] = {
						["enable"] = true,
						["color"] = "ffff33",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["npcTitle"] = {
						["enable"] = true,
						["color"] = "99e8e8",
						["wildcard"] = "<%s>",
						["filter"] = "none"
					},
					["questIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["classifBoss"] = {
						["enable"] = true,
						["color"] = "ff0000",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["moveSpeed"] = {
						["enable"] = false,
						["color"] = "e8e7a8",
						["wildcard"] = "%d%%",
						["filter"] = "none"
					},
					["reactionName"] = {
						["enable"] = true,
						["color"] = "33ffff",
						["wildcard"] = "<%s>",
						["filter"] = "reaction6"
					},
					["factionBig"] = {
						["enable"] = false,
						["filter"] = "none"
					},
					["name"] = {
						["enable"] = true,
						["color"] = "default",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["classifRare"] = {
						["enable"] = true,
						["color"] = "ffaaff",
						["wildcard"] = "(%s)",
						["filter"] = "none"
					},
					["raidIcon"] = {
						["enable"] = true,
						["filter"] = "none"
					},
					["levelValue"] = {
						["enable"] = true,
						["color"] = "level",
						["wildcard"] = "%s",
						["filter"] = "none"
					},
					["classIcon"] = {
						["enable"] = false,
						["filter"] = "none"
					}
				},
				["showTarget"] = true,
				["anchor"] = {
					["returnOnUnitFrame"] = false,
					["position"] = "inherit",
					["hiddenInCombat"] = false,
					["cp"] = "BOTTOM",
					["p"] = "BOTTOMRIGHT",
					["returnInCombat"] = false
				},
				["background"] = {
					["colorfunc"] = "default",
					["alpha"] = 0.9
				},
				["showTargetBy"] = true,
				["grayForDead"] = false
			}
		}
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
