local L = LibStub("AceLocale-3.0"):NewLocale("ExtVendor", "koKR", false)

if L then

L["LOADED_MESSAGE"] = "버전: %s 불러옴. |cffffff00/evui|r 입력하면 설정창을 엽니다.";
L["ADDON_TITLE"] = "Extended Vendor UI";
L["VERSION_TEXT"] = "Extended Vendor UI %s";

L["QUICKVENDOR_BUTTON_TOOLTIP"] = "잡동사니 아이템 모두 판매";

L["CONFIRM_SELL_JUNK"] = "다음과 같은 아이템 판매:";
L["TOTAL_SALE_PRICE"] = "총 판매 금액";
L["ITEMS_BLACKLISTED"] = "%s 아이템을 차단목록에 등록했습니다.";

L["SOLD"] = "판매:";
L["JUNK_MONEY_EARNED"] = "잡동사니 아이템 판매 금액: %s";
L["SOLD_COMPACT"] = " {$count}개의 잡동사니 아이템이 {$price}으로 판매되었습니다.";

L["HIDE_UNUSABLE"] = "사용 가능한 아이템들";
L["HIDE_FILTERED"] = "분류 항목 숨기기";
L["FILTER_SUBOPTIMAL"] = "최적화된 방어구 분류";
L["FILTER_TRANSMOG"] = "형상변환/수집";
L["FILTER_TRANSMOG_ONLY"] = "형상변환 가능한 아이템만 표시";
L["FILTER_COLLECTED_TRANSMOG"] = "수집한 형상변환 아이템 숨김";
L["FILTER_COLLECTABLES"] = "수집품";
L["FILTER_COLLECTED_HEIRLOOMS"] = "수집한 계승품 숨김";
L["FILTER_COLLECTED_TOYS"] = "수집한 장난감 숨김";
L["FILTER_RECIPES"] = "제조법 분류";
L["FILTER_ALREADY_KNOWN"] = "배운 제조법 숨김";
L["FILTER_PURCHASED"] = "구매한 제조법 숨김";
L["FILTER_SLOT"] = "착용";
L["QUALITY_FILTER_MINIMUM"] = "품질 (최소)";
L["QUALITY_FILTER_SPECIFIC"] = "품질 (상세)";
L["STOCK_FILTER"] = "구매 분류";
L["FILTER_DEFAULT_ALL"] = "초기화";
L["ITEMS_HIDDEN"] = "%s 아이템 숨김";
L["CONFIGURE_QUICKVENDOR"] = "빠른 상인 설정";
L["CONFIGURE_ADDON"] = "Extended Vendor UI 설정";

L["FILTER_REASON_ALREADY_KNOWN"] = "이미 배움";
L["FILTER_REASON_ALREADY_OWNED"] = "이미 보유";
L["FILTER_REASON_SEARCH_FILTER"] = "검색어가 일치하지 않음";
L["FILTER_REASON_QUALITY_FILTER"] = "품질 분류가 일치하지 않음";
L["FILTER_REASON_NOT_USABLE"] = "사용/구매 불가능함";
L["FILTER_REASON_SUBOPTIMAL"] = "최적화된 방어구";
L["FILTER_REASON_SLOT_FILTER"] = "착용 분류가 일치하지 않음";
L["FILTER_REASON_NOT_TRANSMOG"] = "형상변환 불가능";
L["FILTER_REASON_OWNED_TRANSMOG"] = "형상변환 이무 수집함";
L["MORE_ITEMS_HIDDEN"] = "%d 개의 다른 아이템이 표시되지 않음";

L["SLOT_CAT_ARMOR"] = "방어구";
L["SLOT_HEAD"] = "머리";
L["SLOT_SHOULDER"] = "어깨";
L["SLOT_BACK"] = "등";
L["SLOT_CHEST"] = "가슴";
L["SLOT_WRIST"] = "손목";
L["SLOT_HANDS"] = "손";
L["SLOT_WAIST"] = "허리";
L["SLOT_LEGS"] = "다리";
L["SLOT_FEET"] = "발";

