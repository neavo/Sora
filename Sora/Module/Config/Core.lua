-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

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
    unit:SetSize((self.menu:GetWidth() - 12 * 2 - 12) / 2, 48)

    return unit
end

local function CreateSliderUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - 12 * 2 - 12) / 2, 48)

    data.value = GetData(data.key)
    unit.core = S.CreateSlider(unit, 11)
    unit.core:SetData(data)
    unit.core:SetPoint("CENTER", unit, "CENTER", 0, 0)
    unit.core:SetLineSize(128, 10)

    return unit
end

local function CreateButtonUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - 12 * 2 - 12) / 2, 48)

    unit.core = S.CreateButton(unit, 12)
    unit.core:SetSize(150, 20)
    unit.core:SetText(data.text)
    unit.core:SetPoint("CENTER", unit, "CENTER", 0, 0)
    unit.core:HookScript("OnClick", data.OnClick)

    return unit
end

local function CreateDropDownUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - 12 * 2 - 12) / 2, 48)

    data.value = GetData(data.key)
    unit.core = S.CreateDropDown(unit, 12)
    unit.core:SetData(data)
    unit.core:SetSelectorSize(128, 18)

    unit.core.text = S.MakeText(unit.core, 12)
    unit.core.text:SetText(data.text)

    unit.core:SetPoint("CENTER", unit, "CENTER", -(unit.core.text:GetWidth() + 12) / 2, 0)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", 12, 0)

    return unit
end

local function CreateCheckBoxUnit(self, data)
    local unit = CreateFrame("Frame", nil, self.menu)
    unit:SetSize((self.menu:GetWidth() - 12 * 2 - 12) / 2, 48)

    data.value = GetData(data.key)
    unit.core = S.CreateCheckBox(unit)
    unit.core:SetData(data)
    unit.core:SetBoxSize(14, 14)

    unit.core.text = S.MakeText(unit.core, 12)
    unit.core.text:SetText(data.text)

    unit.core:SetPoint("CENTER", unit, "CENTER", -(unit.core.text:GetWidth() + 12) / 2, 0)
    unit.core.text:SetPoint("LEFT", unit.core, "RIGHT", 12, 0)

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
            unit:SetPoint("TOPLEFT", menu, "TOPLEFT", 12, -12)
        elseif mod(k, 2) == 0 then
            unit:SetPoint("LEFT", menu.units[k - 1], "RIGHT", 12, 0)
        else
            unit:SetPoint("TOP", menu.units[k - 2], "BOTTOM", 0, -12)
        end

        table.insert(menu.units, unit)
    end
end

