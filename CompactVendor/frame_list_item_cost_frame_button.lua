VladsVendorListItemCostButtonMixin = {}

--[[ global ]] VladsVendorListItemCostButtonMixin.Type = {
	Item = 1,
	Money = 2,
}

--[[ global ]] VladsVendorListItemCostButtonMixin.ShowRealMoney = true

local PRICE_FORMAT = "€ %.2f"
local TOKEN_COST = 20
local PRICE_THRESHOLD = 0.1
local function GetCopperPerUnit()
	C_WowTokenPublic.UpdateMarketPrice()
	local price = C_WowTokenPublic.GetCurrentMarketPrice()
	if price then
		return TOKEN_COST / price
	end
end

function VladsVendorListItemCostButtonMixin:OnLoad()
	local font, size, outline = self.Name:GetFont()
	self.Name:SetFont(font, 13, outline)
	local font, size, outline = self.Icon.Count:GetFont()
	self.Icon.Count:SetFont(font, 11, "OUTLINETHICK")
end

function VladsVendorListItemCostButtonMixin:OnEnter()
	if self.item then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(self.item)
		GameTooltip:Show()
	elseif self.money and self.ShowRealMoney then
		local copperPerUnit = GetCopperPerUnit()
		if copperPerUnit then
			local realMoney = copperPerUnit * self.money
			if realMoney > PRICE_THRESHOLD then
				realMoney = format(PRICE_FORMAT, realMoney)
			else
				realMoney = nil
			end
			if realMoney then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:AddLine(realMoney, 1, 1, 1, false)
				GameTooltip:Show()
			end
		end
	end
end

function VladsVendorListItemCostButtonMixin:OnLeave()
	GameTooltip:Hide()
end

function VladsVendorListItemCostButtonMixin:OnClick()
	HandleModifiedItemClick(self.item)
end

function VladsVendorListItemCostButtonMixin:Reset(item, money)
	self:Hide()
	self:SetWidth(16)
	self.Name:SetText()
	self.Icon:Hide()
	self.Icon.Texture:SetTexture()
	self.Icon.Count:SetText()
	self.item, self.money = item, money
end

function VladsVendorListItemCostButtonMixin:GetMoneyString(money, separateThousands, noIcons, colorText, noDenominator)
	local goldString, silverString, copperString

	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD))
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
	local copper = mod(money, COPPER_PER_SILVER)

	local goldFormat, silverFormat, copperFormat
	local colorBlind = ENABLE_COLORBLIND_MODE == "1"

	if noIcons or colorBlind then
		if not noDenominator or colorBlind then
			goldFormat, silverFormat, copperFormat = separateThousands and ("%s" .. GOLD_AMOUNT_SYMBOL) or ("%d" .. GOLD_AMOUNT_SYMBOL), "%d" .. SILVER_AMOUNT_SYMBOL, "%d" .. COPPER_AMOUNT_SYMBOL
		else
			goldFormat, silverFormat, copperFormat = separateThousands and "%s" or "%d", "%d", "%d"
		end
	else
		goldFormat, silverFormat, copperFormat = separateThousands and GOLD_AMOUNT_TEXTURE_STRING or GOLD_AMOUNT_TEXTURE, SILVER_AMOUNT_TEXTURE, COPPER_AMOUNT_TEXTURE
	end

	if separateThousands then
		goldString = goldFormat:format(FormatLargeNumber(gold), 0, 0)
	else
		goldString = goldFormat:format(gold, 0, 0)
	end
	silverString = silverFormat:format(silver, 0, 0)
	copperString = copperFormat:format(copper, 0, 0)

	if colorText then
		if goldString then
			goldString = "|cffffd700" .. goldString .. "|r"
		end
		if silverString then
			silverString = "|cffc7c7cf" .. silverString .. "|r"
		end
		if copperString then
			copperString = "|cffeda55f" .. copperString .. "|r"
		end
	end

	local moneyString = ""
	local separator = ""
	if gold > 0 then
		moneyString = goldString
		separator = " "
	end
	if silver > 0 then
		moneyString = moneyString .. separator .. silverString
		separator = " "
	end
	if copper > 0 or moneyString == "" then
		moneyString = moneyString .. separator .. copperString
	end

	return moneyString
end

function VladsVendorListItemCostButtonMixin:SetAfford(canAfford)
	if canAfford then
		self.Icon.Texture:SetVertexColor(1, 1, 1)
		-- self.Icon.Texture:SetDesaturated(false)
		-- self.Icon.Count:SetTextColor(1, 1, 1)
		-- self.Name:SetTextColor(1, 1, 1)
	else
		self.Icon.Texture:SetVertexColor(1, 0, 0)
		-- self.Icon.Texture:SetDesaturated(true)
		-- self.Icon.Count:SetTextColor(1, 0, 0)
		-- self.Name:SetTextColor(1, 0, 0)
	end
end

function VladsVendorListItemCostButtonMixin:Set(costType, item, parent, pool)
	local cost = self

	if costType == cost.Type.Item then
		cost:Reset()

		local itemCount = GetMerchantItemCostInfo(item.index)

		if not itemCount or itemCount < 1 then
			return false
		end

		local usedCurrencies = 0

		for i = 1, itemCount do -- MAX_ITEM_COST
			local itemTexture, itemValue, itemLink, itemName = GetMerchantItemCostItem(item.index, i)

			if itemTexture then
				usedCurrencies = usedCurrencies + 1

				if usedCurrencies > 1 then
					cost = parent:PopFromPool(pool)
				end

				local itemNumAvailable = GetItemCount(itemLink, true, false)
				if itemNumAvailable == 0 then
					local currencyID
					if C_CurrencyInfo.GetCurrencyIDFromLink then
						currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(itemLink)
					else
						-- TODO: classic
					end
					if currencyID and currencyID > 0 then
						-- TODO: 9.0
						if GetCurrencyInfo then
							local _, currencyNumAvailable = GetCurrencyInfo(currencyID)
							itemNumAvailable = currencyNumAvailable
						else
							local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
							itemNumAvailable = currencyInfo.quantity
						end
					end
				end

				local text = itemValue > 1 and itemValue or "" -- FormatLargeNumber(itemValue)
				cost:Reset(itemLink, item.price)
				cost:SetAfford(itemNumAvailable - itemValue >= 0)
				cost.Icon.Count:SetText(text)
				cost.Icon.Texture:SetTexture(itemTexture)
				cost.Icon:Show()
				cost:Show()

			else
				return true, true
			end
		end

		return usedCurrencies > 0
	end

	if costType == cost.Type.Money then
		local text = self:GetMoneyString(item.price, true, true, true, true)
		cost:Reset(nil, item.price)
		cost:SetAfford(GetMoney() - item.price >= 0)
		cost.Name:SetText(text)
		cost:Show()
		cost:SetWidth(max(16, cost.Name:GetStringWidth() + (text:find("GoldIcon") and 6 or 0) + (text:find("SilverIcon") and 6 or 0) + (text:find("CopperIcon") and 6 or 0)))
		return true
	end

	return false
end
