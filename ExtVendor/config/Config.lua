local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local STORE_SETTINGS = {};
local CONFIG_SHOWN = false;

function ExtVendor_ShowMainConfig()
    -- call this twice because the interface options panel never likes to open to an addon category the first time for some reason
    InterfaceOptionsFrame_OpenToCategory(ExtVendorConfigContainer);
    InterfaceOptionsFrame_OpenToCategory(ExtVendorConfigContainer);
end

--========================================
-- Setting up the config frame
--========================================
function ExtVendorConfig_OnLoad(self)
    self.name = L["ADDON_TITLE"];
    self.okay = function(self) ExtVendorConfig_Okay(); end;
    self.cancel = function(self) ExtVendorConfig_Cancel(); end;
    self.refresh = function(self) ExtVendorConfig_Refresh(); end;
    self.default = function(self) ExtVendorConfig_SetDefaults(); end;
    InterfaceOptions_AddCategory(self);

    ExtVendorConfigTitle:SetText(string.format(L["VERSION_TEXT"], "|cffffffffv" .. EXTVENDOR.Version));

    -- ********** General Options **********

    ExtVendorConfig_GeneralContainerTitle:SetText(L["CONFIG_HEADING_GENERAL"]);

	ExtVendorConfig_GeneralContainer_ShowLoadMsgText:SetText(L["OPTION_STARTUP_MESSAGE"]);
	ExtVendorConfig_GeneralContainer_ShowLoadMsg.tooltip = L["OPTION_STARTUP_MESSAGE_TOOLTIP"];

	ExtVendorConfig_GeneralContainer_HighPerformanceText:SetText(L["OPTION_REDUCE_LAG"]);
	ExtVendorConfig_GeneralContainer_HighPerformance.tooltip = L["OPTION_REDUCE_LAG_TOOLTIP"];
    
    --ExtVendorConfig_GeneralContainer_Scale.tooltip = L["OPTION_SCALE_TOOLTIP"];

    -- ********** Filter Options **********

    ExtVendorConfig_FilterContainerTitle:SetText(L["CONFIG_HEADING_FILTER"]);

	ExtVendorConfig_FilterContainer_ShowSuboptimalArmorText:SetText(L["OPTION_FILTER_SUBARMOR_SHOW"]);
	ExtVendorConfig_FilterContainer_ShowSuboptimalArmor.tooltip = L["OPTION_FILTER_SUBARMOR_SHOW_TOOLTIP"];

	ExtVendorConfig_FilterContainer_StockDefaultAllText:SetText(L["OPTION_STOCKFILTER_DEFAULTALL"]);
	ExtVendorConfig_FilterContainer_StockDefaultAll.tooltip = L["OPTION_STOCKFILTER_DEFAULTALL_TOOLTIP"];

    -- ********** Quick-Vendor Options **********

    ExtVendorConfig_QuickVendorContainerTitle:SetText(L["CONFIG_HEADING_QUICKVENDOR"]);

	ExtVendorConfig_QuickVendorContainer_EnableButtonText:SetText(L["OPTION_QUICKVENDOR_ENABLEBUTTON"]);
	ExtVendorConfig_QuickVendorContainer_EnableButton.tooltip = L["OPTION_QUICKVENDOR_ENABLEBUTTON_TOOLTIP"];

	ExtVendorConfig_QuickVendorContainer_SuboptimalArmorText:SetText(L["OPTION_QUICKVENDOR_SUBARMOR"]);
	ExtVendorConfig_QuickVendorContainer_SuboptimalArmor.tooltip = L["OPTION_QUICKVENDOR_SUBARMOR_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];

	ExtVendorConfig_QuickVendorContainer_AlreadyKnownText:SetText(L["OPTION_QUICKVENDOR_ALREADYKNOWN"]);
	ExtVendorConfig_QuickVendorContainer_AlreadyKnown.tooltip = L["OPTION_QUICKVENDOR_ALREADYKNOWN_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];

	ExtVendorConfig_QuickVendorContainer_UnusableEquipText:SetText(L["OPTION_QUICKVENDOR_UNUSABLE"]);
	ExtVendorConfig_QuickVendorContainer_UnusableEquip.tooltip = L["OPTION_QUICKVENDOR_UNUSABLE_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];

	ExtVendorConfig_QuickVendorContainer_WhiteGearText:SetText(L["OPTION_QUICKVENDOR_WHITEGEAR"]);
	ExtVendorConfig_QuickVendorContainer_WhiteGear.tooltip = L["OPTION_QUICKVENDOR_WHITEGEAR_TOOLTIP"];

	ExtVendorConfig_QuickVendorContainer_OutdatedGearText:SetText(L["OPTION_QUICKVENDOR_OUTDATEDGEAR"]);
	ExtVendorConfig_QuickVendorContainer_OutdatedGear.tooltip = L["OPTION_QUICKVENDOR_OUTDATEDGEAR_TOOLTIP"] .. "\n\n|cff00ff00" .. L["QUICKVENDOR_SOULBOUND"];

	ExtVendorConfig_QuickVendorContainer_OutdatedFoodText:SetText(L["OPTION_QUICKVENDOR_OUTDATEDFOOD"]);
	ExtVendorConfig_QuickVendorContainer_OutdatedFood.tooltip = L["OPTION_QUICKVENDOR_OUTDATEDFOOD_TOOLTIP"];
    
end

--==================================================
-- Handle when the configuration is opened
--==================================================
--function ExtVendorConfig_OnShow()
--    if (CONFIG_SHOWN) then return; end
--    ExtVendorConfig_StoreCurrentSettings();
--    CONFIG_SHOWN = true;
--end

--========================================
-- Sets the values of the controls to
-- reflect currently loaded settings
--========================================
--function ExtVendorConfig_Refresh()
--    ExtVendorConfig_OnShow();
--	ExtVendorConfig_GeneralContainer_ShowLoadMsg:SetChecked(EXTVENDOR_DATA['config']['show_load_message']);
--	ExtVendorConfig_GeneralContainer_HighPerformance:SetChecked(EXTVENDOR_DATA['config']['high_performance']);
--    ExtVendorConfig_GeneralContainer_Scale:SetValue((EXTVENDOR_DATA['config']['scale'] * 20) - 15);
--
--	ExtVendorConfig_FilterContainer_ShowSuboptimalArmor:SetChecked(EXTVENDOR_DATA['config']['show_suboptimal_armor']);
--	ExtVendorConfig_FilterContainer_StockDefaultAll:SetChecked(EXTVENDOR_DATA['config']['stockfilter_defall']);
--
--    ExtVendorConfig_QuickVendorContainer_EnableButton:SetChecked(EXTVENDOR_DATA['config']['enable_quickvendor']);
--    ExtVendorConfig_QuickVendorContainer_SuboptimalArmor:SetChecked(EXTVENDOR_DATA['config']['quickvendor_suboptimal']);
--    ExtVendorConfig_QuickVendorContainer_AlreadyKnown:SetChecked(EXTVENDOR_DATA['config']['quickvendor_alreadyknown']);
--    ExtVendorConfig_QuickVendorContainer_UnusableEquip:SetChecked(EXTVENDOR_DATA['config']['quickvendor_unusable']);
--    ExtVendorConfig_QuickVendorContainer_WhiteGear:SetChecked(EXTVENDOR_DATA['config']['quickvendor_whitegear']);
--    ExtVendorConfig_QuickVendorContainer_OutdatedGear:SetChecked(EXTVENDOR_DATA['config']['quickvendor_oldgear']);
--    ExtVendorConfig_QuickVendorContainer_OutdatedFood:SetChecked(EXTVENDOR_DATA['config']['quickvendor_oldfood']);
--    --ExtVendorConfig_QuickVendorContainer_CompactChatMessage:SetChecked(EXTVENDOR_DATA['config']['quickvendor_msg_compact']);
--end

--========================================
-- Sets the values of the controls to
-- reflect currently loaded settings
--========================================
function ExtVendorConfig_Refresh()
    if (not CONFIG_SHOWN) then
        ExtVendorConfig_StoreCurrentSettings();
    end
    
	ExtVendorConfig_GeneralContainer_ShowLoadMsg:SetChecked(STORE_SETTINGS.loadMessage);
	ExtVendorConfig_GeneralContainer_HighPerformance:SetChecked(STORE_SETTINGS.reduceLag);

	ExtVendorConfig_FilterContainer_ShowSuboptimalArmor:SetChecked(STORE_SETTINGS.showSuboptimal);
	ExtVendorConfig_FilterContainer_StockDefaultAll:SetChecked(STORE_SETTINGS.stockFilterAll);

    ExtVendorConfig_QuickVendorContainer_EnableButton:SetChecked(STORE_SETTINGS.enableQuickVendor);
    ExtVendorConfig_QuickVendorContainer_SuboptimalArmor:SetChecked(STORE_SETTINGS.quickVendorSuboptimal);
    ExtVendorConfig_QuickVendorContainer_AlreadyKnown:SetChecked(STORE_SETTINGS.quickVendorAlreadyKnown);
    ExtVendorConfig_QuickVendorContainer_UnusableEquip:SetChecked(STORE_SETTINGS.quickVendorUnusable);
    ExtVendorConfig_QuickVendorContainer_WhiteGear:SetChecked(STORE_SETTINGS.quickVendorWhiteGear);
    ExtVendorConfig_QuickVendorContainer_OutdatedGear:SetChecked(STORE_SETTINGS.quickVendorOldGear);
    ExtVendorConfig_QuickVendorContainer_OutdatedFood:SetChecked(STORE_SETTINGS.quickVendorOldFood);
    CONFIG_SHOWN = true;
end

--==================================================
-- Store current settings to restore if the user
-- presses cancel
--==================================================
function ExtVendorConfig_StoreCurrentSettings()
    STORE_SETTINGS = {
        loadMessage = EXTVENDOR_DATA['config']['show_load_message'];
        reduceLag = EXTVENDOR_DATA['config']['high_performance'];
        scale = EXTVENDOR_DATA['config']['scale'];
        showSuboptimal = EXTVENDOR_DATA['config']['show_suboptimal_armor'];
        stockFilterAll = EXTVENDOR_DATA['config']['stockfilter_defall'];
        enableQuickVendor = EXTVENDOR_DATA['config']['enable_quickvendor'];
        quickVendorSuboptimal = EXTVENDOR_DATA['config']['quickvendor_suboptimal'];
        quickVendorAlreadyKnown = EXTVENDOR_DATA['config']['quickvendor_alreadyknown'];
        quickVendorUnusable = EXTVENDOR_DATA['config']['quickvendor_unusable'];
        quickVendorWhiteGear = EXTVENDOR_DATA['config']['quickvendor_whitegear'];
        quickVendorOldGear = EXTVENDOR_DATA['config']['quickvendor_oldgear'];
        quickVendorOldFood = EXTVENDOR_DATA['config']['quickvendor_oldfood'];
    }
end

--========================================
-- Clicking the Okay button
--========================================
function ExtVendorConfig_Okay()
    EXTVENDOR_DATA['config']['show_load_message'] = STORE_SETTINGS.loadMessage;
    EXTVENDOR_DATA['config']['high_performance'] = STORE_SETTINGS.reduceLag;
    EXTVENDOR_DATA['config']['scale'] = STORE_SETTINGS.scale;
    EXTVENDOR_DATA['config']['show_suboptimal_armor'] = STORE_SETTINGS.showSuboptimal;
    EXTVENDOR_DATA['config']['stockfilter_defall'] = STORE_SETTINGS.stockFilterAll;
    EXTVENDOR_DATA['config']['enable_quickvendor'] = STORE_SETTINGS.enableQuickVendor;
    EXTVENDOR_DATA['config']['quickvendor_suboptimal'] = STORE_SETTINGS.quickVendorSuboptimal;
    EXTVENDOR_DATA['config']['quickvendor_alreadyknown'] = STORE_SETTINGS.quickVendorAlreadyKnown;
    EXTVENDOR_DATA['config']['quickvendor_unusable'] = STORE_SETTINGS.quickVendorUnusable;
    EXTVENDOR_DATA['config']['quickvendor_whitegear'] = STORE_SETTINGS.quickVendorWhiteGear;
    EXTVENDOR_DATA['config']['quickvendor_oldgear'] = STORE_SETTINGS.quickVendorOldGear;
    EXTVENDOR_DATA['config']['quickvendor_oldfood'] = STORE_SETTINGS.quickVendorOldFood;
    ExtVendor_UpdateQuickVendorButtonVisibility();
    ExtVendor_RefreshQuickVendorButton();
    ExtVendor_UpdateDisplay();
    CONFIG_SHOWN = false;
end

--==================================================
-- Handle clicking the Cancel button; restore
-- all settings to their previous values
--==================================================
function ExtVendorConfig_Cancel()
    CONFIG_SHOWN = false;
end

--========================================
-- Handler for checking/unchecking
-- checkbox(es)
--========================================
function ExtVendorConfig_CheckBox_OnClick(self, id)
	if (id == 1) then
        STORE_SETTINGS.loadMessage = self:GetChecked();
    elseif (id == 2) then
        STORE_SETTINGS.reduceLag = self:GetChecked();

    -- ********** Filter Options **********

    elseif (id == 10) then
        STORE_SETTINGS.showSuboptimal = self:GetChecked();
    elseif (id == 11) then
        STORE_SETTINGS.stockFilterAll = self:GetChecked();

    -- ********** Quick-Vendor Options **********

    elseif ((id % 100) == 20) then
        STORE_SETTINGS.enableQuickVendor = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 21) then
        STORE_SETTINGS.quickVendorSuboptimal = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 22) then
        STORE_SETTINGS.quickVendorAlreadyKnown = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 23) then
        STORE_SETTINGS.quickVendorUnusable = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 24) then
        STORE_SETTINGS.quickVendorWhiteGear = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 25) then
        STORE_SETTINGS.quickVendorOldGear = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
    elseif ((id % 100) == 26) then
        STORE_SETTINGS.quickVendorOldFood = self:GetChecked();
        if ((id >= 100) and ExtVendor_QVConfigFrame:IsShown()) then ExtVendor_QVConfigFrame_OptionContainer_SaveButton:Enable(); end
	end
