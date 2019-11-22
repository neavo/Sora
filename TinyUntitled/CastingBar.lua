
-------------------------------------
-- 系統施法條都顯示施法時間
-------------------------------------

local function GetFrame(parent)
    if (parent:IsForbidden()) then return end
    if (not parent.CooldownText) then
        local height = parent:GetHeight()
        local fontsize = max(6, floor(height*8/13))
        parent.itimer = 0
        parent.CooldownText = parent:CreateFontString()
        parent.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), fontsize, "OUTLINE")
        parent.CooldownText:SetWidth(60)
        parent.CooldownText:SetJustifyH("RIGHT")
        parent.CooldownText:SetPoint("RIGHT", parent, "RIGHT", -2, 1)
    end
    return parent
end

local function ShowCastingCooldownText(self, elapsed)
    local frame = GetFrame(self)
    if (frame) then
        frame.itimer = frame.itimer + elapsed
        if (frame.itimer > 0.1) then
            frame.itimer = 0
            if self.casting then
                frame.CooldownText:SetText(format("%.1f/%.1f", max(self.value, 0), self.maxValue))
            elseif self.channeling then
                frame.CooldownText:SetText(format("%.1f", max(self.value, 0)))
            else
                frame.CooldownText:SetText("")
            end
        end
    end
end

hooksecurefunc("CastingBarFrame_OnUpdate", ShowCastingCooldownText)

hooksecurefunc("CastingBarFrame_OnEvent", function(self, event, ...)
    if (self:IsForbidden()) then return end
    local hasHooked = self:GetAttribute("hasHooked")
    if (not hasHooked) then
        self:SetAttribute("hasHooked", true)
        self:HookScript("OnUpdate", ShowCastingCooldownText)
    end
end)

if (CastingBarFrame) then
    CastingBarFrame:HookScript("OnUpdate", ShowCastingCooldownText)
    CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
    CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
    CastingBarFrame.Border:SetPoint("TOP", 0, 26)
    CastingBarFrame.Text:SetPoint("TOP", 0, 3)
    CastingBarFrame.Icon:Show()
    CastingBarFrame.Icon:SetSize(20,20)
end

hooksecurefunc("MirrorTimerFrame_OnUpdate", function(self, elapsed)
    if (self.paused) then return end
    if (not self.CooldownText) then
        self.CooldownText = self:CreateFontString(nil)
        self.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), 8, "OUTLINE")
        self.CooldownText:SetWidth(100)
        self.CooldownText:SetJustifyH("RIGHT")
        self.CooldownText:SetPoint("RIGHT", self, "RIGHT", -10, 6)
        self.itimer = 0
        _G[self:GetName().."Border"]:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
        _G[self:GetName().."StatusBar"]:SetHeight(14)
        _G[self:GetName().."StatusBar"]:SetPoint("TOP", 0, -1)
    end
    self.itimer = self.itimer + elapsed
    if (self.itimer > 0.5) then
        self.itimer = 0
        self.CooldownText:SetText(floor(self.value))
    end
end)
