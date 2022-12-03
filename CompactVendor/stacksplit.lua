VladsVendorListItemQuantityStackSplitMixin = {}

-- can't run any keybinds from unsecure code
local function RunBinding() end

function VladsVendorListItemQuantityStackSplitMixin:OnLoad()
end

function VladsVendorListItemQuantityStackSplitMixin:OnHide()
	for key in next, (self.down or {}) do
		if GetBindingAction(key) then
			RunBinding(GetBindingAction(key), "up")
		end
		self.down[key] = nil
	end

	if self.owner then
		self.owner.hasStackSplit = 0
	end
end

function VladsVendorListItemQuantityStackSplitMixin:OnChar(text)
	if self.isMultiStack and self.maxStack < self.minSplit * text then
		return
	elseif text < "0" or text > "9" then
		return
	end

	if self.typing == 0 then
		self.typing = self.minSplit
		self.split = 0
	end

	local split = (self.split * 10) + (text * self.minSplit)
	if split == self.split then
		if self.split == 0 then
			self.split = self.minSplit
		end
		return
	end

	if split <= self.maxStack then
		self.split = split
		self:UpdateStackText()

		if split == self.maxStack then
			self.RightButton:Disable()
		else
			self.RightButton:Enable()
		end

		if split == self.minSplit then
			self.LeftButton:Disable()
		else
			self.LeftButton:Enable()
		end

	elseif split == 0 then
		self.split = 1
	end
end

function VladsVendorListItemQuantityStackSplitMixin:OnKeyDown(key)
	local numKey = gsub(key, "NUMPAD", "")

	if key == "BACKSPACE" or key == "DELETE" then
		if self.typing == 0 or self.split == self.minSplit then
			return
		end

		self.split = floor(self.split / 10)
		if self.split <= self.minSplit then
			self.split = self.minSplit
			self.typing = 0
			self.LeftButton:Disable()
		else
			self.LeftButton:Enable()
		end

		self:UpdateStackText()

		if self.money == self.maxStack then
			self.RightButton:Disable()
		else
			self.RightButton:Enable()
		end

	elseif key == "ENTER" then
		self:OkayButtonOnClick()

	elseif GetBindingFromClick(key) == "TOGGLEGAMEMENU" then
		self:CancelButtonOnClick()

	elseif key == "LEFT" or key == "DOWN" then
		self:LeftButtonOnClick()

	elseif key == "RIGHT" or key == "UP" then
		self:RightButtonOnClick()

	elseif not tonumber(numKey) and GetBindingAction(key) then
		-- Running bindings not used by the StackSplit frame allows players to retain control of their characters.
		RunBinding(GetBindingAction(key))
	end

	self.down = self.down or {}
	self.down[key] = true
end

function VladsVendorListItemQuantityStackSplitMixin:OnKeyUp(key)
	local numKey = gsub(key, "NUMPAD", "")

	if not tonumber(numKey) and GetBindingAction(key) then
		-- If we don't run the up bindings as well, interesting things happen (like you never stop moving)
		RunBinding(GetBindingAction(key), "up")
	end

	if self.down then
		self.down[key] = nil
	end
end

function VladsVendorListItemQuantityStackSplitMixin:LeftButtonOnClick()
	if self.split == self.minSplit then
		return
	end

	self.split = self.split - self.minSplit
	self:UpdateStackText()

	if self.split == self.minSplit then
		self.LeftButton:Disable()
	end

	self.RightButton:Enable()
end

function VladsVendorListItemQuantityStackSplitMixin:RightButtonOnClick()
	if self.split == self.maxStack then
		return
	end

	self.split = self.split + self.minSplit
	self:UpdateStackText()

	if self.split == self.maxStack then
		self.RightButton:Disable()
	end

	self.LeftButton:Enable()
end

function VladsVendorListItemQuantityStackSplitMixin:OkayButtonOnClick()
	self:Hide()

	if self.owner then
		self.owner.SplitStack(self.owner, self.split)
	end
end

function VladsVendorListItemQuantityStackSplitMixin:CancelButtonOnClick()
	self:Hide()
end

function VladsVendorListItemQuantityStackSplitMixin:OpenStackSplitFrame(maxStack, parent, anchor, anchorTo, stackCount)
	if self.owner then
		self.owner.hasStackSplit = 0
	end
	
	if not maxStack or maxStack < 1 then
		self:Hide()
		return
	end

	self.maxStack = maxStack
	self.owner = parent
	parent.hasStackSplit = 1
	self.minSplit = stackCount or 1
	self.split = self.minSplit
	self.typing = 0
	self.StackSplitText:SetText(self.split)
	self.LeftButton:Disable()
	self.RightButton:Enable()
	self:ClearAllPoints()
	self:SetPoint(anchor, parent, anchorTo, 0, 0)
	self:Show()
	self:ChooseFrameType(self.minSplit)
end

function VladsVendorListItemQuantityStackSplitMixin:ChooseFrameType(splitAmount)
	if splitAmount == 1 then 
		self:SetSize(172, 96)
		self.isMultiStack = false
		self.SingleItemSplitBackground:Show()
		self.MultiItemSplitBackground:Hide()
		self.StackItemCountText:Hide()
		self.StackSplitText:ClearAllPoints()
		self.StackSplitText:SetPoint("RIGHT", self, "RIGHT", -50, 18)
		self.OkayButton:ClearAllPoints()
		self.OkayButton:SetPoint("RIGHT", self, "BOTTOM", -3, 32)
		self.CancelButton:ClearAllPoints()
		self.CancelButton:SetPoint("LEFT", self, "BOTTOM", 5, 32)
	else
		self.isMultiStack = true
		self:SetSize(172, 120)
		self.SingleItemSplitBackground:Hide()
		self.MultiItemSplitBackground:Show()
		self.StackSplitText:ClearAllPoints()
		self.StackSplitText:SetPoint("CENTER", self, "CENTER", 5, 30)
		self.StackSplitText:SetText(STACKS:format(self.split/self.minSplit))
		self.StackItemCountText:SetText(TOTAL_STACKS:format(self.split))
		self.StackItemCountText:Show()
		self.OkayButton:ClearAllPoints()
		self.OkayButton:SetPoint("RIGHT", self, "BOTTOM", -3, 40)
		self.CancelButton:ClearAllPoints()
		self.CancelButton:SetPoint("LEFT", self, "BOTTOM", 5, 40)
	end
end

function VladsVendorListItemQuantityStackSplitMixin:UpdateStackText()
	if self.isMultiStack then
		self.StackSplitText:SetText(STACKS:format(self.split/self.minSplit))
		self.StackItemCountText:SetText(TOTAL_STACKS:format(self.split))
	else
		self.StackSplitText:SetText(self.split)
	end
end

function VladsVendorListItemQuantityStackSplitMixin:UpdateStackSplitFrame(maxStack)
	self.maxStack = maxStack

	if self.maxStack < 2 then
		if self.owner then
			self.owner.hasStackSplit = 0
		end
		self:Hide()
		return
	end

	if self.split > self.maxStack then
		self.split = self.maxStack
		self.StackSplitText:SetText(self.split)
	end

	if self.split == self.maxStack then
		self.RightButton:Disable()
	else
		self.RightButton:Enable()
	end

	if self.split == 1 then
		self.LeftButton:Disable()
	else
		self.LeftButton:Enable()
	end
end
