-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Event
local function OnPlayerLogin(self, event, ...)
    -- 关闭 - 垃圾信息过滤
    SetCVar("spamFilter", 0)

    -- 关闭 - 和谐
    SetCVar("overrideArchive", 0)

    -- 关闭 - 语言过滤器
    SetCVar("profanityFilter", 0)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
