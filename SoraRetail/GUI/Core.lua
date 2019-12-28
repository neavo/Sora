-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local GUI = nil
local width, space = 768, 8
local rowSize, rowNum = 24, 16

-- Initialize
S.GUI = S.GUI or {}

-- Common
-- Anchor
local function CreateAnchor(self, ...)
    S.GUI.Anchor = CreateFrame("Frame", nil, UIParent)
    S.GUI.Anchor:SetSize(width, rowSize * rowNum + space * (rowNum + 1))
    S.GUI.Anchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    S.GUI.Anchor:SetFrameStrata("HIGH")
end

-- Tab
local function CreateTabUnit(parent, data)
    local unit = S.CreateButton(parent)
    unit:SetSize(parent:GetWidth() - space * 2, rowSize)

    unit.text = S.MakeText(unit, 14)
    unit.text:SetText(data)
    unit.text:SetPoint("CENTER", unit, "CENTER", 0, 0)

    return unit
end

local function CreateTab(self, ...)
    local tab = S.CreateButton(S.GUI.Anchor)
    tab:SetSize((width - space) / 4, rowSize * rowNum + space * (rowNum + 1))
    tab:SetPoint("BOTTOMLEFT", S.GUI.Anchor, "BOTTOMLEFT", 0, 0)

    tab:SetScript("OnLeave", nil)
    tab:SetScript("OnEnter", nil)

    tab.units = {}

    for i = 1, rowNum do
        local unit = CreateTabUnit(tab, i)

        if i == 1 then
            unit:SetPoint("TOP", tab, "TOP", 0, -space)
        else
            unit:SetPoint("TOP", tab.units[i - 1], "BOTTOM", 0, -space)
        end

        table.insert(tab.units, unit)
    end
end

-- Menu
local function GetData(key)
    local data = nil

    for k in string.gmatch(key .. ".", "(.-)%.") do
        if not data then
            data = _G[k]
        else
            data = data[k]
        end
    end

    return data
end

local function CreateMenuUnit(parent, data)
    local unit = CreateFrame("Frame", nil, parent)
    unit:SetSize(parent:GetWidth() - space * 2, rowSize * 2 + space * 1)

    unit.title = S.MakeText(unit, 14)
    unit.title:SetText(data.title)
    unit.title:SetPoint("TOPLEFT", unit, "TOPLEFT", 4, -8)

    unit.childs = {}

    for k, v in pairs(data.childs) do
        local child = nil

        if v.type == "editbox" then
            child = S.CreateEditBox(unit, 11)
        elseif v.type == "checkbox" then
            child = S.CreateCheckBox(unit, 11)
            print(GetData(v.key))
        elseif v.type == "dropdown" then
            child = S.CreateDropDown(unit, 11)
        end

        child:SetSize(96, 16)

        if k == 1 then
            child:SetPoint("BOTTOMLEFT", unit, "BOTTOMLEFT", 4, 8)
        else
            child:SetPoint("LEFT", unit.childs[k - 1], "RIGHT", 8, 0)
        end

        table.insert(unit.childs, child)
    end

    return unit
end

local function CreateMenu(self, ...)
    local menu = S.CreateButton(S.GUI.Anchor)
    menu:SetSize((width - space) / 4 * 3, rowSize * rowNum + space * (rowNum + 1))
    menu:SetPoint("BOTTOMRIGHT", S.GUI.Anchor, "BOTTOMRIGHT", 0, 0)

    menu:SetScript("OnLeave", nil)
    menu:SetScript("OnEnter", nil)

    menu.units = {}

    data = {
        {
            title = "测试标题 - " .. 1,
            childs = {
                {type = "editbox", key = "SoraDB.EB.1", defalut = "SoraDB.EB.1"},
                {type = "editbox", key = "SoraDB.EB.2", defalut = "SoraDB.EB.2"},
                {type = "editbox", key = "SoraDB.EB.3", defalut = "SoraDB.EB.3"},
                {type = "editbox", key = "SoraDB.EB.4", defalut = "SoraDB.EB.4"},
                {type = "editbox", key = "SoraDB.EB.5", defalut = "SoraDB.EB.5"}
            }
        },
        {
            title = "测试标题 - " .. 2,
            childs = {
                {type = "checkbox", key = "SoraDB.CB.x1", defalut = "SoraDB.CB.1"},
                {type = "checkbox", key = "SoraDB.CB.x2", defalut = "SoraDB.CB.2"},
                {type = "checkbox", key = "SoraDB.CB.x3", defalut = "SoraDB.CB.3"},
                {type = "checkbox", key = "SoraDB.CB.x4", defalut = "SoraDB.CB.4"},
                {type = "checkbox", key = "SoraDB.CB.x5", defalut = "SoraDB.CB.5"}
            }
        },
        {
            title = "测试标题 - " .. 3,
            childs = {
                {type = "dropdown", key = "SoraDB.DD.1", defalut = "SoraDB.DD.1"},
                {type = "dropdown", key = "SoraDB.DD.2", defalut = "SoraDB.DD.2"},
                {type = "dropdown", key = "SoraDB.DD.3", defalut = "SoraDB.DD.3"},
                {type = "dropdown", key = "SoraDB.DD.4", defalut = "SoraDB.DD.4"},
                {type = "dropdown", key = "SoraDB.DD.5", defalut = "SoraDB.DD.5"}
            }
        }
    }

    for k, v in pairs(data) do
        local unit = CreateMenuUnit(menu, v)

        if k == 1 then
            unit:SetPoint("TOPLEFT", menu, "TOPLEFT", space, -space)
        else
            unit:SetPoint("TOP", menu.units[k - 1], "BOTTOM", 0, -space)
        end

        table.insert(menu.units, unit)
    end
end

-- Close
local function OnCloseClick(self, btn, ...)
    S.GUI.Anchor:Hide()
end

local function CreateClose(self, ...)
    local close = S.CreateButton(S.GUI.Anchor)
    close:SetSize(rowSize, rowSize)
    close:SetPoint("BOTTOMRIGHT", S.GUI.Anchor, "TOPRIGHT", 0, space)

    close.text = S.MakeText(close, 20)
    close.text:SetText("×")
    close.text:SetPoint("CENTER", close, "CENTER", 0, 0)

    close:SetScript("OnClick", OnCloseClick)
end

-- Title
local function CreateTitle(self, ...)
    local title = S.CreateButton(S.GUI.Anchor)
    title:SetSize(width - rowSize - space, rowSize)
    title:SetPoint("BOTTOMLEFT", S.GUI.Anchor, "TOPLEFT", 0, space)

    title.text = S.MakeText(title, 14)
    title.text:SetText("|cff70C0F5Sora's|r Config")
    title.text:SetPoint("CENTER", title, "CENTER", 0, 0)

    title:SetScript("OnLeave", nil)
    title:SetScript("OnEnter", nil)
end

-- Event
local function OnPlayerLogin(self, event, ...)
    CreateAnchor(self, ...)

    CreateTab(self, ...)
    CreateMenu(self, ...)
    CreateClose(self, ...)
    CreateTitle(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
