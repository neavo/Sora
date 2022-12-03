VladsVendorListItemMixin = {}

--[[ global ]] VladsVendorListItemMixin.ConfirmationRequirementForVendors = {
	[151950] = false, -- Mrrglrlr
	[151951] = false, -- Grrmrlg
	[151952] = false, -- Flrggrl
	[151953] = false, -- Hurlgrl
	[152084] = true, -- Mrrl
	[152593] = false, -- Murloco
}

local VladsVendorListItemEvents = {
	"GET_ITEM_INFO_RECEIVED",
	-- "MERCHANT_FILTER_ITEM_UPDATE", -- spams a lot and doesn't really help with UI updates
}

VladsVendorListItemMixin.Background = {}
VladsVendorListItemMixin.Color = {}
VladsVendorListItemMixin.ItemHexColorToQualityIndex = {}
do
	-- additional colors
	VladsVendorListItemMixin.Background.None   = { 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00 }
	VladsVendorListItemMixin.Background.Red    = { 1.00, 0.00, 0.00, 0.75, 1.00, 0.00, 0.00, 0.00 }
	VladsVendorListItemMixin.Background.Orange = { 1.00, 0.40, 0.00, 0.75, 1.00, 0.40, 0.00, 0.00 }
	VladsVendorListItemMixin.Background.Yellow = { 1.00, 1.00, 0.00, 0.75, 1.00, 1.00, 0.00, 0.00 }

	-- item qualities by name
	VladsVendorListItemMixin.Background.Gray      = { 0.62, 0.62, 0.62, 0.75, 0.62, 0.62, 0.62, 0.00 }
	VladsVendorListItemMixin.Background.White     = { 1.00, 1.00, 1.00, 0.75, 1.00, 1.00, 1.00, 0.00 }
	VladsVendorListItemMixin.Background.Green     = { 0.00, 1.00, 0.00, 0.75, 0.00, 1.00, 0.00, 0.00 }
	VladsVendorListItemMixin.Background.Blue      = { 0.50, 0.50, 1.00, 1.00, 0.50, 0.50, 1.00, 0.00 }
	VladsVendorListItemMixin.Background.Purple    = { 1.00, 0.00, 1.00, 0.75, 1.00, 0.00, 1.00, 0.00 }
	VladsVendorListItemMixin.Background.Legendary = { 1.00, 0.50, 0.00, 0.75, 1.00, 0.50, 0.00, 0.00 }
	VladsVendorListItemMixin.Background.Artifact  = { 0.90, 0.80, 0.50, 0.75, 0.90, 0.80, 0.50, 0.00 }
	VladsVendorListItemMixin.Background.Heirloom  = { 1.00, 0.75, 0.50, 0.75, 1.00, 0.75, 0.50, 0.00 }

	-- item qualities by index
	VladsVendorListItemMixin.Background[0] = VladsVendorListItemMixin.Background.Gray
	VladsVendorListItemMixin.Background[1] = VladsVendorListItemMixin.Background.White
	VladsVendorListItemMixin.Background[2] = VladsVendorListItemMixin.Background.Green
	VladsVendorListItemMixin.Background[3] = VladsVendorListItemMixin.Background.Blue
	VladsVendorListItemMixin.Background[4] = VladsVendorListItemMixin.Background.Purple
	VladsVendorListItemMixin.Background[5] = VladsVendorListItemMixin.Background.Legendary
	VladsVendorListItemMixin.Background[6] = VladsVendorListItemMixin.Background.Artifact
	VladsVendorListItemMixin.Background[7] = VladsVendorListItemMixin.Background.Heirloom

	-- item qualities text
	for i = 0, 8 do
		local r, g, b, hex = GetItemQualityColor(i)

		VladsVendorListItemMixin.Color[i] = {
			r = r,
			g = g,
			b = b,
			hex = hex,
		}

		VladsVendorListItemMixin.ItemHexColorToQualityIndex[hex] = i
	end

	VladsVendorListItemMixin.Color.None = VladsVendorListItemMixin.Color[0]
end

