VladsVendorListItemQuantityButtonMixin = {}

local StackSplitFrame = VladsVendorListItemQuantityStackSplitFrame

--[[ global ]] local state = {}

--[[ global hook ]] StackSplitFrame:HookScript("OnHide", function()
	state.button = nil
end)

function VladsVendorListItemQuantityButtonMixin:OnLoad()
	self:GetNormalTexture():SetTexCoord(0.15625, 0.5, 0.84375, 0.5, 0.15625, 0, 0.84375, 0)
	self:GetHighlightTexture():SetTexCoord(0.15625, 1, 0.84375, 1, 0.15625, 0.5, 0.84375, 0.5)

	--[[ global into private callback ]] self.listScrollCallback = function()
		self:ListScrollCallback()
	end

	-- required by StackSplitFrame
	self.hasStackSplit = 0
	self.SplitStack = self.SplitStackCallback
end

function VladsVendorListItemQuantityButtonMixin:OnShow()
	self:GetList():RegisterCallback(VladsVendorListMixin.Event.Scroll, self.listScrollCallback, self.listScrollCallback)
end

function VladsVendorListItemQuantityButtonMixin:OnHide()
	self:GetList():UnregisterCallback(VladsVendorListMixin.Event.Scroll, self.listScrollCallback)

	if not StackSplitFrame:IsShown() then
		return
	end
	if self == StackSplitFrame.owner then
		StackSplitFrame:Hide()
	end
end

function VladsVendorListItemQuantityButtonMixin:OnClick(button)
	if StackSplitFrame:IsShown() and self == StackSplitFrame.owner then
		StackSplitFrame:Hide()
	else
		StackSplitFrame:OpenStackSplitFrame(250, self, "TOPLEFT", "TOPRIGHT")
		state.button, state.index = self, self:GetItem():GetItem().index
	end
end

--[[ global ]] function VladsVendorListItemQuantityButtonMixin:ListScrollCallback()
	if not state.button or not state.index then
		return
	end
	local list = self:GetList()
	local itemButton = list:GetItemButtonByIndex(state.index)
	if itemButton then
		StackSplitFrame:ClearAllPoints()
		StackSplitFrame:SetPoint("TOPLEFT", itemButton, "TOPRIGHT")
	else
		StackSplitFrame:Hide()
	end
end

function VladsVendorListItemQuantityButtonMixin:GetList()
	return self:GetParent():GetParent():GetParent():GetParent()
end

function VladsVendorListItemQuantityButtonMixin:GetItem()
	return self:GetParent()
end

--[[ called from StackSplitFrame ]] function VladsVendorListItemQuantityButtonMixin:SplitStackCallback(quantity)
	if not quantity or not state.index then
		return
	end
	local list = self:GetList()
	local itemButton = list:GetItemButtonByIndex(state.index)
	if itemButton and itemButton:HasItem() then
		itemButton:Purchase(quantity, true)
	end
end
