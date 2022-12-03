--[[ global ]] VladsVendorListItemCacheMixin = {}

VladsVendorListItemCacheMixin.Cache = {}

function VladsVendorListItemCacheMixin:GetCache(button, item, autoCreate)
	local cache = self.Cache[item.guid]
	if not cache and autoCreate then
		cache = {}
		self.Cache[item.guid] = cache
	end
	return cache
end

function VladsVendorListItemCacheMixin:SetCache(button, item)
	local cache = self:GetCache(button, item, true)
	cache.text = button.Name:GetText()
	cache.backgroundColor = button.backgroundColor
	cache.textColor = button.textColor
	return cache
end

function VladsVendorListItemCacheMixin:ClearAllTooltipCache()
	for _, cache in pairs(self.Cache) do
		cache.tooltipScanCount = nil
		cache.tooltipScanned = nil
	end
end
