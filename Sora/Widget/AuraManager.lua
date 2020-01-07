-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local AM = {}

-- Common
function AM.CreateInstance(parent)
    local instance = CreateFrame("Frame", nil, parent)
    instance:Hide()
    instance:SetHeight(24 * 8 + 12 * 9 + 48 * 2)
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

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(instance:GetFrameLevel())

    instance.title = CreateFrame("Frame", nil, instance)
    instance.title:SetPoint("TOPLEFT", instance, "TOPLEFT", 0, 0)
    instance.title:SetPoint("BOTTOMRIGHT", instance, "TOPRIGHT", 0, -48)

    instance.title.text = S.MakeText(instance.title, 12)
    instance.title.text:SetPoint("CENTER", instance.title, "CENTER", 0, 0)
    instance.title.text:SetSpacing(4)

    instance.title.reload = S.CreateButton(instance.title, 11.5)
    instance.title.reload:SetText("重")
    instance.title.reload:SetSize(24, 24)
    instance.title.reload:SetPoint("LEFT", instance.title, "LEFT", 12, 0)

    instance.title.close = S.CreateButton(instance.title, 20)
    instance.title.close:SetText("×")
    instance.title.close:SetSize(24, 24)
    instance.title.close:SetPoint("RIGHT", instance.title, "RIGHT", -12, 0)

    instance.title.divide = instance.title:CreateTexture(nil, "ARTWORK")
    instance.title.divide:SetPoint("TOPLEFT", instance.title, "BOTTOMLEFT", 12, -1)
    instance.title.divide:SetPoint("BOTTOMRIGHT", instance.title, "BOTTOMRIGHT", -12, 0)
    instance.title.divide:SetTexture(DB.Border)
    instance.title.divide:SetVertexColor(r, g, b, 1.00)

    instance.bottom = CreateFrame("Frame", nil, instance)
    instance.bottom:SetPoint("TOPLEFT", instance, "BOTTOMLEFT", 0, 48)
    instance.bottom:SetPoint("BOTTOMRIGHT", instance, "BOTTOMRIGHT", 0, 0)

    instance.bottom.text = S.MakeText(instance.bottom, 12)
    instance.bottom.text:SetText("请输入有效的状态ID：")

    instance.bottom.editbox = S.CreateEditBox(instance.bottom, 12)
    instance.bottom.editbox:SetSize(96, 14)
    instance.bottom.editbox:SetPoint("LEFT", instance.bottom.text, "RIGHT", 4, 0)
    instance.bottom.editbox:SetJustifyH("CENTER")
    instance.bottom.editbox:SetJustifyV("MIDDLE")
    instance.bottom.editbox:SetAutoFocus(false)
    instance.bottom.editbox:SetTextInsets(4, 4, 4, 4)

    instance.bottom.editbox.bg = instance.bottom.editbox:CreateTexture(nil, "BORDER")
    instance.bottom.editbox.bg:SetAllPoints()
    instance.bottom.editbox.bg:SetTexture(DB.Backdrop)
    instance.bottom.editbox.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.bottom.confirm = S.CreateButton(instance.bottom, 12)
    instance.bottom.confirm:SetSize(48, 14)
    instance.bottom.confirm:SetText("添加")
    instance.bottom.confirm:SetPoint("LEFT", instance.bottom.editbox, "RIGHT", 4, 0)

    instance.bottom.editbox.shadow = S.MakeShadow(instance.bottom.editbox, 2)
    instance.bottom.editbox.shadow:SetFrameLevel(instance.bottom.editbox:GetFrameLevel())

    instance.bottom.divide = instance.bottom:CreateTexture(nil, "ARTWORK")
    instance.bottom.divide:SetPoint("TOPLEFT", instance.bottom, "TOPLEFT", 12, 0)
    instance.bottom.divide:SetPoint("BOTTOMRIGHT", instance.bottom, "TOPRIGHT", -12, -1)
    instance.bottom.divide:SetTexture(DB.Border)
    instance.bottom.divide:SetVertexColor(r, g, b, 1.00)

    instance.content = CreateFrame("Frame", nil, instance)
    instance.content:SetPoint("TOPLEFT", instance.title, "BOTTOMLEFT", 0, 0)
    instance.content:SetPoint("BOTTOMRIGHT", instance.bottom, "TOPRIGHT", 0, 0)

    return instance
end

function AM.UpdateTitle(self)
    local data = self.data

    self.title.text:SetText(data.text)
end

function AM.UpdateBottom(self)
    local offset = (self.bottom.editbox:GetWidth() + self.bottom.confirm:GetWidth() + 8) / 2
    self.bottom.text:SetPoint("CENTER", self.bottom, "CENTER", -offset, 0)
