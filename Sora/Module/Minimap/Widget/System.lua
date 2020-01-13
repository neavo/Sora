-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
S.Minimap = S.Minimap or {}

-- Common
local function CreateInstance(parent)
    local instance = CreateFrame("StatusBar", nil, parent)
    instance:SetMinMaxValues(0, 144)
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

function S.Minimap.CreateSystem(parent)
    local instance = CreateInstance(parent)
    instance.mode = 1

    local function OnTicker()
        if instance.mode == 1 then
            local value = GetFramerate()

            instance:SetValue(value)
            instance:SetMinMaxValues(0, 144)
            instance.text:SetText(("%.2f|cffffd700FPS|r"):format(value))
        elseif instance.mode == 2 then
            local _, _, latencyHome, latencyWorld = GetNetStats()
            local value = max(latencyHome, latencyWorld)

            instance:SetValue(value)
            instance:SetMinMaxValues(0, 200)
            instance.text:SetText(("%d|cffffd700ms|r"):format(value))
        end
    end

    local function OnLeave(self, event, ...)
        GameTooltip:Hide()
    end

    local function OnEnter(self, ...)
        GameTooltip:SetOwner(instance, "ANCHOR_BOTTOMRIGHT")

        local framerate = GetFramerate()
        local _, _, latencyHome, latencyWorld = GetNetStats()

        GameTooltip:AddLine("系统：", 0.44, 0.75, 0.96)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("本地延迟：", latencyHome .. "|cffffd700ms|r", 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)
        GameTooltip:AddDoubleLine("世界延迟：", latencyWorld .. "|cffffd700ms|r", 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)
        GameTooltip:AddDoubleLine("实时帧数：", ("%.2f|cffffd700FPS|r"):format(framerate), 0.90, 0.90, 0.90, 0.90, 0.90, 0.90)

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("提示：左键点击切换 帧率/延迟 显示", 1.00, 0.84, 0.00)
        GameTooltip:Show()
    end

    local function OnMouseDown(self, ...)
        instance.mode = instance.mode == 1 and 2 or 1

        OnTicker()
    end

    C_Timer.NewTicker(1.00, OnTicker)
    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnMouseDown", OnMouseDown)

    return instance
end
