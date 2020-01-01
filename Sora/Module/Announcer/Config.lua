-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Announcer = C.Announcer or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Announcer = SoraDB.Announcer or {}

    SoraDB.Announcer.OnlyPlayer = SoraDB.Announcer.OnlyPlayer or false
    SoraDB.Announcer.AlertForPlayer = SoraDB.Announcer.AlertForPlayer or false

    C.Announcer = S.Copy(SoraDB.Announcer)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Announcer = C.Config.Announcer or {}

    C.Config.Announcer.Tab = {
        index = 4,
        text = "信息通报"
    }

    C.Config.Announcer.Menu = {
        {
            type = "checkbox",
            text = "只通报玩家施放的技能",
            key = "SoraDB.Announcer.OnlyPlayer",
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Announcer.OnlyPlayer = S.ToBoolean(data.value)
                end
            end
        },
        {
            type = "checkbox",
            text = "只通报在玩家个人频道",
            key = "SoraDB.Announcer.AlertForPlayer",
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Announcer.AlertForPlayer = S.ToBoolean(data.value)
                end
            end
        },
        {
            type = "space"
        },
        {
            type = "button",
            text = "重置本页设置至默认值",
            OnClick = function(self, btn, ...)
                table.wipe(SoraDB.Announcer)
                ReloadUI()
            end
        }
    }
end

-- Event
local OnAddonLoaded = function(self, event, addon, ...)
    if addon ~= "Sora" then
        return 0
    end

    CreateDB(self, ...)
    CreateConfig(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Register()
