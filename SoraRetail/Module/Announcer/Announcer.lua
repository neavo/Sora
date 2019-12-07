-- Engine
local S, C, L, DB = unpack(select(2, ...))
local _G, tsort, tinsert = _G, table.sort, tinsert

-- Variables
local lastMsg = nil
local lastMsgTime = nil

-- Initialize
local CompletedQuests = {}
CompletedQuests.Init = false

-- Functions
local SendMessage = function(msg, sound)
    if msg == lastMsg and lastMsgTime == time() then
        return 0
    else
        lastMsg = msg
        lastMsgTime = time()
    end

    if sound then
        PlaySound(SOUNDKIT.RAID_WARNING, "Master")
    end

    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        SendChatMessage("[Sora's Announcer] " .. msg, "INSTANCE_CHAT")
    elseif IsInRaid() then
        SendChatMessage("[Sora's Announcer] " .. msg, "RAID")
    elseif IsInGroup() then
        SendChatMessage("[Sora's Announcer] " .. msg, "PARTY")
    else
        print("|cff70C0F5[Sora's Announcer]|r " .. msg)
    end
end

-- Quest Accept
local OnQuestAccepted = function(self, event, questIndex, questId)
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
local function GetPattern(pattern)
    pattern = gsub(pattern, "%(", "%%%1")
    pattern = gsub(pattern, "%)", "%%%1")
    pattern = gsub(pattern, "%%%d?$?.", "(.+)")

    return format("^%s$", pattern)
end
local QuestPatterns = {
    ["Found"] = GetPattern(ERR_QUEST_ADD_FOUND_SII),
    ["Item"] = GetPattern(ERR_QUEST_ADD_ITEM_SII),
    ["Kill"] = GetPattern(ERR_QUEST_ADD_KILL_SII),
    ["PKill"] = GetPattern(ERR_QUEST_ADD_PLAYER_KILL_SII),
    ["ObjectiveComplete"] = GetPattern(ERR_QUEST_OBJECTIVE_COMPLETE_S),
    ["QuestComplete"] = GetPattern(ERR_QUEST_COMPLETE_S),
    ["QuestFailed"] = GetPattern(ERR_QUEST_FAILED_S)
}
local OnUIInfoMessage = function(self, event, errorType, msg)
    for _, pattern in pairs(QuestPatterns) do
        if string.match(msg, pattern) then
            local _, _, _, cur, max = string.find(msg, "(.*)[:：]%s*([-%d]+)%s*/%s*([-%d]+)%s*$")
            cur, max = tonumber(cur), tonumber(max)

            if cur and max and max >= 10 then
                if mod(cur, floor(max / 5)) == 0 then
                    SendMessage(msg, true)
                end
            else
                SendMessage(msg, true)
            end

            break
        end
    end
end

-- Quest Complete
local OnQuestTurnedIn = function(self, event, questID, xpReward, moneyReward)
    if QuestUtils_IsQuestWorldQuest(questID) then
        local link = GetQuestLink(questID)

        if link and not CompletedQuests[questID] then
            CompletedQuests[questID] = true
            SendMessage("完成任务：" .. link, true)
        end
    end
end
local OnQuestLogUpdate = function(self, event, ...)
    for i = 1, GetNumQuestLogEntries() do
        local _, _, _, _, _, isComplete, _, questID = GetQuestLogTitle(i)
        local link = GetQuestLink(questID)
        local worldQuest = select(3, GetQuestTagInfo(questID))

        if link and isComplete and not CompletedQuests[questID] and not worldQuest then
            if CompletedQuests.Init then
                SendMessage("完成任务：" .. link)
            end
            CompletedQuests[questID] = true
        end
    end

    CompletedQuests.Init = true
end

-- Dispel、Stolen、Interrupt
local OnCombarLogEventUnfiltered = function(self, event, ...)
    local timestamp, eventType, hideCaster, sourceGUID, sourceName = CombatLogGetCurrentEventInfo()

    if eventType ~= "SPELL_DISPEL" and eventType ~= "SPELL_STOLEN" and eventType ~= "SPELL_INTERRUPT" then
        return 0
    end

    local action = ""
    if eventType == "SPELL_DISPEL" then
        action = " 驱散了 "
    elseif eventType == "SPELL_STOLEN" then
        action = " 偷取了 "
    elseif eventType == "SPELL_INTERRUPT" then
        action = " 打断了 "
    end

    local spellId, _, _, extraSpellId = select(12, CombatLogGetCurrentEventInfo())

    if C.Announcer.OnlyPlayer then
        if sourceName == UnitName("player") or sourceName == UnitName("pet") or sourceName == UnitName("vehicle") then
            SendMessage(sourceName .. " 使用 " .. GetSpellLink(spellId) .. action .. GetSpellLink(extraSpellId))
        end
    else
        SendMessage(sourceName .. " 使用 " .. GetSpellLink(spellId) .. action .. GetSpellLink(extraSpellId))
    end
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.QUEST_ACCEPTED = OnQuestAccepted
EventHandler.Event.UI_INFO_MESSAGE = OnUIInfoMessage
EventHandler.Event.QUEST_TURNED_IN = OnQuestTurnedIn
EventHandler.Event.QUEST_LOG_UPDATE = OnQuestLogUpdate
EventHandler.Event.COMBAT_LOG_EVENT_UNFILTERED = OnCombarLogEventUnfiltered
EventHandler.RegisterAllEvents()
