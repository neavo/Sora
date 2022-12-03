VladsVendorFrameMixin = {}

local function Hide(frame)
	frame.Show = frame.Hide
	frame:Hide()
end

local VladsVendorFrameEvents = {
	"ADDON_LOADED",
	"MERCHANT_SHOW",
	"MERCHANT_CLOSED",
}

function VladsVendorFrameMixin:OnLoad()
	FrameUtil.RegisterFrameForEvents(self, VladsVendorFrameEvents)

	-- cover the page area in the merchant frame
	self:SetPoint("TOPLEFT", MerchantFrameInset, "TOPLEFT", 3, -2)
	self:SetPoint("BOTTOMRIGHT", MerchantFrameInset, "BOTTOMRIGHT", -20, 55)

	-- re-anchor the buyback button as it acts a bit odd when swapping tabs
	MerchantBuyBackItem:ClearAllPoints()
	MerchantBuyBackItem:SetPoint("BOTTOMRIGHT", -7, 33)

	-- re-parent the merchant item frames to only appear in the buyback tab
	for i = 1, 10 do
		_G["MerchantItem" .. i]:SetParent(MerchantItem11)
	end

	-- we don't need pagination anymore
	Hide(MerchantNextPageButton)
	Hide(MerchantPrevPageButton)
	Hide(MerchantPageText)
end

function VladsVendorFrameMixin:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		self:SetupAddOnSupport()
	elseif event == "MERCHANT_SHOW" then
		if self:IsShown() then
			self:GetList():Update()
		else
			self:Show()
		end
	elseif event == "MERCHANT_CLOSED" then
		self:Hide()
		VladsVendorListItemCacheMixin:ClearAllTooltipCache()
	end
end

function VladsVendorFrameMixin:GetList()
	return self.List
end

function VladsVendorFrameMixin:SetupAddOnSupport()
	if IsAddOnLoaded("ElvUI") then
		self:SetupElvUI()
	end
	if IsAddOnLoaded("GnomishVendorShrinker") then
		self:SetupGnomishVendorShrinker()
	end
end

function VladsVendorFrameMixin:SetupElvUI()
	if self.setupElvUI then
		return
	end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", MerchantFrameInset, "TOPLEFT", 8, -5)
	self:SetPoint("BOTTOMRIGHT", MerchantFrameInset, "BOTTOMRIGHT", -20, 60)

	local E = ElvUI and ElvUI[1]
	local S = E and E:GetModule("Skins")

	if not S then
		return
	end

	if not E.Border then
		return
	end

	if not self.List or not self.List.ListScrollFrame or not self.List.ListScrollFrame.ScrollBar then
		return
	end

	S:HandleScrollBar(self.List.ListScrollFrame.ScrollBar)
	self.List.InsetFrame:StripTextures()

	S:HandleEditBox(self.Search)
	self.Search:SetSize(102, 18)
	self.Search:ClearAllPoints()
	self.Search:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 13, -35)
	self.Search:SetPoint("RIGHT", MerchantFrameLootFilter, "LEFT", 0, 0)

	self.setupElvUI = true
end

function VladsVendorFrameMixin:SetupGnomishVendorShrinker()
	if self.setupGnomishVendorShrinker then
		return
	end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", MerchantFrameInset, "TOPRIGHT", 10, -4)
	self:SetSize(296, 298)

	self.setupGnomishVendorShrinker = true
end
