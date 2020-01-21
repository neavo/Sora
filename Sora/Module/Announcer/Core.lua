-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local lastMsgTime = nil
local completedQuests = {}

-- Common
local function SendMessage(msg, sound)
    if sound and SoraDB.Announcer.AlertMode == 2 then
        PlaySound(SOUNDKIT.RAID_WARNING, "Master")
    end

    if C.Announcer.AlertForPlayer then
        print("|cff70C0F5[Sora's]|r " .. msg)
        return 0
    end

    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        SendChatMessage("[Sora's] " .. msg, "INSTANCE_CHAT")
    elseif IsInRaid() then
        SendChatMessage("[Sora's] " .. msg, "RAID")
    elseif IsInGroup() then
        SendChatMessage("[Sora's] " .. msg, "PARTY")
    else
        print("|cff70C0F5[Sora's]|r " .. msg)
    end
end

-- Quest Accept
local function OnQuestAccepted(self, event, questIndex, questId)
    local link = GetQuestLink(questId)
    local frequency = select(7, GetQuestLogTitle(questIndex))

    if link then
        local tagID, _, worldQuestType = GetQuestTagInfo(questId)

        if tagID == 109 or worldQuestType == LE_QUEST_TAG_TYPE_PROFESSION then
            return
        end

        if frequency == LE_QUEST_FREQUENCY_DAILY then
            SendMessage("接受日常任务：" .. link, true)
        elseif frequency == LE_QUEST_FREQUENCY_WEEKLY then
            SendMessage("接受周常任务：" .. link, true)
        else
            SendMessage("接受任务：" .. link, true)
        end
    end
end
-- Quest Progress
local function FitPattern(p)
    p = string.gsub(p, "%%s", "(.+)")
    p = string.gsub(p, "%%d", "(%%d+)")

    return "^" .. p .. "$"
end
local QuestPatterns = {
    FitPattern(ERR_QUEST_ADD_ITEM_SII),
    FitPattern(ERR_QUEST_ADD_KILL_SII),
    FitPattern(ERR_QUEST_ADD_FOUND_SII),
    FitPattern(ERR_QUEST_ADD_PLAYER_KILL_SII),
    FitPattern(ERR_QUEST_FAILED_S),
    FitPattern(ERR_QUEST_COMPLETE_S),
    FitPattern(ERR_QUEST_UNKNOWN_COMPLETE),
    FitPattern(ERR_QUEST_OBJECTIVE_COMPLETE_S)
}
local function OnUIInfoMessage(self, event, errorType, msg)
    for _, pattern in pairs(QuestPatterns) do
        if string.match(msg, pattern) then
            SendMessage(msg, true)
            return
        end
    end
end

-- Quest Complete
local function OnQuestTurnedIn(self, event, questID, xpReward, moneyReward)
    local link = GetQuestLink(questID) or completedQuests[questID]

    if link then
        SendMessage("完成任务：" .. link, true)
    end
end

local function OnQuestLogUpdate(self, event, ...)
    for i = 1, GetNumQuestLogEntries() do
        local _, _, _, _, _, isComplete, _, questID = GetQuestLogTitle(i)
        local link = GetQuestLink(questID)

        if isComplete and link then
            completedQuests[questID] = link
        end
    end
end

-- Dispel、Stolen、Interrupt
local function OnCombarLogEventUnfiltered(self, event, ...)
    local timestamp, event, _, _, sourceName, _, _, _, destName = CombatLogGetCurrentEventInfo()

    if event ~= "SPELL_DISPEL" and event ~= "SPELL_STOLEN" and event ~= "SPELL_INTERRUPT" then
        return 0
    end

    local isPlayer = sourceName == UnitName("player") or sourceName == UnitName("pet") or sourceName == UnitName("vehicle")
    if C.Announcer.OnlyPlayer and not isPlayer then
        return 0
    end

    if lastMsgTime == timestamp then
        return 0
    end

    local action = ""
    local spellId, _, _, destSpellId = select(12, CombatLogGetCurrentEventInfo())

    if event == "SPELL_DISPEL" then
        action = " 驱散了 "
    elseif event == "SPELL_STOLEN" then
        action = " 偷取了 "
    elseif event == "SPELL_INTERRUPT" then
        action = " 打断了 "
    end

    lastMsgTime = timestamp
    SendMessage(sourceName .. " 使用 " .. GetSpellLink(spellId) .. action .. destName .. " 的 " .. GetSpellLink(destSpellId))
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.QUEST_ACCEPTED = OnQuestAccepted
EventHandler.Event.UI_INFO_MESSAGE = OnUIInfoMessage
EventHandler.Event.QUEST_TURNED_IN = OnQuestTurnedIn
EventHandler.Event.QUEST_LOG_UPDATE = OnQuestLogUpdate
EventHandler.Event.COMBAT_LOG_EVENT_UNFILTERED = OnCombarLogEventUnfiltered
EventHandler.Register()
