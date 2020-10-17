local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local ITEM_LIST_WIDTH_WITH_SCROLLBAR = 393;
local ITEM_LIST_WIDTH_NO_SCROLLBAR = 413;

StaticPopupDialogs["EXTVENDOR_CONFIRM_RESET_BLACKLIST"] = {
    text = L["CONFIRM_RESET_BLACKLIST"],
    button1 = YES,
    button2 = NO,
    OnAccept = function(self) ExtVendor_QVConfig_ResetBlacklist(); end,
    timeout = 0,
    hideOnEscape = 1,
    whileDead = 1,
};

StaticPopupDialogs["EXTVENDOR_CONFIRM_CLEAR_GLOBAL_WHITELIST"] = {
    text = L["CONFIRM_CLEAR_GLOBAL_WHITELIST"],
    button1 = YES,
    button2 = NO,
    OnAccept = function(self) ExtVendor_QVConfig_ClearGlobalWhitelist(); end,
    timeout = 0,
    hideOnEscape = 1,
    whileDead = 1,
};

StaticPopupDialogs["EXTVENDOR_CONFIRM_CLEAR_LOCAL_WHITELIST"] = {
    text = L["CONFIRM_CLEAR_LOCAL_WHITELIST"],
    button1 = YES,
    button2 = NO,
    OnAccept = function(self) ExtVendor_QVConfig_ClearLocalWhitelist(); end,
    timeout = 0,
    hideOnEscape = 1,
    whileDead = 1,
};

local ONSHOW_TIMER = 0;
local ONSHOW_TIMER_ENABLED = false;
local FIRST_ONSHOW = true;

