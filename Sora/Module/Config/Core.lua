-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local rowSize, btnSize = 48, 24
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
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    return unit
end

local function CreateSliderUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    data.value = GetData(data.key)
    unit.core = S.CreateSlider(unit, 11)
    unit.core:SetData(data)
    unit.core:SetPoint("CENTER", unit, "CENTER", 0, 0)
    unit.core:SetLineSize(128, 10)

    return unit
end

local function CreateButtonUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    unit.core = S.CreateButton(unit, 12)
    unit.core:SetSize(150, 20)
    unit.core:SetText(data.text)
    unit.core:SetPoint("CENTER", unit, "CENTER", 0, 0)
    unit.core:SetScript("OnClick", data.OnClick)

    return unit
end

local function CreateEditBoxUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    data.value = GetData(data.key)
    unit.core = S.CreateEditBox(unit, 11)
    unit.core:SetData(data)
    unit.core:SetBTNSize(24, 14)
    unit.core:SetEditBoxSize(48, 14)

    unit.core.text = S.MakeText(unit.core, 11)
    unit.core.text:SetText(data.text)

    unit.core.text:SetPoint("LEFT", unit, "LEFT", space, 0)
    unit.core:SetPoint("LEFT", unit.core.text, "RIGHT", space, 0)

    return unit
end

local function CreateDropDownUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    data.value = GetData(data.key)
    unit.core = S.CreateDropDown(unit, 12)
    unit.core:SetData(data)
    unit.core:SetSelectorSize(128, 18)

    unit.core.text = S.MakeText(unit.core, 12)
    unit.core.text:SetText(data.text)

    unit.core:SetPoint("CENTER", unit, "CENTER", -(unit.core.text:GetWidth() + space) / 2, 0)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", space, 0)

    return unit
end

local function CreateCheckBoxUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - space * 2 - space) / 2, rowSize)

    data.value = GetData(data.key)
    unit.core = S.CreateCheckBox(unit)
    unit.core:SetData(data)
    unit.core:SetPoint("CENTER", unit, "CENTER", 0, 0)
    unit.core:SetBoxSize(14, 14)

    unit.core.text = S.MakeText(unit.core, 12)
    unit.core.text:SetText(data.text)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", space, 0)

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

    local height = 0
    for k, v in pairs(data.Menu) do
        local unit = CreateMenuUnit(self, v)

        if k == 1 then
            height = height + space + unit:GetHeight()
            unit:SetPoint("TOPLEFT", menu, "TOPLEFT", space, -space)
        elseif mod(k, 2) == 0 then
            unit:SetPoint("LEFT", menu.units[k - 1], "RIGHT", space, 0)
        else
            height = height + space * 2 + unit:GetHeight()
            unit:SetPoint("TOP", menu.units[k - 2], "BOTTOM", 0, -space * 2)
        end

        table.insert(menu.units, unit)
    end

    menu:SetSize(width - btnSize * 6 - space, height + space)
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
    tab.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

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

    local scroll = CreateFrame("ScrollFrame", nil, self, "UIPanelScrollFrameTemplate")
    scroll:SetSize(width - btnSize * 6 - space, height)
    scroll:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    scroll:SetScrollChild(menu)

    scroll.shadow = S.MakeShadow(scroll, 2)
    scroll.shadow:SetFrameLevel(self:GetFrameLevel())

    scroll.shadow.bg = scroll.shadow:CreateTexture(nil, "BORDER")
    scroll.shadow.bg:SetAllPoints()
    scroll.shadow.bg:SetTexture(DB.Backdrop)
    scroll.shadow.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    if AuroraClassic then
        AuroraClassic[1].ReskinScroll(scroll.ScrollBar)
    end

    local function OnShow(self, ...)
        if not self:GetScrollChild() then
            return 0
        end

        if self:GetHeight() > self:GetScrollChild():GetHeight() then
            self.ScrollBar:Show()
        else
            self.ScrollBar:Hide()
        end
    end

    scroll:SetScript("OnShow", OnShow)

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
    title.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    title.shadow = S.MakeShadow(title, 2)
    title.shadow:SetFrameLevel(self:GetFrameLevel())

    title.text = S.MakeText(title, 14)
    title.text:SetText("|cff70C0F5Sora's|r Config - 设置选项将在点击左上角按钮重载UI后生效")
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
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

    local btn = CreateFrame("Button", nil, GameMenuFrame)
    btn:SetSize(GameMenuButtonAddons:GetSize())
    btn:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -4)

    btn.bg = btn:CreateTexture(nil, "BORDER")
    btn.bg:SetAllPoints()
    btn.bg:SetTexture(DB.Backdrop)
    btn.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    btn.text = S.MakeText(btn, 12.5)
    btn.text:SetText("|cff70C0F5Sora's|r Config")
    btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0)

    btn.shadow = S.MakeBorder(btn, 1)
    btn.shadow:SetFrameLevel(btn:GetFrameLevel())

    local function OnClick(_, ...)
        if not InCombatLockdown() then
            self:Show()
            HideUIPanel(GameMenuFrame)
        else
            PlaySound(SOUNDKIT.RAID_WARNING, "Master")
            print("|cff70C0F5[Sora's]|r 无法在战斗时打开设置面板！")
        end
    end

    local function OnEnter(self, ...)
        self.bg:SetVertexColor(r / 4, g / 4, b / 4, 0.50)
        self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        self.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    btn:SetScript("OnLeave", OnLeave)
    btn:SetScript("OnEnter", OnEnter)
    btn:SetScript("OnClick", OnClick)

    local function OnShow(self, ...)
        self:SetHeight(self:GetHeight() + btn:GetHeight() + 4)
        GameMenuButtonLogout:SetPoint("TOP", btn, "BOTTOM", 0, -4)
    end
    GameMenuFrame:HookScript("OnShow", OnShow)
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

    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION, "Master")
end

local function OnHide(self, ...)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION, "Master")
end

local function OnDragStop(self, ...)
    self:StopMovingOrSizing()
end

local function OnDragStart(self, ...)
    self:StartMoving()
end

local function OnPlayerLogin(self, event, ...)
    local instance = CreateInstance(UIParent)

    instance:Hide()
    instance:SetSize(width, height)
    instance:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    instance:SetMovable(true)
    instance:EnableMouse(true)
    instance:SetToplevel(true)
    instance:SetFrameStrata("DIALOG")
    instance:RegisterForDrag("LeftButton")
    instance:SetClampedToScreen(true)

    instance:SetScript("OnShow", OnShow)
    instance:SetScript("OnHide", OnHide)
    instance:SetScript("OnDragStop", OnDragStop)
    instance:SetScript("OnDragStart", OnDragStart)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
