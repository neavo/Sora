local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local EXTVENDOR_DUMMY;
local SELL_PROGRESS_TIMER = 0;
local PROGRESS_MAX = 1;
local SELL_INTERVAL = 0.2;
local JUNK_LINE_LIMIT = 50;
local TEST_MODE = false;
local ITEM_LIST_WIDTH_WITH_SCROLLBAR = 533;
local ITEM_LIST_WIDTH_NO_SCROLLBAR = 553;

local currentJunkList = {};

--========================================
-- Popup load
--========================================
function ExtVendor_SellJunkPopup_OnLoad(self)

    ExtVendor_SellJunkPopupMessage:SetText(L["CONFIRM_SELL_JUNK"]);

    hooksecurefunc("StaticPopup_OnShow", ExtVendor_Hook_StaticPopup_OnShow);
    hooksecurefunc("StaticPopup_OnHide", ExtVendor_Hook_StaticPopup_OnHide);
    
    ExtVendor_SellJunkPopup_JunkListItemListScrollBar.Show =
        function(self)
            ExtVendor_SellJunkPopup_JunkListItemList:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			for _X, button in next, ExtVendor_SellJunkPopup_JunkListItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_WITH_SCROLLBAR);
			end
			getmetatable(self).__index.Show(self);
        end
    ExtVendor_SellJunkPopup_JunkListItemListScrollBar.Hide =
        function(self)
            ExtVendor_SellJunkPopup_JunkListItemList:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			for _X, button in next, ExtVendor_SellJunkPopup_JunkListItemList.buttons do
				button:SetWidth(ITEM_LIST_WIDTH_NO_SCROLLBAR);
			end
			getmetatable(self).__index.Hide(self);
        end
    ExtVendor_SellJunkPopup_JunkListItemList.update = ExtVendor_SellJunkPopup_UpdateScrollingList;
    HybridScrollFrame_CreateButtons(ExtVendor_SellJunkPopup_JunkListItemList, "ExtVendor_JunkItemListButtonTemplate", 0, 0);

    tinsert(UISpecialFrames, "ExtVendor_SellJunkPopup");

end

--========================================
-- Show the custom sell junk popup
--========================================
function ExtVendor_ShowJunkPopup(junkList, numBlacklisted)

    if (ExtVendor_SellJunkPopup:IsShown() or (not junkList)) then return; end

    ExtVendor_SellJunkPopup_UpdatePosition();

    ExtVendor_SellJunkPopup_BuildJunkList(junkList, numBlacklisted);
    currentJunkList = junkList;
    ExtVendor_SellJunkPopup_UpdateScrollingList();

    ExtVendor_SellJunkPopup:Show();

    if (EXTVENDOR.DebugMode) then
        ExtVendor_SellJunkPopupDebugButton:Show();
    else
        ExtVendor_SellJunkPopupDebugButton:Hide();
    end

end

--========================================
-- Update popup position based on the
-- state of the original static popups
--========================================
function ExtVendor_SellJunkPopup_UpdatePosition()

    local anchorTo = 0;

    for i = 1, 4, 1 do
        local popup = _G["StaticPopup" .. i];
        if (popup) then
            if (popup:IsShown()) then
                anchorTo = i;
            end
        end
    end

    ExtVendor_SellJunkPopup:ClearAllPoints();
    if (anchorTo > 0) then
        ExtVendor_SellJunkPopup:SetPoint("TOP", _G["StaticPopup" .. anchorTo], "BOTTOM", 0, 0);
    else
        ExtVendor_SellJunkPopup:SetPoint("TOP", UIParent, "TOP", 0, -135);
    end

end

