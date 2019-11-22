
-------------------------------------
-- 目標框架: 顯示debuff倒計時
-------------------------------------

hooksecurefunc("TargetFrame_UpdateAuras", function(self)
    local selfName = self:GetName()
    local maxDebuffs = self.maxDebuffs or MAX_TARGET_DEBUFFS
    local _, frame, debuffName, duration
	for i = 1, maxDebuffs do
        frame = _G[selfName.."Debuff"..i.."Cooldown"]
        if (frame) then
            debuffName, _, _, _, duration = UnitDebuff(self.unit, i, "PLAYER")
            if (debuffName and duration and duration <= 60) then
                frame:SetHideCountdownNumbers(false)
            else
                frame:SetHideCountdownNumbers(true)
            end
        end
    end
end)


-------------------------------------
-- 目標框架&專注框架: 顯示職業顔色
-------------------------------------

hooksecurefunc("TargetFrame_Update", function(self)
    local _, class, color
    local unit = self.overrideName or self.unit
    if (self:IsShown() and UnitIsPlayer(unit)) then
        _, class = UnitClass(unit)
        color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
        self.name:SetTextColor(color.r, color.g, color.b)
        self.name:SetText(UnitName(unit))
        if UnitIsFriend("player", unit) then
            self.nameBackground:SetVertexColor(0.2, 0.2, 0.2, 0.4)
            if (class == "DEATHKNIGHT") then
                self.name:SetTextColor(0.88, 0.32, 0.32)
            end
        elseif UnitIsEnemy("player", unit) then
            local r, g, b = UnitSelectionColor(unit)
            self.nameBackground:SetVertexColor(r, g, b, 0.2)
        end
    else
        self.name:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
    end
end)


-------------------------------------
-- 目標的目標&專注目標的目標: 職業顔色
-------------------------------------

hooksecurefunc("UnitFrame_Update", function(self, isParty)
    if ((self.unit == "targettarget" or self.unit == "focus-target") and self:IsShown()) then
        local _, class, color
        if (UnitExists(self.unit)) then
            _, class = UnitClass(self.unit)
            color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
            self.name:SetText(UnitName(self.unit))
            self.name:SetTextColor(color.r, color.g, color.b)
        end
    end
end)


-------------------------------------
-- 敵方目標血條紅色顯示
-------------------------------------

--目標和專注
hooksecurefunc("HealthBar_OnValueChanged", function(self, value, smooth)
    if (self.unit == "target" or self.unit == "focus") then
        --以下是HP百分比顯示
        local _, maxHealth = self:GetMinMaxValues()
        local hpPercent = ""
        if (maxHealth) then
            local p = self:GetValue() / maxHealth * 100
            if (p > 25) then
                hpPercent = format("%d%%", p)
            else
                hpPercent = format("|cffff8811%.1f%%|r", p)
            end
        end
        if (not self.healthPercentString) then
            self.healthPercentString = self:CreateFontString(nil)
            self.healthPercentString:SetFont(SystemFont_Outline_Small:GetFont(), 9, "OUTLINE")
            self.healthPercentString:SetPoint("RIGHT", self, "LEFT", -2, 0)
        end
        self.healthPercentString:SetText(hpPercent)
    end
end)

--目標的目標和專注的目標等
hooksecurefunc("UnitFrame_Update", function(self, isParty)
    if ((self.unit == "target" or self.unit == "focus" or self.unit == "targettarget" or self.unit == "focus-target")
        and self:IsShown()) then
        if UnitCanAttack(self.unit, "player") then
            self.healthbar:SetStatusBarColor(0.9, 0.1, 0.1)
        elseif (UnitIsEnemy("player", self.unit)) then
            local r, g, b = UnitSelectionColor(self.unit)
            if (r < 0.9) then
                self.healthbar:SetStatusBarColor(0.9, 0.1, 0.25)
            else
                self.healthbar:SetStatusBarColor(r, g, b)
            end
        end
    end
end)
