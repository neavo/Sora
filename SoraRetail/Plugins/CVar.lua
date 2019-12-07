-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    -- 反和谐
    SetCVar("overrideArchive", 0)

    -- 装备对比
    SetCVar("alwaysCompareItems", 1)

    -- 伤害字体大小
    SetCVar("WorldTextScale", 1.5)

    -- 还原经典战斗文字效果
    SetCVar("floatingCombatTextCombatDamage", 1)
    SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript(
    "OnEvent",
    function(self, event, ...)
        if event == "PLAYER_LOGIN" then
            OnPlayerLogin(self, event, ...)
        end
    end
)
