-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnTickder()
end

local function OnPlayerLogin(self, event, ...)
    if C.Tutorial.Initialized then
        return 0
    end

    for i = 1, NUM_CHAT_WINDOWS do
        SetChatWindowSize(i, 13)
    end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler:Register()
