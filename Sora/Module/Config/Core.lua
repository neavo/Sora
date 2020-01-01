-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local rowSize, btnSize = 32, 24
local width, height, space = 768, 512, 8

-- Initialize
C.Config = C.Config or {}

-- Common
local function GetData(key)
    local data = nil

    for k in string.gmatch(key .. ".", "(.-)%.") do
        if not data then
            data = _G[k]
        elseif tonumber(k) then
            data = data[tonumber(k)]
        else
            data = data[k]
        end
    end

    return data
end

local function CreateSpaceUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize(self.menu:GetWidth() - space * 2, 32)

    return unit
end

local function CreateSliderUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    data.value = GetData(data.key)
    unit.core = S.CreateSlider(unit, 11)
    unit.core:SetLineSize(128, 10)
    unit.core:SetPoint("LEFT", unit, "LEFT", 0, 0)
    unit.core:SetData(data)

    unit:SetSize(self.menu:GetWidth() - space * 2, select(2, unit.core:GetSize()))

    return unit
end

local function CreateButtonUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    unit.core = S.CreateButton(unit)
    unit.core:SetSize(128, 20)
    unit.core:SetPoint("LEFT", unit, "LEFT", 0, 0)
    unit.core:SetScript("OnClick", data.OnClick)

    unit.core.text = S.MakeText(unit.core, 11)
    unit.core.text:SetText(data.text)
    unit.core.text:SetPoint("CENTER", unit.core, "CENTER", 0, 0)

    unit:SetSize(self.menu:GetWidth() - space * 2, select(2, unit.core:GetSize()))

    return unit
end

local function CreatePostionUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    local options = {
        CENTER = "CENTER",
        TOP = "TOP",
        BOTTOM = "BOTTOM",
        LEFT = "LEFT",
        RIGHT = "RIGHT",
        TOPLEFT = "TOPLEFT",
        BOTTOMLEFT = "BOTTOMLEFT",
        TOPRIGHT = "TOPRIGHT",
        TOPRIGHT = "TOPRIGHT"
    }

    unit.core = {}
    data.value = S.Copy(GetData(data.key))

    unit.core.text = S.MakeText(unit, 11)
    unit.core.text:SetText(data.text)
    unit.core.text:SetPoint("TOPLEFT", unit, "TOPLEFT", 0, 0)

    unit.core[1] = S.CreateDropDown(unit, 11)
    unit.core[1]:SetPoint("BOTTOMLEFT", unit, "BOTTOMLEFT", 0, 0)
    unit.core[1]:SetSelectorSize(96, 14)
    unit.core[1]:SetData(
        {
            value = data.value[1],
            options = options
        }
    )
    unit.core[1].OnDataChanged = function(self, d, ...)
        data.value[1] = d.value
        data.OnDataChanged(self, data, ...)
    end

    op = {}
    op[data.value[2]] = data.value[2]
    unit.core[2] = S.CreateDropDown(unit, 11)
    unit.core[2]:SetPoint("LEFT", unit.core[1], "RIGHT", 8, 0)
    unit.core[2]:SetSelectorSize(96, 14)
    unit.core[2]:SetData(
        {
            value = data.value[2],
            options = {[data.value[2]] = data.value[2]}
        }
    )
    unit.core[2].OnDataChanged = function(self, d, ...)
        data.value[2] = d.value
        data.OnDataChanged(self, data, ...)
    end

    unit.core[3] = S.CreateDropDown(unit, 11)
    unit.core[3]:SetPoint("LEFT", unit.core[2], "RIGHT", 8, 0)
    unit.core[3]:SetSelectorSize(96, 14)
    unit.core[3]:SetData(
        {
            value = data.value[3],
            options = options
        }
    )
    unit.core[3].OnDataChanged = function(self, d, ...)
        data.value[3] = d.value
        data.OnDataChanged(self, data, ...)
    end

    unit.core[4] = S.CreateEditBox(unit, 11)
    unit.core[4]:SetBTNSize(24, 14)
    unit.core[4]:SetEditBoxSize(48, 14)
    unit.core[4]:SetData(
        {
            value = data.value[4]
        }
    )
    unit.core[4].OnDataChanged = function(self, d, ...)
        if tonumber(d.value) then
            data.value[4] = tonumber(d.value)
            data.OnDataChanged(self, data, ...)
        end
    end

    unit.core[4].text = S.MakeText(unit.core[4], 11)
    unit.core[4].text:SetText("横轴偏移量")

    unit.core[4].text:SetPoint("LEFT", unit.core[3], "RIGHT", 8, 0)
    unit.core[4]:SetPoint("LEFT", unit.core[4].text, "RIGHT", 4, 0)

    unit.core[5] = S.CreateEditBox(unit, 11)
    unit.core[5]:SetBTNSize(24, 14)
    unit.core[5]:SetEditBoxSize(48, 14)
    unit.core[5]:SetData(
        {
            value = data.value[5]
        }
    )
    unit.core[5].OnDataChanged = function(self, d, ...)
        if tonumber(d.value) then
            data.value[5] = tonumber(d.value)
            data.OnDataChanged(self, data, ...)
        end
    end

    unit.core[5].text = S.MakeText(unit.core[5], 11)
    unit.core[5].text:SetText("纵轴偏移量")

    unit.core[5].text:SetPoint("LEFT", unit.core[4], "RIGHT", 8, 0)
    unit.core[5]:SetPoint("LEFT", unit.core[5].text, "RIGHT", 4, 0)

    unit:SetSize(self.menu:GetWidth() - space * 2, unit.core.text:GetHeight() + 8 + select(2, unit.core[1]:GetSize()))

    return unit
