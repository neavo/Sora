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

function BN.CreateInstance(parent, fontSize)
    local instance = CreateFrame("Button", nil, parent)
    instance:SetFrameLevel(parent:GetFrameLevel() + 1)

    instance.bg = instance:CreateTexture(nil, "BORDER")
    instance.bg:SetAllPoints()
    instance.bg:SetTexture(DB.Backdrop)
    instance.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)

    instance.text = S.MakeText(instance, fontSize)
    instance.text:SetPoint("CENTER", instance, "CENTER", 0, 0)

    instance.shadow = S.MakeShadow(instance, 2)
    instance.shadow:SetFrameLevel(parent:GetFrameLevel() + 1)

    return instance
end

function S.CreateButton(parent, fontSize)
    local instance = BN.CreateInstance(parent, fontSize or 12)

    local function OnEnter(self, ...)
        instance.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        instance.bg:SetVertexColor(0.20, 0.20, 0.20, 0.60)
        instance.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)

    instance.GetText = BN.GetText
    instance.SetText = BN.SetText

    return instance
end