L["SLOT_CAT_ACCESSORIES"] = "장신구";
L["SLOT_NECK"] = "목";
L["SLOT_SHIRT"] = "속옷";
L["SLOT_TABARD"] = "겉옷";
L["SLOT_FINGER"] = "손가락";
L["SLOT_TRINKET"] = "장신구";

L["SLOT_CAT_WEAPONS"] = "무기";
L["SLOT_WEAPON2H"] = "양손";
L["SLOT_WEAPON1H"] = "한손 / 주장비";
L["SLOT_WEAPONOH"] = "보조장비";
L["SLOT_RANGED"] = "원거리";

L["SLOT_CAT_OFFHAND"] = "보조장비";
L["SLOT_OFFHAND"] = "보조장비";
L["SLOT_SHIELD"] = "방패";

-- this string is used to match against the "Classes: ___" text on items that require specific classes.
L["CLASSES"] = "직업:";

-- [ITEM TOOLTIP CHECK] Used to check if an item is food or drink.
L["ITEM_USE_FOOD_BASIC"] = "사용 효과: ([%d%.]+)$2초에 걸쳐 총 ([%d,%%]+)$1의 생명력이 회복됩니다. 음식을 먹으려면 앉아 있어야 합니다.";
L["ITEM_USE_DRINK_BASIC"] = "사용 효과: ([%d%.]+)$2초에 걸쳐 총 ([%d,%%]+)$1의 마나가 회복됩니다. 음식을 먹으려면 앉아 있어야 합니다.";
L["ITEM_USE_FOOD_DRINK_BASIC"] = "사용 효과: ([%d%.]+)$3초에 걸쳐 총 ([%d,%%]+)$1의 생명력과 ([%d,%%]+)$2의 마나가 회복됩니다. 음식을 먹으려면 앉아 있어야 합니다.";

-- used for checking darkmoon faire replica items
L["REPLICA"] = "제조법";

