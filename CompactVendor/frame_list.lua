VladsVendorListMixin = CreateFromMixins(CallbackRegistryMixin or CallbackRegistryBaseMixin)

local LibItemSearch = LibStub("LibItemSearch-1.2")

local VladsVendorListEvents = {
	"MERCHANT_UPDATE",
	"BAG_UPDATE_DELAYED",
}

VladsVendorListMixin:GenerateCallbackEvents({
	"Scroll",
	"Filter",
	"Tooltip",
	"Search",
})

function VladsVendorListMixin:OnLoad()
	(CallbackRegistryMixin or CallbackRegistryBaseMixin).OnLoad(self)

	local function OnScroll()
		self.isScrollUpdate = true -- avoid recursion
		self:Update()
		self:TriggerEvent(VladsVendorListMixin.Event.Scroll)
		self:GameTooltipUpdate()
		self.isScrollUpdate = false
	end

	local function OnFilter()
		self:Update()
		self:TriggerEvent(VladsVendorListMixin.Event.Filter)
		self:GameTooltipUpdate()
	end

	self.ListScrollFrame.update = OnScroll
	self.ListScrollFrame.ScrollBar.doNotHide = true
	self.ListScrollFrame.ScrollBar:SetValue(0)

	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		hooksecurefunc("SetMerchantFilter", OnFilter)
		hooksecurefunc("ResetSetMerchantFilter", OnFilter)
	end

	--[[ global into private callback ]] self.searchCallback = function(_, text)
		self:SearchCallback(text)
	end
end

function VladsVendorListMixin:OnShow()
	FrameUtil.RegisterFrameForEvents(self, VladsVendorListEvents)
	self:RegisterCallback(VladsVendorListMixin.Event.Search, self.searchCallback, self.searchCallback)
	self:Update()
end

function VladsVendorListMixin:OnHide()
	FrameUtil.UnregisterFrameForEvents(self, VladsVendorListEvents)
	self:UnregisterCallback(VladsVendorListMixin.Event.Search, self.searchCallback)
end

function VladsVendorListMixin:OnEvent(event, ...)
	self:Update()
end

function VladsVendorListMixin:Update()
	-- scroll list to the top if we're talking to a new vendor
	self.npc = UnitGUID("npc")
	if self.prevNPC and self.prevNPC ~= self.npc then self.ListScrollFrame.ScrollBar:SetValue(0) end
	self.prevNPC = self.npc

	-- update the layout and display
	self:RefreshLayout()
	self:RefreshListDisplay()
end

function VladsVendorListMixin:RefreshLayout()
	if not self.ListScrollFrame.buttons then
		HybridScrollFrame_CreateButtons(self.ListScrollFrame, "VladsVendorListItemTemplate", 0, 0)
	end
end

function VladsVendorListMixin:RefreshListDisplay()
	local scrollFrame = self.ListScrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local numButtons = #buttons
	local numActiveButtons = 0
	local height = buttons[1]:GetHeight()
	local usedHeight = 0
	local numMerchantItems = GetMerchantNumItems()

	local searchOffset = 0
	local searchText = self:GetFrame().Search:GetText()
	searchText = searchText and searchText ~= "" and searchText or nil

	local i = 0
	while i < numButtons do
		i = i + 1

		local button = buttons[i]
		local displayIndex = i + offset

		if searchText then
			searchOffset = self:GetSearchOffset(displayIndex, searchText)
			numActiveButtons = numActiveButtons - searchOffset
			offset = offset + searchOffset
			displayIndex = i + offset
		end

		if displayIndex <= numMerchantItems then
			usedHeight = usedHeight + height
			button:SetItem(displayIndex)
		else
			button:SetItem(0)
		end

		numActiveButtons = numActiveButtons + 1
	end

	if not self.isScrollUpdate then
		HybridScrollFrame_Update(scrollFrame, (numMerchantItems - (numButtons - numActiveButtons)) * height, usedHeight)
	end
end

function VladsVendorListMixin:GetItemButtonByIndex(index)
	local scrollFrame = self.ListScrollFrame
	local buttons = scrollFrame.buttons

	for i = 1, #buttons do
		local button = buttons[i]
		local item = button:GetItem()

		if item.index == index then
			return button
		end
	end
end

function VladsVendorListMixin:GameTooltipUpdate()
	local frame = GetMouseFocus()
	if not frame or type(frame) ~= "table" or type(frame.GetScript) ~= "function" then
		return
	end
	local func = frame:GetScript("OnEnter")
	if func then
		func(frame)
	end
end

function VladsVendorListMixin:GetFrame()
	return self:GetParent()
end

function VladsVendorListMixin:GetNPC()
	if not self.npc then
		return
	end
	local npcType, _, _, _, _, id = strsplit("-", self.npc)
	return tonumber(id), npcType, self.npc
end

--[[ global ]] function VladsVendorListMixin:SearchCallback(text)
	self:RefreshListDisplay()
end

function VladsVendorListMixin:GetSearchOffset(index, text)
	local offset = 0
	while true do
		local link = GetMerchantItemLink(index + offset)
		if not link or LibItemSearch:Matches(link, text) then
			break
		end
		offset = offset + 1
	end
	return offset
end
