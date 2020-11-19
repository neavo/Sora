-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local mountsData = {}

-- Begin
local function HookSetUnitAura(self, unit, index, filter)
    if InCombatLockdown() then
        return
    end

    if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) then
        return
    end

    local name, texture, count, debuffType, duration, expirationTime, _, _, _, spellId, _, _, _, _, timeMod = UnitAura(unit, index, filter)
    local mountID = mountsData[spellId]

    if mountID then
        local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal.GetMountInfoExtraByID(abs(mountID))
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine(
            "坐骑来源：",
            mountID > 0 and "（已收集）" or "（未收集）",
            mountID > 0 and 0.10 or 0.90,
            mountID > 0 and 0.90 or 0.00,
            0.10,
            mountID > 0 and 0.10 or 0.90,
            mountID > 0 and 0.90 or 0.00,
            0.10
        )
        GameTooltip:AddLine(sourceText, 0.90, 0.90, 0.90)
        GameTooltip:Show()
    end
end

-- Event
local function OnPlayerLogin(self, event, ...)
    hooksecurefunc(GameTooltip, "SetUnitAura", HookSetUnitAura)
    hooksecurefunc(GameTooltip, "SetUnitBuff", HookSetUnitAura)
end

local function OnPlayerEnteringWorld(self, event, ...)
    for i = 1, C_MountJournal.GetNumMounts() do
        local _, spellId, _, _, _, _, _, _, _, _, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
        if spellId then
            mountsData[spellId] = (isCollected and 1 or -1) * mountID
        end
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
