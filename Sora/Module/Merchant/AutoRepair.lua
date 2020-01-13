-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function getMoney(money)
	local c = money % 100
	local s = math.floor((money % 10000) / 100)
	local g = math.floor(money / 10000)

	return format(GOLD_AMOUNT_TEXTURE, g, 0, 0) ..
		" " .. format(SILVER_AMOUNT_TEXTURE, s, 0, 0) .. " " .. format(COPPER_AMOUNT_TEXTURE, c, 0, 0)
end

local function OnMerchantShow(self, event, ...)
	if not CanMerchantRepair() then
		return 0
	end

	local cost, canRepair = GetRepairAllCost()

	if cost <= 0 then
		return 0
	end

	if IsInGuild() then
		local guildMoney = GetGuildBankWithdrawMoney()

		if guildMoney > GetGuildBankMoney() then
			guildMoney = GetGuildBankMoney()
		end

		if guildMoney > cost and CanGuildBankRepair() then
			RepairAllItems(1)

			print("|cff70C0F5[Sora's]|r |cffffd700您公会修理花费了：|r" .. getMoney(cost))
		elseif canRepair then
			RepairAllItems(nil)

			print("|cff70C0F5[Sora's]|r |cffffd700您自费修理花费了：|r" .. getMoney(cost))
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.MERCHANT_SHOW = OnMerchantShow
EventHandler:Register()