function VladsVendorListItemMixin:UpdateScale()
	local frame = self:GetParent():GetParent()
	local frameWidth = frame:GetWidth()

	local width, height = self:GetSize()
	local scale = CompactVendorDB.ListItemScale or 1

	self:SetSize(frameWidth - 5, height * scale)

	self.Icon:SetScale(scale)
	self.CircleMask:SetScale(scale)
	self.Name:SetScale(scale)

	self.Quantity:SetScale(scale)
	self.Cost:SetScale(scale)
end

function VladsVendorListItemMixin:OnLoad()
	self.item = CreateFromMixins(VladsVendorListItemMethodsMixin) ---@type VladsVendorListItemMethodsMixin

	--[[ global into private callback ]] self.tooltipCallback = function(...)
		self:TooltipCallback(...)
	end

	self:UpdateScale()
end

local band = bit.band
local bor = bit.bor
local RecipeMask = VladsVendorListTooltipMixin.RecipeMask

function VladsVendorListItemMixin:TooltipCallbackSetColors(mask)
	-- get item
	local item = self:GetItem()
	-- set text and background colors
	local backgroundColor = item.quality
	local textColor = item.quality
	if band(RecipeMask.BattlePetCollected, mask) == RecipeMask.BattlePetCollected then
		backgroundColor = self.Background.None
		textColor = self.Color[0]
	elseif band(RecipeMask.AlreadyKnown, mask) == RecipeMask.AlreadyKnown then
		backgroundColor = self.Background.None
		textColor = self.Color[0]
	elseif band(RecipeMask.Reputation, mask) == RecipeMask.Reputation then
		backgroundColor = self.Background.Red
	elseif band(RecipeMask.Profession, mask) == RecipeMask.Profession then
		backgroundColor = self.Background.Orange
	elseif band(RecipeMask.ProfessionRank, mask) == RecipeMask.ProfessionRank then
		backgroundColor = self.Background.Yellow
	end
	-- override if it's not a recipe with any mask, and we can't afford it
	if mask == 0 and not item:CanAfford() then
		backgroundColor = self.Background.Red
	end
	-- set the colors to the button
	if backgroundColor then
		self:SetBackgroundColor(backgroundColor)
	end
	if textColor then
		self:SetTextColor(textColor)
	end
end

--[[ global ]] function VladsVendorListItemMixin:TooltipCallback(event, itemButton, tip, lines)
	-- only work with the data if its ours
	if self ~= itemButton then
		return
	end
	-- scan the tip if we don't have it provided
	if not lines then
		lines = VladsVendorListTooltipMixin:TooltipText(tip)
	end
	-- find requirements in tooltip text
	local mask = 0
	for i = 1, lines.numLines do
		local line = lines[i]
		local textLeft, textRight, colorLeft, colorRight = line[1], line[2], line[3], line[4]
		local lineType, canUse = VladsVendorListTooltipMixin:TooltipTextParse(textLeft, colorLeft)
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.Reputation and not canUse then mask = bor(mask, RecipeMask.Reputation) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.Profession and not canUse then mask = bor(mask, RecipeMask.Profession) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.ProfessionRank and not canUse then mask = bor(mask, RecipeMask.ProfessionRank) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.AlreadyKnown and not canUse then mask = bor(mask, RecipeMask.AlreadyKnown) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.BattlePetCollected and not canUse then mask = bor(mask, RecipeMask.BattlePetCollected) end
	end
	-- set button colors
	self:TooltipCallbackSetColors(mask)
	-- get item
	local item = self:GetItem()
	-- update cached colors on the second draw as recipes needs a moment to fully load both items
	local cache = VladsVendorListItemCacheMixin:GetCache(self, item)
	if cache then
		cache.backgroundColor = self.backgroundColor
		cache.textColor = self.textColor
		cache.tooltipScanCount = (cache.tooltipScanCount or 0) + 1
		cache.tooltipScanned = cache.tooltipScanCount > 1
	end
end

