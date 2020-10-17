local L = LibStub("AceLocale-3.0"):NewLocale("ExtVendor", "zhCN", true)

if L then

L["LOADED_MESSAGE"] = "版本 %s 已载入。";
L["ADDON_TITLE"] = "Extended Vendor UI";
L["VERSION_TEXT"] = "Extended Vendor UI %s";

L["QUICKVENDOR_BUTTON_TOOLTIP"] = "售出所有垃圾(灰色)物品";

L["CONFIRM_SELL_JUNK"] = "你想要售出下列的物品吗：";
L["TOTAL_SALE_PRICE"] = "总出售金额";
L["ITEMS_BLACKLISTED"] = "%s 个物品被忽略";

L["SOLD"] = "售出:";
L["JUNK_MONEY_EARNED"] = "售出垃圾物品所得： %s";

L["HIDE_UNUSABLE"] = "可用物品筛选";
L["HIDE_FILTERED"] = "隐藏筛选";
L["HIDE_KNOWN_RECIPES"] = "只显示未学的专业图纸";
L["FILTER_SUBOPTIMAL"] = "过滤非最佳化护甲";
L["FILTER_TRANSMOG"] = "Transmog/Appearance";
L["FILTER_TRANSMOG_ONLY"] = "Transmoggable Items Only";
L["FILTER_COLLECTED_TRANSMOG"] = "Hide Collected Appearances";
L["FILTER_RECIPES"] = "图纸过滤";
L["FILTER_ALREADY_KNOWN"] = "隐藏已经学会";
L["FILTER_PURCHASED"] = "隐藏已经购买";
L["FILTER_SLOT"] = "部位";
L["QUALITY_FILTER_MINIMUM"] = "品质(最低)";
L["QUALITY_FILTER_SPECIFIC"] = "品质(特定)";
L["STOCK_FILTER"] = "预设过滤";
L["FILTER_DEFAULT_ALL"] = "预设为所有";
L["ITEMS_HIDDEN"] = "%s 物品隐藏";
L["CONFIGURE_QUICKVENDOR"] = "设置快速售出设定";


L["SLOT_CAT_ARMOR"] = "护甲";
L["SLOT_HEAD"] = "头部";
L["SLOT_SHOULDER"] = "肩部";
L["SLOT_BACK"] = "背部";
L["SLOT_CHEST"] = "胸部";
L["SLOT_WRIST"] = "手腕";
L["SLOT_HANDS"] = "手";
L["SLOT_WAIST"] = "腰部";
L["SLOT_LEGS"] = "腿部";
L["SLOT_FEET"] = "脚";

L["SLOT_CAT_ACCESSORIES"] = "配件与饰品";
L["SLOT_NECK"] = "颈部";
L["SLOT_SHIRT"] = "衬衣";
L["SLOT_TABARD"] = "外袍";
L["SLOT_FINGER"] = "手指";
L["SLOT_TRINKET"] = "饰品";

L["SLOT_CAT_WEAPONS"] = "武器";
L["SLOT_WEAPON2H"] = "双手";
L["SLOT_WEAPON1H"] = "单手/主手";
L["SLOT_WEAPONOH"] = "副手";
L["SLOT_RANGED"] = "远程";

L["SLOT_CAT_OFFHAND"] = "副手";
L["SLOT_OFFHAND"] = "副手装备";
L["SLOT_SHIELD"] = "盾牌";

-- this string is used to match against the "Classes: ___" text on items that require specific classes.
L["CLASSES"] = "职业:";

-- used for checking darkmoon faire replica items
L["REPLICA"] = "复制品";

-- configuration strings
L["CONFIG_HEADING_GENERAL"] = "一般设定";
L["OPTION_STARTUP_MESSAGE"] = "显示载入讯息";
L["OPTION_STARTUP_MESSAGE_TOOLTIP"] = "勾选此选项，每次登入游戏时\n将会在聊天框显示本插件讯息。";
L["OPTION_MOUSEWHEEL_PAGING"] = "滑鼠滚轮换页";
L["OPTION_MOUSEWHEEL_PAGING_TOOLTIP"] = "如果启用，滑鼠滚轮可以用来\n卷动商店的页面。";
L["OPTION_SCALE"] = "缩放: %s";
L["OPTION_SCALE_TOOLTIP"] = "设定主要商店介面的大小。";
L["CONFIG_HEADING_FILTER"] = "过滤设定";
L["OPTION_FILTER_SUBARMOR_SHOW"] = "永远不隐藏非最佳化护甲";
L["OPTION_FILTER_SUBARMOR_SHOW_TOOLTIP"] = "如果启用，不是你的职业最佳护甲\n将会被过滤掩盖\n而不是从选单中移除。";
L["OPTION_STOCKFILTER_DEFAULTALL"] = "预设过滤为全部";
L["OPTION_STOCKFILTER_DEFAULTALL_TOOLTIP"] = "如果勾选启用，『过滤』将预设为\n全部而不是角色的职业。";
L["CONFIG_HEADING_QUICKVENDOR"] = "快速售出设定";
L["OPTION_QUICKVENDOR_ENABLEBUTTON"] = "显示快速售出按钮";
L["OPTION_QUICKVENDOR_ENABLEBUTTON_TOOLTIP"] = "在商店介面上显示或隐藏快速售出按钮。";
L["OPTION_QUICKVENDOR_SUBARMOR"] = "非最佳化护甲 (只限拾绑)";
L["OPTION_QUICKVENDOR_SUBARMOR_TOOLTIP"] = "如果启用，次等护甲物品\n将会被快速售出。\n\n包含:\n|cffa0a0a0- 战士/圣骑士/死亡骑士: 布甲、皮甲、锁甲(等级40以上)\n- 萨满/猎人: 布甲、皮甲(等级40以上)\n- 盗贼/德鲁伊/武僧: 布甲";
L["OPTION_QUICKVENDOR_ALREADYKNOWN"] = "已学会的图纸 (只限拾绑)";
L["OPTION_QUICKVENDOR_ALREADYKNOWN_TOOLTIP"] = "如果启用，|cffff0000已学会|r 的图纸(例如专业或食谱)\n 将被列入快速售出清单中。";
L["OPTION_QUICKVENDOR_UNUSABLE"] = "不能使用的装备 (只限拾绑)";
L["OPTION_QUICKVENDOR_UNUSABLE_TOOLTIP"] = "如果启用，你的职业无法使用的装备\n (基于护甲、武器类型或职业限制)\n将适用于快速售出。\n\n例如:|cffa0a0a0\n- 皮甲对于法师\n- 铠甲对于萨满\n- 双手剑对于牧师\n- 非你职业的套装";
L["OPTION_QUICKVENDOR_WHITEGEAR"] = "一般品质 (|cffffffff白色|r) 武器和护甲";
L["OPTION_QUICKVENDOR_WHITEGEAR_TOOLTIP"] = "如果启用，所有白色品质的武器和护甲 (未装备的)\n将会被快速售出。";
L["NOTE"] = "注意";
L["QUICKVENDOR_SOULBOUND"] = "这个选项只会影响『拾取绑定』装备。";

