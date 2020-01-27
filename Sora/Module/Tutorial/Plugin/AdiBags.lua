-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	AdiBagsDB = {
		["profiles"] = {
			["Default"] = {
				["virtualStacks"] = {
					["freeSpace"] = false
				},
				["scale"] = 1,
				["maxHeight"] = 0.9,
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
				["qualityHighlight"] = false,
				["compactLayout"] = true,
				["columnWidth"] = {
					["Bank"] = 14,
					["Backpack"] = 14
				},
				["positionMode"] = "manual",
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
