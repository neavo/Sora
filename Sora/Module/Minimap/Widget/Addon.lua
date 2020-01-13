-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function CreateInstance(parent)
    local instance = CreateFrame("StatusBar", nil, parent)
    instance:SetMinMaxValues(0, 128 * 1024)
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

function S.Minimap.CreateAddon(parent)
    local instance = CreateInstance(parent)
    instance.addons = {}

    local function OnTicker()
        instance.addons = {}
        UpdateAddOnMemoryUsage()

        for i = 1, GetNumAddOns() do
            local addon = {}

            addon.isLoaded = IsAddOnLoaded(i)
            addon.addonName = select(2, GetAddOnInfo(i))
            addon.addonMemory = GetAddOnMemoryUsage(i)

            table.insert(instance.addons, addon)
        end

        local function OnSort(l, r)
            local result = false

            if l.addonMemory and r.addonMemory then
                result = l.addonMemory > r.addonMemory
            elseif l.addonMemory and not r.addonMemory then
                result = true
            elseif not l.addonMemory and r.addonMemory then
                result = false
            elseif not l.addonMemory and not r.addonMemory then
                result = false
            end

            return result
        end
        table.sort(instance.addons, OnSort)

        local curMemory = 0
        for k, v in pairs(instance.addons) do
            curMemory = curMemory + v.addonMemory
        end

        instance:SetValue(curMemory)
        instance.text:SetText(S.FormatMemory(curMemory))
    end

    local function OnLeave(self, event, ...)
        GameTooltip:Hide()
    end

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")

        local curMemory = 0
        for k, v in pairs(instance.addons) do
            curMemory = curMemory + v.addonMemory
        end

        GameTooltip:AddDoubleLine("合计：", S.FormatMemory(curMemory), 0.44, 0.75, 0.96, 0.10, 0.90, 0.10)
        GameTooltip:AddLine(" ")

        for k, v in pairs(instance.addons) do
            if v.isLoaded then
                curMemory = curMemory + v.addonMemory
                GameTooltip:AddDoubleLine(v.addonName, S.FormatMemory(v.addonMemory), 0.90, 0.90, 0.90, 0.10, 0.90, 0.10)
            end
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("提示：左键点击回收插件内存", 1.00, 0.84, 0.00)
        GameTooltip:Show()
    end

    local function OnMouseDown(self, ...)
        local before = gcinfo()

        collectgarbage()
        print("|cff70C0F5[Sora's]|r |cffffd700您回收了插件内存：|r" .. S.FormatMemory(before - gcinfo()))

        OnTicker()
    end

    local function OnValueChanged(self, value, ...)
        local _, maxValue = instance:GetMinMaxValues()

        if value > maxValue * 0.75 then
            instance:SetStatusBarColor(1.00, 0.00, 0.00)
        elseif value > maxValue * 0.50 then
            instance:SetStatusBarColor(1.00, 1.00, 0.00)
        else
            instance:SetStatusBarColor(0.00, 0.40, 1.00)
        end
    end

    C_Timer.NewTicker(5.00, OnTicker)
    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnMouseDown", OnMouseDown)
    instance:SetScript("OnValueChanged", OnValueChanged)

    return instance
end
