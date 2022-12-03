--[[ global ]] VladsVendorListTooltipMixin = {}

-- text cache over previously scanned links
local textCache = {}

-- returns cache entry
local function TooltipReadCache(link)
	return textCache[link]
end

-- writes cache entry
local function TooltipWriteCache(tip, link)
	local cache = VladsVendorListTooltipMixin:TooltipText(tip)

	if cache then
		textCache[link] = cache
	end
end

-- purges cache of one or all entries
local function TooltipPurgeCache(linkOrNil)
	if linkOrNil then
		textCache[linkOrNil] = nil
	else
		table.wipe(textCache)
	end
end

-- converts rgb to hex color string
local function RGB2HEX(r, g, b)
	return format("%02X%02X%02X", floor(r*255+.5), floor(g*255+.5), floor(b*255+.5))
end

-- converts a localization string to a pattern
local function SafePattern(pattern)
	return pattern
		:gsub("%%", "%%%%")
		:gsub("%.", "%%%.")
		:gsub("%?", "%%%?")
		:gsub("%+", "%%%+")
		:gsub("%-", "%%%-")
		:gsub("%(", "%%%(")
		:gsub("%)", "%%%)")
		:gsub("%[", "%%%[")
		:gsub("%]", "%%%]")
		:gsub("%%%%s", "(.-)")
		:gsub("%%%%d", "(%%d+)")
		:gsub("%%%%%%[%d%.%,]+f", "([%%d%%.%%,]+)")
end

-- text cache reset handler on certain events
local TextCacheHandler do

	local CompareCollectionBeforeAndAfter do
		local cache = { pets = {}, mounts = {} }
		local diff = { pets = {}, mounts = {} }

		function CompareCollectionBeforeAndAfter(scanCompanions, scanMounts)
			if scanCompanions then
				table.wipe(diff.pets)
				for i = 1, C_PetJournal.GetNumPets(), 1 do
					local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(i)
					isOwned = not not isOwned -- booleanify
					local temp = cache.pets[speciesID]
					if temp ~= isOwned then
						diff.pets[speciesID] = isOwned
					end
					cache.pets[speciesID] = isOwned
				end
			end
			if scanMounts then
				table.wipe(diff.mounts)
				local mountIDs = C_MountJournal.GetMountIDs()
				for i = 1, #mountIDs do
					local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(mountIDs[i])
					isCollected = not not isCollected -- booleanify
					local temp = cache.mounts[mountID]
					if temp ~= isCollected then
						diff.mounts[mountID] = isCollected
					end
					cache.mounts[mountID] = isCollected
				end
			end
			return scanCompanions or scanMounts, diff.pets, diff.mounts
		end
	end

	local function OnEvent(_, event, ...)
		if event == "LEARNED_SPELL_IN_TAB"
		or event == "NEW_RECIPE_LEARNED" then
			local spellID = ...
			if spellID then
				TooltipPurgeCache() -- TODO: can we specifically purge the links related to this entry?
			end
		elseif event == "TOYS_UPDATED" then
			local itemID, isNew = ...
			if itemID and isNew then
				local _, itemLink = GetItemInfo(itemID)
				if itemLink then
					TooltipPurgeCache(itemLink)
				end
			end
		elseif event == "HEIRLOOMS_UPDATED" then
			local itemID, updateReason = ...
			if itemID and updateReason == "NEW" then
				local _, itemLink = GetItemInfo(itemID)
				if itemLink then
					TooltipPurgeCache(itemLink)
				end
			end
		elseif event == "PET_JOURNAL_PET_DELETED"
			or event == "PET_JOURNAL_LIST_UPDATE"
			or event == "NEW_MOUNT_ADDED"
			or event == "COMPANION_UPDATE"
			or event == "COMPANION_LEARNED"
			or event == "COMPANION_UNLEARNED" then
			local hasUpdated, pets, mounts = CompareCollectionBeforeAndAfter(true, event ~= "PET_JOURNAL_PET_DELETED" and event ~= "PET_JOURNAL_LIST_UPDATE")
			if hasUpdated and ((pets and next(pets) ~= nil) or (mounts and next(mounts) ~= nil)) then
				TooltipPurgeCache()
			end
		elseif event == "PLAYER_LOGIN"
			or event == "PLAYER_ENTERING_WORLD" then
			local hasUpdated, pets, mounts = CompareCollectionBeforeAndAfter(true, true)
			if hasUpdated and ((pets and next(pets) ~= nil) or (mounts and next(mounts) ~= nil)) then
				TooltipPurgeCache()
			end
		end
	end

	TextCacheHandler = CreateFrame("Frame")
	TextCacheHandler:SetScript("OnEvent", OnEvent)

	TextCacheHandler:RegisterEvent("LEARNED_SPELL_IN_TAB") -- spellID
	TextCacheHandler:RegisterEvent("NEW_RECIPE_LEARNED") -- spellID

	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		TextCacheHandler:RegisterEvent("TOYS_UPDATED") -- itemID, isNew
		TextCacheHandler:RegisterEvent("HEIRLOOMS_UPDATED") -- itemID, updateReason
		TextCacheHandler:RegisterEvent("PET_JOURNAL_PET_DELETED") -- petID
		TextCacheHandler:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
		TextCacheHandler:RegisterEvent("NEW_MOUNT_ADDED") -- mountID
		TextCacheHandler:RegisterEvent("COMPANION_UPDATE") -- companionType
		TextCacheHandler:RegisterEvent("COMPANION_LEARNED")
		TextCacheHandler:RegisterEvent("COMPANION_UNLEARNED")

		TextCacheHandler:RegisterEvent("PLAYER_LOGIN")
		TextCacheHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
	end