function VladsVendorListItemMixin:TooltipCallbackInstant(tip)
	-- parse the lines and create the mask
	local mask = 0
	for i = 1, tip:NumLines(), 1 do
		local textLeft = tip.L[i]
		local colorLeft = tip.LC[i]
		local lineType, canUse = VladsVendorListTooltipMixin:TooltipTextParse(textLeft, colorLeft)
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.Reputation and not canUse then mask = bor(mask, RecipeMask.Reputation) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.Profession and not canUse then mask = bor(mask, RecipeMask.Profession) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.ProfessionRank and not canUse then mask = bor(mask, RecipeMask.ProfessionRank) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.AlreadyKnown and not canUse then mask = bor(mask, RecipeMask.AlreadyKnown) end
		if lineType == VladsVendorListTooltipMixin.TooltipTextType.BattlePetCollected and not canUse then mask = bor(mask, RecipeMask.BattlePetCollected) end
	end
	-- set button colors
	self:TooltipCallbackSetColors(mask)
end

function VladsVendorListItemMixin:OnShow()
	FrameUtil.RegisterFrameForEvents(self, VladsVendorListItemEvents)
	self:GetList():RegisterCallback(VladsVendorListMixin.Event.Tooltip, self.tooltipCallback, self.tooltipCallback)
	self:Update()
end

function VladsVendorListItemMixin:OnHide()
	FrameUtil.UnregisterFrameForEvents(self, VladsVendorListItemEvents)
	self:GetList():UnregisterCallback(VladsVendorListMixin.Event.Tooltip, self.tooltipCallback)
end

function VladsVendorListItemMixin:OnEvent(event, itemID, success)
	if event == "GET_ITEM_INFO_RECEIVED" then
		if itemID == 0 or not itemID or not success or not self:HasItem() then
			return
		end
		local item = self:GetItem()
		if item.id == itemID then
			self:Update()
		end
	elseif event == "MERCHANT_FILTER_ITEM_UPDATE" then
		if itemID == 0 or not itemID or not self:HasItem() then
			return
		end
		local item = self:GetItem()
		if item.id == itemID then
			self:Update()
		end
	end
end

function VladsVendorListItemMixin:OnEnter()
	if not self:HasItem() then
		return
	end
	local item = self:GetItem()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetMerchantItem(item.index)
	GameTooltip_ShowCompareItem()
	MerchantFrame.itemHover = item.index
	self.hovering = true
end

function VladsVendorListItemMixin:OnLeave()
	GameTooltip:Hide()
	ResetCursor()
	MerchantFrame.itemHover = nil
	self.hovering = false
end

function VladsVendorListItemMixin:OnUpdate()
	if not self.hovering then
		return
	end
	if self ~= GameTooltip:GetOwner() then
		return
	end
	if IsModifiedClick("DRESSUP") then
		ShowInspectCursor()
	else
		local item = self:GetItem()
		if CanAffordMerchantItem(item.index) == false then
			SetCursor("BUY_ERROR_CURSOR")
		else
			SetCursor("BUY_CURSOR")
		end
	end
end

function VladsVendorListItemMixin:OnClick(button)
	local item = self:GetItem()
	if HandleModifiedItemClick(item.link) then
		return
	end
	if button == "LeftButton" then
		if IsModifiedClick("DRESSUP") then
			if DressUpItemLink(item.link) then
			elseif DressUpBattlePetLink(item.link) then
			elseif DressUpMountLink(item.link) then
			end
		elseif IsModifiedClick("SHIFT") then
			self:SelectQuantity()
		end
	elseif button == "RightButton" then
		if IsModifiedClick("ALT") then
			self:Purchase(item.maxStackCount)
		else
			self:Purchase()
		end
	end
end

function VladsVendorListItemMixin:GetQualityIndexFromLink(link)
	if not link then
		return
	end
	local hex = link:match("|c([%x]+)|")
	if not hex then
		return
	end
	return self.ItemHexColorToQualityIndex[hex]
end

function VladsVendorListItemMixin:HasItem()
	return self.item.exists
end

