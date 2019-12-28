-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local EB = {}

-- Common
function EB.Create(parent, fontSize)
    local frame = CreateFrame("Button", nil, parent)

    frame.btn = CreateFrame("Button", nil, frame)
    frame.btn:Hide()
    frame.btn:SetFrameLevel(frame:GetFrameLevel() + 1)
    frame.btn:SetPoint("RIGHT", frame, "RIGHT", 0, 0)

    frame.btn.bg = frame.btn:CreateTexture(nil, "BORDER")
    frame.btn.bg:SetAllPoints()
    frame.btn.bg:SetTexture(DB.Backdrop)
    frame.btn.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.btn.text = S.MakeText(frame.btn, fontSize - 2)
    frame.btn.text:SetText("确定")
    frame.btn.text:SetPoint("CENTER", 0.5, 0.0)

    frame.btn.shadow = S.MakeShadow(frame.btn, 2)
    frame.btn.shadow:SetFrameLevel(frame.btn:GetFrameLevel() + 1)

    frame.editbox = CreateFrame("EditBox", nil, frame)
    frame.editbox:SetAutoFocus(false)
    frame.editbox:SetTextInsets(4, 4, 4, 4)
    frame.editbox:SetTextColor(0.90, 0.90, 0.90)
    frame.editbox:SetShadowOffset(1, -1)
    frame.editbox:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    frame.editbox:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
    frame.editbox:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.editbox:SetFrameLevel(frame:GetFrameLevel() + 1)

    frame.editbox.bg = frame.editbox:CreateTexture(nil, "BORDER")
    frame.editbox.bg:SetAllPoints()
    frame.editbox.bg:SetTexture(DB.Backdrop)
    frame.editbox.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.editbox.shadow = CreateFrame("Frame", nil, frame.editbox)
    frame.editbox.shadow:SetFrameLevel(frame.editbox:GetFrameLevel() + 1)
    frame.editbox.shadow:SetPoint("TOPLEFT", frame.editbox, -1, 1)
    frame.editbox.shadow:SetPoint("BOTTOMRIGHT", frame.editbox, 1, -1)
    frame.editbox.shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = 1})
    frame.editbox.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return frame
end

function EB.UpdateDataBinding(self)
    local data = self.data
end

function EB.OnBTNLeave(self, ...)
    self.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
    self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
end

function EB.OnBTNEnter(self, ...)
    self.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
    self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
end

function EB.OnBTNClick(self, ...)
    self:GetParent().editbox:ClearFocus()
end

function EB.OnEnterPressed(self, ...)
    self:GetParent().editbox:ClearFocus()
end

function EB.OnEditFocusLost(self, ...)
    self:GetParent().btn:Hide()
end

function EB.OnEditFocusGained(self, ...)
    self:GetParent().btn:Show()
end

function EB.GetSize(self, ...)
    return self:__GetSize()
end

function EB.SetSize(self, width, height, ...)
    self:__SetSize(width, height)

    self.btn:SetSize(height * 1.5, height)
    self.editbox:SetSize(width - height * 1.5 - 4, height)
end

function EB.GetData(self, ...)
    return self.data
end

function EB.SetData(self, data, ...)
    self.data = data

    UpdateDataBinding(self)
end

function S.CreateEditBox(parent, fontSize)
    local frame = EB.Create(parent, fontSize)

    frame.btn:SetScript("OnLeave", EB.OnBTNLeave)
    frame.btn:SetScript("OnEnter", EB.OnBTNEnter)
    frame.btn:SetScript("OnClick", EB.OnBTNClick)

    frame.editbox:SetScript("OnEnterPressed", EB.OnEnterPressed)
    frame.editbox:SetScript("OnEditFocusLost", EB.OnEditFocusLost)
    frame.editbox:SetScript("OnEditFocusGained", EB.OnEditFocusGained)

    frame.__GetSize = frame.GetSize
    frame.__SetSize = frame.SetSize

    frame.GetSize = EB.GetSize
    frame.SetSize = EB.SetSize
    frame.GetData = EB.GetData
    frame.SetData = EB.SetData

    return frame
end
