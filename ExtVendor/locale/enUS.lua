local L = LibStub("AceLocale-3.0"):NewLocale("ExtVendor", "enUS", true)

if L then

L["LOADED_MESSAGE"] = "Version %s loaded. Type |cffffff00/evui|r to configure.";
L["ADDON_TITLE"] = "Extended Vendor UI";
L["VERSION_TEXT"] = "Extended Vendor UI %s";

L["QUICKVENDOR_BUTTON_TOOLTIP"] = "Sell all unwanted items";

L["CONFIRM_SELL_JUNK"] = "Do you want to sell the following items:";
L["TOTAL_SALE_PRICE"] = "Total sale price";
L["ITEMS_BLACKLISTED"] = "%s item(s) blacklisted";

L["SOLD"] = "Sold:";
L["JUNK_MONEY_EARNED"] = "Money earned from junk items: %s";
L["SOLD_COMPACT"] = "Sold {$count} junk items for {$price}.";

L["HIDE_UNUSABLE"] = "Usable Items";
L["HIDE_FILTERED"] = "Hide Filtered";
L["FILTER_SUBOPTIMAL"] = "Filter Sub-optimal Armor";
L["FILTER_TRANSMOG"] = "Transmog/Appearance";
L["FILTER_TRANSMOG_ONLY"] = "Transmogrifiable Items Only";
L["FILTER_COLLECTED_TRANSMOG"] = "Hide Collected Appearances";
L["FILTER_COLLECTABLES"] = "Collectables";
L["FILTER_COLLECTED_HEIRLOOMS"] = "Hide Collected Heirlooms";
L["FILTER_COLLECTED_TOYS"] = "Hide Collected Toys";
L["FILTER_COLLECTED_MOUNTS"] = "Hide Collected Mounts";
L["FILTER_RECIPES"] = "Recipe Filtering";
L["FILTER_ALREADY_KNOWN"] = "Hide Already Known";
L["FILTER_PURCHASED"] = "Hide Already Purchased";
L["FILTER_SLOT"] = "Slot";
L["QUALITY_FILTER_MINIMUM"] = "Quality (Minimum)";
L["QUALITY_FILTER_SPECIFIC"] = "Quality (Specific)";
L["STOCK_FILTER"] = "Stock Filter";
L["FILTER_DEFAULT_ALL"] = "Default to All";
L["ITEMS_HIDDEN"] = "%s items hidden";
L["CONFIGURE_QUICKVENDOR"] = "Configure Quick-Vendor";
L["CONFIGURE_ADDON"] = "Configure Extended Vendor UI";

L["FILTER_REASON_ALREADY_KNOWN"] = "Already Known";
L["FILTER_REASON_ALREADY_OWNED"] = "Already Owned";
L["FILTER_REASON_SEARCH_FILTER"] = "Does not match search text";
L["FILTER_REASON_QUALITY_FILTER"] = "Does not match quality filter";
L["FILTER_REASON_NOT_USABLE"] = "Cannot be used/purchased";
L["FILTER_REASON_SUBOPTIMAL"] = "Sub-optimal armor";
L["FILTER_REASON_SLOT_FILTER"] = "Does not match slot filter";
L["FILTER_REASON_NOT_TRANSMOG"] = "Not transmogrifiable";
L["FILTER_REASON_OWNED_TRANSMOG"] = "Appearance already collected";
L["MORE_ITEMS_HIDDEN"] = "%d other items not shown";

L["SLOT_CAT_ARMOR"] = "Armor";
L["SLOT_HEAD"] = "Head";
L["SLOT_SHOULDER"] = "Shoulder";
L["SLOT_BACK"] = "Back";
L["SLOT_CHEST"] = "Chest";
L["SLOT_WRIST"] = "Wrist";
L["SLOT_HANDS"] = "Hands";
L["SLOT_WAIST"] = "Waist";
L["SLOT_LEGS"] = "Legs";
L["SLOT_FEET"] = "Feet";

L["SLOT_CAT_ACCESSORIES"] = "Accessories";
L["SLOT_NECK"] = "Neck";
L["SLOT_SHIRT"] = "Shirt";
L["SLOT_TABARD"] = "Tabard";
L["SLOT_FINGER"] = "Finger";
L["SLOT_TRINKET"] = "Trinket";

L["SLOT_CAT_WEAPONS"] = "Weapons";
L["SLOT_WEAPON2H"] = "Two-Handed";
L["SLOT_WEAPON1H"] = "One-Handed / Main Hand";
L["SLOT_WEAPONOH"] = "Off Hand";
L["SLOT_RANGED"] = "Ranged";

L["SLOT_CAT_OFFHAND"] = "Off Hand";
L["SLOT_OFFHAND"] = "Held in Off-hand";
L["SLOT_SHIELD"] = "Shields";