-- configuration strings
L["CONFIG_HEADING_GENERAL"] = "일반 설정";
L["OPTION_STARTUP_MESSAGE"] = "불러오기 메시지 보기";
L["OPTION_STARTUP_MESSAGE_TOOLTIP"] = "Extended Vendor UI의 메시지를\n로그인할 때 대화창에 표시합니다.";
L["OPTION_REDUCE_LAG"] = "랙 감소";
L["OPTION_REDUCE_LAG_TOOLTIP"] = "성능에 큰 영황을 주는 기능이 비활성화 됩니다.\n\n다음의 기능을 사용할 수 없습니다.:\n|cffa0a0a0- 분류: 배운 제조법 숨김";
L["OPTION_SCALE"] = "크기: %s";
L["OPTION_SCALE_TOOLTIP"] = "상인 창의 크기를 조절합니다.";
L["CONFIG_HEADING_FILTER"] = "분류 설정";
L["OPTION_FILTER_SUBARMOR_SHOW"] = "최적화된 방어구 보기";
L["OPTION_FILTER_SUBARMOR_SHOW_TOOLTIP"] = "직업에 최적화된 방어구 분류가 아닌 아이템은\n목록에서 제거되지 않고 분류할 때만 항상 음영 처리됩니다.";
L["OPTION_STOCKFILTER_DEFAULTALL"] = "기본 구입 분류 항목: 전체";
L["OPTION_STOCKFILTER_DEFAULTALL_TOOLTIP"] = "구입시 기본 분류는 직업 대신에 전체로 선택합니다.";
L["CONFIG_HEADING_QUICKVENDOR"] = "빠른 상인 설정";
L["OPTION_QUICKVENDOR_ENABLEBUTTON"] = "빠른 상인 버튼을 표시";
L["OPTION_QUICKVENDOR_ENABLEBUTTON_TOOLTIP"] = "상인 창에 빠른 상인 버튼을 표시합니다.";
L["OPTION_QUICKVENDOR_SUBARMOR"] = "최적화된 방어구 (BoP only)";
L["OPTION_QUICKVENDOR_SUBARMOR_TOOLTIP"] = "최적화된 방어구의 아이템이\n빠른 상인의 기능에 포함됩니다.\n\n포함되는 방어구:\n|cffa0a0a0- 전사/성기사/죽음의기사: 천, 가죽, 사슬 (40레벨 이상)\n- 주술사/사냥꾼: 천, 가죽 (40레벨 이상)\n- 도적/드루이드/수도사/악마사냥꾼: 천";
L["OPTION_QUICKVENDOR_ALREADYKNOWN"] = "이미 소지한/배운 아이템 (BoP only)";
L["OPTION_QUICKVENDOR_ALREADYKNOWN_TOOLTIP"] = "이미 소지한/배운 (전문기술이나 제조법) 아이템이\n빠른 상인의 기능에 포함됩니다.";
L["OPTION_QUICKVENDOR_UNUSABLE"] = "사용 불가능한 장비 (BoP only)";
L["OPTION_QUICKVENDOR_UNUSABLE_TOOLTIP"] = "당신의 직업에서 사용 불가능한 아이템(직업 제한으로 인한 무기, 방어구들)이\n빠른 상인의 기능에 포함됩니다.\n\n예:|cffa0a0a0\n- 마법사의 가죽 방어구\n- 주술사의 판금 방어구\n- 사제의 양손 검\n- 다른 직업의 세트 방어구 아이템";
L["OPTION_QUICKVENDOR_WHITEGEAR"] = "일반 품질의 (|cffffffff흰색|r) 무기와 방어구";
L["OPTION_QUICKVENDOR_WHITEGEAR_TOOLTIP"] = "착용하지 않을 모든 일반(흰색) 무기와 방어구들이\n빠른 상인의 기능에 포함됩니다.";
L["OPTION_QUICKVENDOR_OUTDATEDGEAR"] = "지난 던전/공격대 아이템 (BoP only)";
L["OPTION_QUICKVENDOR_OUTDATEDGEAR_TOOLTIP"] = "지난 확장팩의 레벨이 낮은 희귀 또는 영웅 아이템(무기 또는 방어구)이\n빠른 상인의 기능에 포함됩니다.";
L["OPTION_QUICKVENDOR_OUTDATEDFOOD"] = "지난 음식과 음료";
L["OPTION_QUICKVENDOR_OUTDATEDFOOD_TOOLTIP"] = "플레이어 레벨보다 낮은 음식과 음료 아이템이\n빠른 상인의 기능에 포함됩니다.";
L["OPTION_QUICKVENDOR_COMPACTMESSAGE"] = "대화창 메시지 요약";
L["OPTION_QUICKVENDOR_COMPACTMESSAGE_TOOLTIP"] = "대화창의 완료 메시지를 단문으로 표시합니다.";
L["NOTE"] = "주의";
L["QUICKVENDOR_SOULBOUND"] = "이 설정은 획득 시 귀속(BoP) 아이템에만 적용됩니다.";

L["QUICKVENDOR_REASON_POORQUALITY"] = "하급 품질";
L["QUICKVENDOR_REASON_WHITEGEAR"] = "일반 품질 장비";
L["QUICKVENDOR_REASON_SUBOPTIMAL"] = "하위 최적 갑옷";
L["QUICKVENDOR_REASON_ALREADYKNOWN"] = "이미 습득";
L["QUICKVENDOR_REASON_UNUSABLEARMOR"] = "사용 할 수 없는 방어구 종류";
L["QUICKVENDOR_REASON_UNUSABLEWEAPON"] = "사용 할 수 없는 방어구 종류";
L["QUICKVENDOR_REASON_CLASSRESTRICTED"] = "직업 제한";
L["QUICKVENDOR_REASON_WHITELISTED"] = "등록 목록";
L["QUICKVENDOR_REASON_OUTDATED_GEAR"] = "지난 장비";
L["QUICKVENDOR_REASON_OUTDATED_FOOD"] = "지난 음식/음료";
L["QUICKVENDOR_MORE_ITEMS"] = "(%s others)";