function ExtVendor_QVConfig_OnLoad(self)

    tinsert(UISpecialFrames, "ExtVendor_QVConfigFrame");

    self:RegisterForDrag("LeftButton");

    -- set up text
    ExtVendor_QVConfigFrameHeader:SetText(L["QUICKVENDOR_CONFIG_HEADER"]);

    ExtVendor_QVConfigFrameBlacklistHeader:SetText(L["CUSTOMIZE_BLACKLIST"]);
    ExtVendor_QVConfigFrameBlacklistDescription:SetText(L["CUSTOMIZE_BLACKLIST_TEXT"]);
    ExtVendor_QVConfigFrame_ItemDropBlacklistText:SetText(L["DROP_ITEM_BLACKLIST"]);
    ExtVendor_QVConfigFrame_BlacklistText:SetText(L["ITEMLIST_GLOBAL_TEXT"]);
    ExtVendor_QVConfigFrame_RemoveFromBlacklistButton:SetText(L["DELETE_SELECTED"]);
    ExtVendor_QVConfigFrame_ResetBlacklistButton:SetText(L["RESET_TO_DEFAULT"]);

    ExtVendor_QVConfigFrameWhitelistHeader:SetText(L["CUSTOMIZE_WHITELIST"]);
    ExtVendor_QVConfigFrameWhitelistDescription:SetText(L["CUSTOMIZE_WHITELIST_TEXT"]);

    ExtVendor_QVConfigFrame_ItemDropGlobalWhitelistText:SetText(L["DROP_ITEM_WHITELIST"]);
    ExtVendor_QVConfigFrame_GlobalWhitelistText:SetText(L["ITEMLIST_GLOBAL_TEXT"]);
    ExtVendor_QVConfigFrame_RemoveFromGlobalWhitelistButton:SetText(L["DELETE_SELECTED"]);
    ExtVendor_QVConfigFrame_ClearGlobalWhitelistButton:SetText(L["CLEAR_ALL"]);

    ExtVendor_QVConfigFrame_ItemDropLocalWhitelistText:SetText(L["DROP_ITEM_WHITELIST"]);
    ExtVendor_QVConfigFrame_LocalWhitelistText:SetText(L["ITEMLIST_LOCAL_TEXT"]);
    ExtVendor_QVConfigFrame_RemoveFromLocalWhitelistButton:SetText(L["DELETE_SELECTED"]);
    ExtVendor_QVConfigFrame_ClearLocalWhitelistButton:SetText(L["CLEAR_ALL"]);

    ExtVendor_QVConfigFrame_RemoveFromBlacklistButton:Disable();
    ExtVendor_QVConfigFrame_RemoveFromGlobalWhitelistButton:Disable();
    ExtVendor_QVConfigFrame_RemoveFromLocalWhitelistButton:Disable();
    ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Disable();

    ExtVendor_QVConfigFrame_OptionContainerHeader:SetText(L["CONFIG_HEADING_QUICKVENDOR"]);
	ExtVendor_QVConfigFrame_OptionContainer_EnableButtonText:SetText(L["OPTION_QUICKVENDOR_ENABLEBUTTON"]);
	ExtVendor_QVConfigFrame_OptionContainer_EnableButton.tooltip = L["OPTION_QUICKVENDOR_ENABLEBUTTON_TOOLTIP"];
	ExtVendor_QVConfigFrame_OptionContainer_SuboptimalArmorText:SetText(L["OPTION_QUICKVENDOR_SUBARMOR"]);
	ExtVendor_QVConfigFrame_OptionContainer_SuboptimalArmor.tooltip = L["OPTION_QUICKVENDOR_SUBARMOR_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];
	ExtVendor_QVConfigFrame_OptionContainer_AlreadyKnownText:SetText(L["OPTION_QUICKVENDOR_ALREADYKNOWN"]);
	ExtVendor_QVConfigFrame_OptionContainer_AlreadyKnown.tooltip = L["OPTION_QUICKVENDOR_ALREADYKNOWN_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];
	ExtVendor_QVConfigFrame_OptionContainer_UnusableEquipText:SetText(L["OPTION_QUICKVENDOR_UNUSABLE"]);
	ExtVendor_QVConfigFrame_OptionContainer_UnusableEquip.tooltip = L["OPTION_QUICKVENDOR_UNUSABLE_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];
	ExtVendor_QVConfigFrame_OptionContainer_WhiteGearText:SetText(L["OPTION_QUICKVENDOR_WHITEGEAR"]);
	ExtVendor_QVConfigFrame_OptionContainer_WhiteGear.tooltip = L["OPTION_QUICKVENDOR_WHITEGEAR_TOOLTIP"];
	ExtVendor_QVConfigFrame_OptionContainer_OutdatedGearText:SetText(L["OPTION_QUICKVENDOR_OUTDATEDGEAR"]);
	ExtVendor_QVConfigFrame_OptionContainer_OutdatedGear.tooltip = L["OPTION_QUICKVENDOR_OUTDATEDGEAR_TOOLTIP"];
	ExtVendor_QVConfigFrame_OptionContainer_OutdatedFoodText:SetText(L["OPTION_QUICKVENDOR_OUTDATEDFOOD"]);
	ExtVendor_QVConfigFrame_OptionContainer_OutdatedFood.tooltip = L["OPTION_QUICKVENDOR_OUTDATEDFOOD_TOOLTIP"];
	--ExtVendor_QVConfigFrame_OptionContainer_CompactChatMessageText:SetText(L["OPTION_QUICKVENDOR_COMPACTMESSAGE"]);
	--ExtVendor_QVConfigFrame_OptionContainer_CompactChatMessage.tooltip = L["OPTION_QUICKVENDOR_COMPACTMESSAGE_TOOLTIP"];
    
    -- set up blacklist
    ExtVendor_QVConfigFrame_BlacklistItemListScrollBar.Show =
        function(self)
            ExtVendor_QVConfigFrame_BlacklistItemList:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_BlacklistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			end
			getmetatable(self).__index.Show(self);
        end
    ExtVendor_QVConfigFrame_BlacklistItemListScrollBar.Hide =
        function(self)
            ExtVendor_QVConfigFrame_BlacklistItemList:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_BlacklistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			end
			getmetatable(self).__index.Hide(self);
        end

    ExtVendor_QVConfigFrame_BlacklistItemList.update = ExtVendor_QVConfig_Blacklist_Update;
    ExtVendor_QVConfigFrame_BlacklistItemList.deleteButton = ExtVendor_QVConfigFrame_RemoveFromBlacklistButton;
    HybridScrollFrame_CreateButtons(ExtVendor_QVConfigFrame_BlacklistItemList, "ExtVendor_BlacklistedItemButtonTemplate", 0, 0);

    -- set up global whitelist
    ExtVendor_QVConfigFrame_GlobalWhitelistItemListScrollBar.Show =
        function(self)
            ExtVendor_QVConfigFrame_GlobalWhitelistItemList:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_GlobalWhitelistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			end
			getmetatable(self).__index.Show(self);
        end
    ExtVendor_QVConfigFrame_GlobalWhitelistItemListScrollBar.Hide =
        function(self)
            ExtVendor_QVConfigFrame_GlobalWhitelistItemList:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_GlobalWhitelistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			end
			getmetatable(self).__index.Hide(self);
        end

    ExtVendor_QVConfigFrame_ItemDropGlobalWhitelistButton.isWhitelist = true;
    ExtVendor_QVConfigFrame_GlobalWhitelistItemList.update = ExtVendor_QVConfig_GlobalWhitelist_Update;
    ExtVendor_QVConfigFrame_GlobalWhitelistItemList.deleteButton = ExtVendor_QVConfigFrame_RemoveFromGlobalWhitelistButton;
    HybridScrollFrame_CreateButtons(ExtVendor_QVConfigFrame_GlobalWhitelistItemList, "ExtVendor_BlacklistedItemButtonTemplate", 0, 0);

    -- set up local whitelist
    ExtVendor_QVConfigFrame_LocalWhitelistItemListScrollBar.Show =
        function(self)
            ExtVendor_QVConfigFrame_LocalWhitelistItemList:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_LocalWhitelistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			end
			getmetatable(self).__index.Show(self);
        end
    ExtVendor_QVConfigFrame_LocalWhitelistItemListScrollBar.Hide =
        function(self)
            ExtVendor_QVConfigFrame_LocalWhitelistItemList:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			for _X, button in next, ExtVendor_QVConfigFrame_LocalWhitelistItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			end
			getmetatable(self).__index.Hide(self);
        end

    ExtVendor_QVConfigFrame_ItemDropLocalWhitelistButton.isWhitelist = true;
    ExtVendor_QVConfigFrame_ItemDropLocalWhitelistButton.isLocal = true;
    ExtVendor_QVConfigFrame_LocalWhitelistItemList.update = ExtVendor_QVConfig_LocalWhitelist_Update;
    ExtVendor_QVConfigFrame_LocalWhitelistItemList.deleteButton = ExtVendor_QVConfigFrame_RemoveFromLocalWhitelistButton;
    HybridScrollFrame_CreateButtons(ExtVendor_QVConfigFrame_LocalWhitelistItemList, "ExtVendor_BlacklistedItemButtonTemplate", 0, 0);

end

function ExtVendor_QVConfig_OnShow()
    ExtVendor_QVConfig_Blacklist_Update();
    ExtVendor_QVConfig_GlobalWhitelist_Update();
    ExtVendor_QVConfig_LocalWhitelist_Update();
    if (FIRST_ONSHOW) then
        ONSHOW_TIMER = 0;
        ONSHOW_TIMER_ENABLED = true;
        FIRST_ONSHOW = false;
        for idx, id in pairs(EXTVENDOR_DATA['quickvendor_blacklist']) do
            GetItemInfo(id);
        end
        for idx, id in pairs(EXTVENDOR_DATA['quickvendor_whitelist']) do
            GetItemInfo(id);
        end
        for idx, id in pairs(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist']) do
            GetItemInfo(id);
        end
    end
    ExtVendor_QVConfigFrame_OptionContainer_EnableButton:SetChecked(EXTVENDOR_DATA['config']['enable_quickvendor']);
    ExtVendor_QVConfigFrame_OptionContainer_SuboptimalArmor:SetChecked(EXTVENDOR_DATA['config']['quickvendor_suboptimal']);
    ExtVendor_QVConfigFrame_OptionContainer_AlreadyKnown:SetChecked(EXTVENDOR_DATA['config']['quickvendor_alreadyknown']);
    ExtVendor_QVConfigFrame_OptionContainer_UnusableEquip:SetChecked(EXTVENDOR_DATA['config']['quickvendor_unusable']);
    ExtVendor_QVConfigFrame_OptionContainer_WhiteGear:SetChecked(EXTVENDOR_DATA['config']['quickvendor_whitegear']);
    ExtVendor_QVConfigFrame_OptionContainer_OutdatedGear:SetChecked(EXTVENDOR_DATA['config']['quickvendor_oldgear']);
    ExtVendor_QVConfigFrame_OptionContainer_OutdatedFood:SetChecked(EXTVENDOR_DATA['config']['quickvendor_oldfood']);
    --ExtVendor_QVConfigFrame_OptionContainer_CompactChatMessage:SetChecked(EXTVENDOR_DATA['config']['quickvendor_msg_compact']);
    ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Disable();
end

function ExtVendor_QVConfig_OnUpdate(self, elapsed)
    -- half a second after the first time the quickvendor config is shown, refresh all lists
    if (ONSHOW_TIMER_ENABLED) then
        ONSHOW_TIMER = ONSHOW_TIMER + elapsed;
        if (ONSHOW_TIMER >= 0.3) then
            ExtVendor_QVConfig_Blacklist_Update();
            ExtVendor_QVConfig_GlobalWhitelist_Update();
            ExtVendor_QVConfig_LocalWhitelist_Update();
            ONSHOW_TIMER_ENABLED = false;
        end
    end
end

function ExtVendor_QVConfig_Blacklist_Update()

    local scrollFrame = ExtVendor_QVConfigFrame_BlacklistItemList;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
    local numBlacklisted = table.maxn(EXTVENDOR_DATA['quickvendor_blacklist']);
    local selection = scrollFrame.selection or -1;
	--local selection = scrollFrame.selection;

	local blacklistIndex;
	local displayedHeight = 0;
	for i = 1, numButtons do
		blacklistIndex = i + offset;
		if (blacklistIndex > numBlacklisted) then
			buttons[i]:Hide();
		else
            local itemID = EXTVENDOR_DATA['quickvendor_blacklist'][blacklistIndex];
            local itemName, itemLink, itemRarity, _X, _X, _X, _X, _X, _X, itemTexture = GetItemInfo(itemID);
            buttons[i].index = blacklistIndex;
            local displayName = "|cffff0000" .. L["UNKNOWN_ITEM"];
            if (itemName and itemRarity) then
                displayName = ITEM_QUALITY_COLORS[itemRarity].hex .. itemName;
            end
            ExtVendor_ItemListButton_DisplayItem(buttons[i], itemID, itemTexture, displayName, selection);
			displayedHeight = displayedHeight + buttons[i]:GetHeight();
		end
	end

    local totalHeight = numBlacklisted * 20;

	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);

end

function ExtVendor_QVConfig_GlobalWhitelist_Update()

    local scrollFrame = ExtVendor_QVConfigFrame_GlobalWhitelistItemList;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
    local numBlacklisted = table.maxn(EXTVENDOR_DATA['quickvendor_whitelist']);
    local selection = scrollFrame.selection or -1;
	--local selection = scrollFrame.selection;

	local blacklistIndex;
	local displayedHeight = 0;
	for i = 1, numButtons do
		blacklistIndex = i + offset;
		if (blacklistIndex > numBlacklisted) then
			buttons[i]:Hide();
		else
            local itemID = EXTVENDOR_DATA['quickvendor_whitelist'][blacklistIndex];
            local itemName, itemLink, itemRarity, _X, _X, _X, _X, _X, _X, itemTexture = GetItemInfo(itemID);
            buttons[i].index = blacklistIndex;
            local displayName = "|cffff0000" .. L["UNKNOWN_ITEM"];
            if (itemName and itemRarity) then
                displayName = ITEM_QUALITY_COLORS[itemRarity].hex .. itemName;
            end
            ExtVendor_ItemListButton_DisplayItem(buttons[i], itemID, itemTexture, displayName, selection);
			displayedHeight = displayedHeight + buttons[i]:GetHeight();
		end
	end

    local totalHeight = numBlacklisted * 20;

	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);

end

function ExtVendor_QVConfig_LocalWhitelist_Update()

    local scrollFrame = ExtVendor_QVConfigFrame_LocalWhitelistItemList;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
    local numBlacklisted = table.maxn(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist']);
    local selection = scrollFrame.selection or -1;
	--local selection = scrollFrame.selection;

	local blacklistIndex;
	local displayedHeight = 0;
	for i = 1, numButtons do
		blacklistIndex = i + offset;
		if (blacklistIndex > numBlacklisted) then
			buttons[i]:Hide();
		else
            local itemID = EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'][blacklistIndex];
            local itemName, itemLink, itemRarity, _X, _X, _X, _X, _X, _X, itemTexture = GetItemInfo(itemID);
            buttons[i].index = blacklistIndex;
            local displayName = "|cffff0000" .. L["UNKNOWN_ITEM"];
            if (itemName and itemRarity) then
                displayName = ITEM_QUALITY_COLORS[itemRarity].hex .. itemName;
            end
            ExtVendor_ItemListButton_DisplayItem(buttons[i], itemID, itemTexture, displayName, selection);
			displayedHeight = displayedHeight + buttons[i]:GetHeight();
		end
	end

    local totalHeight = numBlacklisted * 20;

	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);

end

function ExtVendor_ItemListButton_DisplayItem(button, itemID, itemIcon, itemName, selection)
    if (not button) then return; end
    button.itemID = itemID;
    if (itemID) then
        button:Show();
    else
        button:Hide();
        return;
    end
    local buttonIcon = _G[button:GetName() .. "Icon"];
    local buttonName = _G[button:GetName() .. "Name"];
    local buttonSelection = _G[button:GetName() .. "Selection"];
    if (itemIcon) then
        if (buttonIcon ~= nil) then buttonIcon:SetTexture(itemIcon); end
    end
    if (buttonName ~= nil) then buttonName:SetText(itemName); end
    if (button.index == selection) then
        buttonSelection:Show();
    else
        buttonSelection:Hide();
    end
end

function ExtVendor_QVConfig_ShowBlacklistedItemTooltip(button)
    if (not button.itemID) then return; end
    GameTooltip:SetOwner(button, "ANCHOR_BOTTOMLEFT", 0, 20);
    GameTooltip:SetItemByID(button.itemID);
end

function ExtVendor_QVConfig_SelectItemListButton(self)
    if (self) then
        local scrollFrame = self:GetParent():GetParent();
        scrollFrame.selection = self.index;
        scrollFrame.update();
        if (scrollFrame.deleteButton) then
            scrollFrame.deleteButton:Enable();
        end
    end
end

local function errorMessage(message, itemLink, reason)
    local r = string.gsub(message, "{$item}", itemLink);
    r = string.gsub(r, "{$reason}", reason);
    return r;
end

function ExtVendor_QVConfig_OnItemDrop(button)

    local infoType, itemID, itemLink = GetCursorInfo();
    if (infoType ~= "item") then return; end
    local itemName, retLink, itemRarity, _X, _X, _X, _X, _X, _X, _X, itemSellPrice = GetItemInfo(itemID);
    ClearCursor();

    -- verify the item has a vendor price, otherwise there's no point
    if ((itemSellPrice or 0) == 0) then
        local errorString = "";
        if (button.isWhitelist) then
            errorString = L["CANNOT_WHITELIST"];
        else
            errorString = L["CANNOT_BLACKLIST"];
        end
        ExtVendor_Message(errorMessage(errorString, retLink, L["REASON_NO_SELL_PRICE"]));
        return;
    end

    if (button.isWhitelist) then
        if (ExtVendor_IsBlacklisted(itemID)) then
            ExtVendor_Message(errorMessage(L["CANNOT_WHITELIST"], retLink, L["REASON_ALREADY_BLACKLISTED"]));
            return;
        end
        if (button.isLocal) then
            if (ExtVendor_IsWhitelisted(itemID)) then
                ExtVendor_Message(errorMessage(L["CANNOT_WHITELIST"], retLink, L["REASON_ALREADY_WHITELISTED"]));
            else
                tinsert(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'], itemID);
                ExtVendor_QVConfig_LocalWhitelist_Update();
                ExtVendor_Message(string.format(L["ITEM_ADDED_TO_LOCAL_WHITELIST"], retLink));
                ExtVendor_UpdateDisplay();
            end
        else
            if (ExtVendor_IsWhitelisted(itemID, true)) then
                ExtVendor_Message(errorMessage(L["CANNOT_WHITELIST"], retLink, L["REASON_ALREADY_WHITELISTED"]));
            else
                ExtVendor_QVConfig_RemoveEntry(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'], itemID);
                ExtVendor_QVConfigFrame_LocalWhitelistItemList.selection = -1;
                tinsert(EXTVENDOR_DATA['quickvendor_whitelist'], itemID);
                ExtVendor_QVConfig_GlobalWhitelist_Update();
                ExtVendor_QVConfig_LocalWhitelist_Update();
                ExtVendor_Message(string.format(L["ITEM_ADDED_TO_GLOBAL_WHITELIST"], retLink));
                ExtVendor_UpdateDisplay();
            end
        end
    else
        if (ExtVendor_IsWhitelisted(itemID)) then
            ExtVendor_Message(errorMessage(L["CANNOT_BLACKLIST"], retLink, L["REASON_ALREADY_WHITELISTED"]));
            return;
        end
        if (ExtVendor_IsBlacklisted(itemID)) then
            ExtVendor_Message(errorMessage(L["CANNOT_BLACKLIST"], retLink, L["REASON_ALREADY_BLACKLISTED"]));
        else
            tinsert(EXTVENDOR_DATA['quickvendor_blacklist'], itemID);
            ExtVendor_QVConfig_Blacklist_Update();
            ExtVendor_Message(string.format(L["ITEM_ADDED_TO_BLACKLIST"], retLink));
            ExtVendor_UpdateDisplay();
        end
    end

end

function ExtVendor_QVConfig_RemoveEntry(tbl, value)

    local i = 1;
    while (i <= #tbl) do
        if (tbl[i] == value) then
            table.remove(tbl, i);
        else
            i = i + 1;
        end
    end

end

function ExtVendor_QVConfig_DeleteFromBlacklist()
    ExtVendor_QVConfigFrame_RemoveFromBlacklistButton:Disable();
    local sel = ExtVendor_QVConfigFrame_BlacklistItemList.selection or 0;
    if (sel > 0) then
        table.remove(EXTVENDOR_DATA['quickvendor_blacklist'], sel);
    end
    ExtVendor_QVConfigFrame_BlacklistItemList.selection = -1;
    ExtVendor_QVConfig_Blacklist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_ResetBlacklist()
    ExtVendor_QVConfigFrame_Blacklist.selection = -1;
    EXTVENDOR_DATA['quickvendor_blacklist'] = EXTVENDOR_QUICKVENDOR_DEFAULT_BLACKLIST;
    ExtVendor_QVConfig_Blacklist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_DeleteFromGlobalWhitelist()
    ExtVendor_QVConfigFrame_RemoveFromGlobalWhitelistButton:Disable();
    local sel = ExtVendor_QVConfigFrame_GlobalWhitelistItemList.selection or 0;
    if (sel > 0) then
        table.remove(EXTVENDOR_DATA['quickvendor_whitelist'], sel);
    end
    ExtVendor_QVConfigFrame_GlobalWhitelistItemList.selection = -1;
    ExtVendor_QVConfig_GlobalWhitelist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_ClearGlobalWhitelist()
    ExtVendor_QVConfigFrame_GlobalWhitelist.selection = -1;
    EXTVENDOR_DATA['quickvendor_whitelist'] = {};
    ExtVendor_QVConfig_GlobalWhitelist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_DeleteFromLocalWhitelist()
    ExtVendor_QVConfigFrame_RemoveFromLocalWhitelistButton:Disable();
    local sel = ExtVendor_QVConfigFrame_LocalWhitelistItemList.selection or 0;
    if (sel > 0) then
        table.remove(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'], sel);
    end
    ExtVendor_QVConfigFrame_LocalWhitelistItemList.selection = -1;
    ExtVendor_QVConfig_LocalWhitelist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_ClearLocalWhitelist()
    ExtVendor_QVConfigFrame_LocalWhitelist.selection = -1;
    EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'] = {};
    ExtVendor_QVConfig_LocalWhitelist_Update();
    ExtVendor_UpdateDisplay();
end

function ExtVendor_QVConfig_Save()
    local STORE_SETTINGS = ExtVendorConfig_GetStoredSettings();
    EXTVENDOR_DATA['config']['enable_quickvendor'] = STORE_SETTINGS.enableQuickVendor;
    EXTVENDOR_DATA['config']['quickvendor_suboptimal'] = STORE_SETTINGS.quickVendorSuboptimal;
    EXTVENDOR_DATA['config']['quickvendor_alreadyknown'] = STORE_SETTINGS.quickVendorAlreadyKnown;
    EXTVENDOR_DATA['config']['quickvendor_unusable'] = STORE_SETTINGS.quickVendorUnusable;
    EXTVENDOR_DATA['config']['quickvendor_whitegear'] = STORE_SETTINGS.quickVendorWhiteGear;
    EXTVENDOR_DATA['config']['quickvendor_oldgear'] = STORE_SETTINGS.quickVendorOldGear;
    EXTVENDOR_DATA['config']['quickvendor_oldfood'] = STORE_SETTINGS.quickVendorOldFood;
    ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Disable();
end
