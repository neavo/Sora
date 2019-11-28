-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local addons = {}
local anchors = {}
local solts = {1, 3, 5, 6, 7, 8, 9, 10, 16, 17}

-- Begin
local function OnLeave(self, event, ...)
    GameTooltip:Hide()
end

local function OnPingBarEnter(self, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    local _, _, latencyHome, latencyWorld = GetNetStats()
    GameTooltip:AddLine("延迟：", 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("本地延迟：", latencyHome, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
    GameTooltip:AddDoubleLine("世界延迟：", latencyWorld, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
    
    GameTooltip:Show()
end

local function OnClockBarEnter(self, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    GameTooltip:AddLine(date "%A, %B %d", 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_LOCALTIME, GameTime_GetLocalTime(true), 0.75, 0.90, 1.00, 1.00, 1.00, 1.00)
    GameTooltip:AddDoubleLine(TIMEMANAGER_TOOLTIP_REALMTIME, GameTime_GetGameTime(true), 0.75, 0.90, 1.00, 1.00, 1.00, 1.00)
    
    GameTooltip:Show()
end

local function OnAddonBarEnter(self, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    local currMemory = 0
    for key, value in pairs(addons) do
        currMemory = currMemory + value.addonMemory
    end
    
    GameTooltip:AddDoubleLine(
        "总共内存使用：", S.FormatMemory(currMemory), 0.40, 0.78, 1.00, 0.84, 0.75, 0.65
    )
    GameTooltip:AddLine(" ")
    
    for key, value in pairs(addons) do
        if value.isLoaded then
            currMemory = currMemory + value.addonMemory
            
            GameTooltip:AddDoubleLine(value.addonName, S.FormatMemory(value.addonMemory), 1.00, 1.00, 1.00, 0.00, 1.00, 0.00
        )
        end
    end
    
    GameTooltip:Show()
end

local function OnGoldBarEnter(self, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    local money = GetMoney()
    local gold = floor(money / 100 / 100)
    local sliver = floor((money - gold * 100 * 100) / 100)
    local copper = floor((money - gold * 100 * 100 - sliver * 100))
    
    GameTooltip:AddLine("货币：", 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine(
        "金币：", ("%d|cffffd700G|r %d|cffc7c7cfS|r %d|cffb87333C|r"):format(gold, sliver, copper), 1.00, 1.00, 1.00, 1.00, 1.00, 1.00
    )
    GameTooltip:Show()
end

local function OnItemBarEnter(self, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    local maxDurability, currDurability = 0, 0
    
    for key, value in pairs(solts) do
        if GetInventoryItemLink("player", value) ~= nil then
            local curr, max = GetInventoryItemDurability(value)
            
            if curr and max then
                maxDurability = maxDurability + max
                currDurability = currDurability + curr
            end
        end
    end
    
    local value = currDurability / maxDurability * 100
    
    GameTooltip:AddLine("装备：", 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine(
        "耐久：", string.format("%.2f%%", value), 1.00, 1.00, 1.00, 1.00, 1.00, 1.00
    )
    GameTooltip:Show()
end

local function OnExperienceBarEnter(self, event, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    GameTooltip:AddLine(self.onEnterInfoLine:GetText(), 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("经验：", self.onEnterValueLine:GetText(), 1.00, 1.00, 1.00)
    GameTooltip:AddDoubleLine("休息：", self.onEnterRestedLine:GetText(), 1.00, 1.00, 1.00)
    
    GameTooltip:Show()
end

local function OnReputationBarEnter(self, event, ...)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:ClearLines()
    
    GameTooltip:AddLine(self.onEnterInfoLine:GetText(), 0.40, 0.78, 1.00)
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine("声望：", self.onEnterValueLine:GetText(), 1.00, 1.00, 1.00)
    
    GameTooltip:Show()
end

local function SetPingBar()
    local bar = CreateFrame("StatusBar", nil, anchors[1])
    bar:SetPoint("BOTTOMLEFT")
    bar:SetMinMaxValues(0, 1000)
    bar:SetStatusBarTexture(DB.Statusbar)
    bar:SetStatusBarColor(0.00, 0.40, 1.00)
    bar:SetSize((C.MiniMap.Width - 4 * 2) / 3, C.MiniMap.BarHeight)
    
    bar.text = S.MakeText(bar, 10)
    bar.text:SetText("0ms")
    bar.text:SetPoint("CENTER", 0, 5)
    
    bar.shadow = S.MakeShadow(bar, 2)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetTexture(DB.Statusbar)
    bar.bg:SetAllPoints()
    bar.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    bar:SetScript("OnLeave", OnLeave)
    bar:SetScript("OnEnter", OnPingBarEnter)
    
    anchors[1].pingBar = bar
end

local function SetClockBar(self, ...)
    GameTimeFrame:Hide()
    TimeManagerClockButton:Hide()
    
    local bar = CreateFrame("Frame", nil, anchors[1])
    bar:SetPoint("BOTTOM")
    bar:SetSize((C.MiniMap.Width - 4 * 2) / 3, C.MiniMap.BarHeight * 2)
    
    bar.text = S.MakeText(bar, 14)
    bar.text:SetAllPoints()
    
    bar:SetScript("OnLeave", OnLeave)
    bar:SetScript("OnEnter", OnClockBarEnter)
    
    anchors[1].clockBar = bar
end

local function SetAddonBar(self, ...)
    local bar = CreateFrame("StatusBar", nil, anchors[1])
    bar:SetPoint("BOTTOMRIGHT")
    bar:SetMinMaxValues(0, 128 * 1024)
    bar:SetStatusBarTexture(DB.Statusbar)
    bar:SetStatusBarColor(0.00, 0.40, 1.00)
    bar:SetSize((C.MiniMap.Width - 4 * 2) / 3, C.MiniMap.BarHeight)
    
    bar.text = S.MakeText(bar, 10)
    bar.text:SetText("N/A")
    bar.text:SetPoint("CENTER", 0, 5)
    
    bar.shadow = S.MakeShadow(bar, 2)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetTexture(DB.Statusbar)
    bar.bg:SetAllPoints()
    bar.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    bar:SetScript("OnLeave", OnLeave)
    bar:SetScript("OnEnter", OnAddonBarEnter)
    
    anchors[1].addonBar = bar
end

local function SetPCABar(self, ...)
    anchors[1] = CreateFrame("Frame", nil, self)
    anchors[1]:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 3)
    
    SetPingBar(self, ...)
    SetClockBar(self, ...)
    SetAddonBar(self, ...)
end

local function SetGoldBar(self, ...)
    local bar = CreateFrame("StatusBar", nil, anchors[2])
    bar:SetPoint("BOTTOMLEFT")
    bar:SetMinMaxValues(0, 999999)
    bar:SetStatusBarTexture(DB.Statusbar)
    bar:SetStatusBarColor(0.00, 0.40, 1.00)
    bar:SetSize((C.MiniMap.Width - 4) / 2, C.MiniMap.BarHeight)
    
    bar.text = S.MakeText(bar, 10)
    bar.text:SetText("N/A")
    bar.text:SetPoint("CENTER", 0, 5)
    
    bar.shadow = S.MakeShadow(bar, 2)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetTexture(DB.Statusbar)
    bar.bg:SetAllPoints()
    bar.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    bar:SetScript("OnLeave", OnLeave)
    bar:SetScript("OnEnter", OnGoldBarEnter)
    
    anchors[2].goldBar = bar
end

local function SetItemBar()
    local bar = CreateFrame("StatusBar", nil, anchors[2])
    bar:SetPoint("BOTTOMRIGHT")
    bar:SetMinMaxValues(0, 100)
    bar:SetStatusBarTexture(DB.Statusbar)
    bar:SetStatusBarColor(0.00, 0.40, 1.00)
    bar:SetSize((C.MiniMap.Width - 4) / 2, C.MiniMap.BarHeight)
    
    bar.text = S.MakeText(bar, 10)
    bar.text:SetText("N/A")
    bar.text:SetPoint("CENTER", 0, 5)
    
    bar.shadow = S.MakeShadow(bar, 2)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetTexture(DB.Statusbar)
    bar.bg:SetAllPoints()
    bar.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    bar:SetScript("OnLeave", OnLeave)
    bar:SetScript("OnEnter", OnItemBarEnter)
    
    anchors[2].itemBar = bar
end

local function SetGoldItemBar(self, ...)
    anchors[2] = CreateFrame("Frame", nil, self)
    anchors[2]:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 3)
    
    SetGoldBar(self, ...)
    SetItemBar(self, ...)
end

local function SetExperienceBar(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 3)
    
    local experience = CreateFrame("StatusBar", nil, anchor)
    experience:EnableMouse(true)
    experience:SetPoint("BOTTOM")
    experience:SetStatusBarTexture(DB.Statusbar)
    experience:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight)
    
    experience.rested = CreateFrame("StatusBar", nil, experience)
    experience.rested:SetAllPoints(experience)
    experience.rested:SetStatusBarTexture(DB.Statusbar)
    experience.shadow = S.MakeShadow(experience, 2)
    
    experience.text = S.MakeText(experience, 10)
    experience.text:SetText("N/A")
    experience.text:SetPoint("CENTER", 0, 5)
    self:Tag(experience.text, "[experience:per]%")
    
    experience.bg = experience.rested:CreateTexture(nil, "BACKGROUND")
    experience.bg:SetTexture(DB.Statusbar)
    experience.bg:SetAllPoints()
    experience.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    experience:SetScript("OnLeave", OnLeave)
    experience:SetScript("OnEnter", OnExperienceBarEnter)
    
    experience.onEnterInfoLine = S.MakeText(experience, 10)
    experience.onEnterInfoLine:ClearAllPoints()
    self:Tag(experience.onEnterInfoLine, "[class] - Lv.[level]")
    
    experience.onEnterValueLine = S.MakeText(experience, 10)
    experience.onEnterValueLine:ClearAllPoints()
    self:Tag(experience.onEnterValueLine, "[experience:cur]/[experience:max] - [experience:per]%")
    
    experience.onEnterRestedLine = S.MakeText(experience, 10)
    experience.onEnterRestedLine:ClearAllPoints()
    self:Tag(experience.onEnterRestedLine, "[experience:currested] - [experience:perrested]%")
    
    anchors[3] = anchor
    self.Experience = experience
    self.Experience.Rested = experience.rested
end

local function SetReputationBar(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 3)
    
    local reputation = CreateFrame("StatusBar", nil, anchor)
    reputation:EnableMouse(true)
    reputation:SetPoint("BOTTOM")
    reputation:SetStatusBarTexture(DB.Statusbar)
    reputation:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight)
    
    reputation.colorStanding = true
    reputation.shadow = S.MakeShadow(reputation, 2)
    
    reputation.text = S.MakeText(reputation, 10)
    reputation.text:SetText("N/A")
    reputation.text:SetPoint("CENTER", 0, 5)
    self:Tag(reputation.text, "[reputation:per]%")
    
    reputation.bg = reputation:CreateTexture(nil, "BACKGROUND")
    reputation.bg:SetTexture(DB.Statusbar)
    reputation.bg:SetAllPoints()
    reputation.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    reputation:SetScript("OnLeave", OnLeave)
    reputation:SetScript("OnEnter", OnReputationBarEnter)
    
    reputation.onEnterInfoLine = S.MakeText(reputation, 10)
    reputation.onEnterInfoLine:ClearAllPoints()
    self:Tag(reputation.onEnterInfoLine, "[reputation:faction] - [reputation:standing]")
    
    reputation.onEnterValueLine = S.MakeText(reputation, 10)
    reputation.onEnterValueLine:ClearAllPoints()
    self:Tag(reputation.onEnterValueLine, "[reputation:cur]/[reputation:max] - [reputation:per]%")
    
    anchors[4] = anchor
    self.Reputation = reputation
end

local function SetArtifactPowerBar(self, ...)
    local anchor = CreateFrame("Frame", nil, self)
    anchor:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 3)
    
    local artifactPower = CreateFrame("StatusBar", nil, anchor)
    artifactPower:EnableMouse(true)
    artifactPower:SetPoint("BOTTOM")
    artifactPower:SetStatusBarTexture(DB.Statusbar)
    artifactPower:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight)
    
    artifactPower.text = S.MakeText(artifactPower, 10)
    artifactPower.text:SetText("N/A")
    artifactPower.text:SetPoint("CENTER", 0, 5)
    artifactPower.shadow = S.MakeShadow(artifactPower, 2)
    
    artifactPower.bg = artifactPower:CreateTexture(nil, "BACKGROUND")
    artifactPower.bg:SetTexture(DB.Statusbar)
    artifactPower.bg:SetAllPoints()
    artifactPower.bg:SetVertexColor(0.12, 0.12, 0.12)
    
    artifactPower.PostUpdate = function(self, event, isShown)
        if isShown then
            self.text:SetText(("%d%%"):format(self.current / self.max * 100))
        end
    end
    
    anchors[5] = anchor
    self.ArtifactPower = artifactPower
end

local function RegisterStyle(self, ...)
    self:SetPoint("TOP", Minimap, "BOTTOM", 0, 0)
    self:SetSize(C.MiniMap.Width, C.MiniMap.BarHeight * 5)
    
    SetPCABar(self, ...)
    SetGoldItemBar(self, ...)
    SetExperienceBar(self, ...)
    SetReputationBar(self, ...)
    SetArtifactPowerBar(self, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_InfoBar", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_InfoBar")
    
    local oUFFrame = oUF:Spawn("player", "oUF_Sora_InfoBar")
end

local function UpdateAnchors(self, ...)
    local bars = {}
    
    table.insert(bars, anchors[1])
    table.insert(bars, anchors[2])
    
    if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
        table.insert(bars, anchors[3])
    end
    
    if select(1, GetWatchedFactionInfo()) then
        table.insert(bars, anchors[4])
    end
    
    if HasArtifactEquipped() or (C_AzeriteItem and C_AzeriteItem.FindActiveAzeriteItem()) then
        table.insert(bars, anchors[5])
    end
    
    for k, v in ipairs(bars) do
        if k == 1 then
            v:SetPoint("TOP")
        else
            v:SetPoint("TOP", bars[k - 1], "BOTTOM", 0, 0)
        end
    end
end

local function UpdatePingBar(self, ...)
    local pingBar = anchors[1].pingBar
    local _, _, latencyHome, latencyWorld = GetNetStats()
    local value = (latencyHome > latencyWorld) and latencyHome or latencyWorld
    
    pingBar:SetValue(value)
    pingBar.text:SetText(value .. "ms")
    
    if value > 499 then
        pingBar:SetStatusBarColor(1.00, 0.00, 0.00)
    elseif value > 249 then
        pingBar:SetStatusBarColor(1.00, 1.00, 0.00)
    else
        pingBar:SetStatusBarColor(0.00, 0.40, 1.00)
    end
end

local function UpdateClockBar(self, ...)
    anchors[1].clockBar.text:SetText(GameTime_GetLocalTime(true))
end

local function UpdateAddonBar(self, ...)
    UpdateAddOnMemoryUsage()
    local addonCount = GetNumAddOns()
    
    if addonCount == #addons then
        return
    end
    
    addons = {}
    for i = 1, addonCount do
        local _ = nil
        local addon = {}
        
        addon.isLoaded = IsAddOnLoaded(i)
        _, addon.addonName = GetAddOnInfo(i)
        addon.addonMemory = GetAddOnMemoryUsage(i)
        
        addons[i] = addon
    end
    
    table.sort(addons, function(l, r)
        if l and r then
            return l.addonMemory > r.addonMemory
        end
    end)
    
    local currMemory = 0
    for key, value in pairs(addons) do
        currMemory = currMemory + value.addonMemory
    end
    
    local bar = anchors[1].addonBar
    
    bar:SetValue(currMemory)
    bar.text:SetText(S.FormatMemory(currMemory))
    
    if currMemory > 96 * 1024 then
        bar:SetStatusBarColor(1.00, 0.00, 0.00)
    elseif currMemory > 64 * 1024 then
        bar:SetStatusBarColor(1.00, 1.00, 0.00)
    else
        bar:SetStatusBarColor(0.00, 0.40, 1.00)
    end
end

local function UpdateGoldBar(self, ...)
    local money = GetMoney()
    local gold = floor(money / 100 / 100)
    
    local bar = anchors[2].goldBar
    bar:SetValue(money / 100 / 100)
    bar.text:SetText(("%d|cffffd700G|r"):format(gold))
end

local function UpdateItemBar(self, ...)
    local bar = anchors[2].itemBar
    local maxDurability, currDurability = 0, 0
    
    for key, value in pairs(solts) do
        if GetInventoryItemLink("player", value) ~= nil then
            local curr, max = GetInventoryItemDurability(value)
            
            if curr and max then
                maxDurability = maxDurability + max
                currDurability = currDurability + curr
            end
        end
    end
    
    local value = maxDurability > 0 and currDurability / maxDurability * 100 or 100
    
    if value < 10 then
        bar:SetStatusBarColor(1.00, 0.00, 0.00)
    elseif value < 30 then
        bar:SetStatusBarColor(1.00, 1.00, 0.00)
    else
        bar:SetStatusBarColor(0.00, 0.40, 1.00)
    end
    
    bar:SetValue(value)
    bar.text:SetText(("%d%%"):format(value))
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)

Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)

Event.timer = 0.00
Event:SetScript("OnUpdate", function(self, elapsed, ...)
    self.timer = self.timer + elapsed
    
    if self.timer > 3.00 then
        self.timer = 0.00
        
        UpdateAnchors()

        if not anchors or not anchors[1] then
            return
        end

        UpdatePingBar(self, ...)
        UpdateClockBar(self, ...)
        UpdateAddonBar(self, ...)
        
        UpdateGoldBar(self, ...)
        UpdateItemBar(self, ...)
    end
end)
