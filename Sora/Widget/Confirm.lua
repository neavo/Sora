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
    instance:Hide()
    instance:SetSize(96, 96)
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

    instance.top = CreateFrame("Frame", nil, instance)
    instance.top:SetHeight(48)
    instance.top:SetPoint("TOP", instance, "TOP", 0, 0)

    instance.top.title = S.MakeText(instance.top, fontSize + 4)
    instance.top.title:SetPoint("CENTER", instance.top, "CENTER", 0, 0)
    instance.top.title:SetSpacing(4)

    instance.top.divide = instance.top:CreateTexture(nil, "ARTWORK")
    instance.top.divide:SetPoint("TOPLEFT", instance.top, "BOTTOMLEFT", 12, -1)
    instance.top.divide:SetPoint("BOTTOMRIGHT", instance.top, "BOTTOMRIGHT", -12, 0)
    instance.top.divide:SetTexture(DB.Border)
    instance.top.divide:SetVertexColor(r, g, b, 1.00)

    instance.bottom = CreateFrame("Frame", nil, instance)
    instance.bottom:SetHeight(48)
    instance.bottom:SetPoint("BOTTOM", instance, "BOTTOM", 0, 0)

    instance.bottom.no = S.CreateButton(instance.bottom, fontSize)
    instance.bottom.no:SetSize(fontSize * 8, fontSize + 8)
    instance.bottom.no:SetFrameLevel(instance.bottom:GetFrameLevel() + 1)

    instance.bottom.yes = S.CreateButton(instance.bottom, fontSize)
    instance.bottom.yes:SetSize(fontSize * 8, fontSize + 8)
    instance.bottom.yes:SetFrameLevel(instance.bottom:GetFrameLevel() + 1)

    instance.content = CreateFrame("Frame", nil, instance)
    instance.content:SetHeight(48)
    instance.content:SetPoint("CENTER", instance, "CENTER", 0, 0)

    instance.content.detail = S.MakeText(instance.content, fontSize)
    instance.content.detail:SetPoint("CENTER", instance.content, "CENTER", 0, 0)
    instance.content.detail:SetSpacing(4)

    return instance
end

function SD.UpdateTop(self)
    local data = self.data
    local top = self.top

    top.title:SetText(data.title)
    top:SetSize(self:GetWidth() - 12 * 2, top:GetHeight())
end

function SD.UpdateBottom(self)
    local data = self.data
    local bottom = self.bottom

    bottom.no:Hide()
    bottom.no:SetText(data.noText or "取消")
    bottom.no:ClearAllPoints()

    bottom.yes:Hide()
    bottom.yes:SetText(data.yesText or "确认")
    bottom.yes:ClearAllPoints()

    local btnWidth = bottom.no:GetWidth()
    local btnHeight = bottom.no:GetHeight()

    if data.OnNoClick and not data.OnYesClick then
        bottom.no:Show()
        bottom.no:SetPoint("CENTER", bottom, "CENTER", 0, 0)
    elseif not data.OnNoClick and data.OnYesClick then
        bottom.yes:Show()
        bottom.yes:SetPoint("CENTER", bottom, "CENTER", 0, 0)
    elseif data.OnNoClick and data.OnYesClick then
        bottom.no:Show()
        bottom.yes:Show()
        bottom.no:SetPoint("CENTER", bottom, "CENTER", btnWidth / 2 + 8, 0)
        bottom.yes:SetPoint("CENTER", bottom, "CENTER", -(btnWidth / 2 + 8), 0)
    end

    bottom:SetSize(self:GetWidth() - 12 * 2, bottom:GetHeight())
end

function SD.UpdateContent(self)
    local data = self.data
    local content = self.content

    content.detail:SetText(data.detail)
    content:SetSize(self:GetWidth() - 12 * 2, content.detail:GetHeight() + 12 * 2)
end

function SD.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    SD.UpdateTop(self)
    SD.UpdateBottom(self)
    SD.UpdateContent(self)

    self:SetHeight(self.top:GetHeight() + self.bottom:GetHeight() + self.content:GetHeight())
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
    return self:GetWidth()
end

function SD.SetConfirmWidth(self, width)
    self:SetWidth(width)

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

    local function OnDragStop(self, ...)
        instance:StopMovingOrSizing()
    end

    local function OnDragStart(self, ...)
        instance:StartMoving()
    end

    local function OnNoClick(self, btn, ...)
        instance:Hide()

        if instance.data.OnNoClick then
            instance.data.OnNoClick(instance, btn, ...)
        end
    end

    local function OnYesClick(self, btn, ...)
        instance:Hide()

        if instance.data.OnYesClick then
            instance.data.OnYesClick(instance, btn, ...)
        end
    end

    instance:SetScript("OnShow", OnShow)
    instance:SetScript("OnHide", OnHide)
    instance:SetScript("OnDragStop", OnDragStop)
    instance:SetScript("OnDragStart", OnDragStart)
    instance.bottom.no:HookScript("OnClick", OnNoClick)
    instance.bottom.yes:HookScript("OnClick", OnYesClick)

    instance.Get = SD.Get
    instance.Set = SD.Set
    instance.GetData = SD.GetData
    instance.SetData = SD.SetData
    instance.GetConfirmWidth = SD.GetConfirmWidth
    instance.SetConfirmWidth = SD.SetConfirmWidth

    return instance
end
