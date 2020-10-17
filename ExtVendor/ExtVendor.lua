EXTVENDOR_DATA = {};
EXTVENDOR = {
    Version = GetAddOnMetadata("ExtVendor", "Version"),
    VersionID = 10807,
    ItemsPerSubpage = MERCHANT_ITEMS_PER_PAGE,
    SubpagesPerPage = 2,
    Hooks = {},
    Profile = "",
    SelectedQuality = 0,
    SpecificQuality = false,
    ElvUI_Installed = false,
    RefreshingQuickVendorList = false,
    HiddenItemsTooltipList = {},
    DebugMode = false,
    SlotFilterIndex = 0,
    --PerfProfile = {},
    CommandHooks = {},
    QuickVendor = {
        Processing = false,
        TotalItemsSold = 0,
        TotalSellPrice = 0,
        CurrentJunkList = {},
        ProcessJunkList = {},
        InventoryDetail = {},
    },
};
MERCHANT_ITEMS_PER_PAGE = 20;       -- overrides default value of base ui, default functions will handle page display accordingly

--EXTVENDOR.PerfProfile.EII_Tooltip = {
--    GetItemID = 0,
--    SetTooltip = 0,
--    HideTooltip = 0,
--    GetText = 0,
--    ParseAlreadyKnown = 0,
--    ParseClasses = 0,
--    ParseFood = 0,
--    ParseAccountBound = 0,
--    Total = 0,
--    ItemCount = 0,
--    Enable = false,
--};

--function EXTVENDOR.PerfProfile.EII_Tooltip.Reset()
--    EXTVENDOR.PerfProfile.EII_Tooltip.GetItemID = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.SetTooltip = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.HideTooltip = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.GetText = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.ParseAlreadyKnown = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.ParseClasses = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.ParseFood = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.ParseAccountBound = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.Total = 0;
--    EXTVENDOR.PerfProfile.EII_Tooltip.ItemCount = 0;
--end

local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local EXTVENDOR_NUM_PAGES = 1;
local LAST_INVENTORY_UPDATE = 0;
local QUEUE_DISPLAY_REFRESH = false;
local SUPPRESS_UPDATES = false;
local SUPPRESS_SEARCH_ONCHANGE_UPDATE = false;
local ELVUI_CHECK = false;
local QUEUE_QUICKVENDOR_UPDATE = false;
local ONSHOW_QUEUE_STATE = 0;
local HIDDEN_ITEM_TOOLTIP_LIMIT = 40;
local QUEUE_QVBUTTON_UPDATE = 0;

local function DebugMessage(msg, force)
    if (not EXTVENDOR.DebugMode and not force) then return; end
    ExtVendor_Message("|cffff0000[DEBUG]|r " .. msg);
end

