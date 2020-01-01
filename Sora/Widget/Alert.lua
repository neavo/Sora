-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local SD = {}

-- Common
function SD.CreateInstance(parent, fontSize)
    local instance = CreateFrame("Frame", nil, parent)

    instance.alert = CreateFrame("Frame", nil, instance)
    instance.alert:SetPoint("CENTER", instance, "CENTER", 0, 0)
    instance.alert:SetFrameStrata("DIALOG")

    instance.alert.bg = instance.alert:CreateTexture(nil, "BORDER")
    instance.alert.bg:SetAllPoints()
    instance.alert.bg:SetTexture(DB.Backdrop)
    instance.alert.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    instance.alert.shadow = S.MakeShadow(instance.alert, 2)
    instance.alert.shadow:SetFrameLevel(instance.alert:GetFrameLevel())

    instance.alert.title = S.MakeText(instance.alert, fontSize + 4)
    instance.alert.title:SetPoint("TOP", instance.alert, "TOP", 0, -12)

    instance.alert.divide = instance.alert:CreateTexture(nil, "ARTWORK")
    instance.alert.divide:SetPoint("TOP", instance.alert.title, "BOTTOM", 0, -12)
    instance.alert.divide:SetHeight(1)
    instance.alert.divide:SetTexture(DB.Border)
    instance.alert.divide:SetVertexColor(r, g, b, 1.00)

    instance.alert.detail = S.MakeText(instance.alert, fontSize)
    instance.alert.detail:SetPoint("TOP", instance.alert.divide, "BOTTOM", 0, -12)
    instance.alert.detail:SetSpacing(2)

    instance.alert.passive = CreateFrame("Button", nil, instance.alert)
    instance.alert.passive:SetSize(fontSize * 8, fontSize + 8)
    instance.alert.passive:SetFrameLevel(instance.alert:GetFrameLevel() + 1)

    instance.alert.passive.text = S.MakeText(instance.alert.passive, fontSize)
    instance.alert.passive.text:SetPoint("CENTER", instance.alert.passive, "CENTER", 0, 0)

    instance.alert.passive.bg = instance.alert.passive:CreateTexture(nil, "BORDER")
    instance.alert.passive.bg:SetAllPoints()
    instance.alert.passive.bg:SetTexture(DB.Backdrop)
    instance.alert.passive.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    instance.alert.passive.shadow = S.MakeShadow(instance.alert.passive, 1)
    instance.alert.passive.shadow:SetFrameLevel(instance.alert:GetFrameLevel() + 1)

    instance.alert.positive = CreateFrame("Button", nil, instance.alert)
    instance.alert.positive:SetSize(fontSize * 8, fontSize + 8)
    instance.alert.positive:SetFrameLevel(instance.alert:GetFrameLevel() + 1)

    instance.alert.positive.text = S.MakeText(instance.alert.positive, fontSize)
    instance.alert.positive.text:SetPoint("CENTER", instance.alert.positive, "CENTER", 0, 0)

    instance.alert.positive.bg = instance.alert.positive:CreateTexture(nil, "BORDER")
    instance.alert.positive.bg:SetAllPoints()
    instance.alert.positive.bg:SetTexture(DB.Backdrop)
    instance.alert.positive.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    instance.alert.positive.shadow = S.MakeShadow(instance.alert.positive, 1)
    instance.alert.positive.shadow:SetFrameLevel(instance.alert:GetFrameLevel() + 1)

    return instance
end

function SD.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    self.alert.title:SetText(data.title)
    self.alert.detail:SetText(data.detail)
    self.alert.detail:SetJustifyH(data.justifyH or "CENTER")

    self.alert.title:SetWidth(self.alert:GetWidth() - 12 * 2)
    self.alert.detail:SetWidth(self.alert:GetWidth() - 12 * 2)
    self.alert.divide:SetWidth(self.alert:GetWidth() - 12 * 2)

    self.alert.passive.text:SetText(data.passiveText)
    self.alert.positive.text:SetText(data.positiveText)

    local btnWidth = self.alert.passive:GetWidth()
    if data.OnPassiveClick and not data.OnPositiveClick then
        self.alert.passive:SetPoint("BOTTOM", self.alert, "BOTTOM", 0, 12)
    elseif not data.OnPassiveClick and data.OnPositiveClick then
        self.alert.positive:SetPoint("BOTTOM", self.alert, "BOTTOM", 0, 12)
    elseif data.OnPassiveClick and data.OnPositiveClick then
        self.alert.passive:SetPoint("BOTTOM", self.alert, "BOTTOM", btnWidth / 2 + 8, 12)
        self.alert.positive:SetPoint("BOTTOM", self.alert, "BOTTOM", -(btnWidth / 2 + 8), 12)
    end

    self.alert:SetSize(
        self.alert:GetWidth(),
        12 + self.alert.title:GetHeight() + 12 + self.alert.divide:GetHeight() + 12 + self.alert.detail:GetHeight() + 12 +
            self.alert.passive:GetHeight() +
            12
    )
    self:SetSize(self.alert:GetSize())
end

function SD.GetData(self)
    return self.data
end

function SD.SetData(self, data)
    self.data = data

    SD.UpdateDataBinding(self)
end

function SD.GetAlterWidth(self)
    return self.alert:GetWidth()
end

function SD.SetAlterWidth(self, width)
    self.alert:SetWidth(width)

    SD.UpdateDataBinding(self)
end

function S.CreateAlert(parent, fontSize)
    local instance = SD.CreateInstance(parent, fontSize)

    local function OnPassiveLeave(self, ...)
        instance.alert.passive.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
        instance.alert.passive.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnPassiveEnter(self, ...)
        instance.alert.passive.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.alert.passive.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnPassiveClick(self, btn, ...)
        if instance.data.OnPassiveClick then
            instance.data.OnPassiveClick(instance, btn, ...)
        end
    end

    local function OnPositiveLeave(self, ...)
        instance.alert.positive.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
        instance.alert.positive.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnPositiveEnter(self, ...)
        instance.alert.positive.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.alert.positive.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnPositiveClick(self, btn, ...)
        if instance.data.OnPositiveClick then
            instance.data.OnPositiveClick(instance, btn, ...)
        end
    end

    instance.alert.passive:SetScript("OnLeave", OnPassiveLeave)
    instance.alert.passive:SetScript("OnEnter", OnPassiveEnter)
    instance.alert.passive:SetScript("OnClick", OnPassiveClick)
    instance.alert.positive:SetScript("OnLeave", OnPositiveLeave)
    instance.alert.positive:SetScript("OnEnter", OnPositiveEnter)
    instance.alert.positive:SetScript("OnClick", OnPositiveClick)

    instance.GetData = SD.GetData
    instance.SetData = SD.SetData
    instance.GetAlterWidth = SD.GetAlterWidth
    instance.SetAlterWidth = SD.SetAlterWidth

    return instance
end