L["QUICKVENDOR_PROGRESS"] = "잡동사니 아이템 판매...";

-- quick vendor config strings
L["QUICKVENDOR_CONFIG_HEADER"] = "빠른 상인 설정";
L["CUSTOMIZE_BLACKLIST"] = "사용자 차단목록";
L["CUSTOMIZE_BLACKLIST_TEXT"] = "차단목록에 있는 아이템은 빠른 상인 기능으로 판매할 수 없습니다.";
L["CUSTOMIZE_WHITELIST"] = "사용자 등록목록";
L["CUSTOMIZE_WHITELIST_TEXT"] = "등록목록에 있는 아이템은 항상 빠른 상인 기능으로 판매할 수 있습니다.";
L["ITEMLIST_GLOBAL_TEXT"] = "이 목록은 현재 계정의 모든 캐릭터에 적용됩니다.";
L["ITEMLIST_LOCAL_TEXT"] = "이 목록은 현재 접속중인 캐릭터에만 적용됩니다.";
L["DROP_ITEM_BLACKLIST"] = "가방에 있는 아이템을 버튼위에 놀려 놓으면 차단목록에 추가됩니다.";
L["DROP_ITEM_WHITELIST"] = "가방에 있는 아이템을 버튼위에 놀려 놓으면 등록목록에 추가됩니다";
L["CANNOT_BLACKLIST"] = "{$item} 을 차단목록에 추가할 수 없음: {$reason}";
L["CANNOT_WHITELIST"] = "{$item} 을 등록목록에 추가할 수 없음: {$reason}";
L["REASON_NO_SELL_PRICE"] = "판매 가격이 없음";
L["REASON_ALREADY_BLACKLISTED"] = "아이템은 이미 차단목록에 있음";
L["REASON_ALREADY_WHITELISTED"] = "아이템은 이미 등록목록에 있음";
L["ITEM_ADDED_TO_BLACKLIST"] = "%s 아이템이 빠른 상인 차단목록에 추가되었습니다.";
L["ITEM_ADDED_TO_GLOBAL_WHITELIST"] = "%s 아이템이 모든 캐릭터의 등록목록에 추가되었습니다.";
L["ITEM_ADDED_TO_LOCAL_WHITELIST"] = "%s 아이템이 현재 접속중인 캐릭터의 등록목록에 추가되었습니다.";
L["DELETE_SELECTED"] = "선택아이템 삭제";
L["RESET_TO_DEFAULT"] = "기본값으로 초기화";
L["CLEAR_ALL"] = "모두 삭제";
L["CONFIRM_RESET_BLACKLIST"] = "빠른 상인 차단목록을 기본값으로 초기화 하겠습니까?";
L["CONFIRM_CLEAR_GLOBAL_WHITELIST"] = "빠른 상인 등록목록(계정)을 기본값으로 초기화 하겠습니까?";
L["CONFIRM_CLEAR_LOCAL_WHITELIST"] = "빠른 상인 등록목록(현재 캐릭터)를 기본값으로 초기화 하겠습니까?";
L["UNKNOWN_ITEM"] = "알 수 없는 아이템";
L["BASIC_SETTINGS"] = "기본 설정";

-- ***** About page strings *****
L["ABOUT"] = "정보";
L["LABEL_AUTHOR"] = "제작자";
L["LABEL_EMAIL"] = "이메일";
L["LABEL_HOSTS"] = "다운로드 사이트";

L["TRANSLATORS"] = "번역자:";

L["COPYRIGHT"] = "©2012-2019, All rights reserved.";

end