--========================================
-- Initial load routine
--========================================
function ExtVendor_OnLoad(self)

    ExtVendor_RebuildMerchantFrame();

    ExtVendor_UpdateButtonPositions();

    EXTVENDOR.Hooks["MerchantFrame_UpdateMerchantInfo"] = MerchantFrame_UpdateMerchantInfo;
    MerchantFrame_UpdateMerchantInfo = function() end --ExtVendor_UpdateMerchantInfo;
    EXTVENDOR.Hooks["MerchantFrame_UpdateBuybackInfo"] = MerchantFrame_UpdateBuybackInfo;
    MerchantFrame_UpdateBuybackInfo = ExtVendor_UpdateBuybackInfo;
    
    EXTVENDOR.Hooks["MerchantPrevPageButton_OnClick"] = MerchantPrevPageButton_OnClick;
    MerchantPrevPageButton_OnClick = ExtVendor_PrevPageButton;
    EXTVENDOR.Hooks["MerchantNextPageButton_OnClick"] = MerchantNextPageButton_OnClick;
    MerchantNextPageButton_OnClick = ExtVendor_NextPageButton;
    
    MerchantPrevPageButton:SetScript("OnClick", ExtVendor_PrevPageButton);
    MerchantNextPageButton:SetScript("OnClick", ExtVendor_NextPageButton);

    MerchantFrame:SetScript("OnShow", ExtVendor_OnShow);
    MerchantFrame:HookScript("OnHide", ExtVendor_OnHide);
    
    MerchantFrameTab1:HookScript("OnClick", ExtVendor_UpdateDisplay);
    MerchantFrameTab2:HookScript("OnClick", ExtVendor_UpdateDisplay);

    self:RegisterEvent("ADDON_LOADED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("UNIT_INVENTORY_CHANGED");
    self:RegisterEvent("BAG_UPDATE");
    self:RegisterEvent("MERCHANT_SHOW");
    self:RegisterEvent("MERCHANT_UPDATE");

    SLASH_EXTVENDOR1 = "/evui";
    SlashCmdList["EXTVENDOR"] = ExtVendor_CommandHandler;

end

--========================================
-- Hooked merchant frame OnShow
--========================================
function ExtVendor_OnShow(self)
	-- Update repair all button status
	MerchantFrame_UpdateCanRepairAll();
	MerchantFrame_UpdateGuildBankRepair();
	PanelTemplates_SetTab(MerchantFrame, 1);
	ResetSetMerchantFilter();
	
	MerchantFrame_Update();
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
    
    SUPPRESS_UPDATES = true;
    SUPPRESS_SEARCH_ONCHANGE_UPDATE = true;

    MerchantFrameSearchBox:SetText("");
    if (EXTVENDOR_DATA['config']['stockfilter_defall']) then
        SetMerchantFilter(LE_LOOT_FILTER_ALL);
    end
    ExtVendor_SetMinimumQuality(0);
    ExtVendor_SetSlotFilter(0);

    SUPPRESS_UPDATES = false;
end

--========================================
-- Hooked merchant frame OnHide
--========================================
function ExtVendor_OnHide(self)

    CloseDropDownMenus();
    ExtVendor_StopProcessQuickVendor();

end

--========================================
-- Event handler
--========================================
function ExtVendor_OnEvent(self, event, ...)
    
    if (event == "ADDON_LOADED") then
        local arg1 = ...;
        if (arg1 == "ExtVendor") then
            ExtVendor_Setup();
        end
    elseif (event == "PLAYER_ENTERING_WORLD") then
        if (not ELVUI_CHECK) then ExtVendor_ElvUICheck(); end
        ELVUI_CHECK = true;
    elseif (event == "UNIT_INVENTORY_CHANGED") then
        local unit = ...;
        if (unit == "player") then
            DebugMessage("UNIT_INVENTORY_CHANGED");
            if (MerchantFrame:IsVisible() and (not EXTVENDOR.QuickVendor.Processing)) then
                ExtVendor_OnInventoryUpdate();
            end
        end
    elseif (event == "BAG_UPDATE") then
        if (EXTVENDOR.QuickVendor.Processing) then
            DebugMessage("BAG_UPDATE");
            ExtVendor_ProgressQuickVendor();
        else
            ExtVendor_RefreshQuickVendorButton();
        end
    elseif (event == "MERCHANT_SHOW") then
        ONSHOW_QUEUE_STATE = 1;
    elseif (event == "MERCHANT_UPDATE") then
        QUEUE_DISPLAY_REFRESH = true;
    end

end

--========================================
-- Update handler - handle refresh
-- queueing to limit the merchant frame
-- to no more than 1 refresh per
-- 1/10 seconds
--========================================
function ExtVendor_OnUpdate(self, elapsed)

    if (EXTVENDOR.RefreshingQuickVendorList) then
        ExtVendor_DoQuickVendorRefresh();
    elseif (QUEUE_QUICKVENDOR_UPDATE) then
        if (ExtVendor_StartQuickVendorRefresh()) then
            DebugMessage("Updating Quick-Vendor button");
            QUEUE_QUICKVENDOR_UPDATE = false;
        end
    end
    
    if (ONSHOW_QUEUE_STATE > 0) then QUEUE_DISPLAY_REFRESH = false; end
    if (ONSHOW_QUEUE_STATE == 1) then
        ExtVendor_UpdateDisplay();
        ONSHOW_QUEUE_STATE = 2;
    elseif (ONSHOW_QUEUE_STATE == 2) then
        OpenAllBags(self);
        ContainerFrame_UpdateAll();
        ONSHOW_QUEUE_STATE = 3;
    elseif (ONSHOW_QUEUE_STATE == 3) then
        ExtVendor_StartQuickVendorRefresh();
        ONSHOW_QUEUE_STATE = 4;
    elseif (ONSHOW_QUEUE_STATE == 4) then
        ExtVendor_UpdateMerchantInfo();
        ONSHOW_QUEUE_STATE = 0;
    end
    
    if (QUEUE_QVBUTTON_UPDATE > 0) then
        QUEUE_QVBUTTON_UPDATE = QUEUE_QVBUTTON_UPDATE - elapsed;
        if (QUEUE_QVBUTTON_UPDATE <= 0) then
            QUEUE_QVBUTTON_UPDATE = 0;
            ExtVendor_RefreshQuickVendorButton();
        end
    end
    
    if (QUEUE_DISPLAY_REFRESH) then
        if ((GetTime() - LAST_INVENTORY_UPDATE) > 0.1) then
            ExtVendor_UpdateDisplay();
            LAST_INVENTORY_UPDATE = GetTime();
            QUEUE_DISPLAY_REFRESH = false;
        end
    end
    
    SUPPRESS_SEARCH_ONCHANGE_UPDATE = false;
end

--========================================
-- ...
--========================================
function ExtVendor_OnInventoryUpdate()
    if ((GetTime() - LAST_INVENTORY_UPDATE) > 0.1) then
        ExtVendor_UpdateDisplay();
        LAST_INVENTORY_UPDATE = GetTime();
    else
        QUEUE_DISPLAY_REFRESH = true;
    end
end

--========================================
-- Post-load setup
--========================================
function ExtVendor_Setup()

    EXTVENDOR.Profile = GetRealmName() .. "." .. UnitName("player");

    local version = ExtVendor_CheckSetting("version", EXTVENDOR.VersionID);

    EXTVENDOR_DATA['config']['version'] = EXTVENDOR.VersionID;

    ExtVendor_CheckSetting("usable_items", false);
    ExtVendor_CheckSetting("hide_filtered", false);
    ExtVendor_CheckSetting("optimal_armor", false);
    ExtVendor_CheckSetting("show_suboptimal_armor", false);
    ExtVendor_CheckSetting("hide_known_recipes", false);
    ExtVendor_CheckSetting("stockfilter_defall", false);
    ExtVendor_CheckSetting("show_load_message", false);
    ExtVendor_CheckSetting("enable_quickvendor", true);
    ExtVendor_CheckSetting("filter_purchased_recipes", true);
    ExtVendor_CheckSetting("high_performance", true);
    ExtVendor_CheckSetting("hide_known_heirlooms", true);
    ExtVendor_CheckSetting("hide_known_toys", true);
    ExtVendor_CheckSetting("hide_known_mounts", true);

    ExtVendor_CheckSetting("quickvendor_suboptimal", false);
    ExtVendor_CheckSetting("quickvendor_alreadyknown", false);
    ExtVendor_CheckSetting("quickvendor_unusable", false);
    ExtVendor_CheckSetting("quickvendor_whitegear", false);
    ExtVendor_CheckSetting("quickvendor_oldgear", false);
    ExtVendor_CheckSetting("quickvendor_oldfood", false);

    if (EXTVENDOR_DATA['config']['show_load_message']) then
        ExtVendor_Message(string.format(L["LOADED_MESSAGE"], EXTVENDOR.Version));
    end

    -- initialize the customizable blacklist
    if (not EXTVENDOR_DATA['quickvendor_blacklist']) then
        EXTVENDOR_DATA['quickvendor_blacklist'] = EXTVENDOR_QUICKVENDOR_DEFAULT_BLACKLIST;
    end
    -- initialize global whitelist
    if (not EXTVENDOR_DATA['quickvendor_whitelist']) then
        EXTVENDOR_DATA['quickvendor_whitelist'] = {};
    end

    if (not EXTVENDOR_DATA[EXTVENDOR.Profile]) then
        EXTVENDOR_DATA[EXTVENDOR.Profile] = {};
    end

    -- initialize per-character whitelist
    if (not EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist']) then
        EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist'] = {};
    end

    ExtVendor_UpdateQuickVendorButtonVisibility();
end

--========================================
-- Check configuration setting, and
-- initialize with default value if not
-- present
--========================================
function ExtVendor_CheckSetting(field, default)

    if (not EXTVENDOR_DATA['config']) then
        EXTVENDOR_DATA['config'] = {};
    end
    if (EXTVENDOR_DATA['config'][field] == nil) then
        EXTVENDOR_DATA['config'][field] = default;
    end
    return EXTVENDOR_DATA['config'][field];
end

--========================================
-- Rearrange item slot positions
--========================================
function ExtVendor_UpdateButtonPositions(isBuyBack)

    local btn;
    local vertSpacing;

    if (isBuyBack) then
        vertSpacing = -30;
        horizSpacing = 50;
    else
        vertSpacing = -16;
        horizSpacing = 12;
    end
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        btn = _G["MerchantItem" .. i];
        if (isBuyBack) then
            if (i > BUYBACK_ITEMS_PER_PAGE) then
                btn:Hide();
            else
                if (i == 1) then
                    btn:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 64, -105);
                else
                    if ((i % 3) == 1) then
                        btn:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 3)], "BOTTOMLEFT", 0, vertSpacing);
                    else
                        btn:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", horizSpacing, 0);
                    end
                end
            end
        else
            btn:Show();
            if ((i % EXTVENDOR.ItemsPerSubpage) == 1) then
                if (i == 1) then
                    btn:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 24, -70);
                else
                    btn:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - (EXTVENDOR.ItemsPerSubpage - 1))], "TOPRIGHT", 12, 0);
                end
            else
                if ((i % 2) == 1) then
                    btn:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 2)], "BOTTOMLEFT", 0, vertSpacing);
                else
                    btn:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", horizSpacing, 0);
                end
            end
        end
    end