end

--========================================
-- Handler for mousing over options
-- on the config window
--========================================
function ExtVendorConfig_Option_OnEnter(self)
	if (self.tooltip) then
        GameTooltip:SetOwner(self, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOPLEFT", self:GetName(), "BOTTOMLEFT", -10, -4);
        GameTooltip:SetText(self.tooltip, 1, 1, 1);
        GameTooltip:Show();
	end
end

--========================================
-- Moving the mouse away from config
-- options
--========================================
function ExtVendorConfig_Option_OnLeave(self)
	GameTooltip:Hide();
end

--========================================
-- Handler for changing slider(s)
--========================================
local suppressSliderChange = false;
function ExtVendorConfig_Slider_OnValueChanged(self, id)

    if (suppressSliderChange) then return; end
    if (id == 1) then
        local newScale = ((floor(self:GetValue()) * 5) + 75);
        EXTVENDOR_DATA['config']['scale'] = newScale * 0.01;
        ExtVendor_UpdateScale();
        ExtVendorConfig_Slider_UpdateText(self, string.format(L["OPTION_SCALE"], newScale .. "%"));
        local newValue = floor((newScale - 75) / 5);
        --print(newValue);
        suppressSliderChange = true;
        self:SetValue(newValue);
        suppressSliderChange = false;
    end

end

--========================================
-- Slider text update for value changes
--========================================
function ExtVendorConfig_Slider_UpdateText(slider, text)
    _G[slider:GetName() .. "Text1"]:SetText(text);
end

--========================================
-- Returns a copy of the temporary
-- stored settings
--========================================
function ExtVendorConfig_GetStoredSettings()
    return STORE_SETTINGS;
end