
local INTERRUPT = "interrupted"

-------------------------------------
-- 所有TextStatusBarText字號小一點
-------------------------------------

local fontFile, fontSize, fontFlags = TextStatusBarText:GetFont()

if (GetLocale():sub(1,2) == "zh") then
    TextStatusBarText:SetFont(fontFile, fontSize-3, fontFlags)
    _G["FocusFrameTextureFrameHealthBarText"]:SetFont(fontFile, fontSize-3, fontFlags)
else
    TextStatusBarText:SetFont(fontFile, fontSize-1, fontFlags)
    _G["FocusFrameTextureFrameHealthBarText"]:SetFont(fontFile, fontSize-1, fontFlags)
end

--職業顔色
local color = RAID_CLASS_COLORS[select(2,UnitClass("player"))] or NORMAL_FONT_COLOR
PlayerName:SetTextColor(color.r, color.g, color.b)


-----------------------------------
-- 自動根據是否戰鬥隱藏頭像
-----------------------------------
hooksecurefunc("PlayerFrame_UpdateStatus", function()
    local _, instanceType = IsInInstance()
    if (PlayerFrame.inCombat or PlayerFrame.onHateList or instanceType == "arena") then
        PlayerFrame:SetAlpha(1)
    else
        PlayerFrame:SetAlpha(0.4)
    end
end)


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


-------------------------------------
-- 隱藏HP/MP
-------------------------------------
hooksecurefunc("TextStatusBar_UpdateTextString", function(textStatusBar)
	local name = textStatusBar:GetName()
    if (name == "PartyMemberFrame1HealthBar"
        or name == "PartyMemberFrame2HealthBar"
        or name == "PartyMemberFrame3HealthBar"
        or name == "PartyMemberFrame4HealthBar"
        or name == "PartyMemberFrame1ManaBar"
        or name == "PartyMemberFrame2ManaBar"
        or name == "PartyMemberFrame3ManaBar"
        or name == "PartyMemberFrame4ManaBar"
        or name == "ArenaEnemyFrame1HealthBar"
        or name == "ArenaEnemyFrame2HealthBar"
        or name == "ArenaEnemyFrame3HealthBar"
        or name == "ArenaEnemyFrame4HealthBar"
        or name == "ArenaEnemyFrame1ManaBar"
        or name == "ArenaEnemyFrame2ManaBar"
        or name == "ArenaEnemyFrame3ManaBar"
        or name == "ArenaEnemyFrame4ManaBar"
        or name == "PetFrameHealthBar"
        or name == "PetFrameManaBar") then
        if (textStatusBar.lockShow == 0) then
            textStatusBar.TextString:Hide()
            if (textStatusBar.LeftText) then textStatusBar.LeftText:Hide() end
            if (textStatusBar.RightText) then textStatusBar.RightText:Hide() end
        end
    end
end)


-------------------------------------
-- 打斷提示 
-------------------------------------
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
frame:SetScript("OnEvent", function(self, event, ...)
    local _, subevent, _, _, sourceName, sourceFlag, _, _, destName, _, _, _, _, _, extraSpellID = CombatLogGetCurrentEventInfo()
    if (subevent ~= 'SPELL_INTERRUPT') then return end
    if (bit.band(sourceFlag, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0) then return end
    if (not sourceName) then return end
    local msg = format("%s -%s- %s", sourceName or "", INTERRUPT, GetSpellLink(extraSpellID))
    if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
        SendChatMessage(msg, "INSTANCE_CHAT")
    elseif (IsInRaid()) then
        SendChatMessage(msg, "RAID")
    elseif (IsInGroup()) then
        SendChatMessage(msg, "PARTY")
    end
end)


-------------------------------------
-- 大祕境面板 
-------------------------------------
local function GetStoneUpgradeNum(timeUsed, timeLimit)
    local percent = timeUsed / timeLimit
    if (percent > 1) then return ""
    elseif (percent > 0.8) then return "+1"
    elseif (percent > 0.6) then return "+2"
    else return "+3" end
end

local function SetTimeLimit(self)
    if (not self.hasHooked) then
        self.hasHooked = true
        self:HookScript("OnEnter", function(self)
            local _, _, timeLimit = C_ChallengeMode.GetMapUIInfo(self.mapID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("限定時間")
            GameTooltip:AddLine(GetTimeStringFromSeconds(timeLimit), 1, 1, 1)
            GameTooltip:AddLine(format("%s: %s", "MapID", self.mapID))
            GameTooltip:Show()
        end)
        self.LevelButton = CreateFrame("Button", nil, self, "UIPanelInfoButton")
        self.LevelButton:SetScale(0.9)
        self.LevelButton:SetPoint("BOTTOM", self, "BOTTOM", 0, 4)
        self.LevelButton:SetScript("OnEnter", function(self)
            local parent = self:GetParent()
            local _, _, timeLimit = C_ChallengeMode.GetMapUIInfo(parent.mapID)
            parent:OnEnter()
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("限定時間")
            GameTooltip:AddLine(GetTimeStringFromSeconds(timeLimit), 1, 1, 1)
            GameTooltip:AddLine(format("%s: %s", "MapID", parent.mapID))
            GameTooltip:Show()
        end)
        self.LevelButton:SetScript("OnLeave", function(self)
            GameTooltip_Hide()
        end)
        self.LevelButton:SetScript("OnClick", function(self)
            local parent = self:GetParent()
            local name, _, timeLimit = C_ChallengeMode.GetMapUIInfo(parent.mapID)
            local sec, level = C_MythicPlus.GetSeasonBestForMap(parent.mapID)
            if (sec and level) then
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                ChatEdit_InsertLink(format("(%s%s)%s %s", level, GetStoneUpgradeNum(sec,timeLimit), name, GetTimeStringFromSeconds(sec)))
            end
        end)
    end
end

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, ...)
    local arg1 = ...
    if (arg1 == "Blizzard_ChallengesUI") then
        self:UnregisterEvent("ADDON_LOADED")
        hooksecurefunc("ChallengesFrame_Update", function(self)
            local frames = self.DungeonIcons
            for i = 1, #frames do
                SetTimeLimit(frames[i])
            end
        end)
    end
end)
