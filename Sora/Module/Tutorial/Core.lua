-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function CreateDB(self, ...)
    SoraDBPerCharacter = SoraDBPerCharacter or {}
    SoraDBPerCharacter.Tutorial = SoraDBPerCharacter.Tutorial or {}
    SoraDBPerCharacter.Tutorial.Initialized = SoraDBPerCharacter.Tutorial.Initialized or false

    C.Tutorial = S.Copy(SoraDBPerCharacter.Tutorial)
end

-- Begin
local function CreateAlert(self, ...)
    if C.Tutorial.Initialized then
        return 0
    end

    local alert = S.CreateAlert(UIParent, 12)
    alert:SetData(
        {
            title = "|cff70C0F5Sora's|r",
            detail = "感谢您的认可和使用，请点击下方按钮对 |cff70C0F5Sora's|r 进行初始化。",
            positiveText = "确认",
            OnPositiveClick = function(self, btn, ...)
                SoraDBPerCharacter.Tutorial.Initialized = true

                ReloadUI()
            end
        }
    )
    alert:SetPoint("CENTER", UIParent, "CENTER", 0, 128)
    alert:SetAlterWidth(512)
end

-- Event
local OnAddonLoaded = function(self, event, addon, ...)
    if addon ~= "Sora" then
        return 0
    end

    CreateDB(self, ...)
    CreateAlert(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Register()