end

local function CreateEditBoxUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    data.value = GetData(data.key)
    unit.core = S.CreateEditBox(unit, 11)
    unit.core:SetData(data)
    unit.core:SetBTNSize(24, 14)
    unit.core:SetEditBoxSize(48, 14)

    unit.core.text = S.MakeText(unit.core, 11)
    unit.core.text:SetText(data.text)

    unit.core.text:SetPoint("LEFT", unit, "LEFT", 0, 0)
    unit.core:SetPoint("LEFT", unit.core.text, "RIGHT", 8, 0)

    unit:SetSize(self.menu:GetWidth() - space * 2, select(2, unit.core:GetSize()))

    return unit
end

local function CreateDropDownUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    data.value = GetData(data.key)
    unit.core = S.CreateDropDown(unit, 11)
    unit.core:SetPoint("LEFT", unit, "LEFT", 0, 0)
    unit.core:SetSelectorSize(96, 16)
    unit.core:SetData(data)
    unit.core.OnDataChanged = data.OnDataChanged

    unit.core.text = S.MakeText(unit.core, 11)
    unit.core.text:SetText(data.text)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", 8, 0)

    unit:SetSize(self.menu:GetWidth() - space * 2, select(2, unit.core:GetSize()))

    return unit
end

local function CreateCheckBoxUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)

    data.value = GetData(data.key)
    unit.core = S.CreateCheckBox(unit)
    unit.core:SetPoint("LEFT", unit, "LEFT", 0, 0)
    unit.core:SetBoxSize(14, 14)
    unit.core:SetData(data)
    unit.core.OnDataChanged = data.OnDataChanged

    unit.core.text = S.MakeText(unit.core, 11)
    unit.core.text:SetText(data.text)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", 8, 0)

    unit:SetSize(self.menu:GetWidth() - space * 2, select(2, unit.core:GetSize()))

    return unit
end

local function CreateMenuUnit(self, data)
    local unit = nil

    if data.type == "space" then
        unit = CreateSpaceUnit(self, data)
    elseif data.type == "slider" then
        unit = CreateSliderUnit(self, data)
    elseif data.type == "button" then
        unit = CreateButtonUnit(self, data)
    elseif data.type == "postion" then
        unit = CreatePostionUnit(self, data)
    elseif data.type == "editbox" then
        unit = CreateEditBoxUnit(self, data)
    elseif data.type == "dropdown" then
        unit = CreateDropDownUnit(self, data)
    elseif data.type == "checkbox" then
        unit = CreateCheckBoxUnit(self, data)
    end

    return unit
end

local function UpdateMenu(self, data)
    local menu = self.menu

    menu.units = menu.units or {}
    for k, v in pairs(menu.units) do
        S.KillFrame(v)
    end
    table.wipe(menu.units)

    for k, v in pairs(data.Menu) do
        local unit = CreateMenuUnit(self, v)

        if k == 1 then
            unit:SetPoint("TOP", menu, "TOP", 0, -space)
        else
            unit:SetPoint("TOP", menu.units[k - 1], "BOTTOM", 0, -space * 1.5)
        end

        table.insert(menu.units, unit)
    end
end

local function CreateTabUnit(self, data)
    local unit = S.CreateButton(self.tab)
    unit:SetSize(self.tab:GetWidth() - space * 2, btnSize)

    unit.text = S.MakeText(unit, 12)
    unit.text:SetText(data.Tab.text)
    unit.text:SetPoint("CENTER", unit, "CENTER", 0, 0)

    local function OnClick(_, btn, ...)
        UpdateMenu(self, data)
    end

    unit:SetScript("OnClick", OnClick)

    return unit
end