end

-- on-demand populated in TooltipScan
local TooltipTextPattern

-- call this once the patterns are actually needed
local function TooltipTextPatternInit()
	TooltipTextPattern = {
		Reputation = SafePattern(_G.ITEM_REQ_REPUTATION),
		Profession = SafePattern(_G.ITEM_MIN_SKILL),
		ProfessionRank = SafePattern(_G.TOOLTIP_SUPERCEDING_SPELL_NOT_KNOWN),
		AlreadyKnown = SafePattern(_G.ITEM_SPELL_KNOWN),
		BattlePetCollected = SafePattern(_G.ITEM_PET_KNOWN),
	}
end

-- tooltip pool create, reset and callback trigger
local TooltipPool do

	local function OnTooltipSet(tip)
		if tip.ignoreOnTooltipSetCallback ~= false then
			return
		end
		for itemButton, _ in pairs(tip.itemButtons) do
			local list = itemButton:GetList()
			list:TriggerEvent(list.Event.Tooltip, itemButton, tip)
		end
		tip.updateCount = tip.updateCount + 1
		if tip.updateCount >= tip.scanCount then
			tip.isReleasing = true
			TooltipPool:Release(tip)
		end
	end

	local function OnTooltipCreate(pool)
		local tip = CreateFrame("GameTooltip", "CompactVendorTooltip" .. (pool:GetNumActive() + 1), WorldFrame, TooltipDataProcessor and "GameTooltipTemplate" or nil) -- TODO: DF
		tip.textLeft, tip.textRight = {}, {}
		for i = 1, 64 do
			tip.textLeft[i], tip.textRight[i] = tip:CreateFontString("$parentTextLeft" .. i, nil, "GameFontNormal"), tip:CreateFontString("$parentTextRight" .. i, nil, "GameFontNormal")
			tip:AddFontStrings(tip.textLeft[i], tip.textRight[i])
		end
		tip.link = nil
		tip.itemButtons = {}
		tip.scanCount = 1
		tip.updateCount = 0
		tip.ignoreOnTooltipSetCallback = false
		if TooltipDataProcessor then -- TODO: DF
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSet)
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, OnTooltipSet)
		else
			tip:SetScript("OnTooltipSetItem", OnTooltipSet)
			tip:SetScript("OnTooltipSetSpell", OnTooltipSet)
		end
		tip:SetOwner(WorldFrame, "ANCHOR_NONE")
		return tip
	end

	local function OnTooltipReset(pool, tip)
		if not tip.isReleasing then
			return
		end
		tip.isReleasing = false
		TooltipWriteCache(tip, tip.link)
		table.wipe(tip.itemButtons)
		tip.link = nil
		tip.scanCount = 1
		tip.updateCount = 0
		tip:ClearLines()
	end

	TooltipPool = CreateObjectPool(OnTooltipCreate, OnTooltipReset)

	function TooltipPool:AcquireTip(itemButton, link)
		for tip in self:EnumerateActive() do
			if tip.link == link then
				tip.itemButtons[itemButton] = true
				return tip, true
			end
		end
		local tip = self:Acquire()
		tip.link = link
		tip.itemButtons[itemButton] = true
		tip:SetHyperlink(link)
		return tip, false
	end

end

-- reads the tooltip lines and returns a table with text and color data
function VladsVendorListTooltipMixin:TooltipText(tip)
	local numLines = tip:NumLines()
	local temp = { numLines = numLines }

	for i = 1, numLines do
		local textLeft, textRight = tip.textLeft[i], tip.textRight[i]
		temp[i] = { textLeft:GetText(), textRight:GetText(), RGB2HEX(textLeft:GetTextColor()), RGB2HEX(textRight:GetTextColor()) }
	end

	if temp[1] then
		return temp
	end
end

-- tooltip text data types
VladsVendorListTooltipMixin.TooltipTextType = {
	Reputation = 1,
	Profession = 2,
	ProfessionRank = 3,
	AlreadyKnown = 4,
	BattlePetCollected = 5,
}

-- hardcoded red color for unavailable lines
local RedTooltipColor = "FF2020"