--========================================
-- Build the list of junk items to sell
--========================================
function ExtVendor_SellJunkPopup_BuildJunkList(junkList, numBlacklisted)

    local line = 1;
    local leftText, midText, rightText, quantity;
    local topOfList = 25 + ExtVendor_SellJunkPopupMessage:GetStringHeight() + 15;
    local totalHeight = 0;
    local totalPrice = 0;

    --for i = 1, (JUNK_LINE_LIMIT + 1), 1 do
    --    leftText = _G["ExtVendor_SellJunkPopupLeft" .. i];
    --    midText = _G["ExtVendor_SellJunkPopupMid" .. i];
    --    rightText = _G["ExtVendor_SellJunkPopupRight" .. i];
    --    if (leftText) then leftText:Hide(); end
    --    if (midText) then midText:Hide(); end
    --    if (rightText) then rightText:Hide(); end
    --end
    
    ExtVendor_SellJunkPopup_JunkList:ClearAllPoints();
    ExtVendor_SellJunkPopup_JunkList:SetPoint("TOP", ExtVendor_SellJunkPopup, "TOP", 0, -topOfList);

    --local reachedLineLimit = false;
    if (table.maxn(junkList) > 0) then
        local totalJunkCount = table.maxn(junkList);
        for index, data in pairs(junkList) do
            --if (not reachedLineLimit) then
            --    leftText = _G["ExtVendor_SellJunkPopupLeft" .. line];
            --    midText = _G["ExtVendor_SellJunkPopupMid" .. line];
            --    rightText = _G["ExtVendor_SellJunkPopupRight" .. line];
            --    if (not leftText) then
            --        leftText = ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupLeft" .. line, "ARTWORK", "GameFontHighlightSmall");
            --        if (line == 1) then
            --            leftText:SetPoint("TOPLEFT", ExtVendor_SellJunkPopup, "TOPLEFT", 25, -topOfList);
            --        else
            --            leftText:SetPoint("TOPLEFT", _G["ExtVendor_SellJunkPopupLeft" .. (line - 1)], "BOTTOMLEFT", 0, -2);
            --        end
            --    else
            --        leftText:Show();
            --    end
            --    if (not midText) then
            --        midText = ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupMid" .. line, "ARTWORK", "GameFontHighlightSmall");
            --        if (line == 1) then
            --            midText:SetPoint("TOP", ExtVendor_SellJunkPopup, "TOP", 100, -topOfList);
            --        else
            --            midText:SetPoint("TOP", _G["ExtVendor_SellJunkPopupMid" .. (line - 1)], "BOTTOM", 0, -2);
            --        end
            --    else
            --        midText:Show();
            --    end
            --    if (not rightText) then
            --        rightText = ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupRight" .. line, "ARTWORK", "GameFontHighlightSmall");
            --        rightText:SetJustifyH("RIGHT");
            --        if (line == 1) then
            --            rightText:SetPoint("TOPRIGHT", ExtVendor_SellJunkPopup, "TOPRIGHT", -25, -topOfList);
            --        else
            --            rightText:SetPoint("TOPRIGHT", _G["ExtVendor_SellJunkPopupRight" .. (line - 1)], "BOTTOMRIGHT", 0, -2);
            --        end
            --    else
            --        rightText:Show();
            --    end
            --    if ((line < JUNK_LINE_LIMIT) or (totalJunkCount < (JUNK_LINE_LIMIT + 1))) then
            --        if (data.maxStack > 1) then
            --            quantity = " x " .. data.count;
            --        else
            --            quantity = "";
            --        end
            --        EXTVENDOR_DUMMY, EXTVENDOR_DUMMY, EXTVENDOR_DUMMY, color = GetItemQualityColor(data.quality);
            --        leftText:SetText("|c" .. color .. "[" .. data.name .. "]|r" .. quantity);
            --        midText:SetText(data.reason);
            --        rightText:SetText(string.trim(ExtVendor_FormatMoneyString(data.stackPrice, true)));
            --        if (line == 1) then
            --            totalHeight = topOfList + leftText:GetStringHeight();
            --        else
            --            totalHeight = totalHeight + 2 + leftText:GetStringHeight();
            --        end
            --    else
            --        leftText:SetPoint("TOPLEFT", _G["ExtVendor_SellJunkPopupLeft" .. (line - 1)], "BOTTOMLEFT", 0, -12);
            --        rightText:SetPoint("TOPRIGHT", _G["ExtVendor_SellJunkPopupRight" .. (line - 1)], "BOTTOMRIGHT", 0, -12);
            --        midText:SetPoint("TOP", _G["ExtVendor_SellJunkPopupMid" .. (line - 1)], "BOTTOM", -50, -12);
            --        midText:SetText(string.format(L["QUICKVENDOR_MORE_ITEMS"], (totalJunkCount - (JUNK_LINE_LIMIT - 1))));
            --        totalHeight = totalHeight + 12 + midText:GetStringHeight();
            --        line = line + 1;
            --        reachedLineLimit = true;
            --    end
            --end
            totalPrice = totalPrice + data.stackPrice;
            --if (not reachedLineLimit) then line = line + 1; end
        end
    end

    local tsOffset = 0;

    --totalHeight = totalHeight + 15;
    totalHeight = topOfList + ExtVendor_SellJunkPopup_JunkList:GetHeight() + 10;

    local totalLeft = ExtVendor_SellJunkPopupTotalLeft or ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupTotalLeft", "ARTWORK", "GameFontHighlight");
    local totalRight = ExtVendor_SellJunkPopupTotalRight or ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupTotalRight", "ARTWORK", "GameFontHighlight");
    totalLeft:ClearAllPoints();
    --totalLeft:SetPoint("TOPLEFT", _G["ExtVendor_SellJunkPopupLeft" .. (line - 1)], "BOTTOMLEFT", 110, -(15 + tsOffset));
    totalLeft:SetPoint("TOPLEFT", ExtVendor_SellJunkPopup, "BOTTOMLEFT", 110, 70);
    totalLeft:SetText(L["TOTAL_SALE_PRICE"]);

    totalRight:ClearAllPoints();
    --totalRight:SetPoint("TOPRIGHT", _G["ExtVendor_SellJunkPopupRight" .. (line - 1)], "BOTTOMRIGHT", -110, -(15 + tsOffset));
    totalRight:SetPoint("TOPRIGHT", ExtVendor_SellJunkPopup, "BOTTOMRIGHT", -110, 70);
    totalRight:SetText(ExtVendor_FormatMoneyString(totalPrice));

    totalHeight = totalHeight + totalLeft:GetStringHeight() + 15;

    -- blacklist message
    local blText;
    blText = _G["ExtVendor_SellJunkPopupBlacklist"];
    if ((numBlacklisted or 0) > 0) then
        if (not blText) then
            blText = ExtVendor_SellJunkPopup:CreateFontString("ExtVendor_SellJunkPopupBlacklist", "ARTWORK", "GameFontHighlight");
        end
        blText:ClearAllPoints();
        blText:SetPoint("TOP", ExtVendor_SellJunkPopup, "TOP", 0, -(totalHeight - 10));
        blText:SetText(string.format(L["ITEMS_BLACKLISTED"], numBlacklisted));
        blText:Show();
        totalHeight = totalHeight + 5 + blText:GetStringHeight();
    else
        if (blText) then
            blText:Hide();
        end
    end

    ExtVendor_SellJunkPopupYesButton:SetPoint("TOPRIGHT", ExtVendor_SellJunkPopup, "TOP", -5, -totalHeight);

    totalHeight = totalHeight + ExtVendor_SellJunkPopupYesButton:GetHeight() + 25;

    ExtVendor_SellJunkPopup:SetHeight(totalHeight);

