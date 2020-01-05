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

    instance.confirm = CreateFrame("Frame", nil, instance)
    instance.confirm:SetPoint("CENTER", instance, "CENTER", 0, 0)
    instance.confirm:SetFrameStrata("DIALOG")

    instance.confirm.bg = instance.confirm:CreateTexture(nil, "BORDER")
    instance.confirm.bg:SetAllPoints()
    instance.confirm.bg:SetTexture(DB.Backdrop)
    instance.confirm.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    instance.confirm.shadow = S.MakeShadow(instance.confirm, 2)
    instance.confirm.shadow:SetFrameLevel(instance.confirm:GetFrameLevel())

    instance.confirm.title = S.MakeText(instance.confirm, fontSize + 4)
    instance.confirm.title:SetPoint("TOP", instance.confirm, "TOP", 0, -12)

    instance.confirm.divide = instance.confirm:CreateTexture(nil, "ARTWORK")
    instance.confirm.divide:SetPoint("TOP", instance.confirm.title, "BOTTOM", 0, -12)
    instance.confirm.divide:SetHeight(1)
    instance.confirm.divide:SetTexture(DB.Border)
    instance.confirm.divide:SetVertexColor(r, g, b, 1.00)

    instance.confirm.detail = S.MakeText(instance.confirm, fontSize)
    instance.confirm.detail:SetPoint("TOP", instance.confirm.divide, "BOTTOM", 0, -12)
    instance.confirm.detail:SetSpacing(4)

    instance.confirm.no = CreateFrame("Button", nil, instance.confirm)
    instance.confirm.no:SetSize(fontSize * 8, fontSize + 8)
    instance.confirm.no:SetFrameLevel(instance.confirm:GetFrameLevel() + 1)

    instance.confirm.no.text = S.MakeText(instance.confirm.no, fontSize)
    instance.confirm.no.text:SetPoint("CENTER", instance.confirm.no, "CENTER", 0, 0)

    instance.confirm.no.bg = instance.confirm.no:CreateTexture(nil, "BORDER")
    instance.confirm.no.bg:SetAllPoints()
    instance.confirm.no.bg:SetTexture(DB.Backdrop)
    instance.confirm.no.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.confirm.no.shadow = S.MakeShadow(instance.confirm.no, 1)
    instance.confirm.no.shadow:SetFrameLevel(instance.confirm:GetFrameLevel() + 1)

    instance.confirm.yes = CreateFrame("Button", nil, instance.confirm)
    instance.confirm.yes:SetSize(fontSize * 8, fontSize + 8)
    instance.confirm.yes:SetFrameLevel(instance.confirm:GetFrameLevel() + 1)

    instance.confirm.yes.text = S.MakeText(instance.confirm.yes, fontSize)
    instance.confirm.yes.text:SetPoint("CENTER", instance.confirm.yes, "CENTER", 0, 0)

    instance.confirm.yes.bg = instance.confirm.yes:CreateTexture(nil, "BORDER")
    instance.confirm.yes.bg:SetAllPoints()
    instance.confirm.yes.bg:SetTexture(DB.Backdrop)
    instance.confirm.yes.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.confirm.yes.shadow = S.MakeShadow(instance.confirm.yes, 1)
    instance.confirm.yes.shadow:SetFrameLevel(instance.confirm:GetFrameLevel() + 1)

    return instance
end

function SD.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    self.confirm.title:SetText(data.title)
    self.confirm.detail:SetText(data.detail)
    self.confirm.detail:SetJustifyH(data.justifyH or "CENTER")

    self.confirm.title:SetWidth(self.confirm:GetWidth() - 12 * 2)
    self.confirm.detail:SetWidth(self.confirm:GetWidth() - 12 * 2)
    self.confirm.divide:SetWidth(self.confirm:GetWidth() - 12 * 2)

    self.confirm.no.text:SetText(data.noText or "取消")
    self.confirm.yes.text:SetText(data.yesText or "确认")

    self.confirm.no:Hide()
    self.confirm.yes:Hide()
    self.confirm.no:ClearAllPoints()
    self.confirm.yes:ClearAllPoints()

    local btnWidth = self.confirm.no:GetWidth()
    local btnHeight = self.confirm.no:GetHeight()

    if data.OnNoClick and not data.OnYesClick then
        self.confirm.no:Show()
        self.confirm.no:SetPoint("BOTTOM", self.confirm, "BOTTOM", 0, 12)
    elseif not data.OnNoClick and data.OnYesClick then
        self.confirm.yes:Show()
        self.confirm.yes:SetPoint("BOTTOM", self.confirm, "BOTTOM", 0, 12)
    elseif data.OnNoClick and data.OnYesClick then
        self.confirm.no:Show()
        self.confirm.yes:Show()
        self.confirm.no:SetPoint("BOTTOM", self.confirm, "BOTTOM", btnWidth / 2 + 8, 12)
        self.confirm.yes:SetPoint("BOTTOM", self.confirm, "BOTTOM", -(btnWidth / 2 + 8), 12)
    end

    self.confirm:SetHeight(12 + self.confirm.title:GetHeight() + 12 + self.confirm.divide:GetHeight() + 12 + self.confirm.detail:GetHeight() + 12 + btnHeight + 12)
    self:SetSize(self.confirm:GetSize())
end

function SD.Get(self, k)
    return self.data[k]
end

function SD.Set(self, k, v)
    self.data[k] = v

    SD.UpdateDataBinding(self)
end

function SD.GetData(self)
    return self.data
end

function SD.SetData(self, data)
    self.data = data

    SD.UpdateDataBinding(self)
end

function SD.GetConfirmWidth(self)
    return self.confirm:GetWidth()
end

function SD.SetConfirmWidth(self, width)
    self.confirm:SetWidth(width)

    SD.UpdateDataBinding(self)
end

function S.CreateConfirm(parent, fontSize)
    local instance = SD.CreateInstance(parent, fontSize)

    local function OnShow(self, ...)
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
    end

    local function OnHide(self, ...)
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
    end

    local function OnNoLeave(self, ...)
        instance.confirm.no.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        instance.confirm.no.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnNoEnter(self, ...)
        instance.confirm.no.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.confirm.no.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnNoClick(self, btn, ...)
        instance:Hide()

        if instance.data.OnNoClick then
            instance.data.OnNoClick(instance, btn, ...)
        end
    end

    local function OnYesLeave(self, ...)
        instance.confirm.yes.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        instance.confirm.yes.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnYesEnter(self, ...)
        instance.confirm.yes.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.confirm.yes.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnYesClick(self, btn, ...)
        instance:Hide()

        if instance.data.OnYesClick then
            instance.data.OnYesClick(instance, btn, ...)
        end
    end

    instance.confirm:SetScript("OnShow", OnShow)
    instance.confirm:SetScript("OnHide", OnHide)
    instance.confirm.no:SetScript("OnLeave", OnNoLeave)
    instance.confirm.no:SetScript("OnEnter", OnNoEnter)
    instance.confirm.no:SetScript("OnClick", OnNoClick)
    instance.confirm.yes:SetScript("OnLeave", OnYesLeave)
    instance.confirm.yes:SetScript("OnEnter", OnYesEnter)
    instance.confirm.yes:SetScript("OnClick", OnYesClick)

    instance.Get = SD.Get
    instance.Set = SD.Set
    instance.GetData = SD.GetData
    instance.SetData = SD.SetData
    instance.GetConfirmWidth = SD.GetConfirmWidth
    instance.SetConfirmWidth = SD.SetConfirmWidth

    return instance
end