end

function AM.UpdateContent(self)
    self.data.auras = self.data.auras or {}
    self.content.units = self.content.units or {}

    local auras = self.data.auras
    local units = self.content.units

    for k, v in pairs(units) do
        S.KillFrame(v)
    end
    table.wipe(units)

    local function MoveBack(key)
        if key == 1 then
            return 0
        end

        auras[key], auras[key - 1] = auras[key - 1], auras[key]
        AM.UpdateDataBinding(self)
    end

    local function MoveForward(key)
        if key == #auras then
            return 0
        end

        auras[key], auras[key + 1] = auras[key + 1], auras[key]
        AM.UpdateDataBinding(self)
    end

    local function DeleteTarget(key)
        table.remove(auras, key)
        AM.UpdateDataBinding(self)
    end

    local function OnClick(self, btn, ...)
        local menu = S.CreateEasyMenu()
        menu.NewLine("操作菜单", nil, nil, {isTitle = true})
        menu.NewLine("向前移动", MoveBack, {self.key})
        menu.NewLine("向后移动", MoveForward, {self.key})
        menu.NewLine("移除此项", DeleteTarget, {self.key})
        menu.Show()
    end

    for k, v in ipairs(auras) do
        local link = GetSpellLink(v)
        local _, _, icon = GetSpellInfo(v)

        local unit = S.CreateButton(self.content, 12)
        unit:SetText(link)
        unit:SetSize(150, 24)
        unit:HookScript("OnClick", OnClick)

        unit.key = k
        unit.value = v

        unit.icon = unit:CreateTexture(nil, "ARTWORK")
        unit.icon:SetSize(12, 12)
        unit.icon:SetPoint("RIGHT", unit.text, "LEFT", -4, 0)
        unit.icon:SetTexture(icon)
        unit.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        unit.icon.shadow = S.MakeTextureShadow(unit, unit.icon, 1)
        unit.icon.shadow:SetFrameLevel(unit:GetFrameLevel())

        if k == 1 then
            unit:SetPoint("TOPLEFT", self.content, "TOPLEFT", 12, -12)
        elseif mod(k, 5) == 1 then
            unit:SetPoint("TOP", units[k - 5], "BOTTOM", 0, -12)
        else
            unit:SetPoint("LEFT", units[k - 1], "RIGHT", 12, 0)
        end

        table.insert(units, unit)
    end
end

function AM.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    if data.OnDataChanged then
        data.OnDataChanged(self, data)
    end

    AM.UpdateTitle(self)
    AM.UpdateBottom(self)
    AM.UpdateContent(self)
end

function AM.GetData(self)
    return self.data
end

function AM.SetData(self, data)
    self.data = data

    AM.UpdateDataBinding(self)
end

function AM.GetManagerWidth(self)
    return self:GetWidth()
end

function AM.SetManagerWidth(self, width)
    self:SetWidth(width)

    AM.UpdateDataBinding(self)
end

function S.CreateAuraManager(parent)
    local instance = AM.CreateInstance(parent)

    local function OnDragStop(self, ...)
        instance:StopMovingOrSizing()
    end

    local function OnDragStart(self, ...)
        instance:StartMoving()
    end

    local function OnCloseClick(self, btn, ...)
        instance:Hide()
    end

    local function OnReloadClick(self, btn, ...)
        ReloadUI()
    end

    local function OnConfirmClick(self, btn, ...)
        instance.bottom.editbox:ClearFocus()

        local spellid = instance.bottom.editbox:GetText()

        if not spellid or not tonumber(spellid) then
            S.Error("请输入有效的状态ID！")
            return 0
        end

        spellid = tonumber(spellid)

        local link = GetSpellLink(spellid)
        local _, _, icon = GetSpellInfo(spellid)

        if not link or not icon then
            S.Error("请输入有效的状态ID！")
            return 0
        end

        table.insert(instance.data.auras, spellid)
        AM.UpdateDataBinding(instance)
    end

    local function OnEnterPressed(self, ...)
        OnConfirmClick(self, nil, nil)
    end

    instance:SetScript("OnDragStop", OnDragStop)
    instance:SetScript("OnDragStart", OnDragStart)
    instance.title.close:HookScript("OnClick", OnCloseClick)
    instance.title.reload:HookScript("OnClick", OnReloadClick)
    instance.bottom.confirm:HookScript("OnClick", OnConfirmClick)
    instance.bottom.editbox:HookScript("OnEnterPressed", OnEnterPressed)

    instance.GetData = AM.GetData
    instance.SetData = AM.SetData
    instance.GetManagerWidth = AM.GetManagerWidth
    instance.SetManagerWidth = AM.SetManagerWidth

    return instance
end
