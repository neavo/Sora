-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function CreateIcons(instance)
    local perRow = C.Minimap.IconDrawerPerRow
    local size = (Minimap:GetWidth() - 4 * (perRow - 1)) / perRow

    local datas = {}
    for k, v in pairs(_G) do
        if string.match(k, "LibDBIcon10_") and v:GetObjectType() == "Button" then
            local regions = {v:GetRegions()}

            for x, y in pairs(regions) do
                if y ~= v.icon then
                    S.KillFrame(y)
                end
            end

            table.insert(datas, v)
        end
    end

    if #datas == 0 then
        return 0
    end

    instance.container:SetFrameLevel(datas[1]:GetFrameLevel() - 2)
    instance.container.shadow:SetFrameLevel(instance.container:GetFrameLevel())

    local function OnEnter(self, ...)
        local text = instance.container:IsVisible() and "点击收起" or "点击展开"

        GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 4)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(text, 0.75, 0.90, 1.00)
        GameTooltip:Show()
    end

    local function OnLeave(self, ...)
        GameTooltip:Hide()
    end

    local function OnClick(self, key, ...)
        if instance.container:IsVisible() then
            self:SetText("+")
            instance.container:Hide()
        else
            self:SetText("×")
            instance.container:Show()
        end
    end

    local data = {}
    data.text = "+"
    data.OnEnter = OnEnter
    data.OnLeave = OnLeave
    data.OnClick = OnClick
    table.insert(datas, perRow, data)

    local icons = {}
    for k, v in pairs(datas) do
        local parent = k <= perRow and instance or instance.container

        local icon = S.CreateButton(parent, 20)
        icon:SetSize(size, size)
        icon:SetFrameStrata("MEDIUM")
        icon:SetFrameLevel(parent:GetFrameLevel() + 1)

        if v.text then
            icon:SetText(v.text)
            icon:HookScript("OnEnter", v.OnEnter)
            icon:HookScript("OnLeave", v.OnLeave)
            icon:HookScript("OnClick", v.OnClick)
        else
            local function OnEnter(self, ...)
                local r, g, b = S.GetClassColor()

                icon.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
                icon.shadow:SetBackdropBorderColor(r, g, b, 1.00)
            end

            local function OnLeave(self, ...)
                icon.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
                icon.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
            end

            v:ClearAllPoints()
            v:SetSize(size, size)
            v:SetPoint("CENTER", icon, -2, 0)
            v:SetParent(icon)
            v:RegisterForDrag(nil)
            v:HookScript("OnEnter", OnEnter)
            v:HookScript("OnLeave", OnLeave)
        end

        if C.Minimap.IconDrawerSide == 1 then
            if k == 1 then
                icon:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 4, 0)
            elseif mod(k, perRow) == 1 then
                icon:SetPoint("TOPRIGHT", icons[k - perRow], "TOPLEFT", -4, 0)
            else
                icon:SetPoint("TOP", icons[k - 1], "BOTTOM", 0, -4)
            end
        elseif C.Minimap.IconDrawerSide == 2 then
            if k == 1 then
                icon:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -4, 0)
            elseif mod(k, perRow) == 1 then
                icon:SetPoint("TOPLEFT", icons[k - perRow], "TOPRIGHT", 4, 0)
            else
                icon:SetPoint("TOP", icons[k - 1], "BOTTOM", 0, -4)
            end
        end

        table.insert(icons, icon)
    end
end

local function CreateInstance(parent)
    local instance = CreateFrame("Frame", nil, parent)

    instance.container = CreateFrame("Frame", nil, parent)
    instance.container:Hide()
    instance.container:EnableMouse(true)
    instance.container:SetAllPoints()
    instance.container:SetFrameStrata("MEDIUM")

    instance.container.bg = instance.container:CreateTexture(nil, "BORDER")
    instance.container.bg:SetAllPoints()
    instance.container.bg:SetTexture(DB.Backdrop)
    instance.container.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
    instance.container.shadow = S.MakeShadow(instance.container, 2)

    return instance
end

-- Event
local function OnPlayerLogin(self, event, ...)
    local instance = CreateInstance(Minimap)

    CreateIcons(instance)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
