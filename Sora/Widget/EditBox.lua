-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local EB = {}

-- Common
function EB.CreateInstance(parent, fontSize)
    local instance = CreateFrame("Button", nil, parent)

    instance.editbox = CreateFrame("EditBox", nil, instance)
    instance.editbox:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
    instance.editbox:SetPoint("LEFT", instance, "LEFT", 0, 0)
    instance.editbox:SetJustifyH("CENTER")
    instance.editbox:SetJustifyV("MIDDLE")
    instance.editbox:SetAutoFocus(false)
    instance.editbox:SetTextColor(0.90, 0.90, 0.90)
    instance.editbox:SetTextInsets(4, 4, 4, 4)
    instance.editbox:SetFrameLevel(instance:GetFrameLevel() + 1)
    instance.editbox:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    instance.editbox:SetShadowOffset(1, -1)

    instance.editbox.bg = instance.editbox:CreateTexture(nil, "BORDER")
    instance.editbox.bg:SetAllPoints()
    instance.editbox.bg:SetTexture(DB.Backdrop)
    instance.editbox.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.editbox.shadow = S.MakeShadow(instance.editbox, 1)
    instance.editbox.shadow:SetFrameLevel(instance.editbox:GetFrameLevel())

    instance.btn = CreateFrame("Button", nil, instance)
    instance.btn:Hide()
    instance.btn:SetFrameLevel(instance:GetFrameLevel() + 1)
    instance.btn:SetPoint("LEFT", instance.editbox, "RIGHT", 4, 0)

    instance.btn.bg = instance.btn:CreateTexture(nil, "BORDER")
    instance.btn.bg:SetAllPoints()
    instance.btn.bg:SetTexture(DB.Backdrop)
    instance.btn.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.btn.text = S.MakeText(instance.btn, fontSize - 2)
    instance.btn.text:SetText("确定")
    instance.btn.text:SetPoint("CENTER", 0.5, 0.0)

    instance.btn.shadow = S.MakeShadow(instance.btn, 1)
    instance.btn.shadow:SetFrameLevel(instance.btn:GetFrameLevel())

    return instance
end

function EB.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    if data.OnDataChanged then
        self.OnDataChanged = data.OnDataChanged
    end

    self.editbox:SetText(data.value)
    self:SetSize(self.btn:GetWidth() + 4 + self.editbox:GetWidth(), max(self.btn:GetHeight(), self.editbox:GetHeight()))
end

function EB.GetBTNSize(self)
    return self.btn:GetSize()
end

function EB.SetBTNSize(self, width, height)
    self.btn:SetSize(width, height)

    EB.UpdateDataBinding(self)
end

function EB.GetEditBoxSize(self)
    return self.editbox:GetSize()
end

function EB.SetEditBoxSize(self, width, height)
    self.editbox:SetSize(width, height)

    EB.UpdateDataBinding(self)
end

function EB.GetData(self)
    return self.data
end

function EB.SetData(self, data)
    self.data = data

    EB.UpdateDataBinding(self)
end

function S.CreateEditBox(parent, fontSize)
    local instance = EB.CreateInstance(parent, fontSize)

    local function OnBTNLeave(self, ...)
        self.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnBTNEnter(self, ...)
        self.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnBTNClick(self, ...)
        instance.data.value = instance.editbox:GetText()
        instance.editbox:ClearFocus()

        if instance.OnDataChanged then
            instance.OnDataChanged(instance, instance.data, ...)
        end

        EB.UpdateDataBinding(instance)
    end

    local function OnEnterPressed(self, ...)
        instance.data.value = instance.editbox:GetText()
        instance.editbox:ClearFocus()

        if instance.OnDataChanged then
            instance.OnDataChanged(instance, instance.data, ...)
        end

        EB.UpdateDataBinding(instance)
    end

    local function OnEditFocusLost(self, ...)
        instance.btn:Hide()
    end

    local function OnEditFocusGained(self, ...)
        instance.btn:Show()
    end

    instance.btn:SetScript("OnLeave", OnBTNLeave)
    instance.btn:SetScript("OnEnter", OnBTNEnter)
    instance.btn:SetScript("OnClick", OnBTNClick)

    instance.editbox:SetScript("OnEnterPressed", OnEnterPressed)
    instance.editbox:SetScript("OnEditFocusLost", OnEditFocusLost)
    instance.editbox:SetScript("OnEditFocusGained", OnEditFocusGained)

    instance.GetData = EB.GetData
    instance.SetData = EB.SetData
    instance.GetBTNSize = EB.GetBTNSize
    instance.SetBTNSize = EB.SetBTNSize
    instance.GetEditBoxSize = EB.GetEditBoxSize
    instance.SetEditBoxSize = EB.SetEditBoxSize

    return instance
end