local function CreateTabUnit(self, data)
    local unit = S.CreateButton(self.tab)
    unit:SetSize(self.tab:GetWidth() - 12 * 2, 24)

    unit.text = S.MakeText(unit, 12)
    unit.text:SetText(data.Tab.text)
    unit.text:SetPoint("CENTER", unit, "CENTER", 0, 0)

    local function OnClick(_, btn, ...)
        UpdateMenu(self, data)
    end

    unit:HookScript("OnClick", OnClick)

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
            unit:SetPoint("TOP", tab, "TOP", 0, -12)
        else
            unit:SetPoint("TOP", tab.units[#tab.units], "BOTTOM", 0, -12)
        end

        table.insert(tab.units, unit)
    end
end

-- Tab
local function CreateTab(self)
    local scroll = CreateFrame("ScrollFrame", nil, self, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -48)
    scroll:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", 192, 0)

    scroll.divide = self:CreateTexture(nil, "ARTWORK")
    scroll.divide:SetPoint("TOPLEFT", scroll, "TOPRIGHT", -1, -12)
    scroll.divide:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT", 0, 12)
    scroll.divide:SetTexture(DB.Border)
    scroll.divide:SetVertexColor(r, g, b, 1.00)

    self.tab = CreateFrame("Frame", nil, self)
    self.tab:SetSize(scroll:GetSize())

    scroll:SetScrollChild(self.tab)
    scroll.ScrollBar:SetAlpha(0.00)
end

-- Menu
local function CreateMenu(self)
    local scroll = CreateFrame("ScrollFrame", nil, self, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", self, "TOPLEFT", 192, -48)
    scroll:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)

    self.menu = CreateFrame("Frame", nil, self)
    self.menu:SetSize(scroll:GetSize())

    scroll:SetScrollChild(self.menu)
    scroll.ScrollBar:SetAlpha(0.00)
end

-- Title
local function CreateTitle(self)
    self.title = CreateFrame("Frame", nil, self)
    self.title:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.title:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, -48)

    self.title.text = S.MakeText(self.title, 14)
    self.title.text:SetText("|cff70C0F5Sora's|r Config - 设置选项将在点击左上角按钮重载UI后生效")
    self.title.text:SetPoint("CENTER", self.title, "CENTER", 0, 0)

    self.title.divide = self.title:CreateTexture(nil, "ARTWORK")
    self.title.divide:SetPoint("TOPLEFT", self.title, "BOTTOMLEFT", 12, -1)
    self.title.divide:SetPoint("BOTTOMRIGHT", self.title, "BOTTOMRIGHT", -12, 0)
    self.title.divide:SetTexture(DB.Border)
    self.title.divide:SetVertexColor(r, g, b, 1.00)

    self.title.close = S.CreateButton(self.title, 20)
    self.title.close:SetText("×")
    self.title.close:SetSize(24, 24)
    self.title.close:SetPoint("RIGHT", self.title, "RIGHT", -12, 0)

    self.title.reload = S.CreateButton(self.title, 11.5)
    self.title.reload:SetText("重")
    self.title.reload:SetSize(24, 24)
    self.title.reload:SetPoint("LEFT", self.title, "LEFT", 12, 0)

    local function OnCloseClick(_, btn, ...)
        self:Hide()
    end

    local function OnReloadClick(_, btn, ...)
        ReloadUI()
    end

    self.title.close:HookScript("OnClick", OnCloseClick)
    self.title.reload:HookScript("OnClick", OnReloadClick)
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

    btn.text = S.MakeText(btn, 13)
    btn.text:SetText("|cff70C0F5Sora's|r Config")
    btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0)

    btn.shadow = S.MakeBorder(btn, 1)
    btn.shadow:SetFrameLevel(btn:GetFrameLevel())

    local function OnClick(_, ...)
        if InCombatLockdown() then
            S.Error("无法在战斗时打开设置面板！")
        else
            self:Show()
            HideUIPanel(GameMenuFrame)
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
    instance:Hide()
    instance:SetSize(192 + 768, 48 * 9 + 12 * 10)
    instance:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    instance:SetMovable(true)
    instance:EnableMouse(true)
    instance:SetToplevel(true)
    instance:SetFrameStrata("DIALOG")
    instance:RegisterForDrag("LeftButton")
    instance:SetClampedToScreen(true)

    instance.bg = instance:CreateTexture(nil, "BORDER")
    instance.bg:SetAllPoints()
    instance.bg:SetTexture(DB.Backdrop)
    instance.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    CreateTab(instance)
    CreateMenu(instance)
    CreateTitle(instance)
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

    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN, "Master")
end

local function OnHide(self, ...)
    PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE, "Master")
end

local function OnDragStop(self, ...)
    self:StopMovingOrSizing()
end

local function OnDragStart(self, ...)
    self:StartMoving()
end

local function OnPlayerLogin(self, event, ...)
    local instance = CreateInstance(UIParent)

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(instance:GetFrameLevel())

    instance:SetScript("OnShow", OnShow)
    instance:SetScript("OnHide", OnHide)
    instance:SetScript("OnDragStop", OnDragStop)
    instance:SetScript("OnDragStart", OnDragStart)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
