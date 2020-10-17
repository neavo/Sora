local NUM_LINES = 0;
local LINE_HEIGHT = 12;
local DEBUG_TITLE = "Debug Title";
local DEBUG_MESSAGE = "";
local DEBUG_LINES = {};
local NEED_REFRESH = false;
local REFRESH_DELAY = 0;

function ExtVendor_QuickVendorDebug_OnLoad(self)
    table.insert(EXTVENDOR.CommandHooks, ExtVendor_QuickVendorDebug_OnCommand);
    self:RegisterForDrag("LeftButton");
    ExtVendor_QuickVendorDebugFrameHeader:SetText("Quick Vendor Debug - Inventory Detail");
    ExtVendor_QuickVendorDebugFrameReportMessage:SetText("If Quick Vendor is not vendoring items correctly, you can provide a screenshot of this dialog to help diagnose the problem.");
end

function ExtVendor_QuickVendorDebug_OnCommand(cmd)
    if (strlower(cmd) == "qvcfg") then
        local summ = "Quick-Vendor Configuration Summary:";
        local fields = { "quickvendor_alreadyknown", "quickvendor_oldfood", "quickvendor_oldgear", "quickvendor_suboptimal", "quickvendor_unusable", "quickvendor_whitegear" }
        for i, f in pairs(fields) do
            summ = summ .. "\n" .. f .. ": " .. (EXTVENDOR_DATA['config'][f] and "|cff00ff00ON|r" or "|cffff0000OFF|r");
        end
        ExtVendor_Message(summ);
        return true;
    elseif (strlower(cmd) == "qvdebug") then
        ExtVendor_QuickVendorDebug();
        return true;
    elseif (strlower(cmd) == "translatehelp") then
        ExtVendor_TranslatorHelp();
        return true;
    end
    return false;
end

function ExtVendor_QuickVendorDebug_OnShow(self)
    ExtVendor_QuickVendorDebugFrameHeader:SetText(DEBUG_TITLE);
    ExtVendor_QuickVendorDebugFrameReportMessage:SetText(DEBUG_MESSAGE);
    local count = #DEBUG_LINES;
    local i;
    if (NUM_LINES < count) then NUM_LINES = count; end
    ExtVendor_QuickVendorDebugFrame:SetHeight(100 + (count * LINE_HEIGHT));
    for i = 1, NUM_LINES do
        local tleft = _G["ExtVendor_QuickVendorDebugFrameItem" .. i .. "Left"];
        local tright = _G["ExtVendor_QuickVendorDebugFrameItem" .. i .. "Right"];
        if (not tleft) then
            tleft = self:CreateFontString("ExtVendor_QuickVendorDebugFrameItem" .. i .. "Left", "ARTWORK", "GameFontHighlightSmall");
            tright = self:CreateFontString("ExtVendor_QuickVendorDebugFrameItem" .. i .. "Right", "ARTWORK", "GameFontHighlightSmall");
            tleft:SetPoint("TOPLEFT", ExtVendor_QuickVendorDebugFrame, "TOPLEFT", 40, -(30 + (i * LINE_HEIGHT)));
            tleft:SetPoint("BOTTOMRIGHT", ExtVendor_QuickVendorDebugFrame, "TOPRIGHT", 40, -(50 + (i * LINE_HEIGHT)));
            tright:SetPoint("TOPRIGHT", ExtVendor_QuickVendorDebugFrame, "TOPRIGHT", -40, -(30 + (i * LINE_HEIGHT)));
            tright:SetPoint("BOTTOMLEFT", ExtVendor_QuickVendorDebugFrame, "TOPLEFT", 40, -(50 + (i * LINE_HEIGHT)));
            tleft:SetJustifyH("LEFT");
            tright:SetJustifyH("RIGHT");
        end
        if (i <= count) then
            tleft:Show();
            tleft:SetText(DEBUG_LINES[i].left or "");
            tright:Show();
            tright:SetText(DEBUG_LINES[i].right or "");
        else
            tleft:Hide();
            tright:Hide();
        end
    end
end

function ExtVendor_QuickVendorDebug_OnUpdate(self, elapsed)
    if (REFRESH_DELAY > 0) then
        REFRESH_DELAY = max(0, REFRESH_DELAY - elapsed);
        if (REFRESH_DELAY <= 0) then
            ExtVendor_TranslatorHelp(true);
        end
    end
end


