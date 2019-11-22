-- Engine
-- local S, C, L, DB = unpack(select(2, ...))

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("MERCHANT_SHOW")
Event:SetScript("OnEvent", function(self, ...)
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
        local g, s, c = math.floor(cost / 10000) or 0, math.floor((cost % 10000) / 100) or 0, cost % 100
        DEFAULT_CHAT_FRAME:AddMessage("共售出：" .. g .. "|cffffc125G|r " .. s .. "|cffc7c7cfS|r " .. c .. "|cffeda55fC|r", 255, 255, 255)
    end
end)
