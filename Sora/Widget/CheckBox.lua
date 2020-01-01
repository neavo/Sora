-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local CB = {}

-- Common
function CB.CreateInstance(parent)
    local frame = CreateFrame("Button", nil, parent)

    frame.box = CreateFrame("Frame", nil, frame)
    frame.box:SetPoint("LEFT", frame, "LEFT", 0, 0)

    frame.box.bg = frame.box:CreateTexture(nil, "ARTWORK")
    frame.box.bg:SetAllPoints()
    frame.box.bg:SetTexture(DB.Backdrop)
    frame.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.box.hl = frame.box:CreateTexture(nil, "OVERLAY")
    frame.box.hl:Hide()
    frame.box.hl:SetAllPoints()
    frame.box.hl:SetTexture(DB.Backdrop)
    frame.box.hl:SetVertexColor(1.00, 1.00, 1.00, 0.30)

    frame.box.shadow = S.MakeShadow(frame.box, 1)
    frame.box.shadow:SetFrameLevel(frame.box:GetFrameLevel())

    return frame
end

function CB.UpdateDataBinding(self)
    local data = self.data

    if not data then
        return 0
    end

    self.OnDataChanged = data.OnDataChanged

    if data.value then
        self.box.bg:SetVertexColor(r, g, b, 1.00)
    else
        self.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
    end
end

function CB.GetData(self, ...)
    return self.data
end

function CB.SetData(self, data, ...)
    self.data = data

    CB.UpdateDataBinding(self)
end

function CB.GetBoxSize(self, ...)
    return self.box:GetSize()
end

function CB.SetBoxSize(self, width, height, ...)
    self:SetSize(width, height)
    self.box:SetSize(height, height)

    CB.UpdateDataBinding(self)
end

function S.CreateCheckBox(parent)
    local instance = CB.CreateInstance(parent)

    local function OnEnter(self, ...)
        instance.box.hl:Show()
    end

    local function OnLeave(self, ...)
        instance.box.hl:Hide()
    end

    local function OnClick(self, btn, ...)
        local data = instance.data

        if not data.value then
            data.value = true
            instance.box.bg:SetVertexColor(r, g, b, 1.00)
        else
            data.value = false
            instance.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
        end

        if instance.OnDataChanged then
            instance.OnDataChanged(instance, data, ...)
        end
    end

    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnClick", OnClick)

    instance.GetData = CB.GetData
    instance.SetData = CB.SetData
    instance.GetBoxSize = CB.GetBoxSize
    instance.SetBoxSize = CB.SetBoxSize

    return instance
end
