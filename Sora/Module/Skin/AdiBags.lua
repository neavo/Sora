-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function SkinBag()
	if not AdiBagsContainer1 then
		return 0
	end

	for i = 1, 999 do
		local btn = _G["AdiBagsItemButton" .. i]

		if not btn then
			break
		end

		if not btn.__skined then
			btn.shadow = S.MakeShadow(btn, 2)
			btn.shadow:SetFrameLevel(btn:GetFrameLevel())

			local p = C.Core.Pixel or 1.00
			local count = _G["AdiBagsItemButton" .. i .. "Count"]
			count:SetPoint("BOTTOMRIGHT", 0, 0)
			count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
			count:SetShadowOffset(1.00 * p, -1.00 * p)
			count:SetShadowColor(0.00, 0.00, 0.00, 0.50)

			S.KillFrame(_G["AdiBagsItemButton" .. i .. "NormalTexture"])
			S.KillFrame(_G["AdiBagsItemButton" .. i .. "IconQuestTexture"])
		end

		local itemid = btn.itemId
		local itemName, itemLink, itemRarity = GetItemInfo(itemid or 6948)
		local r, g, b = GetItemQualityColor(itemRarity)

		btn.__skined = true
		btn.shadow:SetBackdropBorderColor(r, g, b, 1.00)
	end
end

local function SkinBank()
	if not AdiBagsContainer2 then
		return 0
	end

	for i = 1, 999 do
		local btn = _G["AdiBagsBankItemButton" .. i]

		if not btn then
			break
		end

		if not btn.__skined then
			btn.shadow = S.MakeShadow(btn, 2)

			local p = C.Core.Pixel or 1.00
			local count = _G["AdiBagsBankItemButton" .. i .. "Count"]
			count:SetPoint("BOTTOMRIGHT", 0, 0)
			count:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
			count:SetShadowOffset(1.00 * p, -1.00 * p)
			count:SetShadowColor(0.00, 0.00, 0.00, 0.50)

			S.KillFrame(_G["AdiBagsBankItemButton" .. i .. "NormalTexture"])
			S.KillFrame(btn.IconQuestTexture)
		end

		local itemid = btn.itemId
		local itemName, itemLink, itemRarity = GetItemInfo(itemid or 6948)
		local r, g, b = GetItemQualityColor(itemRarity)

		btn.__skined = true
		btn.shadow:SetBackdropBorderColor(r, g, b, 1.00)
	end
end

-- Event
local function OnBagUpdate(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	C_Timer.NewTicker(0.25, SkinBag, 1)
	C_Timer.NewTicker(0.25, SkinBank, 1)
end

local function OnPlayerLogin(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	for i = 1, 2 do
		local function OnTicker(self, ...)
			local container = _G["AdiBagsContainer" .. i]

			if not container then
				return 0
			end

			self:Cancel()

			if 1 == 1 then
				SkinBag()
			elseif i == 2 then
				SkinBank()
			end

			container.shadow = S.MakeShadow(container, 2)
			container.shadow:SetFrameLevel(container:GetFrameLevel())
			container.shadow:SetBackdropBorderColor(1.00, 1.00, 1.00, 1.00)
		end

		C_Timer.NewTicker(1.00, OnTicker)
	end
end

local function OnBankFrameOpened(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	C_Timer.NewTicker(0.25, SkinBank, 1)
end

local function OnGuildBankFrameOpened(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	C_Timer.NewTicker(0.25, SkinBank, 1)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.BAG_UPDATE = OnBagUpdate
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.BANKFRAME_OPENED = OnBankFrameOpened
-- EventHandler.Event.GUILDBANKFRAME_OPENED = OnGuildBankFrameOpened
EventHandler.Register()
