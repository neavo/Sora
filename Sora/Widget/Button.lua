-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local BN = {}

-- Common
function BN.GetText(self)
    return self.text:GetText()
end

function BN.SetText(self, text)
    self.text:SetText(text)
end

function BN.GetIcon(self)
    return self.icon:GetTexture()
end

function BN.SetIcon(self, icon)
    self.icon:SetTexture(icon)
end

function BN.CreateInstance(parent, fontSize, name)
    local instance = CreateFrame("Button", name, parent)
    instance:SetFrameLevel(parent:GetFrameLevel() + 1)

    instance.bg = instance:CreateTexture(nil, "BORDER")
    instance.bg:SetAllPoints()
    instance.bg:SetTexture(DB.Backdrop)
    instance.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.text = S.MakeText(instance, fontSize)
    instance.text:SetPoint("CENTER", instance, "CENTER", 0, 0)

    instance.icon = instance:CreateTexture(nil, "ARTWORK")
    instance.icon:SetAllPoints()

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(parent:GetFrameLevel() + 1)

    return instance
end

function S.CreateButton(parent, fontSize, name)
    local instance = BN.CreateInstance(parent, fontSize or 12, name)

    local function OnEnter(self, ...)
        instance.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        instance.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        instance.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnClick(self, btn, ...)
        PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
    end

    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnClick", OnClick)

    instance.GetText = BN.GetText
    instance.SetText = BN.SetText
    instance.GetIcon = BN.GetIcon
    instance.SetIcon = BN.SetIcon

    return instance
end