L["QUICKVENDOR_REASON_POORQUALITY"] = "灰色品质装备";
L["QUICKVENDOR_REASON_WHITEGEAR"] = "白色品质装备";
L["QUICKVENDOR_REASON_SUBOPTIMAL"] = "非最佳化护甲";
L["QUICKVENDOR_REASON_ALREADYKNOWN"] = "已学会";
L["QUICKVENDOR_REASON_UNUSABLEARMOR"] = "无法使用的护甲类型";
L["QUICKVENDOR_REASON_UNUSABLEWEAPON"] = "无法使用的武器类型";
L["QUICKVENDOR_REASON_CLASSRESTRICTED"] = "职业限定";
L["QUICKVENDOR_REASON_WHITELISTED"] = "列入白名单";
L["QUICKVENDOR_MORE_ITEMS"] = "(%s others)";

L["QUICKVENDOR_PROGRESS"] = "Selling Junk Items...";        -- this is new and needs to be translated!

-- quick vendor config strings
L["QUICKVENDOR_CONFIG_HEADER"] = "快速售出设置";
L["CUSTOMIZE_BLACKLIST"] = "自定义黑名单";
L["CUSTOMIZE_BLACKLIST_TEXT"] = "在此名单的物品『不会』使用快速售出的功能出售。";
L["CUSTOMIZE_WHITELIST"] = "自定义白名单";
L["CUSTOMIZE_WHITELIST_TEXT"] = "在此名单的物品将『总是』使用快速售出的功能出售。";
L["ITEMLIST_GLOBAL_TEXT"] = "此清单适用此帐号的所有角色。";
L["ITEMLIST_LOCAL_TEXT"] = "此清单只适用你正在玩的角色。";
L["DROP_ITEM_BLACKLIST"] = "从你的背包拖动物品到此按钮来新增到黑名单。";
L["DROP_ITEM_WHITELIST"] = "从你的背包拖动物品到此按钮来新增到白名单。";
L["CANNOT_BLACKLIST"] = "无法加入{$item}到黑名单: {$reason}";
L["CANNOT_WHITELIST"] = "无法加入{$item}到白名单: {$reason}";
L["REASON_NO_SELL_PRICE"] = "无商店价格";
L["REASON_ALREADY_BLACKLISTED"] = "物品已在黑名单内";
L["REASON_ALREADY_WHITELISTED"] = "物品已在白名单内";
L["ITEM_ADDED_TO_BLACKLIST"] = "%s 已经加入到快速售出的黑名单。";
L["ITEM_ADDED_TO_GLOBAL_WHITELIST"] = "%s 已经加入到所有角色的快速售出白名单。";
L["ITEM_ADDED_TO_LOCAL_WHITELIST"] = "%s 已经加入到唯独当前角色的快速售出白名单。";
L["DELETE_SELECTED"] = "删除已选的";
L["RESET_TO_DEFAULT"] = "重置到预设";
L["CLEAR_ALL"] = "清除所有";
L["CONFIRM_RESET_BLACKLIST"] = "你确定要重置快速售出的黑名单为预设值吗？";
L["CONFIRM_CLEAR_GLOBAL_WHITELIST"] = "你确定想要清除帐号通用的快速售出白名单吗？";
L["CONFIRM_CLEAR_LOCAL_WHITELIST"] = "你确定想要清除当前角色的快速售出白名单吗？";
L["UNKNOWN_ITEM"] = "未知物品";
L["BASIC_SETTINGS"] = "基础设定";

-- ***** About page strings *****
L["ABOUT"] = "关于";
L["LABEL_AUTHOR"] = "作者";
L["LABEL_EMAIL"] = "Email";
L["LABEL_HOSTS"] = "下载网站";

L["TRANSLATORS"] = "翻译者:";

L["COPYRIGHT"] = "©2012-2019, 版权所有。";

end
