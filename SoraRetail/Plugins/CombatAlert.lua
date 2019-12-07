-----------------------------------
-- 離開和進入戰鬥,大文字提示
-----------------------------------
local locale = GetLocale()
local L = {
    enterCombat = { default = "Enter Combat", zhTW = "進入戰鬥", zhCN = "进入战斗" },
    leaveCombat = { default = "Leave Combat", zhTW = "離開戰鬥", zhCN = "离开战斗" },
}
local alertFrame = CreateFrame("Frame")
alertFrame:SetSize(400, 65)
alertFrame:SetPoint("TOP", 0, -280)
alertFrame:SetScale(0.7)
alertFrame:Hide()
alertFrame.Bg = alertFrame:CreateTexture(nil, "BACKGROUND")
alertFrame.Bg:SetTexture("Interface\\LevelUp\\MinorTalents")
alertFrame.Bg:SetPoint("TOP")
alertFrame.Bg:SetSize(400, 67)
alertFrame.Bg:SetTexCoord(0, 400/512, 341/512, 407/512)
alertFrame.Bg:SetVertexColor(1, 1, 1, 0.4)
alertFrame.text = alertFrame:CreateFontString(nil, "ARTWORK", "GameFont_Gigantic")
alertFrame.text:SetPoint("CENTER")
alertFrame.text:SetShadowOffset(1, -1)
alertFrame.text:SetShadowColor(0, 0, 0, 0.5)
alertFrame:SetScript("OnUpdate", function(self, elapsed)
    self.timer = self.timer + elapsed
    if (self.timer > self.totalTime) then self:Hide() end
    if (self.timer <= 0.5) then
        self:SetAlpha(self.timer * 2)
    elseif (self.timer > 2) then
        self:SetAlpha(1-self.timer/self.totalTime)
    end
end)
alertFrame:SetScript("OnShow", function(self)
    self.totalTime = 3.2
    self.timer = 0
end)
alertFrame:SetScript("OnEvent", function(self, event, ...)
    self:Hide()
    if (event == "PLAYER_REGEN_DISABLED") then
        self.text:SetText(L.enterCombat[locale] or L.enterCombat.default)
    elseif (event == "PLAYER_REGEN_ENABLED") then
        self.text:SetText(L.leaveCombat[locale] or L.leaveCombat.default)
    end
    self:Show()
end) 
alertFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
alertFrame:RegisterEvent("PLAYER_REGEN_DISABLED")