function VladsVendorListItemMixin:SetItem(index)
	local item = self.item

	item.exists = false
	item.guid = nil
	item.index = index

	if index > 0 then
		item.name,
		item.texture,
		item.price,
		item.stackCount,
		item.numAvailable,
		item.isPurchasable,
		item.isUsable,
		item.extendedCost,
		item.currencyID = GetMerchantItemInfo(index)

		item.canRefund = C_MerchantFrame.IsMerchantItemRefundable and C_MerchantFrame.IsMerchantItemRefundable(index)
		item.link = GetMerchantItemLink(index)
		item.quality = nil

		if item.currencyID then
			item.name, item.texture, item.numAvailable, item.quality = CurrencyContainerUtil.GetCurrencyContainerInfo(item.currencyID, item.numAvailable, item.name, item.texture, nil)
		end

		if item.link then
			item.id,
			item.type,
			item.subType,
			item.equipLoc,
			item.icon,
			item.classID,
			item.subClassID = GetItemInfoInstant(item.link)

			local _, _, quality, _, _, _, _, maxStackCount = GetItemInfo(item.link)
			item.maxStackCount = maxStackCount

			if not item.currencyID or not item.quality then
				item.quality = quality or self:GetQualityIndexFromLink(item.link) or item.quality or 1
			end

			-- TODO: anima powers in vendor (spell id to quality color)

			item.qualityColorR,
			item.qualityColorG,
			item.qualityColorB,
			item.qualityColorHex = GetItemQualityColor(item.quality)

			local list = self:GetList()
			item.guid = list.npc .. "@" .. item.link
			item.exists = true
		end
	end

	if item.exists then
		if self:IsShown() then
			self:Update()
		else
			self:Show()
		end
		self.Quantity:SetEnabled(self:CanSelectQuantity())
	else
		self:Hide()
	end
end

function VladsVendorListItemMixin:GetItem(onlyIfExists)
	if onlyIfExists and not self:HasItem() then
		return
	end
	return self.item
end

function VladsVendorListItemMixin:Update()
	if not self:HasItem() then
		return
	end

	local item = self:GetItem()

	local cache = VladsVendorListItemCacheMixin:GetCache(self, item)

	local text = cache and cache.text
	if not text or item.numAvailable > -1 then
		text = ""
			.. (item.numAvailable and item.numAvailable > -1 and "|cffFFFF00[" .. item.numAvailable .. "]|r " or "")
			.. (item.name or SEARCH_LOADING_TEXT)
			.. (item.stackCount and item.stackCount > 1 and " |cffFFFF00x" .. item.stackCount .. "|r" or "")
	end

	self.Icon:SetTexture(item.texture)
	self.Name:SetText(text)
	self.Cost:Update()

	local backgroundColor = self.Background.None
	local textColor = max(1, item.quality)

	local isPurchasable = item:IsPurchasable()
	local isUsable = item:IsUsable()
	local canAfford = item:CanAfford()
	local canLearn = item:CanLearn()

	if not isPurchasable or not isUsable or not canAfford then
		backgroundColor = self.Background.Red
	end

	if canLearn then
		if VladsVendorListTooltipMixin.UseExperimentalScanning then
			backgroundColor = nil
			textColor = nil
			VladsVendorListTooltipMixin:TooltipScanInstant(self, item.link) -- self:TooltipCallbackInstant()
		elseif cache and cache.tooltipScanned then
			backgroundColor = cache.backgroundColor
			textColor = cache.textColor
		else
			backgroundColor = nil
			textColor = nil
			VladsVendorListTooltipMixin:TooltipScan(self, item.link) -- self:TooltipCallback()
		end
	end

	if backgroundColor then
		self:SetBackgroundColor(backgroundColor)
	end

	if textColor then
		self:SetTextColor(textColor)
	end

	if not cache then
		VladsVendorListItemCacheMixin:SetCache(self, item)
	end
end

function VladsVendorListItemMixin:CanSelectQuantity()
	-- local item = self:GetItem()
	return true -- TODO: need to figure out if we can avoid tooltip scanning for this information
end

function VladsVendorListItemMixin:SelectQuantity()
	if not self:CanSelectQuantity() then
		return
	end
	self.Quantity:Click()
end