end

function ExtVendor_SellJunkPopup_UpdateScrollingList()

    local scrollFrame = ExtVendor_SellJunkPopup_JunkListItemList;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;
    local numJunk = table.maxn(currentJunkList);
    local selection = -1; --scrollFrame.selection or -1;

	local junkListIndex;
	local displayedHeight = 0;
	for i = 1, numButtons do
		junkListIndex = i + offset;
		if (junkListIndex > numJunk) then
			buttons[i]:Hide();
		else
            local junkData = currentJunkList[junkListIndex];
            local itemName, itemLink, itemRarity, _X, _X, _X, _X, _X, _X, itemTexture = GetItemInfo(junkData.id);
            buttons[i].index = blacklistIndex;
            local displayName = "|cffff0000" .. L["UNKNOWN_ITEM"];
            if (junkData.name and junkData.quality) then
                displayName = ITEM_QUALITY_COLORS[junkData.quality].hex .. junkData.name;
            end
            --ExtVendor_ItemListButton_DisplayItem(buttons[i], itemID, itemTexture, displayName, selection);
            ExtVendor_SellJunkPopup_DisplayItem(buttons[i], junkData.id, itemTexture, displayName, junkData.reason, junkData.stackPrice, selection)
			displayedHeight = displayedHeight + buttons[i]:GetHeight();
		end
	end

    local totalHeight = numJunk * 20;

	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);
    
end

