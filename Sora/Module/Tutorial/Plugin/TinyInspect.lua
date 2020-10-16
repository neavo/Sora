-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
	if C.Tutorial.Initialized then
		return 0
	end

	TinyInspectDB = {
		["EnableItemLevelBag"] = true,
		["EnableItemLevelChat"] = true,
		["ShowPartySpecialization"] = true,
		["ShowInspectColoredLabel"] = true,
		["EnableItemLevelPaperDoll"] = true,
		["EnableRaidItemLevel"] = false,
		["SendPartyItemLevelToParty"] = false,
		["ShowOwnFrameWhenInspecting"] = false,
		["EnableItemLevelGuildNews"] = true,
		["ShowCharacterItemSheet"] = true,
		["EnableItemLevelMerchant"] = true,
		["version"] = 2.5,
		["ShowCorruptedMark"] = true,
		["ShowItemSlotString"] = true,
		["ShowItemBorder"] = true,
		["EnableItemLevelGuildBank"] = true,
		["EnableItemLevelAuction"] = true,
		["SendPartyItemLevelToSelf"] = true,
		["EnableItemLevelAltEquipment"] = true,
		["EnableItemLevelBank"] = true,
		["EnableItemLevel"] = true,
		["ShowColoredItemLevelString"] = false,
		["ItemLevelAnchorPoint"] = "TOP",
		["EnableItemLevelLoot"] = true,
		["ShowInspectAngularBorder"] = false,
		["ShowItemStats"] = false,
		["EnablePartyItemLevel"] = true,
		["ShowInspectItemSheet"] = true,
		["EnableItemLevelOther"] = true,
		["EnableMouseItemLevel"] = true,
		["EnableMouseSpecialization"] = true,
		["EnableMouseWeaponLevel"] = true,
		["PaperDollItemLevelOutsideString"] = false,
		["EnableItemLevelTrade"] = true,
		["ShowPluginGreenState"] = false,
	}
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
