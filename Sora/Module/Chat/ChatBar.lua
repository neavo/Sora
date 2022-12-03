-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local size, width, height = nil
local texts = {
    "说",
    "喊",
    "队",
    "会",
    "团",
    "综",
    "世",
    "表",
    "骰"
}
local channels = {
    "/s ",
    "/y ",
    "/p ",
    "/g ",
    "/raid ",
    "/1 "
}

-- Common
local function GetWorldChannel()
    local last = nil
    local list = {GetChannelList()}

    for i, v in ipairs(list) do
        if v == "大脚世界频道" then
            return last
        end

        last = v
    end
end

local function OnEnter(self, ...)
    self.BG:GetScript("OnEnter")()
end

local function OnLeave(self, ...)
    self.BG:GetScript("OnLeave")()
end

local function OnClick(self, btn, ...)
    if self.i <= 6 then
        ChatFrame_OpenChat(channels[self.i], SELECTED_DOCK_FRAME)
    elseif self.i == 7 then
        local id = GetWorldChannel()

        if id then
            ChatFrame_OpenChat("/" .. id .. " ", SELECTED_DOCK_FRAME)
        else
            DEFAULT_CHAT_FRAME:AddMessage('|cff70C0F5[Sora\'s]|r 未找到大脚世界频道，请输入"/加入 大脚世界频道"')
        end
    elseif self.i == 8 then
        if CustomEmoteFrame:IsShown() then
            CustomEmoteFrame:Hide()
        else
            CustomEmoteFrame:Show()
        end
    elseif self.i == 9 then
        RandomRoll(1, 100)
    end
end

local function CreateAnchor()
    local anchor = CreateFrame("Frame", "SoraChatBar", UIParent)
    anchor:SetSize(size, height)
    anchor:SetPoint("TOPLEFT", SoraChat, "TOPRIGHT", 4, 0)
end

local function CreateChatBarButton()
    local btn, btns = nil, {}

    for i = 1, 10 do
        if i <= 9 then
            btn = S.CreateButton(SoraChatBar, 11)
            btn:SetText(texts[i])
            btn:SetSize(size, size)
            btn:HookScript("OnClick", OnClick)
        elseif i == 10 then
            btn = ChatFrameChannelButton
            btn:SetSize(size, size)
            btn:ClearAllPoints()
            btn:SetParent(SoraChatBar)
            btn:SetScript("OnEnter", OnEnter)
            btn:SetScript("OnLeave", OnLeave)

            btn.__bg:Hide()
            btn.BG = S.CreateButton(btn, 12, nil)
            btn.BG:SetAllPoints()
            btn.BG:SetFrameStrata("BACKGROUND")

            btn.Icon:SetSize(btn:GetHeight() - 3, btn:GetWidth() - 3)
            btn.Icon:ClearAllPoints()
            btn.Icon:SetPoint("CENTER", btn, "CENTER", 1, 1)
        end

        btn.i = i
        btn:SetPoint("TOP", SoraChatBar, "TOP", 0, -(4 + size) * (i - 1))
    end
end

-- Event
local function OnInitialize()
    height = SoraChat:GetHeight()
    width = (height - 4 * 9) / 10
    size = (height - 4 * 9) / 10
end

local function OnPlayerLogin(self, event, ...)
    CreateAnchor()
    CreateChatBarButton()
end

local function OnPlayerEnteringWorld(self, event, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