function VladsVendorListItemMixin:RequiresConfirmation()
	-- classic doesn't support the confirmation extended item cost functionality of the merchant frame
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		return false
	end
	-- if the npc is marked as a special requirement, either confirm all purchases, or skip all confirmations
	local id, npcType, guid = self:GetList():GetNPC()
	if id and (npcType == "Creature" or npcType == "Vehicle") then
		local requirement = self.ConfirmationRequirementForVendors[id]
		if type(requirement) == "boolean" then
			return requirement
		end
	end
	-- check if the item isn't refundable, or requires extra cost like currency or other items
	local item = self:GetItem()
	-- https://github.com/Gethe/wow-ui-source/blob/eca4d22da650b0ce775898ce31e708c4a6ee66f5/Interface/FrameXML/MerchantFrame.lua#L652
	if GetMerchantItemCostInfo(item.index) == 0 and item:CanRefund() then
		return not item.price or item.price < MERCHANT_HIGH_PRICE_COST
	end
	return item:HasRealExtendedCost()
end

function VladsVendorListItemMixin:Purchase(quantity, fromStackPopup)
	local item = self:GetItem()
	local stackCount = item.stackCount or 1
	local maxStackCount = item.maxStackCount or 1
	quantity = quantity or stackCount
	if self:RequiresConfirmation() and (fromStackPopup ~= true or not item:CanRefund()) then
		-- add this to mimic the merchant frame attributes onto our custom button
		self:SetID(item.index)
		self.showNonrefundablePrompt = not item:CanRefund()
		self.count = quantity
		self.link = item.link
		self.price = item.price > 0 and item.price or nil
		self.color = { item.qualityColorR, item.qualityColorR, item.qualityColorB }
		self.name = item.name
		self.texture = item.texture
		MerchantFrame_ConfirmExtendedItemCost(self, quantity)
		-- if the item is non-refundable, make it very clear
		if self.showNonrefundablePrompt then
			local _, frame = StaticPopup_Visible("CONFIRM_PURCHASE_NONREFUNDABLE_ITEM")
			if frame then
				local textString = frame.text:GetText()
				frame.text:SetText(textString .. "\n\n" .. "|cffFF0000Your purchase is not refundable.|r")
			end
		end
	else
		if quantity > 1 and quantity ~= stackCount then
			local maxSize = max(stackCount, maxStackCount)
			local remaining = quantity
			repeat
				local maxCount = floor(remaining / maxSize)
				if maxCount > 0 then
					BuyMerchantItem(item.index, maxSize)
					remaining = remaining - maxSize
				else
					BuyMerchantItem(item.index, remaining)
					remaining = 0
				end
			until remaining < 1
		else
			BuyMerchantItem(item.index, quantity)
		end
	end
end

function VladsVendorListItemMixin:SetBackgroundColor(colorIndex, fallback)
	colorIndex = colorIndex or "None"
	local color = (colorIndex and VladsVendorListItemMixin.Background[colorIndex] or colorIndex) or (fallback and VladsVendorListItemMixin.Background[fallback] or fallback)
	if type(color) ~= "table" then
		return false
	end
	self.backgroundColor = color
	-- TODO: DF support
	if self.Bg.SetGradientAlpha then
		self.Bg:SetGradientAlpha("HORIZONTAL", color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8])
	else
		self.Bg:SetGradient("HORIZONTAL", { r = color[1], g = color[2], b = color[3], a = color[4] }, { r = color[5], g = color[6], b = color[7], a = color[8] })
	end
	return true
end

function VladsVendorListItemMixin:SetTextColor(colorIndex, fallback)
	colorIndex = colorIndex or "None"
	local color = (colorIndex and VladsVendorListItemMixin.Color[colorIndex] or colorIndex) or (fallback and VladsVendorListItemMixin.Color[fallback] or fallback)
	if type(color) ~= "table" then
		return false
	end
	self.textColor = color
	self.Name:SetTextColor(color.r, color.g, color.b)
	return true
end

function VladsVendorListItemMixin:GetList()
	return self:GetParent():GetParent():GetParent()
end