end

--========================================
-- Previous page button handler
-- (also used for wheel scrolling)
--========================================
function ExtVendor_PrevPageButton()
    EXTVENDOR.Hooks["MerchantPrevPageButton_OnClick"]();
    ExtVendor_UpdateMerchantInfo(true);
end

--========================================
-- Next page button handler
-- (also used for wheel scrolling)
--========================================
function ExtVendor_NextPageButton()
    EXTVENDOR.Hooks["MerchantNextPageButton_OnClick"]();
    ExtVendor_UpdateMerchantInfo(true);
end

--========================================
-- Show merchant page
--========================================
function ExtVendor_UpdateMerchantInfo(isPageScroll)
    if (SUPPRESS_UPDATES) then return; end
    local startTime = debugprofilestop();
    
    EXTVENDOR.Hooks["MerchantFrame_UpdateMerchantInfo"]();
    ExtVendor_UpdateButtonPositions();

    -- set title and portrait
	MerchantNameText:SetText(UnitName("NPC"));
	SetPortraitTexture(MerchantFramePortrait, "NPC");

    -- locals
    local totalMerchantItems = GetMerchantNumItems();
    local visibleMerchantItems = 0;
    local indexes = {};
    local search = string.trim(MerchantFrameSearchBox:GetText());
	local name, name2, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost, r, g, b, notOptimal, validSlot, reqClasses, accountBound, isHeirloom;
    local link, link2, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemSellPrice, itemId, bindType, iconFileDataId, itemClassId, itemSubClassId, expacId, itemSetId, isCraftingReagent, __;
    local collected, collectedAlt;
    local isFiltered = false;
    local whyFiltered = "";
    local isKnown = false;
    local isDarkmoonReplica = false;
    local checkAlreadyKnown;
    local kc;
    local i, j;
    local merchantItemInfo = {};
    local extItemInfo = {};
    local itemInfo = {};
    local highPerf = EXTVENDOR_DATA['config']['high_performance'];
    
    -- reset the hidden items list
    EXTVENDOR.HiddenItemsTooltipList = {};

    -- For some reason, when opening a vendor for the first time after logging in/reloading, the vendor's items will not load properly on the first attempt. The items have to be queried a second time before the
    -- item list is ever displayed; otherwise the client will get hammered with a million MERCHANT_UPDATE events and start trying to update the vendor list in rapid succession, causing a massive FPS drop for a really
    -- long time until the vendor's items eventually load all the way.
    -- However, querying the merchant item info twice in one attempt prevents this from happening for some reason. So we can just query everything once here first and continue on our way, at
    -- practically no cost of performance, and everything will be fine.
    if (not isPageScroll) then
        for i = 1, totalMerchantItems, 1 do
            name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(i);
        end
    end
    
    local precheckStart = debugprofilestop();
    
    --EXTVENDOR.PerfProfile.EII_Tooltip.Reset();
    --EXTVENDOR.PerfProfile.EII_Tooltip.Enable = true;
    
    -- **************************************************
    --  Pre-check filtering if hiding filtered items
    -- **************************************************
    if (EXTVENDOR_DATA['config']['hide_filtered']) then
        visibleMerchantItems = 0;
        for i = 1, totalMerchantItems, 1 do
            --merchantItemInfo[i] = pack(GetMerchantItemInfo(i));
		    --name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = unpack(merchantItemInfo[i]);
		    name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(i);
            merchantItemInfo[i] = packMerchantItemInfo(name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost);
            if (name) then
                link = GetMerchantItemLink(i);
                isDarkmoonReplica = false;
                isBoP = false;
                isKnown = false;
                isFiltered = false;
                quality = 1;

                -- get info from item link
                if (link) then
                    if (not highPerf) then
                        isKnown, reqClasses, itemId, accountBound = ExtVendor_GetExtendedItemInfo(link);
                        extItemInfo[i] = packExtItemInfo(isKnown, reqClasses, itemId, accountBound);
                    end
                    itemId = ExtVendor_GetItemID(link);
                    name2, link2, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataId, itemSellPrice, itemClassId, itemSubClassId, bindType, expacId, itemSetId, isCraftingReagent = GetItemInfo(link);
                    itemInfo[i] = packItemInfo(name2, link2, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataId, itemSellPrice, itemClassId, itemSubClassId, bindType, expacId, itemSetId, isCraftingReagent);
                end
                -- check if item is an heirloom
                if (itemId) then
                    isHeirloom = C_Heirloom.IsItemHeirloom(itemId);
                else
                    isHeirloom = false;
                end
                -- check if item is a darkmoon faire replica
                if ((bindType ~= 1) and (string.sub(name, 1, string.len(L["REPLICA"]) + 1) == (L["REPLICA"] .. " "))) then
                    isDarkmoonReplica = true;
                end
                
                isFiltered, whyFiltered = ExtVendor_IsItemFiltered(itemId, search, name, quality, itemClassId, itemSubClassId, itemEquipLoc, isKnown, isDarkmoonReplica, isPurchasable, isUsable, EXTVENDOR_DATA['config']['optimal_armor'] and not EXTVENDOR_DATA['config']['show_suboptimal_armor']);
                
                -- ***** add item to list if not filtered *****
                if (isFiltered) then
                    table.insert(EXTVENDOR.HiddenItemsTooltipList, {itemLink = link, reason = whyFiltered});
                else
                    table.insert(indexes, i);
                    visibleMerchantItems = visibleMerchantItems + 1;
                end
                
            else
                return;
            end
        end
    else
        -- no item hiding, add all items to list
        visibleMerchantItems = totalMerchantItems;
        for i = 1, totalMerchantItems, 1 do
		    name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(i);
            merchantItemInfo[i] = packMerchantItemInfo(name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost);
            if (name) then
                link = GetMerchantItemLink(i);
                if (link) then
                    if (not highPerf) then
                        isKnown, reqClasses, itemId, accountBound = ExtVendor_GetExtendedItemInfo(link);
                        extItemInfo[i] = packExtItemInfo(isKnown, reqClasses, itemId, accountBound);
                    end
                    itemId = ExtVendor_GetItemID(link);
                    name2, link2, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataId, itemSellPrice, itemClassId, itemSubClassId, bindType, expacId, itemSetId, isCraftingReagent = GetItemInfo(link);
                    itemInfo[i] = packItemInfo(name2, link2, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataId, itemSellPrice, itemClassId, itemSubClassId, bindType, expacId, itemSetId, isCraftingReagent);
                end
            end
            table.insert(indexes, i);
        end
    end

    local precheckEnd = debugprofilestop();

    -- validate current page shown
    if (MerchantFrame.page > math.max(1, math.ceil(visibleMerchantItems / MERCHANT_ITEMS_PER_PAGE))) then
        MerchantFrame.page = math.max(1, math.ceil(visibleMerchantItems / MERCHANT_ITEMS_PER_PAGE));
    end

    -- Show correct page count based on number of items shown
	MerchantPageText:SetFormattedText(MERCHANT_PAGE_NUMBER, MerchantFrame.page, math.ceil(visibleMerchantItems / MERCHANT_ITEMS_PER_PAGE));

    local displayStart = debugprofilestop();
    
    -- **************************************************
    --  Display items on merchant page
    -- **************************************************
    local index, itemButton;
    local merchantButton, merchantMoney, merchantAltCurrency;
    local colorMult, detailColor, slotColor;
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        index = ((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i;
		itemButton = _G["MerchantItem" .. i .. "ItemButton"];
        itemButton.link = nil;
		merchantButton = _G["MerchantItem" .. i];
		merchantMoney = _G["MerchantItem" .. i .. "MoneyFrame"];
		merchantAltCurrency = _G["MerchantItem" .. i .. "AltCurrencyFrame"];
        if (index <= visibleMerchantItems) then
			name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = unpackMerchantItemInfo(merchantItemInfo[indexes[index]]);
			--name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(indexes[index]);
            if (name ~= nil) then
			    _G["MerchantItem"..i.."Name"]:SetText(name);
			    SetItemButtonCount(itemButton, quantity);
			    SetItemButtonStock(itemButton, numAvailable);
			    SetItemButtonTexture(itemButton, texture);

                -- update item's currency info
			    if ( extendedCost and (price <= 0) ) then
				    itemButton.price = nil;
				    itemButton.extendedCost = true;
				    itemButton.link = GetMerchantItemLink(indexes[index]);
				    itemButton.texture = texture;
				    MerchantFrame_UpdateAltCurrency(indexes[index], i);
				    merchantAltCurrency:ClearAllPoints();
				    merchantAltCurrency:SetPoint("BOTTOMLEFT", "MerchantItem"..i.."NameFrame", "BOTTOMLEFT", 0, 31);
				    merchantMoney:Hide();
				    merchantAltCurrency:Show();
			    elseif ( extendedCost and (price > 0) ) then
				    itemButton.price = price;
				    itemButton.extendedCost = true;
				    itemButton.link = GetMerchantItemLink(indexes[index]);
				    itemButton.texture = texture;
				    MerchantFrame_UpdateAltCurrency(indexes[index], i);
				    MoneyFrame_Update(merchantMoney:GetName(), price);
				    merchantAltCurrency:ClearAllPoints();
				    merchantAltCurrency:SetPoint("LEFT", merchantMoney:GetName(), "RIGHT", -14, 0);
				    merchantAltCurrency:Show();
				    merchantMoney:Show();
			    else
				    itemButton.price = price;
				    itemButton.extendedCost = nil;
				    itemButton.link = GetMerchantItemLink(indexes[index]);
				    itemButton.texture = texture;
				    MoneyFrame_Update(merchantMoney:GetName(), price);
				    merchantAltCurrency:Hide();
				    merchantMoney:Show();
			    end

                isDarkmoonReplica = false;
                isKnown = false;
                isFiltered = false;
                quality = 1;

                if (itemButton.link) then
                    if (not highPerf) then
                        isKnown = unpackExtItemInfo(extItemInfo[indexes[index]]);
                    end
                    itemId = ExtVendor_GetItemID(itemButton.link)
                    __, __, quality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, __, itemSellPrice, itemClassId, itemSubClassId, bindType = unpackItemInfo(itemInfo[indexes[index]]);
                end

                -- set color
                if (quality) then
                    r, g, b = GetItemQualityColor(quality);
                else
                    r, g, b = 1, 1, 1;
                end
                _G["MerchantItem" .. i .. "Name"]:SetTextColor(r, g, b);
                SetItemButtonQuality(itemButton, quality, itemButton.link);
                
                if (itemId) then
                    isHeirloom = C_Heirloom.IsItemHeirloom(itemId);
                else
                    isHeirloom = false;
                end

                -- check if item is a darkmoon faire replica
                if ((bindType ~= 1) and (string.sub(name, 1, string.len(L["REPLICA"]) + 1) == (L["REPLICA"] .. " "))) then
                    isDarkmoonReplica = true;
                end

                if (EXTVENDOR_DATA['config']['hide_filtered']) then
                    if (EXTVENDOR_DATA['config']['show_suboptimal_armor']) then
                        isFiltered = ExtVendor_IsItemFilteredSuboptimal(itemId, quality, itemClassId, itemSubClassId, itemEquipLoc, isUsable, isDarkmoonReplica);
                    end
                else
                    isFiltered = ExtVendor_IsItemFiltered(itemId, search, name, quality, itemClassId, itemSubClassId, itemEquipLoc, isKnown, isDarkmoonReplica, isPurchasable, isUsable, EXTVENDOR_DATA['config']['optimal_armor']);
                end

                ExtVendor_SearchDimItem(_G["MerchantItem" .. i], isFiltered);

			    itemButton.hasItem = true;
			    itemButton:SetID(indexes[index]);
			    itemButton:Show();
                colorMult = 1.0;
                detailColor = {};
                slotColor = {};
                -- unavailable items (limited stock, bought out) are darkened
			    if ( numAvailable == 0 ) then
                    colorMult = 0.5;
                end
			    if ((not isUsable) or (not isPurchasable)) then
                    slotColor = {r = 1.0, g = 0, b = 0};
                    detailColor = {r = 1.0, g = 0, b = 0};
			    else
                    if (notOptimal) then
                        slotColor = {r = 0.25, g = 0.25, b = 0.25};
                        detailColor = {r = 0.5, g = 0, b = 0};
                    else
                        slotColor = {r = 1.0, g = 1.0, b = 1.0};
                        detailColor = {r = 0.5, g = 0.5, b = 0.5};
                    end
			    end
			    SetItemButtonNameFrameVertexColor(merchantButton, detailColor.r * colorMult, detailColor.g * colorMult, detailColor.b * colorMult);
			    SetItemButtonSlotVertexColor(merchantButton, slotColor.r * colorMult, slotColor.g * colorMult, slotColor.b * colorMult);
			    SetItemButtonTextureVertexColor(itemButton, slotColor.r * colorMult, slotColor.g * colorMult, slotColor.b * colorMult);
			    SetItemButtonNormalTextureVertexColor(itemButton, slotColor.r * colorMult, slotColor.g * colorMult, slotColor.b * colorMult);
            end
        else
			itemButton.price = nil;
			itemButton.hasItem = nil;
			itemButton:Hide();
			SetItemButtonNameFrameVertexColor(merchantButton, 0.5, 0.5, 0.5);
			SetItemButtonSlotVertexColor(merchantButton,0.4, 0.4, 0.4);
			_G["MerchantItem"..i.."Name"]:SetText("");
			_G["MerchantItem"..i.."MoneyFrame"]:Hide();
			_G["MerchantItem"..i.."AltCurrencyFrame"]:Hide();
            ExtVendor_SearchDimItem(_G["MerchantItem" .. i], false);
        end
    end
    
    local displayEnd = debugprofilestop();
    
    local finalDispStart = debugprofilestop();

	MerchantFrame_UpdateRepairButtons();

	-- Handle vendor buy back item
	local buybackName, buybackTexture, buybackPrice, buybackQuantity, buybackNumAvailable, buybackIsUsable = GetBuybackItemInfo(GetNumBuybackItems());
	if ( buybackName ) then
		MerchantBuyBackItemName:SetText(buybackName);
		SetItemButtonCount(MerchantBuyBackItemItemButton, buybackQuantity);
		SetItemButtonStock(MerchantBuyBackItemItemButton, buybackNumAvailable);
		SetItemButtonTexture(MerchantBuyBackItemItemButton, buybackTexture);
		MerchantBuyBackItemMoneyFrame:Show();
		MoneyFrame_Update("MerchantBuyBackItemMoneyFrame", buybackPrice);
		MerchantBuyBackItem:Show();
	else
		MerchantBuyBackItemName:SetText("");
		MerchantBuyBackItemMoneyFrame:Hide();
		SetItemButtonTexture(MerchantBuyBackItemItemButton, "");
		SetItemButtonCount(MerchantBuyBackItemItemButton, 0);
		-- Hide the tooltip upon sale
		if ( GameTooltip:IsOwned(MerchantBuyBackItemItemButton) ) then
			GameTooltip:Hide();
		end
	end

	-- Handle paging buttons
	if ( visibleMerchantItems > MERCHANT_ITEMS_PER_PAGE ) then
		if ( MerchantFrame.page == 1 ) then
			MerchantPrevPageButton:Disable();
		else
			MerchantPrevPageButton:Enable();
		end
		if ( MerchantFrame.page == ceil(visibleMerchantItems / MERCHANT_ITEMS_PER_PAGE) or visibleMerchantItems == 0) then
			MerchantNextPageButton:Disable();
		else
			MerchantNextPageButton:Enable();
		end
        EXTVENDOR_NUM_PAGES = ceil(visibleMerchantItems / MERCHANT_ITEMS_PER_PAGE);
		MerchantPageText:Show();
		MerchantPrevPageButton:Show();
		MerchantNextPageButton:Show();
	else
        EXTVENDOR_NUM_PAGES = 1;
		MerchantPageText:Hide();
		MerchantPrevPageButton:Hide();
		MerchantNextPageButton:Hide();
	end

	-- Show all merchant related items
	MerchantBuyBackItem:Show();
	MerchantFrameBottomLeftBorder:Show();
	MerchantFrameBottomRightBorder:Show();

	-- Hide buyback related items
    for i = 13, MERCHANT_ITEMS_PER_PAGE, 1 do
	    _G["MerchantItem" .. i]:Show();
    end

    local numHiddenItems = math.max(0, totalMerchantItems - visibleMerchantItems);
    --local hstring = (numHiddenItems == 1) and L["SINGLE_ITEM_HIDDEN"] or L["MULTI_ITEMS_HIDDEN"];
    MerchantFrameHiddenText:SetText(string.format(L["ITEMS_HIDDEN"], numHiddenItems .. "/" .. totalMerchantItems));
    if (numHiddenItems > 0) then
        MerchantFrameHiddenText:SetFontObject(GameFontNormal);
    else
        MerchantFrameHiddenText:SetFontObject(GameFontDisable);
    end

    local finalDispEnd = debugprofilestop();

    --QUEUE_QUICKVENDOR_UPDATE = true;
    --EXTVENDOR.PerfProfile.EII_Tooltip.Enable = false;
    local endTime = debugprofilestop();
    --DebugMessage("Update took " .. string.format("%.4f", (endTime - startTime)) .. " ms");
    --DebugMessage("PC: " .. string.format("%.4f", (precheckEnd - precheckStart)) .. " ms");
    --DebugMessage("DI: " .. string.format("%.4f", (displayEnd - displayStart)) .. " ms / FD: " .. string.format("%.4f", (finalDispEnd - finalDispStart)) .. " ms");
end

--========================================
-- Show buyback page
--========================================
function ExtVendor_UpdateBuybackInfo()
    EXTVENDOR.Hooks["MerchantFrame_UpdateBuybackInfo"]();
    ExtVendor_UpdateButtonPositions(true);
    local i;
    for i = 1, 12 do
        ExtVendor_SearchDimItem(_G["MerchantItem" .. i], false);
    end
end

--========================================
-- Rebuilds the merchant frame into
-- the extended design
--========================================
function ExtVendor_RebuildMerchantFrame()

    -- set the new width of the frame
    MerchantFrame:SetWidth(690);

    -- create new item buttons as needed
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        if (not _G["MerchantItem" .. i]) then
            CreateFrame("Frame", "MerchantItem" .. i, MerchantFrame, "MerchantItemTemplate");
        end
    end

    -- Thank you Blizzard for making the frame dynamically resizable for me. :D

    -- retexture the border element around the repair/buyback spots on the merchant tab
    MerchantFrameBottomLeftBorder:SetTexture("Interface\\AddOns\\ExtVendor\\textures\\bottomborder");
    MerchantFrameBottomRightBorder:SetTexture("Interface\\AddOns\\ExtVendor\\textures\\bottomborder");

    -- alter the position of the buyback item slot on the merchant tab
    MerchantBuyBackItem:ClearAllPoints();
    MerchantBuyBackItem:SetPoint("TOPLEFT", MerchantItem10, "BOTTOMLEFT", -14, -20);

    -- move the next/previous page buttons
    MerchantPrevPageButton:ClearAllPoints();
    MerchantPrevPageButton:SetPoint("CENTER", MerchantFrame, "BOTTOM", 30, 55);
    MerchantPageText:ClearAllPoints();
    MerchantPageText:SetPoint("BOTTOM", MerchantFrame, "BOTTOM", 160, 50);
    MerchantNextPageButton:ClearAllPoints();
    MerchantNextPageButton:SetPoint("CENTER", MerchantFrame, "BOTTOM", 290, 55);

    -- currency insets
    MerchantExtraCurrencyInset:ClearAllPoints();
    MerchantExtraCurrencyInset:SetPoint("BOTTOMRIGHT", MerchantMoneyInset, "BOTTOMLEFT", 0, 0);
    MerchantExtraCurrencyInset:SetPoint("TOPLEFT", MerchantMoneyInset, "TOPLEFT", -165, 0);
    MerchantExtraCurrencyBg:ClearAllPoints();
    MerchantExtraCurrencyBg:SetPoint("TOPLEFT", MerchantExtraCurrencyInset, "TOPLEFT", 3, -2);
    MerchantExtraCurrencyBg:SetPoint("BOTTOMRIGHT", MerchantExtraCurrencyInset, "BOTTOMRIGHT", -3, 2);

    -- add the search box
    local editbox = CreateFrame("EditBox", "MerchantFrameSearchBox", MerchantFrame, "SearchBoxTemplate");
    editbox:SetWidth(200);
    editbox:SetHeight(24);
    editbox:SetPoint("TOPRIGHT", MerchantFrame, "TOPRIGHT", -15, -30);
    editbox:SetAutoFocus(false);
    editbox:HookScript("OnTextChanged", ExtVendor_OnSearchTextChanged);
    editbox:SetMaxLetters(30);

    -- add quick-vendor button
    local junkBtn = CreateFrame("Button", "MerchantFrameSellJunkButton", MerchantFrame);
    junkBtn:SetWidth(32);
    junkBtn:SetHeight(32);
    junkBtn:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 70, -27);
    junkBtn.tooltip = L["QUICKVENDOR_BUTTON_TOOLTIP"];
    junkBtn:SetScript("OnClick", ExtVendor_StartQuickVendor);
    junkBtn:SetScript("OnEnter", ExtVendor_ShowButtonTooltip);
    junkBtn:SetScript("OnLeave", ExtVendor_HideButtonTooltip);
    junkBtn:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");
    junkBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD");
    junkBtnIcon = junkBtn:CreateTexture("MerchantFrameSellJunkButtonIcon", "BORDER");
    junkBtnIcon:SetTexture("Interface\\Icons\\Inv_Misc_Bag_10");
    junkBtnIcon:SetPoint("TOPLEFT", junkBtn, "TOPLEFT", 0, 0);
    junkBtnIcon:SetPoint("BOTTOMRIGHT", junkBtn, "BOTTOMRIGHT", 0, 0);

    -- filter button
    local filterBtn = CreateFrame("Button", "MerchantFrameFilterButton", MerchantFrame, "UIMenuButtonStretchTemplate");
    filterBtn:SetText(FILTER);
    filterBtn:SetPoint("RIGHT", MerchantFrameSearchBox, "LEFT", -30, 0);
    filterBtn:SetWidth(80);
    filterBtn:SetHeight(22);
    filterBtn:SetScript("OnClick", ExtVendor_DisplayFilterDropDown);

    -- create text for showing number of hidden items
    local hiddenItemsButton = CreateFrame("Button", "MerchantFrameHiddenItems", MerchantFrame);
    hiddenItemsButton:SetWidth(160);
    hiddenItemsButton:SetHeight(22);
    hiddenItemsButton:SetPoint("RIGHT", MerchantFrameFilterButton, "LEFT", -10, 0);
    hiddenItemsButton:SetScript("OnEnter", ExtVendor_ShowHiddenItemsTooltip);
    hiddenItemsButton:SetScript("OnLeave", ExtVendor_HideHiddenItemsTooltip);
    local hiddenText = hiddenItemsButton:CreateFontString("MerchantFrameHiddenText", "ARTWORK", "GameFontDisable");
    hiddenText:SetPoint("LEFT", hiddenItemsButton, "LEFT", 0, 0);
    hiddenText:SetPoint("RIGHT", hiddenItemsButton, "RIGHT", 0, 0);
    hiddenText:SetJustifyH("CENTER");
    hiddenText:SetJustifyV("MIDDLE");
    hiddenText:SetText("0 item(s) hidden");

    -- hide the new stock filter dropdown
    MerchantFrameLootFilter:Hide();

    -- filter options dropdown
    local filterDropdown = CreateFrame("Frame", "MerchantFrameFilterDropDown", UIParent, "UIDropDownMenuTemplate");

    -- create a new tooltip object for handling item tooltips in the background
    evTooltip = CreateFrame("GameTooltip", "ExtVendorHiddenTooltip", UIParent, "GameTooltipTemplate");

end

--========================================
-- Performs additional updates to main
-- display - fades items for searching
-- and applies quality colors to names
--========================================
function ExtVendor_UpdateDisplay()

    if (not SUPPRESS_UPDATES) then
        if (MerchantFrame.selectedTab == 1) then
            ExtVendor_UpdateMerchantInfo();
        elseif (MerchantFrame.selectedTab == 2) then
            ExtVendor_UpdateBuybackInfo();
        end
    end

    CloseDropDownMenus();

end

--========================================
-- Search box handler
--========================================
function ExtVendor_OnSearchTextChanged()
    if (not SUPPRESS_SEARCH_ONCHANGE_UPDATE) then
        ExtVendor_UpdateDisplay();
    end
end

--========================================
-- Dims or shows an item frame
--========================================
function ExtVendor_SearchDimItem(itemFrame, isDimmed)

    if (not itemFrame) then return; end

    local alpha;

    if (isDimmed) then
        alpha = 0.2;
    else
        alpha = 1;
    end
    itemFrame:SetAlpha(alpha);

    local btn = _G[itemFrame:GetName() .. "ItemButton"];
    if (isDimmed) then
        btn:Disable();
    else
        btn:Enable();
    end

end

--========================================
-- Generic button tooltip show handler
--========================================
function ExtVendor_ShowButtonTooltip(self)

    if (self.tooltip) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText(self.tooltip);
        GameTooltip:Show();
    end

end

--========================================
-- Generic button tooltip hide handler
--========================================
function ExtVendor_HideButtonTooltip(self)

    if (GameTooltip:GetOwner() == self) then
        GameTooltip:Hide();
    end

end

--========================================
-- Enable/disable the sell junk button
--========================================
function ExtVendor_SetJunkButtonState(state)
    if (state) then
        MerchantFrameSellJunkButton:Enable();
        MerchantFrameSellJunkButtonIcon:SetDesaturated(false);
    else
        MerchantFrameSellJunkButton:Disable();
        MerchantFrameSellJunkButtonIcon:SetDesaturated(true);
    end
end

--========================================
-- Gold/silver/copper money formatting
--========================================
function ExtVendor_FormatMoneyString(value, trailing)

    value = tonumber(value) or 0;

    local gold = math.floor(value / 10000);
    local silver = math.floor(value / 100) % 100;
    local copper = value % 100;

    local disp = "";

    if (gold > 0) then
        disp = disp .. format(GOLD_AMOUNT_TEXTURE, gold, 0, 0) .. " ";
    end
    if ((silver > 0) or (trailing and (gold > 0))) then
        disp = disp .. format(SILVER_AMOUNT_TEXTURE, silver, 0, 0) .. " ";
    end
    if ((copper > 0) or (trailing and ((gold > 0) or (silver > 0)))) then
        disp = disp .. format(COPPER_AMOUNT_TEXTURE, copper, 0, 0);
    end

    return disp;

end

--========================================
-- Toggles a boolean config setting
--========================================
function ExtVendor_ToggleSetting(name)
    if (EXTVENDOR_DATA['config'][name]) then
        EXTVENDOR_DATA['config'][name] = false;
    else
        EXTVENDOR_DATA['config'][name] = true;
    end
end

--========================================
-- Output message to chat frame
--========================================
function ExtVendor_Message(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<" .. L["ADDON_TITLE"] .. ">|r " .. msg);
end

--========================================
-- Slash command handler
--========================================
function ExtVendor_CommandHandler(cmd)

    if (strlower(cmd) == "debug") then
        EXTVENDOR.DebugMode = not EXTVENDOR.DebugMode;
        if (EXTVENDOR.DebugMode) then
            ExtVendor_Message("Debugging mode enabled");
        else
            ExtVendor_Message("Debugging mode disabled");
        end
        return;
    end
    
    local i, h;
    for i, h in pairs(EXTVENDOR.CommandHooks) do
        if (h(cmd)) then return; end
    end

    ExtVendor_ShowMainConfig();

end

--========================================
-- Called with pcall to safely catch
-- errors (fixes battle pet error)
--========================================
function ExtVendor_SetHiddenTooltip(link)
    ExtVendorHiddenTooltip:SetHyperlink(link);
end

--========================================
-- Updates the quick vendor button's
-- state based on combat/inventory
--========================================
function ExtVendor_RefreshQuickVendorButton()
    QUEUE_QUICKVENDOR_UPDATE = true;
end

--========================================
-- Shows the tooltip listing items hidden
-- by current search/filter criteria
--========================================
function ExtVendor_ShowHiddenItemsTooltip(self)
    local numHidden = #EXTVENDOR.HiddenItemsTooltipList;
    if (numHidden > 0) then
        local numShown = 0;
        MerchantFrameHiddenText:SetFontObject(GameFontHighlight);
        MerchantFrameHiddenText:SetScale(1.1);
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
        GameTooltip:AddLine(MerchantFrameHiddenText:GetText());
        local i, l;
        for i, l in pairs(EXTVENDOR.HiddenItemsTooltipList) do
            GameTooltip:AddDoubleLine(l.itemLink, l.reason, 1, 1, 1, 0.75, 0.75, 0.75);
            numShown = numShown + 1;
            --if ((numShown == HIDDEN_ITEM_TOOLTIP_LIMIT) and ((numHidden - numShown) >= 3)) then
            if ((numHidden > HIDDEN_ITEM_TOOLTIP_LIMIT) and (numShown == (HIDDEN_ITEM_TOOLTIP_LIMIT - 2))) then
                GameTooltip:AddLine(" ");
                GameTooltip:AddLine(string.format(L["MORE_ITEMS_HIDDEN"], (numHidden - numShown)), 1, 1, 1);
                break;
            end
        end
        GameTooltip:Show();
    end
end

--========================================
-- Hides the filtered items tooltip
--========================================
function ExtVendor_HideHiddenItemsTooltip(self)
    if (#EXTVENDOR.HiddenItemsTooltipList > 0) then
        MerchantFrameHiddenText:SetFontObject(GameFontNormal);
    else
        MerchantFrameHiddenText:SetFontObject(GameFontDisable);
    end
    MerchantFrameHiddenText:SetScale(1);
    if (GameTooltip:GetOwner() == self) then
        GameTooltip:Hide();
    end
end

--========================================
-- Formats a string, parsing an array of
-- keys into values
--========================================
function ExtVendor_FormatString(stringToParse, args)
    local key, val;
    local str = stringToParse;
    for key, val in pairs(args) do
        str = string.gsub(str, "{$" .. key .. "}", val);
    end
    return str;
end

function ExtVendor_OnQuickVendorStop()
    QUEUE_QVBUTTON_UPDATE = 0.5;
end

--========================================
-- These functions pack/unpack the return
-- values from GetMerchantItemInfo,
-- ExtVendor_GetExtendedItemInfo and
-- GetItemInfo into tables and back
--========================================
function packMerchantItemInfo(name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost)
    return {name = name, texture = texture, price = price, quantity = quantity, numAvailable = numAvailable, isPurchasable = (isPurchasable or false), isUsable = (isUsable or false), extendedCost = (extendedCost or false)};
end

function unpackMerchantItemInfo(info)
    return info.name, info.texture, info.price, info.quantity, info.numAvailable, info.isPurchasable, info.isUsable, info.extendedCost;
end

function packItemInfo(itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent)
    return {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemLevel = itemLevel, itemMinLevel = itemMinLevel, itemType = itemType, itemSubType = itemSubType, itemStackCount = itemStackCount, itemEquipLoc = itemEquipLoc, iconFileDataID = iconFileDataID, itemSellPrice = itemSellPrice, itemClassID = itemClassID, itemSubClassID = itemSubClassID, bindType = bindType, expacID = expacID, itemSetID = itemSetID, isCraftingReagent = isCraftingReagent};
end

function unpackItemInfo(info)
    return info.itemName, info.itemLink, info.itemRarity, info.itemLevel, info.itemMinLevel, info.itemType, info.itemSubType, info.itemStackCount, info.itemEquipLoc, info.iconFileDataID, info.itemSellPrice, info.itemClassID, info.itemSubClassID, info.bindType, info.expacID, info.itemSetID, info.isCraftingReagent;
end

function packExtItemInfo(isKnown, reqClasses, itemID, isAccountBound)
    return {isKnown = isKnown, reqClasses = reqClasses, itemID = itemID, isAccountBound = isAccountBound};
end

function unpackExtItemInfo(info)
    return info.isKnown, info.reqClasses, info.itemID, info.isAccountBound;
end
