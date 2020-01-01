-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local _, class = UnitClass("player")
local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

-- Initialize
local DD = {}

-- Common
function DD.CreateInstance(parent, fontSize)
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

    frame.right = S.MakeText(frame, fontSize + 4)
    frame.right:SetText("▽")
    frame.right:SetPoint("RIGHT", frame, "RIGHT", 0, 0)

    frame.split = frame:CreateTexture(nil, "ARTWORK")
    frame.split:SetTexture(DB.Border)
    frame.split:SetVertexColor(0.00, 0.00, 0.00, 1.00)
    frame.split:SetPoint("RIGHT", frame.right, "LEFT", 0, 0)

    frame.left = S.MakeText(frame, fontSize)
    frame.left:SetPoint("LEFT", frame, "LEFT", 0, 0)

    frame.menu = CreateFrame("Frame", nil, frame)
    frame.menu:Hide()
    frame.menu:EnableMouse(true)
    frame.menu:SetFrameStrata("DIALOG")
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

function DD.UpdateDataBinding(self)
    if not self.data then
        return
    end

    if not self.menu.childs then
        self.menu.childs = {}
    end

    local value = self.data.value
    local childs = self.menu.childs
    local options = self.data.options

    for k, v in pairs(childs) do
        S.KillFrame(v)
    end
    table.wipe(childs)

    local i = 1
    for k, v in pairs(options) do
        local child = CreateFrame("Button", nil, self.menu)
        child:SetSize(self:GetWidth() - 8, self:GetHeight())

        child.hl = child:CreateTexture(nil, "OVERLAY")
        child.hl:Hide()
        child.hl:SetAllPoints()
        child.hl:SetTexture(DB.Backdrop)
        child.hl:SetVertexColor(1.00, 1.00, 1.00, 0.30)

        child.text = S.MakeText(child, select(2, self.left:GetFont()))
        child.text:SetText(k)
        child.text:SetPoint("CENTER", child, "CENTER", 0, 0)

        if v == value then
            self.left:SetText(k)
        end

        local function OnEnter(_, ...)
            child.hl:Show()
        end

        local function OnLeave(_, ...)
            child.hl:Hide()
        end

        local function OnClick(_, btn, ...)
            self.data.value = v

            self.menu:Hide()
            self.OnDataChanged(self, self.data, ...)

            DD.UpdateDataBinding(self)
        end

        child:SetScript("OnEnter", OnEnter)
        child:SetScript("OnLeave", OnLeave)
        child:SetScript("OnClick", OnClick)

        if i == 1 then
            child:SetPoint("TOP", self.menu, "TOP", 0, -4)
        else
            child:SetPoint("TOP", childs[i - 1], "BOTTOM", 0, -2)
        end

        i = i + 1
        table.insert(childs, child)
    end

    self.menu:SetSize(self:GetWidth(), childs[1]:GetHeight() * #childs + 2 * (#childs - 1) + 8)
end

function DD.GetData(self)
    return self.data
end

function DD.SetData(self, data)
    self.data = data

    DD.UpdateDataBinding(self)
end

function DD.GetSelectorSize(self)
    return self:GetSize()
end

function DD.SetSelectorSize(self, width, height)
    self:SetSize(width, height)
    self.left:SetSize(width - height - 1, height)
    self.split:SetSize(1, height - 2)
    self.right:SetSize(height, height)

    DD.UpdateDataBinding(self)
end

function S.CreateDropDown(parent, fontSize)
    local instance = DD.CreateInstance(parent, fontSize)

    local function OnEnter(self, ...)
        instance.bg:SetVertexColor(r / 4, g / 4, b / 4, 1.00)
        instance.shadow:SetBackdropBorderColor(r, g, b, 1.00)
    end

    local function OnLeave(self, ...)
        instance.bg:SetVertexColor(0.30, 0.30, 0.30, 0.30)
        instance.shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)
    end

    local function OnClick(self, btn, ...)
        if instance.menu:IsVisible() then
            instance.menu:Hide()
        else
            instance.menu:Show()
        end
    end

    instance:SetScript("OnLeave", OnLeave)
    instance:SetScript("OnEnter", OnEnter)
    instance:SetScript("OnClick", OnClick)

    instance.GetData = DD.GetData
    instance.SetData = DD.SetData
    instance.GetSelectorSize = DD.GetSelectorSize
    instance.SetSelectorSize = DD.SetSelectorSize

    return instance
end
