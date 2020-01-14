-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function CreateInstance(parent)
    local instance = CreateFrame("StatusBar", nil, parent)
    instance:SetMinMaxValues(0, 999999)
    instance:SetStatusBarTexture(DB.Statusbar)
    instance:SetStatusBarColor(0.00, 0.40, 1.00)

    instance.text = S.MakeText(instance, 10)
    instance.text:SetText("N/A")
    instance.text:SetPoint("CENTER", 0, 4)

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(instance:GetFrameLevel())

    instance.bg = instance:CreateTexture(nil, "BACKGROUND")
    instance.bg:SetTexture(DB.Statusbar)
    instance.bg:SetAllPoints()
    instance.bg:SetVertexColor(0.12, 0.12, 0.12)

    return instance
end

function S.Minimap.CreateCurrency(parent)
    local instance = CreateInstance(parent)

    local function FormatMoney(money)
        local c = money % 100
        local s = math.floor((money % 10000) / 100)
        local g = math.floor(money / 10000)

        return format(GOLD_AMOUNT_TEXTURE, g, 0, 0) ..
            " " .. format(SILVER_AMOUNT_TEXTURE, s, 0, 0) .. " " .. format(COPPER_AMOUNT_TEXTURE, c, 0, 0)
    end

    local function OnTicker()
        local money = floor(GetMoney() / 100 / 100)

        instance:SetValue(money)
        instance.text:SetText(("%s|cffffd700G|r"):format(S.FormatInteger(money)))
    end

    local function OnLeave(self, event, ...)
        GameTooltip:Hide()
    end

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")

        GameTooltip:AddLine("货币：", 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("金币：", FormatMoney(GetMoney()), 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)

        local start = false
        for i = 1, GetCurrencyListSize() do
            local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(i)

            if start and isHeader then
                break
            end

            if not isHeader and not isUnused then
                start = true
                local iconStr = "|T" .. icon .. ":13:15:0:0:50:50:4:46:4:46|t"
                GameTooltip:AddDoubleLine(name .. "：", count .. " " .. iconStr, 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)
            end
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("提示：自动监视第一个未折叠的货币分类", 1.00, 0.84, 0.00)
        GameTooltip:Show()
    end

    C_Timer.NewTicker(5.00, OnTicker)
    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)

    return instance
end
