local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local SELL_ITEM_GROUP_SIZE = 1;
local REFRESH_CURRENT_BAG = 0;
local REFRESH_CURRENT_SLOT = 1;
local REFRESH_SLOTS_IN_BAG = 0;
local NUM_BLACKLISTED_JUNK = 0;

-- This table defines the levels at which the player "outlevels" gear from
-- a given expac (outdated gear filter). Syntax per entry is as follows:
--  [expac_id] = <min player level for expac's gear to be considered outdated>
local GEAR_OUTLEVEL_TABLE = {
    [0] = 70,   -- vanilla gear uses a different check, this is here just because
    [1] = 90,   -- BC gear is outdated when player reaches level 90
    [2] = 90,   -- wotlk gear is also outdated when player reaches level 90
    [3] = 100,  -- cata gear is outdated when player reaches level 100
    [4] = 100,  -- pandaria gear is also outdated when player reaches level 100
    [5] = 110,  -- draenor gear is outdated when player reaches level 110
    [6] = 120,  -- legion gear is outdated when player reaches level 120
    [7] = 130,  -- BFA gear is outdated when player reaches level 130
    [8] = 130,  -- ...
    [9] = 130,
    [10] = 130,
};

--========================================
-- Gets a list of junk items in the
-- player's bags
--========================================
function ExtVendor_StartQuickVendorRefresh()
    if (EXTVENDOR.RefreshingQuickVendorList) then return false; end
    ExtVendor_SetJunkButtonState(false);
    if (EXTVENDOR.QuickVendor.Processing) then return false; end
    REFRESH_CURRENT_BAG = 0;
    REFRESH_CURRENT_SLOT = 1;
    NUM_BLACKLISTED_JUNK = 0;
    REFRESH_SLOTS_IN_BAG = GetContainerNumSlots(REFRESH_CURRENT_BAG);
    EXTVENDOR.QuickVendor.CurrentJunkList = {};
    EXTVENDOR.QuickVendor.InventoryDetail = {};
    EXTVENDOR.RefreshingQuickVendorList = true;
    return true;
end

function ExtVendor_DoQuickVendorRefresh()
    local processed = 0;
    local __, count, isJunk, junkInfo, detail;
    while true do
        if (processed >= 20) then break; end
        if (REFRESH_CURRENT_SLOT <= REFRESH_SLOTS_IN_BAG) then
            __, count = GetContainerItemInfo(REFRESH_CURRENT_BAG, REFRESH_CURRENT_SLOT);
            if (count) then
                isJunk, junkInfo, isBlacklisted, detail = ExtVendor_IsContainerItemJunk(REFRESH_CURRENT_BAG, REFRESH_CURRENT_SLOT);
                if (isJunk) then
                    table.insert(EXTVENDOR.QuickVendor.CurrentJunkList, junkInfo);
                else
                    if (isBlacklisted) then
                        NUM_BLACKLISTED_JUNK = NUM_BLACKLISTED_JUNK + 1;
                    end
                end
                if (detail) then
                    table.insert(EXTVENDOR.QuickVendor.InventoryDetail, detail);
                end
                processed = processed + 1;
            end
        end
        REFRESH_CURRENT_SLOT = REFRESH_CURRENT_SLOT + 1;
        if (REFRESH_CURRENT_SLOT > REFRESH_SLOTS_IN_BAG) then
            REFRESH_CURRENT_SLOT = 1;
            REFRESH_CURRENT_BAG = REFRESH_CURRENT_BAG + 1;
            REFRESH_SLOTS_IN_BAG = GetContainerNumSlots(REFRESH_CURRENT_BAG);
        end
        if (REFRESH_CURRENT_BAG > 4) then
            ExtVendor_StopQuickVendorRefresh();
            break;
        end
    end
end

