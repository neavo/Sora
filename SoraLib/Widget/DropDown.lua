-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local DD = {}

-- Common
function DD.Create(parent, fontSize)
    local frame = CreateFrame("Button", nil, parent)

    frame.bg = frame:CreateTexture(nil, "BORDER")
    frame.bg:SetAllPoints()
    frame.bg:SetTexture(DB.Backdrop)
    frame.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)

    frame.shadow = CreateFrame("Frame", nil, frame)
    frame.shadow:SetFrameLevel(frame:GetFrameLevel())
    frame.shadow:SetPoint("TOPLEFT", frame, -1, 1)
    frame.shadow:SetPoint("BOTTOMRIGHT", frame, 1, -1)
    frame.shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = 1})
    frame.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    frame.btn = S.MakeText(frame, fontSize + 4)
    frame.btn:SetText("▽")
    frame.btn:SetPoint("RIGHT", frame, "RIGHT", 0, 0)

    frame.split = frame:CreateTexture(nil, "ARTWORK")
    frame.split:SetTexture(DB.Border)
    frame.split:SetVertexColor(0.00, 0.00, 0.00, 1.00)
    frame.split:SetPoint("RIGHT", frame.btn, "LEFT", 0, 0)

    frame.text = S.MakeText(frame, fontSize)
    frame.text:SetPoint("RIGHT", frame.split, "LEFT", 0, 0)

    frame.menu = CreateFrame("Frame", nil, frame)
    frame.menu:Hide()
    frame.menu:SetPoint("TOP", frame, "BOTTOM", 0, -2)

    frame.menu.bg = frame.menu:CreateTexture(nil, "BORDER")
    frame.menu.bg:SetAllPoints()
    frame.menu.bg:SetTexture(DB.Backdrop)
    frame.menu.bg:SetVertexColor(0.12, 0.12, 0.12, 0.75)

    frame.menu.shadow = CreateFrame("Frame", nil, frame.menu)
    frame.menu.shadow:SetFrameLevel(frame.menu:GetFrameLevel())
    frame.menu.shadow:SetPoint("TOPLEFT", frame.menu, -1, 1)
    frame.menu.shadow:SetPoint("BOTTOMRIGHT", frame.menu, 1, -1)
    frame.menu.shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = 1})
    frame.menu.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return frame
end

function DD.OnEnter(self, ...)
    self.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
    self.shadow:SetBackdropBorderColor(r, g, b, 1.00)
end

function DD.OnLeave(self, ...)
    self.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
    self.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
end

function DD.OnClick(self, btn, ...)
    if self.menu:IsShown() then
        self.menu:Hide()
    else
        self.menu:Show()
    end
end

function DD.OnChildDataChanged(self, data, ...)
    local frame = self:GetParent():GetParent()
    local datas = frame:GetData()
    local index = self:GetID()

    for k, v in pairs(datas) do
        v.checked = k == index
    end

    DD.UpdateDataBinding(frame)

    if frame.OnDataChanged then
        frame:OnDataChanged(frame:GetData(), ...)
    end
end

function DD.UpdateDataBinding(self)
    self.menu.childs = self.menu.childs or {}

    local data = self.data
    local childs = self.menu.childs

    for k, v in pairs(childs) do
        S.KillFrame(v)
    end

    table.wipe(childs)

    for k, v in pairs(data) do
        local child = S.CreateCheckBox(self.menu, select(2, self.text:GetFont()))
        child:SetSize(self:GetWidth() - 8, self:GetHeight())
        child:SetID(k)
        child:SetData(v)

        if v.checked then
            self.text:SetText(v.text)
        end

        if k == 1 then
            child:SetPoint("TOP", self.menu, "TOP", 0, -4)
        else
            child:SetPoint("TOP", childs[k - 1], "BOTTOM", 0, -2)
        end

        child.OnDataChanged = DD.OnChildDataChanged

        table.insert(childs, child)
    end

    self.menu:SetSize(self:GetWidth(), childs[1]:GetHeight() * #childs + 2 * (#childs - 1) + 8)
end

local function GetSize(self, ...)
    return self:__GetSize()
end

local function SetSize(self, width, height, ...)
    self:__SetSize(width, height)

    self.btn:SetSize(height, height)
    self.text:SetSize(width - height - 1, height)
    self.split:SetSize(1, height - 2)
end

local function GetData(self, ...)
    return self.data
end

local function SetData(self, data, ...)
    self.data = data

    DD.UpdateDataBinding(self)
end

function S.CreateDropDown(parent, fontSize)
    local frame = DD.Create(parent, fontSize)

    frame:SetScript("OnLeave", DD.OnLeave)
    frame:SetScript("OnEnter", DD.OnEnter)
    frame:SetScript("OnClick", DD.OnClick)

    frame.__GetSize = frame.GetSize
    frame.__SetSize = frame.SetSize

    frame.GetSize = GetSize
    frame.SetSize = SetSize
    frame.GetData = GetData
    frame.SetData = SetData

    return frame
end
