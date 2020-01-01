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
    local cost = 0

    for container = 0, 4 do
        local numSlots = GetContainerNumSlots(container)

        for slot = 1, numSlots do
            local link = GetContainerItemLink(container, slot)

            if link then
                local quality = select(3, GetItemInfo(link))
                local vendorPrice = select(11, GetItemInfo(link))
                local count = select(2, GetContainerItemInfo(container, slot))

                if vendorPrice and vendorPrice > 0 and count > 0 and quality == 0 then
                    UseContainerItem(container, slot)
                    PickupMerchantItem()

                    cost = cost + vendorPrice * count
                end
            end
        end
    end

    if cost > 0 then
        print("|cff70C0F5[Sora's]|r |cffffff00您售出垃圾获得了：|r" .. getMoney(cost))
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.MERCHANT_SHOW = OnMerchantShow
EventHandler:Register()
