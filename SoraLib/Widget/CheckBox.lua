-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local function Create(parent, fontSize)
    local frame = CreateFrame("Button", nil, parent)

    frame.box = CreateFrame("Frame", nil, frame)
    frame.box:SetPoint("LEFT", frame, "LEFT", 0, 0)

    frame.box.bg = frame.box:CreateTexture(nil, "BORDER")
    frame.box.bg:SetAllPoints()
    frame.box.bg:SetTexture(DB.Backdrop)
    frame.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.box.hl = frame.box:CreateTexture(nil, "OVERLAY")
    frame.box.hl:Hide()
    frame.box.hl:SetAllPoints()
    frame.box.hl:SetTexture(DB.Backdrop)
    frame.box.hl:SetVertexColor(1.00, 1.00, 1.00, 0.30)

    frame.box.shadow = CreateFrame("Frame", nil, frame.box)
    frame.box.shadow:SetFrameLevel(frame.box:GetFrameLevel())
    frame.box.shadow:SetPoint("TOPLEFT", frame.box, -1, 1)
    frame.box.shadow:SetPoint("BOTTOMRIGHT", frame.box, 1, -1)
    frame.box.shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = 1})
    frame.box.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    frame.text = S.MakeText(frame, fontSize)
    frame.text:SetPoint("LEFT", frame.box, "RIGHT", 8, 0)

    return frame
end

local function OnEnter(self, ...)
    self.box.hl:Show()
end

local function OnLeave(self, ...)
    self.box.hl:Hide()
end

local function OnClick(self, btn, ...)
    local data = self.data

    if data.checked then
        data.checked = false
        self.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
    else
        data.checked = true
        self.box.bg:SetVertexColor(r, g, b, 1.00)
    end

    if self.OnDataChanged then
        self:OnDataChanged(data, ...)
    end
end

local function UpdateDataBinding(self)
    local data = self.data

    if data.text then
        self.text:SetText(data.text)
    end

    if data.checked then
        self.box.bg:SetVertexColor(r, g, b, 1.00)
    else
        self.box.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
    end
end

local function GetSize(self, ...)
    return self:__GetSize()
end

local function SetSize(self, width, height, ...)
    self:__SetSize(width, height)

    self.box:SetSize(height - 4, height - 4)
end

local function GetData(self, ...)
    return self.data
end

local function SetData(self, data, ...)
    self.data = data

    UpdateDataBinding(self)
end

function S.CreateCheckBox(parent, fontSize)
    local frame = Create(parent, fontSize)

    frame:SetScript("OnLeave", OnLeave)
    frame:SetScript("OnEnter", OnEnter)
    frame:SetScript("OnClick", OnClick)

    frame.__GetSize = frame.GetSize
    frame.__SetSize = frame.SetSize

    frame.GetSize = GetSize
    frame.SetSize = SetSize
    frame.GetData = GetData
    frame.SetData = SetData

    return frame
end
