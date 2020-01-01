-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local EB = {}

-- Common
function EB.CreateInstance(parent, fontSize)
    local frame = CreateFrame("Button", nil, parent)

    frame.editbox = CreateFrame("EditBox", nil, frame)
    frame.editbox:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
    frame.editbox:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.editbox:SetJustifyH("CENTER")
    frame.editbox:SetJustifyV("MIDDLE")
    frame.editbox:SetAutoFocus(false)
    frame.editbox:SetTextColor(0.90, 0.90, 0.90)
    frame.editbox:SetTextInsets(4, 4, 4, 4)
    frame.editbox:SetFrameLevel(frame:GetFrameLevel() + 1)
    frame.editbox:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    frame.editbox:SetShadowOffset(1, -1)

    frame.editbox.bg = frame.editbox:CreateTexture(nil, "BORDER")
    frame.editbox.bg:SetAllPoints()
    frame.editbox.bg:SetTexture(DB.Backdrop)
    frame.editbox.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.editbox.shadow = S.MakeShadow(frame.editbox, 1)
    frame.editbox.shadow:SetFrameLevel(frame.editbox:GetFrameLevel() + 1)

    frame.btn = CreateFrame("Button", nil, frame)
    frame.btn:Hide()
    frame.btn:SetFrameLevel(frame:GetFrameLevel() + 1)
    frame.btn:SetPoint("LEFT", frame.editbox, "RIGHT", 4, 0)

    frame.btn.bg = frame.btn:CreateTexture(nil, "BORDER")
    frame.btn.bg:SetAllPoints()
    frame.btn.bg:SetTexture(DB.Backdrop)
    frame.btn.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.btn.text = S.MakeText(frame.btn, fontSize - 2)
    frame.btn.text:SetText("确定")
    frame.btn.text:SetPoint("CENTER", 0.5, 0.0)

    frame.btn.shadow = S.MakeShadow(frame.btn, 1)
    frame.btn.shadow:SetFrameLevel(frame.btn:GetFrameLevel() + 1)

    return frame
end

function EB.UpdateDataBinding(self)
    local data = self.data

    self.editbox:SetText(data.value)
end

function EB.GetBTNSize(self)
    return self.btn:GetSize()
end

function EB.SetBTNSize(self, width, height)
    self.btn:SetSize(width, height)

    self:SetSize(
        self.btn:GetWidth() + 4 + self.editbox:GetWidth(),
        max(self.btn:GetHeight(), self.editbox:GetHeight())
    )
end

function EB.GetEditBoxSize(self)
    return self.editbox:GetSize()
end

function EB.SetEditBoxSize(self, width, height)
    self.editbox:SetSize(width, height)

    self:SetSize(
        self.btn:GetWidth() + 4 + self.editbox:GetWidth(),
        max(self.btn:GetHeight(), self.editbox:GetHeight())
    )
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
        self.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
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
