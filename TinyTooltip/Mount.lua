
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")

local mounts = {}

if (not C_MountJournal) then return end

local function GetAllMountSource()
    local mountIDs = C_MountJournal.GetMountIDs()
    local _, spellID, isCollected, source
    for i, mountID in ipairs(mountIDs) do
        _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        _, _, source = C_MountJournal.GetMountInfoExtraByID(mountID)
        mounts[spellID] = {
            source = source,
            isCollected = isCollected,
        }
    end
    if (#mounts > 0) then return true end
end

LibEvent:attachEvent("VARIABLES_LOADED", function()
    LibSchedule:AddTask({
        identity = "GetAllMountSource",
        elasped  = 10,
        begined  = GetTime() + 2,
        expired  = GetTime() + 100,
        override = true,
        onExecute = GetAllMountSource,
    })
end)


LibEvent:attachTrigger("tooltip:aura", function(self, tip, args)
    if (args and args[2] and args[2].intVal) then
        local spellID = args[2].intVal
        if (mounts[spellID]) then
            tip:AddLine(" ")
            if (mounts[spellID].isCollected) then
                tip:AddDoubleLine(mounts[spellID].source, COLLECTED, 1, 1, 1, 0.1, 1, 0.1)
            else
                tip:AddLine(mounts[spellID].source, 1, 1, 1)
            end
            tip:Show()
        end
    end
end)