-- this string is used to match against the "Classes: ___" text on items that require specific classes.
L["CLASSES"] = "Classes:";

-- [ITEM TOOLTIP CHECK] Used to check if an item is food or drink.
L["ITEM_USE_FOOD_BASIC"] = "Use: Restores ([%d,%%]+) health over ([%d%.]+) sec.  Must remain seated while eating.";
L["ITEM_USE_DRINK_BASIC"] = "Use: Restores ([%d,%%]+) mana over ([%d%.]+) sec.  Must remain seated while drinking.";
L["ITEM_USE_FOOD_DRINK_BASIC"] = "Use: Restores ([%d,%%]+) health and ([%d,%%]+) mana over ([%d%.]+) sec.  Must remain seated while drinking.";

-- [PARTIAL ITEM NAME CHECK] Used for checking darkmoon faire replica items (e.g. Replica Magister's Robe)
L["REPLICA"] = "Replica";

-- configuration strings
L["CONFIG_HEADING_GENERAL"] = "General Settings";
L["OPTION_STARTUP_MESSAGE"] = "Show loading message";
L["OPTION_STARTUP_MESSAGE_TOOLTIP"] = "If enabled, a message indicating when Extended Vendor UI is\nloaded will be displayed on the chat frame when logging in.";
L["OPTION_REDUCE_LAG"] = "Reduce Lag";
L["OPTION_REDUCE_LAG_TOOLTIP"] = "If enabled, functionality that greatly\nimpacts performance will be disabled.\n\nThe following functionality will be unavailable:\n|cffa0a0a0- Filter: Hide Already Known Recipes";
L["OPTION_SCALE"] = "Scale: %s";
L["OPTION_SCALE_TOOLTIP"] = "Sets the scale of the main vendor interface.";
L["CONFIG_HEADING_FILTER"] = "Filter Settings";
L["OPTION_FILTER_SUBARMOR_SHOW"] = "Never hide sub-optimal armor";
L["OPTION_FILTER_SUBARMOR_SHOW_TOOLTIP"] = "If enabled, items that are not the optimal armor\ntype for your class will always only be shaded out\nwhen filtered instead of removed from the list.";
L["OPTION_STOCKFILTER_DEFAULTALL"] = "Default stock filter to All";
L["OPTION_STOCKFILTER_DEFAULTALL_TOOLTIP"] = "If enabled, the stock filter will always default\nto All instead of the character's class.";
L["CONFIG_HEADING_QUICKVENDOR"] = "Quick-Vendor Settings";
L["OPTION_QUICKVENDOR_ENABLEBUTTON"] = "Show the Quick-Vendor button";
L["OPTION_QUICKVENDOR_ENABLEBUTTON_TOOLTIP"] = "Shows or hides the Quick-Vendor button on the merchant frame.";
L["OPTION_QUICKVENDOR_SUBARMOR"] = "Sub-optimal armor (BoP only)";
L["OPTION_QUICKVENDOR_SUBARMOR_TOOLTIP"] = "If enabled, items of sub-optimal armor types\nwill be included in the quick-vendor feature.\n\nIncludes:\n|cffa0a0a0- Warriors/Paladins/Death Knights: Cloth, Leather, Mail (if level 40+)\n- Shaman/Hunters: Cloth, Leather (if level 40+)\n- Rogues/Druids/Monks: Cloth";
L["OPTION_QUICKVENDOR_ALREADYKNOWN"] = "Aready Known items (BoP only)";
L["OPTION_QUICKVENDOR_ALREADYKNOWN_TOOLTIP"] = "If enabled, items that are |cffff0000Already Known|r (such as profession\nrecipes) will be included in the quick-vendor feature.";
L["OPTION_QUICKVENDOR_UNUSABLE"] = "Unusable equipment (BoP only)";
L["OPTION_QUICKVENDOR_UNUSABLE_TOOLTIP"] = "If enabled, items that your class will never be able to\nuse (due to armor, weapon type or class restrictions)\nwill be included in the quick-vendor feature.\n\nExamples:|cffa0a0a0\n- Leather for Mages\n- Plate for Shaman\n- Two-handed Swords for Priests\n- Tier armor for a class other than your own";
L["OPTION_QUICKVENDOR_WHITEGEAR"] = "Common quality (|cffffffffWhite|r) weapons and armor";
L["OPTION_QUICKVENDOR_WHITEGEAR_TOOLTIP"] = "If enabled, all white weapons and armor (not equipped)\nwill be included in the quick-vendor feature.";
L["OPTION_QUICKVENDOR_OUTDATEDGEAR"] = "Outdated dungeon/raid gear (BoP only)";
L["OPTION_QUICKVENDOR_OUTDATEDGEAR_TOOLTIP"] = "If enabled, rare or epic weapons and armor from\nexpansion content the player has outleveled will\nbe included in the quick-vendor feature.";
L["OPTION_QUICKVENDOR_OUTDATEDFOOD"] = "Outdated food & drink";
L["OPTION_QUICKVENDOR_OUTDATEDFOOD_TOOLTIP"] = "If enabled, food and drinks the player has\noutleveled will be included in the quick-vendor feature.";
L["OPTION_QUICKVENDOR_COMPACTMESSAGE"] = "Compact chat messages";
L["OPTION_QUICKVENDOR_COMPACTMESSAGE_TOOLTIP"] = "If enabled, reduces completion messages displayed\nin the chat window to a single message.";
L["NOTE"] = "NOTE";
L["QUICKVENDOR_SOULBOUND"] = "This option only affects Bind on Pickup (BoP) items.";

L["QUICKVENDOR_REASON_POORQUALITY"] = "Poor quality";
L["QUICKVENDOR_REASON_WHITEGEAR"] = "White quality equipment";
L["QUICKVENDOR_REASON_SUBOPTIMAL"] = "Sub-optimal armor";
L["QUICKVENDOR_REASON_ALREADYKNOWN"] = "Already known";
L["QUICKVENDOR_REASON_UNUSABLEARMOR"] = "Unusable armor type";
L["QUICKVENDOR_REASON_UNUSABLEWEAPON"] = "Unusable weapon type";
L["QUICKVENDOR_REASON_CLASSRESTRICTED"] = "Class-restricted";
L["QUICKVENDOR_REASON_WHITELISTED"] = "Whitelisted";
L["QUICKVENDOR_REASON_OUTDATED_GEAR"] = "Outdated equipment";
L["QUICKVENDOR_REASON_OUTDATED_FOOD"] = "Outdated food/drink";
L["QUICKVENDOR_MORE_ITEMS"] = "(%s others)";

L["QUICKVENDOR_PROGRESS"] = "Selling Junk Items...";

-- quick vendor config strings
L["QUICKVENDOR_CONFIG_HEADER"] = "Quick-Vendor Configuration";
L["CUSTOMIZE_BLACKLIST"] = "Customize Blacklist";
L["CUSTOMIZE_BLACKLIST_TEXT"] = "Items in this list will NEVER be vendored by the Quick-Vendor feature.";
L["CUSTOMIZE_WHITELIST"] = "Customize Whitelists";
L["CUSTOMIZE_WHITELIST_TEXT"] = "Items in these lists will ALWAYS be vendored by the Quick-Vendor feature.";
L["ITEMLIST_GLOBAL_TEXT"] = "This list applies to all characters on this account.";
L["ITEMLIST_LOCAL_TEXT"] = "This list only applies to the character you are currently playing.";
L["DROP_ITEM_BLACKLIST"] = "Drop an item from your bags onto this button to add it to the blacklist.";
L["DROP_ITEM_WHITELIST"] = "Drop an item from your bags onto this button to add it to the whitelist.";
L["CANNOT_BLACKLIST"] = "Cannot add {$item} to the blacklist: {$reason}";
L["CANNOT_WHITELIST"] = "Cannot add {$item} to the whitelist: {$reason}";
L["REASON_NO_SELL_PRICE"] = "No vendor price";
L["REASON_ALREADY_BLACKLISTED"] = "Item is already blacklisted";
L["REASON_ALREADY_WHITELISTED"] = "Item is already whitelisted";
L["ITEM_ADDED_TO_BLACKLIST"] = "%s has been added to the Quick-Vendor blacklist.";
L["ITEM_ADDED_TO_GLOBAL_WHITELIST"] = "%s has been added to the Quick-Vendor whitelist for all characters.";
L["ITEM_ADDED_TO_LOCAL_WHITELIST"] = "%s has been added to the Quick-Vendor whitelist for the current character only.";
L["DELETE_SELECTED"] = "Delete selected";
L["RESET_TO_DEFAULT"] = "Reset to default";
L["CLEAR_ALL"] = "Clear all";
L["CONFIRM_RESET_BLACKLIST"] = "Do you want to reset the Quick-Vendor blacklist to default values?";
L["CONFIRM_CLEAR_GLOBAL_WHITELIST"] = "Do you want to clear the account-wide Quick-Vendor whitelist?";
L["CONFIRM_CLEAR_LOCAL_WHITELIST"] = "Do you want to clear the Quick-Vendor whitelist for this character?";
L["UNKNOWN_ITEM"] = "Unknown Item";
L["BASIC_SETTINGS"] = "Basic Settings";

-- ***** About page strings *****
L["ABOUT"] = "About";
L["LABEL_AUTHOR"] = "Author";
L["LABEL_EMAIL"] = "Email";
L["LABEL_HOSTS"] = "Download Site(s)";

L["TRANSLATORS"] = "Translators:";

L["COPYRIGHT"] = "©2012-2019, All rights reserved.";

end