--========================================
-- Hook for static popup OnShow
--========================================
function ExtVendor_Hook_StaticPopup_OnShow(self)

    ExtVendor_SellJunkPopup_UpdatePosition();
    
end

--========================================
-- Hook for static popup OnHide
--========================================
function ExtVendor_Hook_StaticPopup_OnHide(self)

    ExtVendor_SellJunkPopup_UpdatePosition();

end


--****************************************************************************************************
--*                                                                                                  *
--*    QUICK VENDOR PROGRESS POPUP STUFF                                                             *
--*                                                                                                  *
--****************************************************************************************************


function ExtVendor_SellJunkProgressPopup_OnLoad(self)
    ExtVendor_SellJunkProgressPopup_MainHeader:SetText(L["QUICKVENDOR_PROGRESS"]);
end

function ExtVendor_SellJunkProgressPopup_OnHide(self)
    TEST_MODE = false;
end

--========================================
-- Vendor 'ticks'
--========================================
function ExtVendor_SellJunkProgressPopup_OnUpdate(self, elapsed)

    if (TEST_MODE) then return; end

    if (not EXTVENDOR.QuickVendor.Processing) then ExtVendor_SellJunkProgressPopup:Hide(); end

    --SELL_PROGRESS_TIMER = SELL_PROGRESS_TIMER - elapsed;
    --if (SELL_PROGRESS_TIMER > 0) then return; end
    --SELL_PROGRESS_TIMER = SELL_INTERVAL;
    
    --local tickItemsSold, tickPrice, totalItemsSold, totalPrice = ExtVendor_ProgressQuickVendor();
    
    --if (totalItemsSold) then
    --end
    ExtVendor_SellJunkProgressPopup_MainProgressBar:SetValue(math.min(PROGRESS_MAX, EXTVENDOR.QuickVendor.TotalItemsSold));
    
end

--========================================
-- Showing the popup and setting up
-- some of the elements and timer
--========================================
function ExtVendor_ShowProgressPopup()

    if (not EXTVENDOR.QuickVendor.ProcessJunkList) then return; end
    if (table.maxn(EXTVENDOR.QuickVendor.ProcessJunkList) < 1) then return; end

    SELL_PROGRESS_TIMER = 0;

    PROGRESS_MAX = table.maxn(EXTVENDOR.QuickVendor.ProcessJunkList);
    ExtVendor_SellJunkProgressPopup_MainProgressBar:SetValue(0);
    ExtVendor_SellJunkProgressPopup_MainProgressBar:SetMinMaxValues(0, PROGRESS_MAX);
    
    ExtVendor_SellJunkProgressPopup:Show();

end

--========================================
-- Showing the popup in test mode
--========================================
function ExtVendor_SellJunkPopup_Test()
    if (EXTVENDOR.QuickVendor.Processing) then return; end
    TEST_MODE = true;
    ExtVendor_SellJunkProgressPopup_MainProgressBar:SetValue(0);
    ExtVendor_SellJunkProgressPopup_MainProgressBar:SetMinMaxValues(0, 1);
    ExtVendor_SellJunkProgressPopup:Show();
end


function ExtVendor_SellJunkPopup_ShowItemTooltip(button)
    if (not button.itemID) then return; end
    GameTooltip:SetOwner(button, "ANCHOR_BOTTOMLEFT", 0, 20);
    GameTooltip:SetItemByID(button.itemID);
end

function ExtVendor_SellJunkPopup_DisplayItem(button, itemID, itemIcon, itemName, itemReason, itemPrice, selection)
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
    local buttonReason = _G[button:GetName() .. "Reason"];
    local buttonPrice = _G[button:GetName() .. "Price"];
    local buttonSelection = _G[button:GetName() .. "Selection"];
    if (itemIcon) then
        if (buttonIcon ~= nil) then buttonIcon:SetTexture(itemIcon); end
    end
    if (buttonName ~= nil) then buttonName:SetText(itemName); end
    if (buttonReason ~= nil) then buttonReason:SetText(itemReason or ""); end
    if (buttonPrice ~= nil) then buttonPrice:SetText(string.trim(ExtVendor_FormatMoneyString(itemPrice or 0, true))); end
    if (button.index == selection) then
        buttonSelection:Show();
    else
        buttonSelection:Hide();
    end
end
