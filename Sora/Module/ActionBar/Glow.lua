-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Initialize
local LibButtonGlow = LibStub("LibButtonGlow-1.0")
local datas = {
    {
        triggerID = 223819, -- 神圣意志
        responseID = {
            53385, -- 神圣风暴
            53600, -- 正义盾击
            85222, -- 黎明之光
            85256, -- 圣殿骑士的裁决
            85673 -- 荣耀圣令
        }
    }
}
local actionBarPrefixs = {
    "ActionButton",
    "MultiBarLeftButton",
    "MultiBarRightButton",
    "MultiBarBottomLeftButton",
    "MultiBarBottomRightButton"
}

-- Begin
local function CheckGlow(id)
    local flag = false

    for k, v in pairs(datas) do
        if flag == true then
            break
        end

        if v.hit == true then
            for x, y in pairs(v.responseID) do
                if flag == true then
                    break
                end

                if y == id then
                    flag = true
                end
            end
        end
    end

    return flag
end

-- Event
local function OnUnitAura(self, event, unit, ...)
    if unit ~= "player" then
        return 0
    end

    for k, v in pairs(datas) do
        v.hit = false
    end

    for k, v in pairs({"HELPFUL", "HARMFUL"}) do
        for i = 1, 40 do
            local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

            if not spellID then
                break
            end
            for x, y in pairs(datas) do
                if spellID == y.triggerID then
                    y.hit = true
                    break
                end
            end
        end
    end

    for k, v in pairs(actionBarPrefixs) do
        for i = 1, NUM_ACTIONBAR_BUTTONS do
            local button = _G[v .. i]

            if not button then
                break
            end

            local id = nil
            local unmarkedType, unmarkedID = GetActionInfo(button.action)

            if unmarkedType == "spell" then
                id = unmarkedID
            elseif unmarkedType == "macro" then
                id = GetMacroSpell(unmarkedID)
            end

            if id and CheckGlow(id) then
                LibButtonGlow.ShowOverlayGlow(button)
            else
                LibButtonGlow.HideOverlayGlow(button)
            end
        end
    end
end

local function OnPlayerLogin(self, event, ...)
    local function OnAfter()
        OnUnitAura(self, event, "player")
    end

    C_Timer.After(1.00, OnAfter)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.UNIT_AURA = OnUnitAura
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