local function UpdateTab(self, data)
    local tab = self.tab

    tab.units = tab.units or {}
    for k, v in pairs(tab.units) do
        S.KillFrame(v)
    end
    table.wipe(tab.units)

    for k, v in pairs(data) do
        local unit = CreateTabUnit(self, v)

        if #tab.units == 0 then
            unit:SetPoint("TOP", tab, "TOP", 0, -space)
        else
            unit:SetPoint("TOP", tab.units[#tab.units], "BOTTOM", 0, -space)
        end

        table.insert(tab.units, unit)
    end
end

-- Tab
local function CreateTab(self)
    local tab = CreateFrame("Frame", nil, self)
    tab:SetSize(btnSize * 6, height)
    tab:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
    tab:SetFrameLevel(self:GetFrameLevel())

    tab.bg = tab:CreateTexture(nil, "BORDER")
    tab.bg:SetAllPoints()
    tab.bg:SetTexture(DB.Backdrop)
    tab.bg:SetVertexColor(0.12, 0.12, 0.12, 0.50)

    tab.shadow = S.MakeShadow(tab, 2)
    tab.shadow:SetFrameLevel(self:GetFrameLevel())

    self.tab = tab
end

-- Menu
local function CreateMenu(self)
    local menu = CreateFrame("Frame", nil, self)
    menu:SetSize(width - btnSize * 6 - space, height)
    menu:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    menu:SetFrameLevel(self:GetFrameLevel())

    menu.bg = menu:CreateTexture(nil, "BORDER")
    menu.bg:SetAllPoints()
    menu.bg:SetTexture(DB.Backdrop)
    menu.bg:SetVertexColor(0.12, 0.12, 0.12, 0.50)

    menu.shadow = S.MakeShadow(menu, 2)
    menu.shadow:SetFrameLevel(self:GetFrameLevel())

    self.menu = menu
end

-- Title
local function CreateTitle(self)
    local title = CreateFrame("Frame", nil, self)
    title:SetSize(width - btnSize * 2 - space * 2, btnSize)
    title:SetPoint("BOTTOM", self, "TOP", 0, space)
    title:SetFrameLevel(self:GetFrameLevel())

    title.bg = title:CreateTexture(nil, "BORDER")
    title.bg:SetAllPoints()
    title.bg:SetTexture(DB.Backdrop)
    title.bg:SetVertexColor(0.12, 0.12, 0.12, 0.50)

    title.shadow = S.MakeShadow(title, 2)
    title.shadow:SetFrameLevel(self:GetFrameLevel())

    title.text = S.MakeText(title, 14)
    title.text:SetText("|cff70C0F5Sora's|r Config - 点击左上角按钮重载UI后设置生效")
    title.text:SetPoint("CENTER", title, "CENTER", 0, 0)

    self.title = title
end

-- Close
local function CreateClose(self)
    local close = S.CreateButton(self)
    close:SetSize(btnSize, btnSize)
    close:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, space)

    close.text = S.MakeText(close, 20)
    close.text:SetText("×")
    close.text:SetPoint("CENTER", close, "CENTER", 0, 0)

    local function OnClick(_, btn, ...)
        self:Hide()
    end

    close:SetScript("OnClick", OnClick)

    self.close = close
end

-- Reload
local function CreateReload(self)
    local reload = S.CreateButton(self)
    reload:SetSize(btnSize, btnSize)
    reload:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, space)

    reload.text = S.MakeText(reload, 11.5)
    reload.text:SetText("重")
    reload.text:SetPoint("CENTER", reload, "CENTER", 0, 0)

    local function OnClick(_, btn, ...)
        ReloadUI()
    end

    reload:SetScript("OnClick", OnClick)

    self.reload = reload
end

-- GameMenuButton
local function CreateGameMenuButton(self)
    local btn = S.CreateButton(GameMenuFrame)
    btn:SetSize(GameMenuButtonAddons:GetSize())
    btn:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -4)

    btn.text = S.MakeText(btn, 13)
    btn.text:SetText("|cff70C0F5Sora's|r Config")
    btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0)

    local function OnShow(self, ...)
        self:SetHeight(self:GetHeight() + 4)
        GameMenuButtonLogout:SetPoint("TOP", btn, "BOTTOM", 0, -4)
    end

    GameMenuFrame:HookScript("OnShow", OnShow)

    local function OnClick(_, ...)
        self:Show()
        HideUIPanel(GameMenuFrame)
    end

    btn:SetScript("OnClick", OnClick)
end

-- Begin
local function CreateInstance(parent)
    local instance = CreateFrame("Frame", "SoraConfig", parent)

    CreateTab(instance)
    CreateMenu(instance)
    CreateTitle(instance)
    CreateClose(instance)
    CreateReload(instance)
    CreateGameMenuButton(instance)

    return instance
end

-- Event
local function OnShow(self, ...)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)

    local tabs = {}
    for k, v in pairs(C.Config) do
        table.insert(tabs, v)
    end

    local function OnSort(l, r)
        local flag = false

        if l.Tab.index and not r.Tab.index then
            flag = true
        elseif not l.Tab.index and r.Tab.index then
            flag = false
        elseif not l.Tab.index and not r.Tab.index then
            flag = false
        else
            flag = l.Tab.index < r.Tab.index
        end

        return flag
    end
    table.sort(tabs, OnSort)

    UpdateTab(self, tabs)
    UpdateMenu(self, tabs[1])
end

local function OnHide(self, ...)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
end

local function OnPlayerLogin(self, event, ...)
    local instance = CreateInstance(UIParent)

    instance:Hide()
    instance:SetSize(width, height)
    instance:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    instance:SetFrameStrata("DIALOG")

    instance:SetScript("OnShow", OnShow)
    instance:SetScript("OnHide", OnHide)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
