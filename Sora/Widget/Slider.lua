-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local SD = {}

-- Common
function SD.CreateInstance(parent, fontSize)
    local frame = CreateFrame("Frame", nil, parent)

    frame.line = CreateFrame("Slider", nil, frame)
    frame.line:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.line:SetOrientation("HORIZONTAL")

    frame.line.thumb = frame.line:CreateTexture(nil, "ARTWORK")
    frame.line.thumb:SetTexture(DB.Backdrop)
    frame.line.thumb:SetVertexColor(r, g, b, 1.00)

    frame.line.thumb.hl = frame.line:CreateTexture(nil, "OVERLAY")
    frame.line.thumb.hl:Hide()
    frame.line.thumb.hl:SetTexture(DB.Backdrop)
    frame.line.thumb.hl:SetAllPoints(frame.line.thumb)
    frame.line.thumb.hl:SetVertexColor(1.00, 1.00, 1.00, 0.30)

    frame.line:SetBackdrop(nil)
    frame.line:SetThumbTexture(frame.line.thumb)

    frame.line.bg = frame.line:CreateTexture(nil, "BORDER")
    frame.line.bg:SetAllPoints()
    frame.line.bg:SetTexture(DB.Backdrop)
    frame.line.bg:SetVertexColor(0.12, 0.12, 0.12, 0.50)

    frame.line.shadow = S.MakeShadow(frame.line, 1)
    frame.line.shadow:SetFrameLevel(frame.line:GetFrameLevel())

    frame.text = S.MakeText(frame.line, fontSize)
    frame.text:SetPoint("BOTTOM", frame.line, "TOP", 0, 8)

    frame.minValue = S.MakeText(frame.line, fontSize)
    frame.minValue:SetPoint("TOPRIGHT", frame.line, "BOTTOMLEFT", -4, -4)

    frame.curValue = S.MakeText(frame.line, fontSize)
    frame.curValue:SetPoint("TOP", frame.line, "BOTTOM", 0, -4)

    frame.maxValue = S.MakeText(frame.line, fontSize)
    frame.maxValue:SetPoint("TOPLEFT", frame.line, "BOTTOMRIGHT", 4, -4)

    return frame
end

function SD.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    self.OnDataChanged = data.OnDataChanged

    self.text:SetText(data.text)
    self.minValue:SetText(data.minValue)
    self.curValue:SetText(data.value)
    self.maxValue:SetText(data.maxValue)

    self.line:SetMinMaxValues(data.minValue, data.maxValue)
    self.line:SetValue(data.value)
    self.line:SetValueStep(data.step)
    self.line.thumb:SetSize(6, self.line:GetHeight())

    self:SetSize(
        self.minValue:GetWidth() + 4 + self.line:GetWidth() + 4 + self.maxValue:GetWidth(),
        self.text:GetHeight() + 8 + self.line:GetHeight() + 4 + self.minValue:GetHeight()
    )
end

function SD.GetData(self)
    return self.data
end

function SD.SetData(self, data)
    self.data = data

    SD.UpdateDataBinding(self)
end

function SD.GetLineSize(self)
    return self.line:GetSize()
end

function SD.SetLineSize(self, width, height)
    self.line:SetSize(width, height)

    SD.UpdateDataBinding(self)
end

function S.CreateSlider(parent, fontSize)
    local instance = SD.CreateInstance(parent, fontSize)

    local function OnEnter(self, ...)
        instance.line.thumb.hl:Show()
    end

    local function OnLeave(self, ...)
        instance.line.thumb.hl:Hide()
    end

    local function OnValueChanged(self, value)
        instance.data.value = value

        if instance.OnDataChanged then
            instance.OnDataChanged(instance, instance.data)
        end

        SD.UpdateDataBinding(instance)
    end

    instance.line:SetScript("OnEnter", OnEnter)
    instance.line:SetScript("OnLeave", OnLeave)
    instance.line:SetScript("OnValueChanged", OnValueChanged)

    instance.GetData = SD.GetData
    instance.SetData = SD.SetData
    instance.GetLineSize = SD.GetLineSize
    instance.SetLineSize = SD.SetLineSize

    return instance
end