function ExtVendor_StopQuickVendorRefresh()
    EXTVENDOR.RefreshingQuickVendorList = false;
    if (#EXTVENDOR.QuickVendor.CurrentJunkList > 0) then
        ExtVendor_SetJunkButtonState(true);
    else
        ExtVendor_SetJunkButtonState(false);
    end
end

--========================================
-- Show confirmation for selling all
-- junk items
--========================================
function ExtVendor_StartQuickVendor(self)

    --local junk, numBlacklisted = ExtVendor_GetQuickVendorList();

    if (#EXTVENDOR.QuickVendor.CurrentJunkList > 0) then
        table.sort(EXTVENDOR.QuickVendor.CurrentJunkList, function(a, b) return (a.stackPrice < b.stackPrice); end);
        ExtVendor_ShowJunkPopup(EXTVENDOR.QuickVendor.CurrentJunkList, NUM_BLACKLISTED_JUNK);
    end

end

function ExtVendor_IsContainerItemJunk(bag, slot)
    local __, count = GetContainerItemInfo(bag, slot);
    local iDetail;
    if (count) then
        local link = GetContainerItemLink(bag, slot);
        if (link) then
            local isKnown, reqClasses, itemId, isAccountBound, isFoodOrDrink = ExtVendor_GetExtendedItemInfo(link);
            local name, __, quality, itemLevel, itemReqLevel, itemType, itemSubType, maxStack, itemEquipLoc, __, price, itemClassId, itemSubClassId, bindType, expacID = GetItemInfo(link);
            
            -- make sure the item has a vendor price
            if ((price or 0) > 0) then
                local isJunk, reason, detail = ExtVendor_IsItemQuickVendor(bag, slot, link, quality, itemLevel, itemReqLevel, bindType, isKnown, itemClassId, itemSubClassId, itemEquipLoc, reqClasses, isAccountBound, expacID, isFoodOrDrink);
                
                if (detail) then
                    iDetail = { link = link, isJunk = isJunk, reason = detail };
                else
                    iDetail = { link = link, isJunk = isJunk, reason = "No information" };
                end

                if ((not isJunk) and (reason == 100)) then
                    return false, nil, true, iDetail;
                end

                -- if the item meets requirements, add it to the list
                if (isJunk) then
                    return isJunk, {id = itemId, name = name, quality = quality, count = count, maxStack = maxStack, stackPrice = count * price, reason = reason}, false, iDetail;
                end
                return false, nil, false, iDetail;
            else
                return false, nil, false, { link = link, isJunk = false, reason = "No vendor price" };
            end
        end
    end
    return nil;
end

--========================================
-- Returns whether an item should
-- quick-vendor based on quality, type,
-- if it is already known, soulbound
--========================================
function ExtVendor_IsItemQuickVendor(bag, bagSlot, link, quality, itemLevel, itemReqLevel, bindType, alreadyKnown, itemClassId, itemSubClassId, equipSlot, requiredClasses, isAccountBound, expacID, isFoodOrDrink)
    local itemID = ExtVendor_GetItemID(link);
    local idx, id;

    for idx, id in pairs(EXTVENDOR_INTERNAL_BLACKLIST) do
        if (id == itemID) then
            return false, nil, "Blacklisted internally";
        end
    end
    
    local playerLevel = UnitLevel("player");

    -- don't vendor blacklisted items
    if (ExtVendor_IsBlacklisted(itemID)) then
        return false, 100, "Blacklisted";
    end
    -- always vendor whitelisted items
    if (ExtVendor_IsWhitelisted(itemID)) then
        return true, L["QUICKVENDOR_REASON_WHITELISTED"], "Whitelisted";
    end
    -- never attempt to sell account-bound items (unless they're whitelisted)
    if (isAccountBound) then
        return false, nil, "Account-bound";
    end
    -- NEVER quick-vendor legendary or heirloom items. EVER. Ever. ever.
    if (quality > 4) then
        return false, nil, "Quality too high";
    end
    -- don't vendor equipment if it's part of an equipment set
    if ((itemClassId == LE_ITEM_CLASS_ARMOR) or (itemClassId == LE_ITEM_CLASS_WEAPON)) then
        if (ExtVendor_IsItemInEquipmentSet(bag, bagSlot)) then return false, nil, "Part of equipment set"; end
    end
    -- *** Poor (grey) items ***
    if (quality == 0) then
        return true, L["QUICKVENDOR_REASON_POORQUALITY"], "Poor quality";
    end
    -- *** Common (white) gear ***
    if (EXTVENDOR_DATA['config']['quickvendor_whitegear']) then
        if (quality == 1) then
            if (itemClassId == LE_ITEM_CLASS_ARMOR) then
                if ((itemSubClassId == LE_ITEM_ARMOR_CLOTH) or (itemSubClassId == LE_ITEM_ARMOR_LEATHER) or (itemSubClassId == LE_ITEM_ARMOR_MAIL) or (itemSubClassId == LE_ITEM_ARMOR_PLATE)) then
                    if ((equipSlot ~= "INVTYPE_TABARD") and (equipSlot ~= "INVTYPE_SHIRT")) then
                        return true, L["QUICKVENDOR_REASON_WHITEGEAR"], "Common (white) armor";
                    end
                end
            elseif (itemClassId == LE_ITEM_CLASS_WEAPON) then
                if ((itemSubClassId ~= LE_ITEM_WEAPON_GENERIC) and (itemSubClassId ~= LE_ITEM_WEAPON_FISHINGPOLE)) then
                    return true, L["QUICKVENDOR_REASON_WHITEGEAR"], "Common (white) weapon";
                end
            end
        end
    end
    if (EXTVENDOR_DATA['config']['quickvendor_oldfood']) then
        if (isFoodOrDrink) then
            if (ExtVendor_IsOutdatedItemLevel(itemLevel, playerLevel)) then
                return true, L["QUICKVENDOR_REASON_OUTDATED_FOOD"], "Outdated food";
            end
        end
    end
    -- Soulbound stuff
    if (bindType == 1) then
        -- *** "Already Known" ***
        if (EXTVENDOR_DATA['config']['quickvendor_alreadyknown']) then
            if (alreadyKnown) then
                return true, L["QUICKVENDOR_REASON_ALREADYKNOWN"], "Already known";
            end
        end
        -- *** Unusable (class-restricted, unusable armor/weapon types) ***
        if (EXTVENDOR_DATA['config']['quickvendor_unusable']) then
            if (not ExtVendor_ClassIsAllowed(UnitClass("player"), requiredClasses)) then
                return true, L["QUICKVENDOR_REASON_CLASSRESTRICTED"], "Class restricted";
            end
            if (not ExtVendor_IsUsableArmorType(itemClassId, itemSubClassId, equipSlot)) then
                return true, L["QUICKVENDOR_REASON_UNUSABLEARMOR"], "Unusable armor";
            end
            if (not ExtVendor_IsUsableWeaponType(itemClassId, itemSubClassId, equipSlot)) then
                return true, L["QUICKVENDOR_REASON_UNUSABLEWEAPON"], "Unusable weapon";
            end
        end
        -- *** Sub-optimal armor ***
        if (EXTVENDOR_DATA['config']['quickvendor_suboptimal']) then
            if (not ExtVendor_IsOptimalArmor(itemClassId, itemSubClassId, equipSlot)) then
                return true, L["QUICKVENDOR_REASON_SUBOPTIMAL"], "Sub-optimal armor";
            end
        end
        -- *** Outdated gear ***
        if (((quality == 3) or (quality == 4)) and ((itemClassId == LE_ITEM_CLASS_ARMOR) or (itemClassId == LE_ITEM_CLASS_WEAPON)) and (equipSlot ~= "")) then
            if (EXTVENDOR_DATA['config']['quickvendor_oldgear']) then
                -- always ignore items from the account's expansion level (or higher)
                if (expacID < GetAccountExpansionLevel()) then
                    -- ignore items with a minimum level requirement within 10 levels of the player, regardless of item level or expac (timewarped fix)
                    if (itemReqLevel < (playerLevel - 10)) then
                        if ((playerLevel >= (GEAR_OUTLEVEL_TABLE[expacID] or 999)) or ((expacID == 0) and (playerLevel >= (itemLevel + 12)))) then
                            return true, L["QUICKVENDOR_REASON_OUTDATED_GEAR"], "Outdated rare/epic equipment";
                        end
                    end
                end
            end
        end
    end
    -- nothing matched = do not quickvendor
    return false, nil, "No matching criteria";
end

--========================================
-- Performs quick-vendor
--========================================
function ExtVendor_ConfirmQuickVendor()
    local link, count, name, color, quality, itemLevel, itemReqLevel, price, maxStack, quantity, bindType, expacID, itemType, itemSubType, itemClassId, itemSubClassId, itemEquipLoc, __;
    local isKnown, reqClasses, itemId, isAccountBound, isFoodOrDrink;
    local bag, slot;
    local totalPrice = 0;
    local itemsOnLine = 0;
    local numItemsSold = 0;
    local itemsSold = "";
    local soldPref = L["SOLD"];

    if (not MerchantFrame:IsShown()) then return; end
    
    EXTVENDOR.QuickVendor.ProcessJunkList = EXTVENDOR.QuickVendor.CurrentJunkList; --ExtVendor_GetQuickVendorList();
    if (not EXTVENDOR.QuickVendor.ProcessJunkList) then return; end
    if (table.maxn(EXTVENDOR.QuickVendor.ProcessJunkList) < 1) then return; end
    
    -- use the progress window if the junk item list is bigger than 10 items
    if (table.maxn(EXTVENDOR.QuickVendor.ProcessJunkList) > SELL_ITEM_GROUP_SIZE) then
        ExtVendor_StartProcessQuickVendor();
        return;
    end

    -- otherwise just do it the old way
    for bag = 0, 4, 1 do
        if (GetContainerNumSlots(bag)) then
            for slot = 1, GetContainerNumSlots(bag), 1 do
                __, count = GetContainerItemInfo(bag, slot);
                link = GetContainerItemLink(bag, slot);
                if (link and count) then
                    name, __, quality, itemLevel, itemReqLevel, itemType, itemSubType, maxStack, itemEquipLoc, __, price, itemClassId, itemSubClassId, bindType, expacID = GetItemInfo(link);
                    isKnown, reqClasses, itemId, isAccountBound, isFoodOrDrink = ExtVendor_GetExtendedItemInfo(link);

                    if ((price or 0) > 0) then
                        if (ExtVendor_IsItemQuickVendor(bag, slot, link, quality, itemLevel, itemReqLevel, bindType, isKnown, itemClassId, itemSubClassId, itemEquipLoc, reqClasses, isAccountBound, expacID, isFoodOrDrink)) then
                            PickupContainerItem(bag, slot);
                            PickupMerchantItem(0);
                            __, __, __, color = GetItemQualityColor(quality);
                            if (itemsOnLine > 0) then
                                itemsSold = itemsSold .. ", ";
                            end
                            if (maxStack > 1) then
                                quantity = "x" .. count;
                            else
                                quantity = "";
                            end
                            itemsSold = itemsSold .. "|c" .. color .. "[" .. name .. "]|r" .. quantity;
                            itemsOnLine = itemsOnLine + 1;
                            if (itemsOnLine == 12) then
                                DEFAULT_CHAT_FRAME:AddMessage(soldPref .. " " .. itemsSold, ChatTypeInfo["SYSTEM"].r, ChatTypeInfo["SYSTEM"].g, ChatTypeInfo["SYSTEM"].b, GetChatTypeIndex("SYSTEM"));
                                soldPref = "    ";
                                itemsSold = "";
                                itemsOnLine = 0;
                            end
                            totalPrice = totalPrice + (price * count);
                            numItemsSold = numItemsSold + 1;
                        end
                    end
                end
            end
        end
    end

    if (numItemsSold > 0) then
        DEFAULT_CHAT_FRAME:AddMessage(ExtVendor_FormatString(L["SOLD_COMPACT"], { ["count"] = numItemsSold, ["price"] = "|cffffffff" .. ExtVendor_FormatMoneyString(totalPrice) }), ChatTypeInfo["SYSTEM"].r, ChatTypeInfo["SYSTEM"].g, ChatTypeInfo["SYSTEM"].b, GetChatTypeIndex("SYSTEM"));
    end
end

function ExtVendor_StartProcessQuickVendor()
    if (EXTVENDOR.QuickVendor.Processing) then return; end
    
    EXTVENDOR.QuickVendor.Processing = true;
    EXTVENDOR.QuickVendor.TotalSellPrice = 0;
    EXTVENDOR.QuickVendor.TotalItemsSold = 0;
    ExtVendor_ShowProgressPopup();
    ExtVendor_ProgressQuickVendor();
end

function ExtVendor_ProgressQuickVendor()
    if (not EXTVENDOR.QuickVendor.Processing) then return nil; end

    -- cancel the process if the vendor window is no longer shown
    if (not MerchantFrame:IsShown()) then
        ExtVendor_StopProcessQuickVendor();
        return nil;
    end
    
    local link, count, name, color, quality, itemLevel, itemReqLevel, price, maxStack, quantity, bindType, expacID, itemType, itemSubType, itemEquipLoc, itemClassId, itemSubClassId, __;
    local isKnown, reqClasses, itemId, isAccountBound, isFoodOrDrink;
    local bag, slot;
    local totalPrice = 0;
    local itemsOnLine = 0;
    local numItemsSold = 0;
    local itemsSold = "";
    local soldPref = L["SOLD"];
    
    local CANCEL = false;
    
    for bag = 0, 4, 1 do
        if (GetContainerNumSlots(bag)) then
            for slot = 1, GetContainerNumSlots(bag), 1 do
            
                if (not CANCEL) then

                    __, count, locked = GetContainerItemInfo(bag, slot);
                    if (not locked) then
                        link = GetContainerItemLink(bag, slot);
                        if (link and count) then
                            name, __, quality, itemLevel, itemReqLevel, itemType, itemSubType, maxStack, itemEquipLoc, __, price, itemClassId, itemSubClassId, bindType, expacID = GetItemInfo(link);
                            isKnown, reqClasses, itemId, isAccountBound, isFoodOrDrink = ExtVendor_GetExtendedItemInfo(link);

                            if ((price or 0) > 0) then
                                if (ExtVendor_IsItemQuickVendor(bag, slot, link, quality, itemLevel, itemReqLevel, bindType, isKnown, itemClassId, itemSubClassId, itemEquipLoc, reqClasses, isAccountBound, expacID, isFoodOrDrink)) then
                                    PickupContainerItem(bag, slot);
                                    PickupMerchantItem(0);
                                    __, __, __, color = GetItemQualityColor(quality);
                                    if (itemsOnLine > 0) then
                                        itemsSold = itemsSold .. ", ";
                                    end
                                    if (maxStack > 1) then
                                        quantity = "x" .. count;
                                    else
                                        quantity = "";
                                    end
                                    itemsSold = itemsSold .. "|c" .. color .. "[" .. name .. "]|r" .. quantity;
                                    itemsOnLine = itemsOnLine + 1;
                                    totalPrice = totalPrice + (price * count);
                                    numItemsSold = numItemsSold + 1;
                                    
                                    if (numItemsSold >= SELL_ITEM_GROUP_SIZE) then CANCEL = true; end
                                end
                            end
                        end
                    end
                    
                end
                
            end
        end
    end
    
    EXTVENDOR.QuickVendor.TotalItemsSold = EXTVENDOR.QuickVendor.TotalItemsSold + numItemsSold;
    EXTVENDOR.QuickVendor.TotalSellPrice = EXTVENDOR.QuickVendor.TotalSellPrice + totalPrice;
    
    if (EXTVENDOR.QuickVendor.TotalItemsSold >= #EXTVENDOR.QuickVendor.ProcessJunkList) then
        ExtVendor_StopProcessQuickVendor();
    end
    
    return numItemsSold, totalPrice, EXTVENDOR.QuickVendor.TotalItemsSold, EXTVENDOR.QuickVendor.TotalSellPrice;
    
end

function ExtVendor_StopProcessQuickVendor()
    if (EXTVENDOR.QuickVendor.Processing) then
        EXTVENDOR.QuickVendor.Processing = false;
        if (EXTVENDOR.QuickVendor.TotalItemsSold > 0) then
            DEFAULT_CHAT_FRAME:AddMessage(ExtVendor_FormatString(L["SOLD_COMPACT"], { ["count"] = EXTVENDOR.QuickVendor.TotalItemsSold, ["price"] = "|cffffffff" .. ExtVendor_FormatMoneyString(EXTVENDOR.QuickVendor.TotalSellPrice) }), ChatTypeInfo["SYSTEM"].r, ChatTypeInfo["SYSTEM"].g, ChatTypeInfo["SYSTEM"].b, GetChatTypeIndex("SYSTEM"));
        end
    end
    ExtVendor_SellJunkProgressPopup:Hide();
    ExtVendor_UpdateDisplay();
    ExtVendor_OnQuickVendorStop();
end

--========================================
-- Returns whether or not the specified
-- item ID is blacklisted
--========================================
function ExtVendor_IsBlacklisted(itemId)

    for idx, id in pairs(EXTVENDOR_DATA['quickvendor_blacklist']) do
        if (id == itemId) then
            return true;
        end
    end

    return false;

end

--========================================
-- Returns whether or not the specified
-- item ID is whitelisted
--========================================
function ExtVendor_IsWhitelisted(itemId, globalOnly)
    for idx, id in pairs(EXTVENDOR_DATA['quickvendor_whitelist']) do
        if (id == itemId) then
            return true;
        end
    end
    if (not globalOnly) then
        for idx, id in pairs(EXTVENDOR_DATA[EXTVENDOR.Profile]['quickvendor_whitelist']) do
            if (id == itemId) then
                return true;
            end
        end
    end
    return false;
end

--========================================
-- Shows or hides the quick vendor button
-- depending on configuration
--========================================
function ExtVendor_UpdateQuickVendorButtonVisibility()
    if (EXTVENDOR_DATA['config']['enable_quickvendor']) then
        MerchantFrameSellJunkButton:Show();
    else
        MerchantFrameSellJunkButton:Hide();
    end
end
