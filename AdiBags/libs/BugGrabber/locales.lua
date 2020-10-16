local _, parentAddonTable = ...
local addon = parentAddonTable.BugGrabber
-- Bail out in case we didn't load up for some reason, which
-- happens for example when an embedded BugGrabber finds a
-- standalone !BugGrabber addon.
if not addon then return end

-- We don't need to bail out here if BugGrabber has been loaded from
-- some other embedding addon already, because :LoadTranslations is
-- only invoked on login. All we do is replace the method with a new
-- one that will never be invoked.

function addon:LoadTranslations(locale, L)
	if locale == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "esES" then
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "esMX" then
--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "ptBR" then
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "itIT" then
--@localization(locale="itIT", format="lua_additive_table", handle-unlocalized="ignore")@
	end
end