function ExtVendor_QuickVendorDebug()
    DEBUG_LINES = {};
    local i;
    for i = 1, #EXTVENDOR.QuickVendor.InventoryDetail do
        local rcolor = (EXTVENDOR.QuickVendor.InventoryDetail[i].isJunk and "|cff00ff00" or "|cff808080");
        local jind = rcolor .. ">|r ";
        table.insert(DEBUG_LINES, { left = jind .. (EXTVENDOR.QuickVendor.InventoryDetail[i].link or "???"), right = rcolor .. (EXTVENDOR.QuickVendor.InventoryDetail[i].reason or "???") });
    end
    DEBUG_TITLE = "Quick Vendor Debug - Inventory Detail";
    DEBUG_MESSAGE = "If Quick Vendor is not vendoring items correctly, you can provide a screenshot of this dialog to help diagnose the problem.";
    ExtVendor_QuickVendorDebugFrame:Show();
end


function ExtVendor_TranslatorHelp(isRefresh)
    local ph = isRefresh and "|cffff0000Unable to retrieve string" or "...";
    DEBUG_LINES = {
        { left = "The following fields in the translation file should be set to these values", right = "" },
        { left = "" },
        --{ left = "L[\"ARMOR_CLOTH\"]",              right = select(7, GetItemInfo(93860)) or ph },
        --{ left = "L[\"ARMOR_LEATHER\"]",            right = select(7, GetItemInfo(122383)) or ph },
        --{ left = "L[\"ARMOR_MAIL\"]",               right = select(7, GetItemInfo(122380)) or ph },
        --{ left = "L[\"ARMOR_PLATE\"]",              right = select(7, GetItemInfo(122387)) or ph },
        --{ left = "L[\"ARMOR_SHIELD\"]",             right = select(7, GetItemInfo(122391)) or ph },
        --{ left = "" },
        --{ left = "L[\"WEAPON_1H_AXE\"]",            right = select(7, GetItemInfo(141001)) or ph },
        --{ left = "L[\"WEAPON_1H_MACE\"]",           right = select(7, GetItemInfo(122354)) or ph },
        --{ left = "L[\"WEAPON_1H_SWORD\"]",          right = select(7, GetItemInfo(122351)) or ph },
        --{ left = "L[\"WEAPON_2H_AXE\"]",            right = select(7, GetItemInfo(122349)) or ph },
        --{ left = "L[\"WEAPON_2H_MACE\"]",           right = select(7, GetItemInfo(122386)) or ph },
        --{ left = "L[\"WEAPON_2H_SWORD\"]",          right = select(7, GetItemInfo(122365)) or ph },
        --{ left = "L[\"WEAPON_STAFF\"]",             right = select(7, GetItemInfo(122353)) or ph },
        --{ left = "L[\"WEAPON_POLEARM\"]",           right = select(7, GetItemInfo(140773)) or ph },
        --{ left = "L[\"WEAPON_WAND\"]",              right = select(7, GetItemInfo(11287)) or ph },
        --{ left = "L[\"WEAPON_BOW\"]",               right = select(7, GetItemInfo(122352)) or ph },
        --{ left = "L[\"WEAPON_GUN\"]",               right = select(7, GetItemInfo(122366)) or ph },
        --{ left = "L[\"WEAPON_CROSSBOW\"]",          right = select(7, GetItemInfo(73234)) or ph },
        --{ left = "L[\"WEAPON_DAGGER\"]",            right = select(7, GetItemInfo(122364)) or ph },
        --{ left = "L[\"WEAPON_FIST\"]",              right = select(7, GetItemInfo(122396)) or ph },
        --{ left = "L[\"WEAPON_WARGLAIVE\"]",         right = select(7, GetItemInfo(127829)) or ph },
        --{ left = "" },
        --{ left = "L[\"ITEMTYPE_RECIPE\"]",          right = select(6, GetItemInfo(115357)) or ph },
        --{ left = "L[\"ITEMTYPE_CONSUMABLE\"]",      right = select(6, GetItemInfo(159)) or ph },
        --{ left = "L[\"ITEMSUBTYPE_FOOD_DRINK\"]",   right = select(7, GetItemInfo(159)) or ph },
        --{ left = "L[\"ITEMSUBTYPE_OTHER\"]",        right = select(7, GetItemInfo(122338)) or ph },
    };
    DEBUG_TITLE = "Extended Vendor UI - Translation Helper Tool";
    DEBUG_MESSAGE = "";
    if (isRefresh) then
        ExtVendor_QuickVendorDebug_OnShow(ExtVendor_QuickVendorDebugFrame)
    else
        ExtVendor_QuickVendorDebugFrame:Show();
        REFRESH_DELAY = 0.4;
    end
end
