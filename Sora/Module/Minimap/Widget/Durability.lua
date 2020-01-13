-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function CreateInstance(parent)
    local instance = CreateFrame("StatusBar", nil, parent)
    instance:SetMinMaxValues(0, 100)
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

function S.Minimap.CreateDurability(parent)
    local instance = CreateInstance(parent)
    instance.datas = {}
    instance.curDurability = 0
    instance.maxDurability = 0

    local function OnTicker()
        instance.datas = {}
        instance.curDurability = 0
        instance.maxDurability = 0

        for i = 1, 18 do
            local link = GetInventoryItemLink("player", i)
            local current, maximum = GetInventoryItemDurability(i)

            if link then
                local data = {}
                data.link = link
                data.current = current
                data.maximum = maximum

                table.insert(instance.datas, data)
                instance.curDurability = instance.curDurability + (current or 0)
                instance.maxDurability = instance.maxDurability + (maximum or 0)
            end
        end

        local value = 100
        if instance.maxDurability > 0 then
            value = instance.curDurability / instance.maxDurability * 100
        end

        instance:SetValue(value)
        instance.text:SetText(("%d%%"):format(value))
    end

    local function OnLeave(self, event, ...)
        GameTooltip:Hide()
    end

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine("耐久：", 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")

        for k, v in pairs(instance.datas) do
            local str = nil

            if not v.current or not v.maximum then
                str = "100%"
            else
                str = ("%d%%"):format(v.current / v.maximum * 100)
            end

            GameTooltip:AddDoubleLine(v.link, str, 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)
        end

        GameTooltip:Show()
    end

    local function OnValueChanged(self, value, ...)
        local _, maxValue = instance:GetMinMaxValues()

        if value < maxValue * 0.25 then
            instance:SetStatusBarColor(1.00, 0.00, 0.00)
        elseif value < maxValue * 0.50 then
            instance:SetStatusBarColor(1.00, 1.00, 0.00)
        else
            instance:SetStatusBarColor(0.00, 0.40, 1.00)
        end
    end

    C_Timer.NewTicker(5.00, OnTicker)
    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnValueChanged", OnValueChanged)

    return instance
end
