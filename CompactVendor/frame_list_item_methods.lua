-- TODO: 9.1
local LE_ITEM_CLASS_RECIPE = _G.LE_ITEM_CLASS_RECIPE or Enum.ItemClass.Recipe
local LE_ITEM_CLASS_MISCELLANEOUS = _G.LE_ITEM_CLASS_MISCELLANEOUS or Enum.ItemClass.Miscellaneous
local LE_ITEM_MISCELLANEOUS_MOUNT = _G.LE_ITEM_MISCELLANEOUS_MOUNT or Enum.ItemMiscellaneousSubclass.Mount
local LE_ITEM_CLASS_BATTLEPET = _G.LE_ITEM_CLASS_BATTLEPET or Enum.ItemClass.Battlepet
local LE_ITEM_MISCELLANEOUS_COMPANION_PET = _G.LE_ITEM_MISCELLANEOUS_COMPANION_PET or Enum.ItemMiscellaneousSubclass.CompanionPet

VladsVendorListItemMethodsMixin = {}

--[[ global ]] VladsVendorListItemMethodsMixin.CanLearnTextureTable = {
	[1001489] = true,
	[1001490] = true,
	[1001491] = true,
}

function VladsVendorListItemMethodsMixin:Exists()
	return self.exists == true
end

function VladsVendorListItemMethodsMixin:IsPurchasable()
	return self.isPurchasable
end

function VladsVendorListItemMethodsMixin:IsUsable()
	return self.isUsable
end

function VladsVendorListItemMethodsMixin:HasExtendedCost()
	return self.extendedCost
end

function VladsVendorListItemMethodsMixin:HasRealExtendedCost()
	-- quickly exit if there is no extended cost flag on the item originally
	if not self.extendedCost then
		return
	end
	-- check the required items
	local itemCount = GetMerchantItemCostInfo(self.index)
	for i = 1, itemCount do
		local _, _, link, currencyName = GetMerchantItemCostItem(self.index, i)
		-- if it costs real currency we ask for confirmation
		if currencyName then
			return true
		end
		-- if the item is a common barter item we don't care but if it's a rare one we ask to confirm
		if link then
			local _, _, quality = GetItemInfo(link)
			if quality >= (LE_ITEM_QUALITY_UNCOMMON or Enum.ItemQuality.Uncommon) then -- TODO: 9.0
				return false
			end
		end
	end
	-- by default we require confirmation if nothing else returned beforehand
	return true
end

function VladsVendorListItemMethodsMixin:CanRefund()
	return self.canRefund
end

function VladsVendorListItemMethodsMixin:CanAfford()
	local afford = CanAffordMerchantItem(self.index)
	return afford ~= false
end

function VladsVendorListItemMethodsMixin:IsCurrency()
	return self.currencyID
end

function VladsVendorListItemMethodsMixin:IsRecipe()
	return self.classID == LE_ITEM_CLASS_RECIPE
end

function VladsVendorListItemMethodsMixin:IsMisc()
	return self.classID == LE_ITEM_CLASS_MISCELLANEOUS
end

function VladsVendorListItemMethodsMixin:IsMount()
	return self:IsMisc() and self.subClassID == LE_ITEM_MISCELLANEOUS_MOUNT
end

function VladsVendorListItemMethodsMixin:IsBattlePet()
	return self.classID == LE_ITEM_CLASS_BATTLEPET or (self:IsMisc() and self.subClassID == LE_ITEM_MISCELLANEOUS_COMPANION_PET)
end

function VladsVendorListItemMethodsMixin:IsHeirloom()
	return self.id and C_Heirloom and (C_Heirloom.IsItemHeirloom(self.id) or C_Heirloom.PlayerHasHeirloom(self.id))
end

function VladsVendorListItemMethodsMixin:IsToy()
	return self.id and C_ToyBox and C_ToyBox.GetToyInfo(self.id)
end

function VladsVendorListItemMethodsMixin:CanLearn()
	return self.CanLearnTextureTable[self.texture]
		or self:IsRecipe()
		or self:IsMount()
		or self:IsBattlePet()
		or self:IsHeirloom()
		or self:IsToy()
end
