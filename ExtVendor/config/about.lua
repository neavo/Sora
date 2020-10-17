local L = LibStub("AceLocale-3.0"):GetLocale("ExtVendor", true);

local ABOUT = {
    author = "Germbread (Deathwing-US, Whitemane-US)",
    email = GetAddOnMetadata("ExtVendor", "X-Email"),
    hosts = {
        "https://www.curseforge.com/wow/addons",
        "https://www.curseforge.com/wow/addons/extended-vendor-ui",
    },
    
    translators = {
        { name = "BNS", locale = "Traditional Chinese (zhTW), Simplified Chinese (zhCN)" },
        { name = "next96", locale = "Korean (koKR)" },
    },
};

local CONFIG_SHOWN = false;

--========================================
-- Setting up the config frame
--========================================
function ExtVendorConfig_About_OnLoad(self)
    self.name = L["ABOUT"];
    self.parent = L["ADDON_TITLE"];
    self.okay = function(self) ExtVendorConfig_About_OnClose(); end;
    self.cancel = function(self) ExtVendorConfig_About_OnClose(); end;
    self.refresh = function(self) ExtVendorConfig_About_OnRefresh(); end;
    InterfaceOptions_AddCategory(self);

    ExtVendorConfigAboutTitle:SetText(string.format(L["VERSION_TEXT"], "|cffffffffv" .. EXTVENDOR.Version));
    ExtVendorConfigAboutAuthor:SetText(L["LABEL_AUTHOR"] .. ": |cffffffff" .. ABOUT.author);
    ExtVendorConfigAboutEmail:SetText(L["LABEL_EMAIL"] .. ": |cffffffff" .. ABOUT.email);
    ExtVendorConfigAboutURLs:SetText(L["LABEL_HOSTS"] .. ":");
    
    ExtVendorConfigAboutTranslatorsHeader:SetText(L["TRANSLATORS"]);
end

--========================================
-- Refresh
--========================================
function ExtVendorConfig_About_OnRefresh()
    if (CONFIG_SHOWN) then return; end

    local i2;
    
    for i = 1, table.maxn(ABOUT.hosts), 1 do
        local fontString = _G["ExtVendorConfigAbout_SiteList" .. i];
        if (not fontString) then
            fontString = ExtVendorConfigAbout:CreateFontString("ExtVendorConfigAbout_SiteList" .. i, "ARTWORK", "GameFontHighlight");
        end
        fontString:ClearAllPoints();
        fontString:SetPoint("TOPLEFT", ExtVendorConfigAboutURLs, "TOPLEFT", 20, -(i * 20));
        fontString:SetText(ABOUT.hosts[i]);
        i2 = i;
    end

    local th = _G["ExtVendorConfigAboutTranslatorsHeader"];
    if (th ~= nil) then
        th:ClearAllPoints();
        th:SetPoint("TOPLEFT", ExtVendorConfigAboutTitle, "BOTTOMLEFT", 15, -(150 + (i2 * 20)));
    end

    for i = 1, table.maxn(ABOUT.translators), 1 do
        local fontString = _G["ExtVendorConfigAbout_Translator" .. i];
        if (not fontString) then
            fontString = ExtVendorConfigAbout:CreateFontString("ExtVendorConfigAbout_Translator" .. i, "ARTWORK", "GameFontHighlight");
        end
        fontString:ClearAllPoints();
        fontString:SetPoint("TOPLEFT", ExtVendorConfigAboutTranslatorsHeader, "TOPLEFT", 20, -(i * 20));
        fontString:SetText(ABOUT.translators[i].name .. " |cffa0a0a0(" .. ABOUT.translators[i].locale .. ")");
    end

    CONFIG_SHOWN = true;
end

--========================================
-- Closing the window
--========================================
function ExtVendorConfig_About_OnClose()
    CONFIG_SHOWN = false;
end
