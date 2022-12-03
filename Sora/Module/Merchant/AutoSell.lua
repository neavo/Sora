-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function getMoney(money)
    local c = money % 100
    local s = math.floor((money % 10000) / 100)
    local g = math.floor(money / 10000)

    return format(GOLD_AMOUNT_TEXTURE, g, 0, 0) .. " " .. format(SILVER_AMOUNT_TEXTURE, s, 0, 0) .. " " .. format(COPPER_AMOUNT_TEXTURE, c, 0, 0)
end

local function OnMerchantShow(self, event, ...)
    local cost = 0

    for containerIndex = 0, 4 do
        local numSlots = C_Container.GetContainerNumSlots(containerIndex)

        for slot = 1, numSlots do
            local itemLink = C_Container.GetContainerItemLink(containerIndex, slot)

            if itemLink then
                local quality = select(3, GetItemInfo(itemLink))
                local vendorPrice = select(11, GetItemInfo(itemLink))
                local stackCount = C_Container.GetContainerItemInfo(containerIndex, slot).stackCount

                if vendorPrice and vendorPrice > 0 and quality == 0 and stackCount > 0 then
                    C_Container.UseContainerItem(containerIndex, slot)
                    PickupMerchantItem()

                    cost = cost + vendorPrice * stackCount
                end
            end
        end
    end

    if cost > 0 then
        print("|cff70C0F5[Sora's]|r |cffffd700您售出垃圾获得了：|r" .. getMoney(cost))
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.MERCHANT_SHOW = OnMerchantShow
EventHandler:Register()
