VladsVendorListItemCostFrameMixin = {}

function VladsVendorListItemCostFrameMixin:OnLoad()
end

function VladsVendorListItemCostFrameMixin:GetListItem()
	return self:GetParent()
end

function VladsVendorListItemCostFrameMixin:Update()
	local listItem = self:GetListItem()

	if not listItem:HasItem() then
		return
	end

	local item = listItem:GetItem()
	local pool

	if item.extendedCost then
		if not pool then
			pool = self:CreateCostPool()
		end
		local cost = self:PopFromPool(pool)
		if cost then
			local success, retry = cost:Set(cost.Type.Item, item, self, pool)
			if not success then
				pool[#pool + 1] = cost
			elseif retry then
				C_Timer.After(0.2, function() self:Update() end)
			end
		end
	end

	if item.price > 0 then
		if not pool then
			pool = self:CreateCostPool()
		end
		local cost = self:PopFromPool(pool)
		if cost and not cost:Set(cost.Type.Money, item) then
			pool[#pool + 1] = cost
		end
	end

	if pool then
		for _, cost in pairs(pool) do
			cost:Reset()
		end
		self:Show()
		self:AutoSize()
	else
		self:Hide()
	end
end

function VladsVendorListItemCostFrameMixin:CreateCostPool()
	local pool = {}
	local index = 0

	for i = #self.Costs, 1, -1 do
		index = index + 1
		local cost = self.Costs[i]
		cost.Name:SetText()
		cost.Icon:Hide()
		cost:Hide()
		pool[index] = cost
	end

	return pool
end

function VladsVendorListItemCostFrameMixin:PopFromPool(pool)
	local count = #pool
	if count < 1 then
		return
	end
	return table.remove(pool, count)
end
