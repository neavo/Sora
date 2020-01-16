-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local channels = {"/s ", "/y ", "/p ", "/g ", "/raid ", "/1 ", "/2 "}
local colors = {
    {255 / 255, 255 / 255, 255 / 255},
    {255 / 255, 64 / 255, 64 / 255},
    {170 / 255, 170 / 255, 255 / 255},
    {64 / 255, 255 / 255, 64 / 255},
    {255 / 255, 127 / 255, 0 / 255},
    {210 / 255, 180 / 255, 140 / 255},
    {160 / 255, 120 / 255, 90 / 255},
    {255 / 255, 255 / 255, 0 / 255}
}

-- Begin
local function OnPlayerLogin(self, event, ...)
    local btn = nil
    local btns = {}
    DBT_AllPersistentOptions["Default"]["DBM"].BarYOffset = 15
    DBT_AllPersistentOptions["Default"]["DBM"].HugeBarYOffset = 15
    local anchor = CreateFrame("Frame", nil, UIParent)
    anchor:SetSize(14 * 9 + 4 * 8, 14)
    anchor:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 0, 4)

    local function OnEnter(self, ...)
        if InCombatLockdown() then
            self:SetAlpha(1.00)
        else
            UIFrameFadeIn(self, 0.25, 0.25, 1.00)
        end
    end

    local function OnLeave(self, ...)
        if InCombatLockdown() then
            self:SetAlpha(0.25)
        else
            UIFrameFadeOut(self, 0.25, 1.00, 0.25)
        end
    end

    for i = 1, 9 do
        local function OnClick(self, btn, ...)
            PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
            ChatFrame_OpenChat(channels[i], SELECTED_DOCK_FRAME)
        end

        if i < 8 then
            btn = CreateFrame("Button", nil, anchor)
            btn:SetSize(14, 14)
            btn:SetScript("OnClick", OnClick)
        elseif i == 8 then
            btn = CreateFrame("Button", nil, anchor, "SecureActionButtonTemplate")
            btn:SetSize(14, 14)
            btn:SetAttribute("*type*", "macro")
            btn:SetAttribute("macrotext", "/roll")
        else
            btn = _G["ChatFrameChannelButton"]
            btn:ClearAllPoints()
            btn:SetSize(14 + 2, 14 + 2)
        end

        btn:SetAlpha(0.25)
        btn:SetScript("OnEnter", OnEnter)
        btn:SetScript("OnLeave", OnLeave)

        if i <= 8 then
            btn.bg = btn:CreateTexture(nil, "BORDER")
            btn.bg:SetAllPoints()
            btn.bg:SetTexture(DB.Backdrop)
            btn.bg:SetVertexColor(unpack(colors[i]))

            btn.shadow = S.MakeShadow(btn, 2)
            btn.shadow:SetFrameLevel(btn:GetFrameLevel())
        end

        if i == 1 then
            btn:SetPoint("RIGHT", anchor, "RIGHT", 0, 0)
        else
            btn:SetPoint("RIGHT", btns[i - 1], "LEFT", -4, 0)
        end

        table.insert(btns, btn)
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
