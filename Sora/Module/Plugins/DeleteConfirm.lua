-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local dialogs = {
	["DELETE_ITEM"] = true,
	["DELETE_GOOD_ITEM"] = true,
	["DELETE_QUEST_ITEM"] = true,
	["DELETE_GOOD_QUEST_ITEM"] = true
}

local function OnDeleteItemConfirm(self, event, itemName, qualityID, bonding, questWarn)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local dialog = _G["StaticPopup" .. i]

		if not dialogs[dialog.which] then
			return
		end

		if StaticPopupDialogs[dialog.which].hasEditBox == 1 then
			dialog.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.DELETE_ITEM_CONFIRM = OnDeleteItemConfirm
EventHandler.Register()
