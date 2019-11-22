-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    -- 反和谐
    SetCVar("overrideArchive", 0)

    -- 装备对比
    SetCVar("alwaysCompareItems", 1)
    
    -- 姓名板
    SetCVar("namePlateMinScale", 1) -- 固定大小，提高性能
    SetCVar("namePlateMaxScale", 1) -- 固定大小，提高性能
    SetCVar("nameplateMaxDistance", 40) -- 还原最远显示距离40码
    
    -- 还原经典战斗文字效果
    SetCVar("floatingCombatTextCombatDamage", 1)
    SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnPlayerLogin(self, event, ...)
    end
end)
