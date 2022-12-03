local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local addon = TinyTooltip

local function ParseHyperLink(link)
    local name, value = string.match(link or "", "|?H(%a+):(%d+):")
    if (name and value) then
        return name:gsub("^([a-z])", strupper), value
    end
end

local function ShowId(tooltip, name, value, noBlankLine)
    if (not name or not value) then return end
    if (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) then
        local line = addon:FindLine(tooltip, name)
        if (not line) then
            if (not noBlankLine) then tooltip:AddLine(" ") end
            tooltip:AddLine(format("%s: |cffffffff%s|r", name, value), 0, 1, 0.8)
            tooltip:Show()
        end
        LibEvent:trigger("tooltip.linkid", tooltip, name, value, noBlankLine)
    end
end

local function ShowLinkIdInfo(tooltip, link)
    ShowId(tooltip, ParseHyperLink(link or select(2,tooltip:GetItem())))
end



LibEvent:attachTrigger("tooltip:item", function(self, tip, link)
    ShowLinkIdInfo(tip, link)
end)

LibEvent:attachTrigger("tooltip:spell", function(self, tip)
    ShowId(tip, "Spell", (select(2,tip:GetSpell())))
end)

LibEvent:attachTrigger("tooltip:aura", function(self, tip, args)
    if (args and args[2] and args[2].intVal) then
        ShowId(tip, "Spell", args[2].intVal)
    end
end)

-- Quest
if (QuestMapLogTitleButton_OnEnter) then
    hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(self)
        if (self.questID) then ShowId(GameTooltip, "Quest", self.questID) end
    end)
end

-- Achievement UI
local function ShowAchievementId(self)
    if ((IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) and self.id) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, -32)
        GameTooltip:SetText("|cffffdd22Achievement:|r " .. self.id, 0, 1, 0.8)
        GameTooltip:Show()
    end
end

if (HybridScrollFrame_CreateButtons) then
    hooksecurefunc("HybridScrollFrame_CreateButtons", function(self, buttonTemplate)
        if (buttonTemplate == "StatTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
            end
        elseif (buttonTemplate == "AchievementTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
                button:HookScript("OnLeave", GameTooltip_Hide)
            end
        end
    end)
end
