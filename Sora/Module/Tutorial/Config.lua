-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Tutorial = C.Tutorial or {}

-- Common
local function CreateDB(self, ...)
    SoraDBPerCharacter = SoraDBPerCharacter or {}
    SoraDBPerCharacter.Tutorial = SoraDBPerCharacter.Tutorial or {}
    SoraDBPerCharacter.Tutorial.Initialized = SoraDBPerCharacter.Tutorial.Initialized or false

    C.Tutorial = S.Copy(SoraDBPerCharacter.Tutorial)
end

-- Event
local OnAddonLoaded = function(self, event, addon, ...)
    if addon ~= "Sora" then
        return 0
    end

    CreateDB(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Register()
