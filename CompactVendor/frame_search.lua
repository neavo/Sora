VladsVendorFrameSearchMixin = {}

function VladsVendorFrameSearchMixin:OnLoad()
	SearchBoxTemplate_OnLoad(self)
	if MerchantFrameLootFilter then
		self:SetPoint("RIGHT", MerchantFrameLootFilter, "LEFT", 14, 3)
	else
		self:SetPoint("LEFT", MerchantFramePortrait, "RIGHT", 12, -19)
		self:SetPoint("RIGHT", MerchantFrame, "RIGHT", -12, 0)
	end
end

function VladsVendorFrameSearchMixin:OnHide()
	self.clearButton:Click()
	BagSearch_OnTextChanged(self)
end

function VladsVendorFrameSearchMixin:OnTextChanged()
	SearchBoxTemplate_OnTextChanged(self)
	self:GetList():TriggerEvent(VladsVendorListMixin.Event.Search, self:GetText())
end

function VladsVendorFrameSearchMixin:OnChar()
	BagSearch_OnChar(self)
end

function VladsVendorFrameSearchMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine("Enter an item name to search")
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Type search:", "bop   bou   boe", nil, nil, nil, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "boa  quest", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "l:120  lvl:<120  level:>=120", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "q:epic   q:4", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "t:leather   t:shield", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "n:water   name:water", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "s:heal   set:heal", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "tt:binds   tip:binds   tooltip:binds", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine("Modifiers:", "&   Match both", nil, nil, nil, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "|   Match either", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "!   Do not match", 255, 255, 255, 255, 255, 255)
	GameTooltip:AddDoubleLine(" ", "> < <= >=   Numerical comparisons", 255, 255, 255, 255, 255, 255)
	GameTooltip:Show()
end

function VladsVendorFrameSearchMixin:OnLeave()
	GameTooltip:Hide()
end

function VladsVendorFrameSearchMixin:GetList()
	return self:GetParent().List
end