-- returns if there is a match on the line and color
-- [arg1] 1 = reputation, 2 = profession, 3 = profession rank, 4 = already known
-- [arg2] true = available, false = not available
function VladsVendorListTooltipMixin:TooltipTextParse(text, color)
	if not text then
		return
	elseif text:find(TooltipTextPattern.Reputation) then
		return self.TooltipTextType.Reputation, color ~= RedTooltipColor
	elseif text:find(TooltipTextPattern.Profession) then
		return self.TooltipTextType.Profession, color ~= RedTooltipColor
	elseif text:find(TooltipTextPattern.ProfessionRank) then
		return self.TooltipTextType.ProfessionRank, color ~= RedTooltipColor
	elseif text:find(TooltipTextPattern.AlreadyKnown) then
		return self.TooltipTextType.AlreadyKnown, color ~= RedTooltipColor
	elseif text:find(TooltipTextPattern.BattlePetCollected) then
		return self.TooltipTextType.BattlePetCollected, color ~= RedTooltipColor
	end
end

-- scans a link and triggers a response in the provided itemButton:TooltipCallback()
function VladsVendorListTooltipMixin:TooltipScan(itemButton, link)
	-- resolve the pattern strings
	if not TooltipTextPattern then
		TooltipTextPatternInit()
	end
	-- return cached text
	local cache = TooltipReadCache(link)
	if cache then
		local list = itemButton:GetList()
		list:TriggerEvent(list.Event.Tooltip, itemButton, nil, cache)
		return
	end
	-- scan link
	local tip, pending = TooltipPool:AcquireTip(itemButton, link)
	-- adjust scan count requirement so recipes use two cycles (one to load the recipe, and one to load the item itself that is part of the recipe)
	if itemButton:GetItem():IsRecipe() then
		tip.scanCount = 2 -- TODO: this isn't enough, we need to somehow figure out when the recipe is really done loading, as a rule of 2 or 3 updates might not be sufficient...
	end
	-- avoid deadlock by releasing and caching after a moment
	if not pending then
		C_Timer.After(1, function()
			if TooltipPool:IsActive(tip) then
				tip.isReleasing = true
				TooltipPool:Release(tip)
			end
		end)
	end
end

-- experimental tooltip scanning without waiting for the tooltip to signal it is ready (if used, caching isn't used as it's instant response)
VladsVendorListTooltipMixin.UseExperimentalScanning = true

-- we create a tooltip by borrowing one from the TooltipPool and further modifying it to our application
local InstantTip do
	InstantTip = TooltipPool:Acquire()

	if TooltipDataProcessor then -- TODO: DF
		InstantTip.ignoreOnTooltipSetCallback = true
	else
		InstantTip:SetScript("OnTooltipSetItem", nil)
		InstantTip:SetScript("OnTooltipSetSpell", nil)
	end

	local TextLeft = InstantTip.textLeft
	local TextRight = InstantTip.textRight

	InstantTip.L = setmetatable({}, {
		__index = function(self, i)
			local v = TextLeft[i]:GetText()
			self[i] = v
			return v
		end,
	})

	InstantTip.R = setmetatable({}, {
		__index = function(self, i)
			local v = TextRight[i]:GetText()
			self[i] = v
			return v
		end,
	})

	InstantTip.LC = setmetatable({}, {
		__index = function(self, i)
			local v = RGB2HEX(TextLeft[i]:GetTextColor())
			self[i] = v
			return v
		end,
	})

	InstantTip.RC = setmetatable({}, {
		__index = function(self, i)
			local v = RGB2HEX(TextRight[i]:GetTextColor())
			self[i] = v
			return v
		end,
	})

	function InstantTip:Erase()
		self:ClearLines()
		for i in pairs(self.L) do
			-- TextLeft[i]:SetText()
			self.L[i] = nil
			self.LC[i] = nil
		end
		for i in pairs(self.R) do
			-- TextRight[i]:SetText()
			self.R[i] = nil
			self.RC[i] = nil
		end
	end

	local funcs = {
		"SetHyperlink",
	}

	for _, func in pairs(funcs) do
		local ofunc = InstantTip[func]
		InstantTip[func] = function(self, ...)
			self:Erase()
			return ofunc(self, ...)
		end
	end
end

-- used in TooltipScanInstant
local band = bit.band
local bor = bit.bor
local RecipeMask = {
	Reputation = 1,
	Profession = 2,
	ProfessionRank = 4,
	AlreadyKnown = 8,
	BattlePetCollected = 16,
}
VladsVendorListTooltipMixin.RecipeMask = RecipeMask

-- scans a link without a callback (experimental and might not be as reliable for recipes, at least can't cache these results, probably?)
function VladsVendorListTooltipMixin:TooltipScanInstant(itemButton, link)
	-- resolve the pattern strings
	if not TooltipTextPattern then
		TooltipTextPatternInit()
	end
	-- set the tip hyperlink
	InstantTip:SetHyperlink(link)
	-- instantly respond
	return itemButton:TooltipCallbackInstant(InstantTip)
end
